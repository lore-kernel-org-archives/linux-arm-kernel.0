From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Feb 2012 18:17:43 +0000
Subject: [PATCH v3] ARM: LPC32xx: Ethernet support
In-Reply-To: <1330364762-23203-1-git-send-email-stigge@antcom.de>
References: <1330364762-23203-1-git-send-email-stigge@antcom.de>
Message-ID: <20120227181742.GD2440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 06:46:02PM +0100, Roland Stigge wrote:
> +menu "LPC32XX chip components"
> +
> +config ARCH_LPC32XX_IRAM_FOR_NET
> +	bool "Use IRAM for network buffers"
> +	default n

n is the default.

> +	help
> +	  Say Y here to use the LPC internal fast IRAM (i.e. 256KB SRAM) as
> +	  network buffer.  If the total combined required buffer sizes is
> +	  larger than the size of IRAM, then SDRAM will be used instead.
> +
> +	  This can be enabled safely if the IRAM is not intended for other
> +	  uses.
> +
> +config ARCH_LPC32XX_MII_SUPPORT
> +	bool "Check to enable MII support or leave disabled for RMII support"
> +	default n

Ditto.

> --- linux-2.6.orig/arch/arm/mach-lpc32xx/common.c
> +++ linux-2.6/arch/arm/mach-lpc32xx/common.c
> @@ -186,6 +186,40 @@ struct platform_device lpc32xx_ohci_devi
>  };
>  
>  /*
> + * Network Support
> + */
> +static struct lpc_net_cfg lpc32xx_netdata = {
> +	.phy_irq = -1,
> +	.phy_mask = 0xFFFFFFF0,
> +};
> +
> +static struct resource net_resources[] = {
> +	[0] = {
> +		.start = LPC32XX_ETHERNET_BASE,
> +		.end = LPC32XX_ETHERNET_BASE + SZ_4K - 1,
> +		.flags = IORESOURCE_MEM,
> +	},

DEFINE_RES_MEM() ?

> +	[1] = {
> +		.start = IRQ_LPC32XX_ETHERNET,
> +		.end = IRQ_LPC32XX_ETHERNET,
> +		.flags = IORESOURCE_IRQ,
> +	},

DEFINE_RES_IRQ() ?
