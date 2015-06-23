From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Jun 2015 17:11:15 +0100
Subject: [PATCH 1/4] ARM: rcm-k1879xb1: Add support for K1879XB1 SoC
In-Reply-To: <1435074604-19312-2-git-send-email-andrew@ncrmnt.org>
References: <1435074604-19312-1-git-send-email-andrew@ncrmnt.org>
 <1435074604-19312-2-git-send-email-andrew@ncrmnt.org>
Message-ID: <20150623161114.GB7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 23, 2015 at 06:50:01PM +0300, Andrew Andrianov wrote:
> +config ARCH_RCM_K1879XB1
> +	bool "RC Module K1879XB1YA"
> +	depends on MMU
> +	select CPU_V6
> +        select ARM_AMBA
> +	select ARM_VIC

Obviously something's up with the indentation on the ARM_AMBA line...
Also, these select statements should be sorted alphabetically to help
avoid future merge conflicts.

> @@ -1417,6 +1418,7 @@ config DEBUG_UART_PHYS
>  	default 0xfffb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
>  	default 0xfffe8600 if DEBUG_UART_BCM63XX
>  	default 0xfffff700 if ARCH_IOP33X
> +	default 0x2002b000 if ARCH_RCM_K1879XB1
>  	depends on ARCH_EP93XX || \
>  	        DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
>  		DEBUG_LL_UART_EFM32 || \
> @@ -1511,6 +1513,7 @@ config DEBUG_UART_VIRT
>  	default 0xfefff700 if ARCH_IOP33X
>  	default 0xff003000 if DEBUG_U300_UART
>  	default 0xffd01000 if DEBUG_HIP01_UART
> +	default 0xf802b000 if ARCH_RCM_K1879XB1

Both of these lists have an order - please add your entries in order as
well.

>  	default DEBUG_UART_PHYS if !MMU
>  	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
>  		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 985227c..9beb65f 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -184,6 +184,7 @@ machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
>  machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
>  machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
>  machine-$(CONFIG_ARCH_PXA)		+= pxa
> +machine-$(CONFIG_ARCH_RCM_K1879XB1)	+= rcm-k1879xb1
>  machine-$(CONFIG_ARCH_QCOM)		+= qcom

R doesn't come between P and Q, the order of these options is even
documented in the commentry above the list (so here we have more
proof that comments are worthless. :()

> +static struct map_desc k1879_io_desc[] __initdata = {
> +	{
> +		.virtual	= RCM_K1879_AREA0_VIRT_BASE,
> +		.pfn		= __phys_to_pfn(RCM_K1879_AREA0_PHYS_BASE),
> +		.length		= RCM_K1879_AREA0_SIZE,
> +		.type		= MT_DEVICE,
> +	},
> +	{
> +		.virtual	= RCM_K1879_AREA1_VIRT_BASE,
> +		.pfn		= __phys_to_pfn(RCM_K1879_AREA1_PHYS_BASE),
> +		.length		= RCM_K1879_AREA1_SIZE,
> +		.type		= MT_DEVICE,
> +	},
> +};

We've moved away from static mapping - is there a reason to keep these?

> +static void __iomem *k1879_mif_base(void)
> +{
> +	BUG_ON(!g_k1879_mif);
> +	return g_k1879_mif;
> +}
> +
> +static void __iomem *k1879_sctl_base(void)
> +{
> +	return (void __iomem *)RCM_K1879_SCTL_VIRT_BASE;
> +}
> +
> +static void k1879_level_irq_i2c0_fixup(unsigned int irq, struct irq_desc *desc)
> +{
> +	writel(1, k1879_mif_base() + RCM_K1879_MIF_I2C_INT_STAT);
> +	handle_level_irq(irq, desc);
> +}
> +
> +static void k1879_level_irq_i2c1_fixup(unsigned int irq, struct irq_desc *desc)
> +{
> +	writel(1 << 0, k1879_sctl_base() + RCM_K1879_SCTL_INT_P_OUT);
> +	handle_level_irq(irq, desc);
> +}
> +
> +static void k1879_level_irq_i2c2_fixup(unsigned int irq, struct irq_desc *desc)
> +{
> +	writel(1 << 1, k1879_sctl_base() + RCM_K1879_SCTL_INT_P_OUT);
> +	handle_level_irq(irq, desc);
> +}
> +
> +static void k1879_level_irq_i2c3_fixup(unsigned int irq, struct irq_desc *desc)
> +{
> +	writel(1 << 2, k1879_sctl_base() + RCM_K1879_SCTL_INT_P_OUT);
> +	handle_level_irq(irq, desc);
> +}

I'm not sure this is the best way to deal with this - but I need to look
at the irqchip stuff to suggest an alternative.  Maybe you could provide
a description of what's going on here first?

> +void k1879_restart(enum reboot_mode mode, const char *cmd)

static?

> +{
> +	/* The recommended way to do a soft-reboot on this platform
> +	   is write directly to watchdog registers and cause an immediate
> +	   system reboot
> +	*/
> +	void __iomem *regs;
> +
> +	pr_info("k1879: Requested system restart\n");

I assume this is debugging - do you need to print this?

> +	regs = ioremap_nocache(0x20025000, 0xfff);

Please use ioremap() instead.  Both of these calls may sleep, and so
should not be used in this path (which can be called from atomic
contexts.)  Hence, this needs to happen elsewhere (in your .init_machine
method.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
