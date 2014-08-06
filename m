From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Aug 2014 11:49:47 +0100
Subject: [PATCH V2 1/4] ARM: perf: Set suniden bit.
In-Reply-To: <20140805144833.25462.46011.stgit@localhost>
References: <20140805144831.25462.18149.stgit@localhost>
 <20140805144833.25462.46011.stgit@localhost>
Message-ID: <20140806104947.GD25953@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Tue, Aug 05, 2014 at 03:48:33PM +0100, Martin Fuzzey wrote:
> Counters other than the CPU cycle counter only work if the security module
> SUNIDEN bit is set.
> 
> Since access to this register is only possible in secure mode it will
> only be done if the device tree property "secure-reg-access" is set.
> 
> Without this:
> # perf stat -e cycles,instructions sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>           14606094 cycles                    #    0.000 GHz
>                  0 instructions              #    0.00  insns per cycle
> 
> Some platforms (eg i.MX53) may also need additional platform specific setup.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  Documentation/devicetree/bindings/arm/pmu.txt |    7 ++++
>  arch/arm/include/asm/pmu.h                    |   10 ++++++
>  arch/arm/kernel/perf_event_cpu.c              |    3 ++
>  arch/arm/kernel/perf_event_v7.c               |   44 +++++++++++++++++++++++++
>  4 files changed, 64 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
> index 75ef91d..7dab77e 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> @@ -27,6 +27,13 @@ Optional properties:
>  - qcom,no-pc-write : Indicates that this PMU doesn't support the 0xc and 0xd
>                       events.
>  
> +- secure-reg-access : Indicates that secure mode access is available.
> +		      This will cause the driver to do any setup required that
> +		      is only possible in secure mode.
> +		      If not present the secure registers will not be touched,
> +		      which means the PMU may fail to operate unless external
> +		      code (bootloader or security monitor) has performed the
> +		      appropriate initialisation.
>  Example:
>  
>  pmu {
> diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
> index ae1919b..dfb654f 100644
> --- a/arch/arm/include/asm/pmu.h
> +++ b/arch/arm/include/asm/pmu.h
> @@ -89,6 +89,16 @@ struct arm_pmu {
>  	u64		max_period;
>  	struct platform_device	*plat_device;
>  	struct pmu_hw_events	*(*get_hw_events)(void);
> +
> +	/*
> +	 * Bits indicating any CPU or platform specific activations that have
> +	 * been done so we can undo them when stopping
> +	 */
> +	struct {
> +		unsigned int secure_regs_available : 1;
> +		unsigned int secure_debug_requested : 1;
> +		unsigned int platform_enabled : 1;
> +	} activated_flags;

This should be a single bool secure_access; field.

>  };
>  
>  #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
> diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
> index af9e35e..c09e18e 100644
> --- a/arch/arm/kernel/perf_event_cpu.c
> +++ b/arch/arm/kernel/perf_event_cpu.c
> @@ -313,6 +313,9 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
>  	cpu_pmu->plat_device = pdev;
>  
>  	if (node && (of_id = of_match_node(cpu_pmu_of_device_ids, pdev->dev.of_node))) {
> +		pmu->activated_flags.secure_regs_available =
> +			of_property_read_bool(pdev->dev.of_node,
> +						"secure-reg-access");
>  		init_fn = of_id->data;
>  		ret = init_fn(pmu);
>  	} else {
> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index 1d37568..5ad9626 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -1377,12 +1377,47 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
>  	return IRQ_HANDLED;
>  }
>  
> +#define SDER_SUNIDEN (1 << 1)
> +
> +static inline u32 armv2pmu_read_sder(void)
> +{
> +	u32 sder;
> +
> +	asm volatile("mrc p15, 0, %0, c1, c1, 1" : "=r" (sder));
> +
> +	return sder;
> +}
> +
> +static inline void armv2pmu_write_sder(u32 sder)
> +{
> +	asm volatile("mcr p15, 0, %0, c1, c1, 1" : : "r" (sder));
> +}

Please stick with the naming convention of the file (armv7pmu_*). You can
also combine these functions into armv7pmu_enable_secure_access...

>  static void armv7pmu_start(struct arm_pmu *cpu_pmu)
>  {
>  	unsigned long flags;
>  	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
>  
>  	raw_spin_lock_irqsave(&events->pmu_lock, flags);
> +
> +	/*
> +	 * Counters other than cycle counter require SUNIDEN bit set
> +	 * Set the bit if the DT configuration allows it (secure mode)
> +	 * Otherwise do nothing and hope bootloader / secure monitor did the
> +	 * setup.
> +	 */
> +	if (cpu_pmu->activated_flags.secure_regs_available) {
> +		u32 sder = armv2pmu_read_sder();
> +
> +		if (sder & SDER_SUNIDEN) {
> +			cpu_pmu->activated_flags.secure_debug_requested = 0;
> +		} else {
> +			sder |= SDER_SUNIDEN;
> +			armv2pmu_write_sder(sder);
> +			cpu_pmu->activated_flags.secure_debug_requested = 1;
> +		}

... then just call that here.

> +	}
> +
>  	/* Enable all counters */
>  	armv7_pmnc_write(armv7_pmnc_read() | ARMV7_PMNC_E);
>  	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
> @@ -1394,6 +1429,15 @@ static void armv7pmu_stop(struct arm_pmu *cpu_pmu)
>  	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
>  
>  	raw_spin_lock_irqsave(&events->pmu_lock, flags);
> +
> +	if (cpu_pmu->activated_flags.secure_debug_requested) {
> +		u32 sder = armv2pmu_read_sder();
> +
> +		sder &= ~SDER_SUNIDEN;
> +		armv2pmu_write_sder(sder);
> +		cpu_pmu->activated_flags.secure_debug_requested = 0;
> +	}

Why do we need to disable this? Couldn't we just set this once during probe
and be done with it?

Will
