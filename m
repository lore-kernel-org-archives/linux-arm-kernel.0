From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Jan 2016 17:11:09 +0000
Subject: [PATCH V3 1/1] ARM: perf: Set suniden bit
In-Reply-To: <20160106145500.GA92797@gandalf.middle.earth.net>
References: <20140805144831.25462.18149.stgit@localhost>
 <20140805144833.25462.46011.stgit@localhost>
 <20140806104947.GD25953@arm.com> <53E22E0B.7080907@parkeon.com>
 <20140807173316.GH31101@arm.com>
 <20160106145500.GA92797@gandalf.middle.earth.net>
Message-ID: <20160112171109.GJ15737@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 06, 2016 at 09:55:00AM -0500, George G. Davis wrote:
> From: Martin Fuzzey <mfuzzey@parkeon.com>
> 
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
> After applying:
> # perf stat -e cycles,instructions sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>            5843809      cycles                   
>            2566484      instructions              #    0.44  insns per cycle        
> 
>        1.020144000 seconds time elapsed
> 
> 
> Some platforms (eg i.MX53) may also need additional platform specific setup.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> Signed-off-by: Pooya Keshavarzi <Pooya.Keshavarzi@de.bosch.com>
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> ---
> 
> Changes in v3:
> - Pooya Keshavarzi:
>   * v2 review comment fixups
>   * Use on_each_cpu() to set SUNIDEN on all CPUs
>   * Move armv7pmu_enable_secure_access() call from armv7pmu_start() to
>     armv7_a8_map_event() such that is called only once instead of each
>     time `perf` is executed
> - George G. Davis:
>   * Fixup to apply after file renames due to commit fa8ad78 (arm: perf:
>     factor arm_pmu core out to drivers)
>   * Fix checkpatch 'CHECK: Prefer using the BIT macro' issue
> 
>  Documentation/devicetree/bindings/arm/pmu.txt |  8 ++++++++
>  arch/arm/kernel/perf_event_v7.c               | 17 +++++++++++++++++
>  drivers/perf/arm_pmu.c                        |  3 +++
>  include/linux/perf/arm_pmu.h                  |  1 +
>  4 files changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
> index 97ba45a..8d4b831 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> @@ -45,6 +45,14 @@ Optional properties:
>  - qcom,no-pc-write : Indicates that this PMU doesn't support the 0xc and 0xd
>                       events.
>  
> +- secure-reg-access : Indicates that secure mode access is available.
> +		This will cause the driver to do any setup required that
> +		is only possible in secure mode.
> +		If not present the secure registers will not be touched,
> +		which means the PMU may fail to operate unless external
> +		code (bootloader or security monitor) has performed the
> +		appropriate initialisation.

You should make this clear that it's for ARMv7 CPUs only and is not
supported on anything else (in particular, the arm64 port requires you
to boot in non-secure mode).

You should also run this binding change by a devicetree maintainer.

> +
>  Example:
>  
>  pmu {
> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index 126dc67..8dc5582 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -600,6 +600,11 @@ static const unsigned scorpion_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
>  #define	ARMV7_EXCLUDE_USER	(1 << 30)
>  #define	ARMV7_INCLUDE_HYP	(1 << 27)
>  
> +/*
> + * Secure debug enable reg
> + */
> +#define ARMV7_SDER_SUNIDEN	BIT(1) /* Permit non-invasive debug */
> +
>  static inline u32 armv7_pmnc_read(void)
>  {
>  	u32 val;
> @@ -994,6 +999,15 @@ static void armv7pmu_reset(void *info)
>  	armv7_pmnc_write(ARMV7_PMNC_P | ARMV7_PMNC_C);
>  }
>  
> +static void armv7pmu_enable_secure_access(void *data)
> +{
> +	u32 val;
> +
> +	asm volatile("mrc p15, 0, %0, c1, c1, 1" : "=r" (val));
> +	val |= ARMV7_SDER_SUNIDEN;
> +	asm volatile("mcr p15, 0, %0, c1, c1, 1" : : "r" (val));
> +}

This is probably better off in the ->reset callback, since that it
called off the back of a CPU hotplug notifier when the PMU may need to
be reinitialised.

>  static int armv7_a8_map_event(struct perf_event *event)
>  {
>  	return armpmu_map_event(event, &armv7_a8_perf_map,
> @@ -1060,6 +1074,9 @@ static void armv7pmu_init(struct arm_pmu *cpu_pmu)
>  	cpu_pmu->stop		= armv7pmu_stop;
>  	cpu_pmu->reset		= armv7pmu_reset;
>  	cpu_pmu->max_period	= (1LLU << 32) - 1;
> +
> +	if (cpu_pmu->secure_access)
> +		on_each_cpu(armv7pmu_enable_secure_access, NULL, 1);

Then you can remove this too, since ->reset is called on the relevant
cores already.

Will
