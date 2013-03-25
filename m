From: robherring2@gmail.com (Rob Herring)
Date: Mon, 25 Mar 2013 09:16:25 -0500
Subject: [PATCH 08/10] arm: zynq: Add smp support
In-Reply-To: <1364219596-4954-8-git-send-email-michal.simek@xilinx.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
 <1364219596-4954-8-git-send-email-michal.simek@xilinx.com>
Message-ID: <51505C39.4060507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 08:53 AM, Michal Simek wrote:
> Zynq is dual core Cortex A9 which starts always
> at zero. Using simple trampoline ensure long jump
> to secondary_startup code.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  arch/arm/mach-zynq/Makefile  |    1 +
>  arch/arm/mach-zynq/common.c  |    1 +
>  arch/arm/mach-zynq/common.h  |    7 ++
>  arch/arm/mach-zynq/platsmp.c |  160 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-zynq/slcr.c    |   29 ++++++++
>  5 files changed, 198 insertions(+)
>  create mode 100644 arch/arm/mach-zynq/platsmp.c

[...]

> +/* Secondary CPU kernel startup is a 2 step process. The primary CPU
> + * starts the secondary CPU by giving it the address of the kernel and
> + * then sending it an event to wake it up. The secondary CPU then
> + * starts the kernel and tells the primary CPU it's up and running.
> + */
> +static void __cpuinit zynq_secondary_init(unsigned int cpu)
> +{
> +	/*
> +	 * if any interrupts are already enabled for the primary
> +	 * core (e.g. timer irq), then they will not have been enabled
> +	 * for us: do so
> +	 */
> +	gic_secondary_init(0);
> +
> +	/*
> +	 * Synchronise with the boot thread.
> +	 */
> +	spin_lock(&boot_lock);
> +	spin_unlock(&boot_lock);

Why do you think this is needed? Platforms that need this
synchronization are only the ones that just do wfi for hotplug rather
than properly reseting the core. You appear to do the latter and should
not need this.

> +}
> +
> +int __cpuinit zynq_cpun_start(u32 address, int cpu)
> +{
> +	if (cpu > ncores) {
> +		pr_warn("CPU No. is not available in the system\n");
> +		return -1;
> +	}
> +
> +	/* MS: Expectation that SLCR are directly map and accessible */
> +	/* Not possible to jump to non aligned address */
> +	if (!(address & 3) && (!address || (address >= 0xC))) {

What about Thumb2 kernel entry?

> +		slcr_cpu_stop(cpu);

Isn't a secondary cpu already stopped?

> +
> +		/*
> +		 * This is elegant way how to jump to any address
> +		 * 0x0: Load address at 0x8 to r0
> +		 * 0x4: Jump by mov instruction
> +		 * 0x8: Jumping address
> +		 */
> +		if (address) {
> +			/* 0: ldr r0, [8] */
> +			__raw_writel(0xe59f0000, phys_to_virt(0x0));
> +			/* 4: mov pc, r0 */
> +			__raw_writel(0xe1a0f000, phys_to_virt(0x4));
> +			__raw_writel(address, phys_to_virt(0x8));
> +		}
> +
> +		flush_cache_all();
> +		outer_flush_all();

You should only need to flush range on address 0-4 here.

> +		wmb();
> +
> +		slcr_cpu_start(cpu);
> +
> +		return 0;
> +	}
> +
> +	pr_warn("Can't start CPU%d: Wrong starting address %x\n", cpu, address);
> +
> +	return -1;
> +}
> +EXPORT_SYMBOL(zynq_cpun_start);
> +
> +static int __cpuinit zynq_boot_secondary(unsigned int cpu,
> +						struct task_struct *idle)
> +{
> +	int ret;
> +
> +	/*
> +	 * set synchronisation state between this boot processor
> +	 * and the secondary one
> +	 */
> +	spin_lock(&boot_lock);
> +
> +	ret = zynq_cpun_start(virt_to_phys(secondary_startup), cpu);
> +	if (ret) {
> +		spin_unlock(&boot_lock);
> +		return -1;
> +	}
> +
> +	/*
> +	 * now the secondary core is starting up let it run its
> +	 * calibrations, then wait for it to finish
> +	 */
> +	spin_unlock(&boot_lock);
> +
> +	return 0;
> +}
> +
> +/*
> + * Initialise the CPU possible map early - this describes the CPUs
> + * which may be present or become present in the system.
> + */
> +static void __init zynq_smp_init_cpus(void)
> +{
> +	int i;
> +
> +	ncores = scu_get_core_count(scu_base);
> +
> +	for (i = 0; i < ncores && i < CONFIG_NR_CPUS; i++)
> +		set_cpu_possible(i, true);
> +}
> +
> +static void __init zynq_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	int i;
> +
> +	/*
> +	 * Initialise the present map, which describes the set of CPUs
> +	 * actually populated at the present time.
> +	 */
> +	for (i = 0; i < max_cpus; i++)
> +		set_cpu_present(i, true);
> +
> +	scu_enable(scu_base);
> +}
> +
> +struct smp_operations zynq_smp_ops __initdata = {
> +	.smp_init_cpus		= zynq_smp_init_cpus,
> +	.smp_prepare_cpus	= zynq_smp_prepare_cpus,
> +	.smp_secondary_init	= zynq_secondary_init,
> +	.smp_boot_secondary	= zynq_boot_secondary,
> +};
> diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
> index 36b79d8..7f2a919 100644
> --- a/arch/arm/mach-zynq/slcr.c
> +++ b/arch/arm/mach-zynq/slcr.c
> @@ -33,6 +33,11 @@
>  #define SLCR_UNLOCK			0x8   /* SCLR unlock register */
>  
>  #define SLCR_PSS_RST_CTRL_OFFSET	0x200 /* PS Software Reset Control */
> +
> +#define SLCR_A9_CPU_CLKSTOP		0x10
> +#define SLCR_A9_CPU_RST			0x1
> +
> +#define SLCR_A9_CPU_RST_CTRL		0x244 /* CPU Software Reset Control */
>  #define SLCR_REBOOT_STATUS		0x258 /* PS Reboot Status */
>  
>  void __iomem *zynq_slcr_base;
> @@ -61,6 +66,30 @@ void slcr_system_reset(void)
>  }
>  
>  /**
> + * slcr_cpu_start - Start cpu
> + * @cpu:	cpu number
> + */
> +void slcr_cpu_start(int cpu)
> +{
> +	/* enable CPUn */
> +	writel(SLCR_A9_CPU_CLKSTOP << cpu,
> +	       zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
> +	/* enable CLK for CPUn */
> +	writel(0x0 << cpu, zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
> +}
> +
> +/**
> + * slcr_cpu_stop - Stop cpu
> + * @cpu:	cpu number
> + */
> +void slcr_cpu_stop(int cpu)
> +{
> +	/* stop CLK and reset CPUn */
> +	writel((SLCR_A9_CPU_CLKSTOP | SLCR_A9_CPU_RST) << cpu,
> +	       zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
> +}
> +
> +/**
>   * xslcr_init()
>   * Returns 0 on success, negative errno otherwise.
>   *
> 
