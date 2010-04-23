From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 23 Apr 2010 21:37:09 +0200
Subject: [RFC PATCH 08/10] imx: Add MX53 core support
In-Reply-To: <1271446524-26450-9-git-send-email-r.herring@freescale.com>
References: <1271446524-26450-9-git-send-email-r.herring@freescale.com>
Message-ID: <20100423193709.GB18310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rob,

On Fri, Apr 16, 2010 at 02:35:22PM -0500, Rob Herring wrote:
> Signed-off-by: Rob Herring <r.herring@freescale.com>
> ---
>  arch/arm/mach-mx5/Kconfig                    |    7 +++-
>  arch/arm/mach-mx5/Makefile.boot              |    9 +++--
>  arch/arm/mach-mx5/clock.c                    |   44 ++++++++++++++++++++++++
>  arch/arm/mach-mx5/cpu.c                      |    4 +-
>  arch/arm/mach-mx5/mm.c                       |   17 ++++++++-
>  arch/arm/plat-mxc/devices.c                  |   13 +++++++
>  arch/arm/plat-mxc/include/mach/common.h      |    3 ++
>  arch/arm/plat-mxc/include/mach/debug-macro.S |    9 +++++
>  arch/arm/plat-mxc/include/mach/iomux-mx53.h  |   47 ++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/irqs.h        |    2 +
>  arch/arm/plat-mxc/include/mach/memory.h      |    3 ++
>  arch/arm/plat-mxc/include/mach/mx51.h        |    6 +++
>  arch/arm/plat-mxc/include/mach/mxc.h         |   13 +++++++
>  13 files changed, 169 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/iomux-mx53.h
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 1576d51..12e9ce7 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -2,7 +2,11 @@ if ARCH_MX5
>  
>  config ARCH_MX51
>  	bool
> -	default y
> +	select MXC_TZIC
> +	select ARCH_MXC_IOMUX_V3
> +
> +config ARCH_MX53
> +	bool
>  	select MXC_TZIC
>  	select ARCH_MXC_IOMUX_V3
>  
> @@ -10,6 +14,7 @@ comment "MX5 platforms:"
>  
>  config MACH_MX51_BABBAGE
>  	bool "Support MX51 BABBAGE platforms"
> +	select ARCH_MX51
>  	help
>  	  Include support for MX51 Babbage platform, also known as MX51EVK in
>  	  u-boot. This includes specific configurations for the board and its
> diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
> index 9939a19..741f604 100644
> --- a/arch/arm/mach-mx5/Makefile.boot
> +++ b/arch/arm/mach-mx5/Makefile.boot
> @@ -1,3 +1,6 @@
> -   zreladdr-y	:= 0x90008000
> -params_phys-y	:= 0x90000100
> -initrd_phys-y	:= 0x90800000
> +   zreladdr-$(CONFIG_ARCH_MX51)	:= 0x90008000
> +params_phys-$(CONFIG_ARCH_MX51)	:= 0x90000100
> +initrd_phys-$(CONFIG_ARCH_MX51)	:= 0x90800000
> +   zreladdr-$(CONFIG_ARCH_MX53)	:= 0x70008000
> +params_phys-$(CONFIG_ARCH_MX53)	:= 0x70000100
> +initrd_phys-$(CONFIG_ARCH_MX53)	:= 0x70800000
> diff --git a/arch/arm/mach-mx5/clock.c b/arch/arm/mach-mx5/clock.c
> index 726b7fe..6d0968d 100644
> --- a/arch/arm/mach-mx5/clock.c
> +++ b/arch/arm/mach-mx5/clock.c
> @@ -33,6 +33,7 @@ static struct clk pll1_main_clk;
>  static struct clk pll1_sw_clk;
>  static struct clk pll2_sw_clk;
>  static struct clk pll3_sw_clk;
> +static struct clk pll4_sw_clk;
>  static struct clk lp_apm_clk;
>  static struct clk periph_apm_clk;
>  static struct clk ahb_clk;
> @@ -41,6 +42,7 @@ static struct clk ipg_clk;
>  static void __iomem *pll1_base;
>  static void __iomem *pll2_base;
>  static void __iomem *pll3_base;
> +static void __iomem *pll4_base;
>  
does pll4 only exist on mx53?  If yes, is it worth to add #ifdefs, if
not, please make a seperate patch. 

>  #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
>  
> @@ -102,6 +104,8 @@ static inline void __iomem *_get_pll_base(struct clk *pll)
>  		return pll2_base;
>  	else if (pll == &pll3_sw_clk)
>  		return pll3_base;
> +	else if (pll == &pll4_sw_clk)
> +		return pll4_base;
>  	else
>  		BUG();
>  
> @@ -654,6 +658,15 @@ static struct clk pll3_sw_clk = {
>  	.disable = _clk_pll_disable,
>  };
>  
> +/* PLL4 SW supplies to display clocks */
> +static struct clk pll4_sw_clk = {
> +	.parent = &osc_clk,
> +	.set_rate = _clk_pll_set_rate,
> +	.get_rate = clk_pll_get_rate,
> +	.enable = _clk_pll_enable,
> +	.disable = _clk_pll_disable,
> +};
> +
>  /* Low-power Audio Playback Mode clock */
>  static struct clk lp_apm_clk = {
>  	.parent = &osc_clk,
> @@ -833,3 +846,34 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
>  	mxc_timer_init(&gpt_clk, base, MX51_MXC_INT_GPT);
>  	return 0;
>  }
> +
> +int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
> +			unsigned long ckih1, unsigned long ckih2)
> +{
> +	int i;
> +	__iomem void *base;
> +
> +	pll1_base = ioremap(MX5x_FIXUP_ADDR(MX51_PLL1_BASE_ADDR), SZ_4K);
> +	pll2_base = ioremap(MX5x_FIXUP_ADDR(MX51_PLL2_BASE_ADDR), SZ_4K);
> +	pll3_base = ioremap(MX5x_FIXUP_ADDR(MX51_PLL3_BASE_ADDR), SZ_4K);
> +	pll4_base = ioremap(MX5x_FIXUP_ADDR(MX5x_PLL4_BASE_ADDR), SZ_4K);
> +
> +	external_low_reference = ckil;
> +	external_high_reference = ckih1;
> +	ckih2_reference = ckih2;
> +	oscillator_reference = osc;
> +
> +	for (i = 0; i < ARRAY_SIZE(lookups); i++)
> +		clkdev_add(&lookups[i]);
> +
> +	clk_tree_init();
> +
> +	clk_enable(&cpu_clk);
> +	clk_enable(&main_bus_clk);
> +
> +	/* System timer */
> +	base = ioremap(MX5x_FIXUP_ADDR(MX51_GPT1_BASE_ADDR), SZ_4K);
> +	mxc_timer_init(&gpt_clk, base, MX51_MXC_INT_GPT);
> +	return 0;
> +}
> +
> diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
> index 283ab7e..e5e0e30 100644
> --- a/arch/arm/mach-mx5/cpu.c
> +++ b/arch/arm/mach-mx5/cpu.c
> @@ -78,7 +78,7 @@ static int __init post_cpu_init(void)
>  	if (!cpu_is_mx51())
>  		return 0;
>  
> -	base = ioremap(MX51_AIPS1_BASE_ADDR, SZ_4K);
> +	base = ioremap(MX5x_FIXUP_ADDR(MX51_AIPS1_BASE_ADDR), SZ_4K);
>  	__raw_writel(0x0, base + 0x40);
>  	__raw_writel(0x0, base + 0x44);
>  	__raw_writel(0x0, base + 0x48);
> @@ -87,7 +87,7 @@ static int __init post_cpu_init(void)
>  	__raw_writel(reg, base + 0x50);
>  	iounmap(base);
>  
> -	base = ioremap(MX51_AIPS2_BASE_ADDR, SZ_4K);
> +	base = ioremap(MX5x_FIXUP_ADDR(MX51_AIPS2_BASE_ADDR), SZ_4K);
>  	__raw_writel(0x0, base + 0x40);
>  	__raw_writel(0x0, base + 0x44);
>  	__raw_writel(0x0, base + 0x48);
> diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
> index 8ad1d0c..1b0cf12 100644
> --- a/arch/arm/mach-mx5/mm.c
> +++ b/arch/arm/mach-mx5/mm.c
> @@ -43,10 +43,12 @@ void __init mx5_map_io(void)
>  	void __iomem *base;
>  
>  	mxc_set_cpu_type(MXC_CPU_MX51);
> +	if (cpu_is_mx53())
> +		mxc_io_desc[0].pfn -= __phys_to_pfn(0x20000000);
hmm, if (cpu_is_mx53()), you don't want the
mxc_set_cpu_type(MXC_CPU_MX51); directly above, no?
> 
> -	base = ioremap(MX51_IOMUXC_BASE_ADDR, SZ_4K);
> +	base = ioremap(MX5x_FIXUP_ADDR(MX51_IOMUXC_BASE_ADDR), SZ_4K);
>  	mxc_iomux_v3_init(base);
> -	base = ioremap(MX51_WDOG_BASE_ADDR, SZ_4K);
> +	base = ioremap(MX5x_FIXUP_ADDR(MX51_WDOG_BASE_ADDR), SZ_4K);
>  	mxc_arch_reset_init(base);
>  	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
>  }
> @@ -67,3 +69,14 @@ void __init mx51_init_irq(void)
>  
>  	tzic_init_irq(tzic_virt);
>  }
> +
> +void __init mx5x_init_irq(void)
> +{
> +	void __iomem *tzic_virt;
> +
> +	tzic_virt = ioremap(MX5x_TZIC_BASE_ADDR, SZ_4K);
> +	if (!tzic_virt)
> +		panic("unable to map TZIC interrupt controller\n");
> +	tzic_init_irq(tzic_virt);
> +}
> +
> diff --git a/arch/arm/plat-mxc/devices.c b/arch/arm/plat-mxc/devices.c
> index 56f2fb5..7c4c722 100644
> --- a/arch/arm/plat-mxc/devices.c
> +++ b/arch/arm/plat-mxc/devices.c
> @@ -20,13 +20,26 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <mach/common.h>
> +#include <mach/hardware.h>
>  
>  int __init mxc_register_device(struct platform_device *pdev, void *data)
>  {
>  	int ret;
> +	int i;
>  
>  	pdev->dev.platform_data = data;
>  
> +	if (cpu_is_mx53()) {
> +		for (i = 0; i < pdev->num_resources; i++) {
> +			struct resource *r = &pdev->resource[i];
> +			if (resource_type(r) != IORESOURCE_MEM)
> +				continue;
> +
> +			r->start = MX5x_FIXUP_ADDR(r->start);
> +			r->end = MX5x_FIXUP_ADDR(r->end);
> +		}
> +	}
> +
>  	ret = platform_device_register(pdev);
>  	if (ret)
>  		pr_debug("Unable to register platform device '%s': %d\n",
> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> index 0766746..478cf7b 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -31,6 +31,7 @@ extern void mx27_init_irq(void);
>  extern void mx31_init_irq(void);
>  extern void mx35_init_irq(void);
>  extern void mx51_init_irq(void);
> +extern void mx5x_init_irq(void);
>  extern void mxc91231_init_irq(void);
>  extern void mxc_timer_init(struct clk *timer_clk, void __iomem *, int);
>  extern int mx1_clocks_init(unsigned long fref);
> @@ -41,6 +42,8 @@ extern int mx31_clocks_init(unsigned long fref);
>  extern int mx35_clocks_init(void);
>  extern int mx51_clocks_init(unsigned long ckil, unsigned long osc,
>  			unsigned long ckih1, unsigned long ckih2);
> +extern int mx53_clocks_init(unsigned long ckil, unsigned long osc,
> +			unsigned long ckih1, unsigned long ckih2);
>  extern int mxc91231_clocks_init(unsigned long fref);
>  extern int mxc_register_gpios(void);
>  extern int mxc_register_device(struct platform_device *pdev, void *data);
> diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
> index a99eedf..b71cb57 100644
> --- a/arch/arm/plat-mxc/include/mach/debug-macro.S
> +++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
> @@ -54,6 +54,15 @@
>  #define UART_VADDR	MX51_AIPS1_IO_ADDRESS(MX51_UART1_BASE_ADDR)
>  #endif
>  
> +#ifdef CONFIG_ARCH_MX53
> +#ifdef UART_PADDR
> +#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
> +#endif
> +#include <mach/mx51.h>
> +#define UART_PADDR	(MX51_UART1_BASE_ADDR - 0x20000000)
> +#define UART_VADDR	MX51_AIPS1_IO_ADDRESS(MX51_UART1_BASE_ADDR)
> +#endif
> +
>  #ifdef CONFIG_ARCH_MXC91231
>  #ifdef UART_PADDR
>  #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> new file mode 100644
> index 0000000..38497d9
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> @@ -0,0 +1,47 @@
> +/*
> + * Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#ifndef __MACH_IOMUX_MX51_H__
> +#define __MACH_IOMUX_MX51_H__
...MX53_H__ please
> +
> +#include <mach/iomux-v3.h>
> +
> +/*
> + * various IOMUX alternate output functions (1-7)
> + */
> +typedef enum iomux_config {
> +	IOMUX_CONFIG_ALT0,
> +	IOMUX_CONFIG_ALT1,
> +	IOMUX_CONFIG_ALT2,
> +	IOMUX_CONFIG_ALT3,
> +	IOMUX_CONFIG_ALT4,
> +	IOMUX_CONFIG_ALT5,
> +	IOMUX_CONFIG_ALT6,
> +	IOMUX_CONFIG_ALT7,
> +	IOMUX_CONFIG_GPIO,	/* added to help user use GPIO mode */
> +	IOMUX_CONFIG_SION = 0x1 << 4,	/* LOOPBACK:MUX SION bit */
> +} iomux_pin_cfg_t;
> +
> +/* Pad control groupings */
> +#define MX53_UART1_PAD_CTRL	(PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_PUE | \
> +				PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST)
> +
> +/*
> + * The naming convention for the pad modes is MX51_PAD_<padname>__<padmode>
> + * If <padname> or <padmode> refers to a GPIO, it is named
> + * GPIO_<unit>_<num> see also iomux-v3.h
> + */
> +
> +/*						PAD      MUX   ALT INPSE PATH PADCTRL */
> +#define MX53_PAD_CSI0_D11__UART1_RXD	IOMUX_PAD(0x418, 0xEC, IOMUX_CONFIG_ALT2, 0x878, 1, MX53_UART1_PAD_CTRL)
> +#define MX53_PAD_CSI0_D10__UART1_TXD	IOMUX_PAD(0x414, 0xE8, IOMUX_CONFIG_ALT2, 0x0, 0, MX53_UART1_PAD_CTRL)
> +
> +#endif /* __MACH_IOMUX_MX51_H__ */
ditto

> diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
> index 769a137..c8b7feb 100644
> --- a/arch/arm/plat-mxc/include/mach/irqs.h
> +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> @@ -25,6 +25,8 @@
>  /* these are ordered by size to support multi-SoC kernels */
>  #if defined CONFIG_ARCH_MX2
>  #define MXC_GPIO_IRQS		(32 * 6)
> +#elif defined CONFIG_ARCH_MX53
> +#define MXC_GPIO_IRQS		(32 * 6)
>  #elif defined CONFIG_ARCH_MX1
>  #define MXC_GPIO_IRQS		(32 * 4)
>  #elif defined CONFIG_ARCH_MX25
> diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
> index 05e5b75..53275a6 100644
> --- a/arch/arm/plat-mxc/include/mach/memory.h
> +++ b/arch/arm/plat-mxc/include/mach/memory.h
> @@ -17,6 +17,7 @@
>  #define MX27_PHYS_OFFSET	UL(0xa0000000)
>  #define MX3x_PHYS_OFFSET	UL(0x80000000)
>  #define MX51_PHYS_OFFSET	UL(0x90000000)
> +#define MX53_PHYS_OFFSET	UL(0x70000000)
>  #define MXC91231_PHYS_OFFSET	UL(0x90000000)
>  
>  #if !defined(CONFIG_RUNTIME_PHYS_OFFSET)
> @@ -34,6 +35,8 @@
>  #  define PHYS_OFFSET		MXC91231_PHYS_OFFSET
>  # elif defined CONFIG_ARCH_MX51
>  #  define PHYS_OFFSET		MX51_PHYS_OFFSET
> +# elif defined CONFIG_ARCH_MX53
> +#  define PHYS_OFFSET		MX53_PHYS_OFFSET
>  # endif
>  #endif
>  
> diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
> index b83963f..7759df7 100644
> --- a/arch/arm/plat-mxc/include/mach/mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/mx51.h
> @@ -55,6 +55,7 @@
>  
>  #define MX51_TZIC_BASE_ADDR_TO1		0x8FFFC000
>  #define MX51_TZIC_BASE_ADDR		0xE0000000
> +#define MX5x_TZIC_BASE_ADDR		0x0FFFC000
>  
>  #define MX51_DEBUG_BASE_ADDR		0x60000000
>  #define MX51_DEBUG_SIZE			(36 * SZ_1K)
> @@ -170,6 +171,7 @@
>  #define MX51_PLL1_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x00080000)
>  #define MX51_PLL2_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x00084000)
>  #define MX51_PLL3_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x00088000)
> +#define MX5x_PLL4_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x0008C000)
>  #define MX51_AHBMAX_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x00094000)
>  #define MX51_IIM_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x00098000)
>  #define MX51_CSU_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x0009C000)
> @@ -234,6 +236,10 @@
>  	(MX51_IS_MODULE(x, AIPS1) ? MX51_AIPS1_IO_ADDRESS(x) :	\
>  	0xDEADBEEF)
>  
> +#define MX5x_FIXUP_ADDR(x) ((cpu_is_mx53() && \
> +	(MX51_IS_MODULE(x, AIPS1) || MX51_IS_MODULE(x, AIPS2) || MX51_IS_MODULE(x, SPBA0))) ? \
> +	((x) - 0x20000000) : (x))
> +
>  /*
>   * define the address mapping macros: in physical address order
>   */
> diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
> index ec85f14..b77f71e 100644
> --- a/arch/arm/plat-mxc/include/mach/mxc.h
> +++ b/arch/arm/plat-mxc/include/mach/mxc.h
> @@ -31,6 +31,7 @@
>  #define MXC_CPU_MX31		31
>  #define MXC_CPU_MX35		35
>  #define MXC_CPU_MX51		51
> +#define MXC_CPU_MX53		53
>  #define MXC_CPU_MXC91231	91231
>  
>  #ifndef __ASSEMBLY__
> @@ -121,6 +122,18 @@ extern unsigned int __mxc_cpu_type;
>  # define cpu_is_mx51()		(0)
>  #endif
>  
> +#ifdef CONFIG_ARCH_MX53
> +# ifdef mxc_cpu_type
> +#  undef mxc_cpu_type
> +#  define mxc_cpu_type __mxc_cpu_type
> +# else
> +#  define mxc_cpu_type MXC_CPU_MX53
> +# endif
> +# define cpu_is_mx53()		(mxc_cpu_type == MXC_CPU_MX53)
> +#else
> +# define cpu_is_mx53()		(0)
> +#endif
> +
>  #ifdef CONFIG_ARCH_MXC91231
>  # ifdef mxc_cpu_type
>  #  undef mxc_cpu_type
> -- 
> 1.6.0.4
all in all this looks like a sort of minimal change to make it work
(which is good), but it destroys the efforts spend in the past to use
proper name spaces and have understandable, modular and easy code.  So
according to my preferences about how to program the patch is wrong.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
