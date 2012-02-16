From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 16 Feb 2012 14:00:34 +0900
Subject: [PATCH v2 08/11] ARM: EXYNOS: add support for ARCH_EXYNOS5 and
 EXYNOS5250
In-Reply-To: <1328981685-8602-9-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <1328981685-8602-9-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAH9JG2Usa5k0J0uoyOPxnPG5y9bZAFD+5AR43mbFN04P7t3Npw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2/12/12, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This patch add the CONFIG_ARCH_EXYNOS5 and CONFIG_SOC_EXYNOS5250
> support for EXYNOS5250 SoC has two Cortex-A15 cores. Since actually,
> most codes in mach-exynos/ are used commonly for EXYNOS4 and EXYNOS5
> the EXYNOS5/EXYNOS5250 has been implemented in mach-exynos/.
>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/Makefile                            |    1 +
>  arch/arm/mach-exynos/Kconfig                 |   13 ++
>  arch/arm/mach-exynos/Makefile                |    1 +
>  arch/arm/mach-exynos/common.c                |  165
> ++++++++++++++++++++++++--
>  arch/arm/mach-exynos/common.h                |   11 ++
>  arch/arm/mach-exynos/include/mach/map.h      |   21 +++-
>  arch/arm/mach-exynos/include/mach/regs-pmu.h |    1 +
>  arch/arm/plat-s5p/Kconfig                    |    4 +-
>  arch/arm/plat-samsung/include/plat/cpu.h     |   10 ++
>  9 files changed, 211 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 1683bfb..a826ffc 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -180,6 +180,7 @@ machine-$(CONFIG_ARCH_S5P64X0)		:= s5p64x0
>  machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
>  machine-$(CONFIG_ARCH_S5PV210)		:= s5pv210
>  machine-$(CONFIG_ARCH_EXYNOS4)		:= exynos
> +machine-$(CONFIG_ARCH_EXYNOS5)		:= exynos
>  machine-$(CONFIG_ARCH_SA1100)		:= sa1100
>  machine-$(CONFIG_ARCH_SHARK)		:= shark
>  machine-$(CONFIG_ARCH_SHMOBILE) 	:= shmobile
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 5d602f6..14b3460 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -22,6 +22,12 @@ config ARCH_EXYNOS4
>  	help
>  	  Samsung EXYNOS4 SoCs based systems
>
> +config ARCH_EXYNOS5
> +	bool "SAMSUNG EXYNOS5"
> +	select HAVE_SMP
> +	help
> +	  Samsung EXYNOS5 (Cortex-A15) SoC based systems
This config is located at choice. It means it can't build the exynos4
and exynos5 simultaneously. I'm not sure it's acceptable for mainline.
> +
>  endchoice
>
>  comment "EXYNOS SoCs"
> @@ -53,6 +59,13 @@ config SOC_EXYNOS4412
>  	help
>  	  Enable EXYNOS4412 SoC support
>
> +config SOC_EXYNOS5250
> +	bool "SAMSUNG EXYNOS5250"
> +	default y
> +	depends on ARCH_EXYNOS5
> +	help
> +	  Enable EXYNOS5250 SoC support
> +
>  config EXYNOS4_MCT
>  	bool
>  	default y
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index f8a3770..7214092 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -14,6 +14,7 @@ obj-				:=
>
>  obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
>  obj-$(CONFIG_ARCH_EXYNOS4)	+= clock-exynos4.o
> +obj-$(CONFIG_ARCH_EXYNOS5)	+= clock-exynos5.o
Where's clock-exynos5.c file in this patch?. maybe it's another patch.
>  obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
>  obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
>
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 8db2627..cff7313 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -49,9 +49,12 @@
>  static const char name_exynos4210[] = "EXYNOS4210";
>  static const char name_exynos4212[] = "EXYNOS4212";
>  static const char name_exynos4412[] = "EXYNOS4412";
> +static const char name_exynos5250[] = "EXYNOS5250";
>
>  static void exynos4_map_io(void);
> +static void exynos5_map_io(void);
>  static void exynos4_init_clocks(int xtal);
> +static void exynos5_init_clocks(int xtal);
>  static void exynos_init_uarts(struct s3c2410_uartcfg *cfg, int no);
>  static int exynos_init(void);
>
> @@ -80,6 +83,14 @@ static struct cpu_table cpu_ids[] __initdata = {
>  		.init_uarts	= exynos_init_uarts,
>  		.init		= exynos_init,
>  		.name		= name_exynos4412,
> +	}, {
> +		.idcode		= EXYNOS5250_SOC_ID,
> +		.idmask		= EXYNOS5_SOC_MASK,
> +		.map_io		= exynos5_map_io,
> +		.init_clocks	= exynos5_init_clocks,
> +		.init_uarts	= exynos_init_uarts,
> +		.init		= exynos_init,
> +		.name		= name_exynos5250,
>  	},
>  };
>
> @@ -88,10 +99,14 @@ static struct cpu_table cpu_ids[] __initdata = {
>  static struct map_desc exynos_iodesc[] __initdata = {
>  	{
>  		.virtual	= (unsigned long)S5P_VA_CHIPID,
> -		.pfn		= __phys_to_pfn(EXYNOS4_PA_CHIPID),
> +		.pfn		= __phys_to_pfn(EXYNOS_PA_CHIPID),
>  		.length		= SZ_4K,
>  		.type		= MT_DEVICE,
> -	}, {
> +	},
> +};
> +
> +static struct map_desc exynos4_iodesc[] __initdata = {
> +	{
>  		.virtual	= (unsigned long)S3C_VA_SYS,
>  		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSCON),
>  		.length		= SZ_64K,
> @@ -141,11 +156,7 @@ static struct map_desc exynos_iodesc[] __initdata = {
>  		.pfn		= __phys_to_pfn(EXYNOS4_PA_UART),
>  		.length		= SZ_512K,
>  		.type		= MT_DEVICE,
> -	},
> -};
> -
> -static struct map_desc exynos4_iodesc[] __initdata = {
> -	{
> +	}, {
>  		.virtual	= (unsigned long)S5P_VA_CMU,
>  		.pfn		= __phys_to_pfn(EXYNOS4_PA_CMU),
>  		.length		= SZ_128K,
> @@ -206,6 +217,70 @@ static struct map_desc exynos4_iodesc1[] __initdata = {
>  	},
>  };
>
> +static struct map_desc exynos5_iodesc[] __initdata = {
> +	{
> +		.virtual	= (unsigned long)S3C_VA_SYS,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_SYSCON),
> +		.length		= SZ_64K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S3C_VA_TIMER,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_TIMER),
> +		.length		= SZ_16K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_WATCHDOG),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_SROMC,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_SROMC),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_SYSTIMER),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_SYSRAM,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_SYSRAM),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_CMU,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_CMU),
> +		.length		= 144 * SZ_1K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_PMU,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_PMU),
> +		.length		= SZ_64K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_COMBINER_BASE,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_COMBINER),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S3C_VA_UART,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_UART),
> +		.length		= SZ_512K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_GIC_CPU,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_GIC_CPU),
> +		.length		= SZ_64K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_GIC_DIST,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_GIC_DIST),
> +		.length		= SZ_64K,
> +		.type		= MT_DEVICE,
> +	},
> +};
> +
>  static void exynos_idle(void)
>  {
>  	if (!need_resched())
> @@ -219,6 +294,11 @@ void exynos4_restart(char mode, const char *cmd)
>  	__raw_writel(0x1, S5P_SWRESET);
>  }
>
> +void exynos5_restart(char mode, const char *cmd)
> +{
> +	__raw_writel(0x1, EXYNOS_SWRESET);
> +}
Why new restart is required? it's same S5P_SWRESET and EXYNOS_SWRESET.
see below.
> +
>  /*
>   * exynos_map_io
>   *
> @@ -269,6 +349,16 @@ static void __init exynos4_map_io(void)
>  	s5p_hdmi_setname("exynos4-hdmi");
>  }
>
> +static void __init exynos5_map_io(void)
> +{
> +	iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
> +
> +	/* The I2C bus controllers are directly compatible with s3c2440 */
> +	s3c_i2c0_setname("s3c2440-i2c");
> +	s3c_i2c1_setname("s3c2440-i2c");
> +	s3c_i2c2_setname("s3c2440-i2c");
> +}
> +
>  static void __init exynos4_init_clocks(int xtal)
>  {
>  	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
> @@ -285,6 +375,17 @@ static void __init exynos4_init_clocks(int xtal)
>  	exynos4_setup_clocks();
>  }
>
> +static void __init exynos5_init_clocks(int xtal)
> +{
> +	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
> +
> +	s3c24xx_register_baseclocks(xtal);
> +	s5p_register_clocks(xtal);
> +
> +	exynos5_register_clocks();
> +	exynos5_setup_clocks();
> +}
> +
>  #define COMBINER_ENABLE_SET	0x0
>  #define COMBINER_ENABLE_CLEAR	0x4
>  #define COMBINER_INT_STATUS	0xC
> @@ -428,24 +529,59 @@ void __init exynos4_init_irq(void)
>  	s5p_init_irq(NULL, 0);
>  }
>
> +void __init exynos5_init_irq(void)
> +{
> +	int irq;
> +
> +	gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
> +
> +	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
> +		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
> +				COMBINER_IRQ(irq, 0));
> +		combiner_cascade_irq(irq, IRQ_SPI(irq));
> +	}
> +
> +	/*
> +	 * The parameters of s5p_init_irq() are for VIC init.
> +	 * Theses parameters should be NULL and 0 because EXYNOS4
> +	 * uses GIC instead of VIC.
> +	 */
> +	s5p_init_irq(NULL, 0);
> +}
> +
>  struct bus_type exynos4_subsys = {
>  	.name		= "exynos4-core",
>  	.dev_name	= "exynos4-core",
>  };
>
> +struct bus_type exynos5_subsys = {
> +	.name		= "exynos5-core",
> +	.dev_name	= "exynos5-core",
> +};
> +
>  static struct device exynos4_dev = {
>  	.bus	= &exynos4_subsys,
>  };
>
> -static int __init exynos4_core_init(void)
> +static struct device exynos5_dev = {
> +	.bus	= &exynos5_subsys,
> +};
> +
> +static int __init exynos_core_init(void)
>  {
> -	return subsys_system_register(&exynos4_subsys, NULL);
> +	if (soc_is_exynos5250())
> +		return subsys_system_register(&exynos5_subsys, NULL);
> +	else
> +		return subsys_system_register(&exynos4_subsys, NULL);
>  }
> -core_initcall(exynos4_core_init);
> +core_initcall(exynos_core_init);
>
>  #ifdef CONFIG_CACHE_L2X0
>  static int __init exynos4_l2x0_cache_init(void)
>  {
> +	if (soc_is_exynos5250())
> +		return 0;
> +
>  	/* TAG, Data Latency Control: 2cycle */
>  	__raw_writel(0x110, S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
>
> @@ -465,7 +601,6 @@ static int __init exynos4_l2x0_cache_init(void)
>
>  	return 0;
>  }
> -
>  early_initcall(exynos4_l2x0_cache_init);
>  #endif
>
> @@ -476,7 +611,10 @@ static int __init exynos_init(void)
>  	/* set idle function */
>  	pm_idle = exynos_idle;
>
> -	return device_register(&exynos4_dev);
> +	if (soc_is_exynos5250())
> +		return device_register(&exynos5_dev);
> +	else
> +		return device_register(&exynos4_dev);
>  }
>
>  /* uart registration process */
> @@ -685,6 +823,9 @@ int __init exynos4_init_irq_eint(void)
>  {
>  	int irq;
>
> +	if (soc_is_exynos5250())
> +		return 0;
> +
>  	for (irq = 0 ; irq <= 31 ; irq++) {
>  		irq_set_chip_and_handler(IRQ_EINT(irq), &exynos4_irq_eint,
>  					 handle_level_irq);
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index b32c6b5..677b546 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -16,7 +16,9 @@ extern struct sys_timer exynos4_timer;
>
>  void exynos_init_io(struct map_desc *mach_desc, int size);
>  void exynos4_init_irq(void);
> +void exynos5_init_irq(void);
>  void exynos4_restart(char mode, const char *cmd);
> +void exynos5_restart(char mode, const char *cmd);
>
>  #ifdef CONFIG_ARCH_EXYNOS4
>  void exynos4_register_clocks(void);
> @@ -27,6 +29,15 @@ void exynos4_setup_clocks(void);
>  #define exynos4_setup_clocks()
>  #endif
>
> +#ifdef CONFIG_ARCH_EXYNOS5
> +void exynos5_register_clocks(void);
> +void exynos5_setup_clocks(void);
> +
> +#else
> +#define exynos5_register_clocks()
> +#define exynos5_setup_clocks()
> +#endif
> +
>  #ifdef CONFIG_CPU_EXYNOS4210
>  void exynos4210_register_clocks(void);
>
> diff --git a/arch/arm/mach-exynos/include/mach/map.h
> b/arch/arm/mach-exynos/include/mach/map.h
> index e8a7801..ac60533 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -25,6 +25,7 @@
>
>  #define EXYNOS4_PA_SYSRAM0		0x02025000
>  #define EXYNOS4_PA_SYSRAM1		0x02020000
> +#define EXYNOS5_PA_SYSRAM		0x02020000
>
>  #define EXYNOS4_PA_FIMC0		0x11800000
>  #define EXYNOS4_PA_FIMC1		0x11810000
> @@ -44,14 +45,23 @@
>  #define EXYNOS4_PA_ONENAND		0x0C000000
>  #define EXYNOS4_PA_ONENAND_DMA		0x0C600000
>
> -#define EXYNOS4_PA_CHIPID		0x10000000
> +#define EXYNOS_PA_CHIPID		0x10000000
>
>  #define EXYNOS4_PA_SYSCON		0x10010000
> +#define EXYNOS5_PA_SYSCON		0x10050100
> +
>  #define EXYNOS4_PA_PMU			0x10020000
> +#define EXYNOS5_PA_PMU			0x10040000
> +
>  #define EXYNOS4_PA_CMU			0x10030000
> +#define EXYNOS5_PA_CMU			0x10010000
>
>  #define EXYNOS4_PA_SYSTIMER		0x10050000
> +#define EXYNOS5_PA_SYSTIMER		0x101C0000
> +
>  #define EXYNOS4_PA_WATCHDOG		0x10060000
> +#define EXYNOS5_PA_WATCHDOG		0x101D0000
> +
>  #define EXYNOS4_PA_RTC			0x10070000
>
>  #define EXYNOS4_PA_KEYPAD		0x100A0000
> @@ -59,9 +69,12 @@
>  #define EXYNOS4_PA_DMC0			0x10400000
>
>  #define EXYNOS4_PA_COMBINER		0x10440000
> +#define EXYNOS5_PA_COMBINER		0x10440000
>
>  #define EXYNOS4_PA_GIC_CPU		0x10480000
>  #define EXYNOS4_PA_GIC_DIST		0x10490000
> +#define EXYNOS5_PA_GIC_CPU		0x10480000
> +#define EXYNOS5_PA_GIC_DIST		0x10490000
>
>  #define EXYNOS4_PA_COREPERI		0x10500000
>  #define EXYNOS4_PA_TWD			0x10500600
> @@ -91,7 +104,6 @@
>  #define EXYNOS4_PA_SPI1			0x13930000
>  #define EXYNOS4_PA_SPI2			0x13940000
>
> -
>  #define EXYNOS4_PA_GPIO1		0x11400000
>  #define EXYNOS4_PA_GPIO2		0x11000000
>  #define EXYNOS4_PA_GPIO3		0x03860000
> @@ -109,6 +121,7 @@
>  #define EXYNOS4_PA_SATAPHY_CTRL		0x126B0000
>
>  #define EXYNOS4_PA_SROMC		0x12570000
> +#define EXYNOS5_PA_SROMC		0x12250000
>
>  #define EXYNOS4_PA_EHCI			0x12580000
>  #define EXYNOS4_PA_OHCI			0x12590000
> @@ -116,6 +129,7 @@
>  #define EXYNOS4_PA_MFC			0x13400000
>
>  #define EXYNOS4_PA_UART			0x13800000
> +#define EXYNOS5_PA_UART			0x12C00000
>
>  #define EXYNOS4_PA_VP			0x12C00000
>  #define EXYNOS4_PA_MIXER		0x12C10000
> @@ -124,6 +138,7 @@
>  #define EXYNOS4_PA_IIC_HDMIPHY		0x138E0000
>
>  #define EXYNOS4_PA_IIC(x)		(0x13860000 + ((x) * 0x10000))
> +#define EXYNOS5_PA_IIC(x)		(0x12C60000 + ((x) * 0x10000))
>
>  #define EXYNOS4_PA_ADC			0x13910000
>  #define EXYNOS4_PA_ADC1			0x13911000
> @@ -133,8 +148,10 @@
>  #define EXYNOS4_PA_SPDIF		0x139B0000
>
>  #define EXYNOS4_PA_TIMER		0x139D0000
> +#define EXYNOS5_PA_TIMER		0x12DD0000
>
>  #define EXYNOS4_PA_SDRAM		0x40000000
> +#define EXYNOS5_PA_SDRAM		0x40000000
>
>  /* Compatibiltiy Defines */
>
> diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h
> b/arch/arm/mach-exynos/include/mach/regs-pmu.h
> index 4fff8e9..4c53f38 100644
> --- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
> +++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
> @@ -31,6 +31,7 @@
>  #define S5P_USE_STANDBYWFE_ISP_ARM		(1 << 26)
>
>  #define S5P_SWRESET				S5P_PMUREG(0x0400)
> +#define EXYNOS_SWRESET				S5P_PMUREG(0x0400)
Please use just one.

Thank you,
Kyungmin Park
>
>  #define S5P_WAKEUP_STAT				S5P_PMUREG(0x0600)
>  #define S5P_EINT_WAKEUP_MASK			S5P_PMUREG(0x0604)
> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> index 10e235cc7..88795ea 100644
> --- a/arch/arm/plat-s5p/Kconfig
> +++ b/arch/arm/plat-s5p/Kconfig
> @@ -9,8 +9,8 @@ config PLAT_S5P
>  	bool
>  	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS)
>  	default y
> -	select ARM_VIC if !ARCH_EXYNOS4
> -	select ARM_GIC if ARCH_EXYNOS4
> +	select ARM_VIC if !ARCH_EXYNOS
> +	select ARM_GIC if ARCH_EXYNOS
>  	select GIC_NON_BANKED if ARCH_EXYNOS4
>  	select NO_IOPORT
>  	select ARCH_REQUIRE_GPIOLIB
> diff --git a/arch/arm/plat-samsung/include/plat/cpu.h
> b/arch/arm/plat-samsung/include/plat/cpu.h
> index 73cb3cf..787ceac 100644
> --- a/arch/arm/plat-samsung/include/plat/cpu.h
> +++ b/arch/arm/plat-samsung/include/plat/cpu.h
> @@ -42,6 +42,9 @@ extern unsigned long samsung_cpu_id;
>  #define EXYNOS4412_CPU_ID	0xE4412200
>  #define EXYNOS4_CPU_MASK	0xFFFE0000
>
> +#define EXYNOS5250_SOC_ID	0x43520000
> +#define EXYNOS5_SOC_MASK	0xFFFFF000
> +
>  #define IS_SAMSUNG_CPU(name, id, mask)		\
>  static inline int is_samsung_##name(void)	\
>  {						\
> @@ -58,6 +61,7 @@ IS_SAMSUNG_CPU(s5pv210, S5PV210_CPU_ID, S5PV210_CPU_MASK)
>  IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
>  IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
>  IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
> +IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
>
>  #if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
>      defined(CONFIG_CPU_S3C2416) || defined(CONFIG_CPU_S3C2440) || \
> @@ -120,6 +124,12 @@ IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID,
> EXYNOS4_CPU_MASK)
>  #define EXYNOS4210_REV_1_0	(0x10)
>  #define EXYNOS4210_REV_1_1	(0x11)
>
> +#if defined(CONFIG_SOC_EXYNOS5250)
> +# define soc_is_exynos5250()	is_samsung_exynos5250()
> +#else
> +# define soc_is_exynos5250()	0
> +#endif
> +
>  #define IODESC_ENT(x) { (unsigned long)S3C24XX_VA_##x,
> __phys_to_pfn(S3C24XX_PA_##x), S3C24XX_SZ_##x, MT_DEVICE }
>
>  #ifndef MHZ
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
