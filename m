From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Jun 2015 23:01:49 +0200
Subject: arnRe: [PATCH v2 1/5] ARM: rcm-k1879xb1: Add support for K1879XB1 SoC
In-Reply-To: <1435677307-6526-2-git-send-email-andrew@ncrmnt.org>
References: <1435677307-6526-1-git-send-email-andrew@ncrmnt.org>
 <1435677307-6526-2-git-send-email-andrew@ncrmnt.org>
Message-ID: <1814286.cdle2p4xha@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 June 2015 18:15:03 Andrew Andrianov wrote:
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -185,6 +185,7 @@ machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
>  machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
>  machine-$(CONFIG_ARCH_PXA)		+= pxa
>  machine-$(CONFIG_ARCH_QCOM)		+= qcom
> +machine-$(CONFIG_ARCH_RCM_K1879XB1)	+= rcm-k1879xb1

Could this be a bit shorter, e.g. 'mach-rcm' or 'mach-k1879xb1'?

The directories contain very few files for new platforms these days,
so we just tend to lump everything together by manufacturer.

> diff --git a/arch/arm/mach-rcm-k1879xb1/board-dt.c b/arch/arm/mach-rcm-k1879xb1/board-dt.c
> new file mode 100644
> index 0000000..48d3835
> --- /dev/null
> +++ b/arch/arm/mach-rcm-k1879xb1/board-dt.c
> @@ -0,0 +1,145 @@
> +/*
> + *  arch/arm/mach-rcm-k1879/board-dt.c

Generally speaking, please avoid comments that only contain the file
names. Also, 'board-dt' is not a particularly useful name if that is
used to handle all machines. Maybe call it the same as the platform.

> +
> +static void __iomem *k1879_sctl_base(void)
> +{
> +	return (void __iomem *)RCM_K1879_SCTL_VIRT_BASE;
> +}

Please don't hardcode virtual addresses like this. Instead read it from
DT at boot time using of_iomap or similar.

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
> +
> +static void (*k1879_i2c_fixups[])(unsigned int irq, struct irq_desc *desc) = {
> +	k1879_level_irq_i2c0_fixup,
> +	k1879_level_irq_i2c1_fixup,
> +	k1879_level_irq_i2c2_fixup,
> +	k1879_level_irq_i2c3_fixup
> +};

It looks to me like this could be implemented as a nested irq domain with
its own irqchip driver rather than a hack in platform code.

> +static void __init k1879_dt_mach_init(void)
> +{
> +	struct device_node *np;
> +
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	k1879_mif = ioremap(RCM_K1879_MIF_PHYS_BASE,
> +			    RCM_K1879_MIF_SIZE);
> +	BUG_ON(!k1879_mif);
> +
> +	np = of_find_compatible_node(NULL, NULL, "arm,sp805");
> +	WARN_ON(!np);
> +	if (np)
> +		k1879_wdt = of_iomap(np, 0);

Please move this into the watchdog driver as a reboot handler.

> +	/* Setup i2c interrupt fixups */
> +	setup_i2c_fixups();
> +
> +	/* I2C0 (Internal, HDMI) needs some extra love */
> +	do {
> +		void __iomem *mif;
> +
> +		mif = k1879_mif_base();
> +		writel(1, mif + RCM_K1879_MIF_I2C_INT_TYPE_ENA);
> +		writel(1, mif + RCM_K1879_MIF_I2C_INT_TYPE);
> +		writel(1, mif + RCM_K1879_MIF_I2C_INT_ENA);
> +	} while (0);
> +}

It would be nice if this could be moved to some driver as well, ideally
the one that already maps k1879_mif_base. Does this need to be
done really early at boot time?


> diff --git a/arch/arm/mach-rcm-k1879xb1/hardware.h b/arch/arm/mach-rcm-k1879xb1/hardware.h
> new file mode 100644
> index 0000000..2977ed7
> --- /dev/null
> +++ b/arch/arm/mach-rcm-k1879xb1/hardware.h
> @@ -0,0 +1,48 @@
> +/*
> + *  arch/arm/mach-rcm-k1879/board-dt.c

;-)


	Arnd
