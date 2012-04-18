From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 18 Apr 2012 08:02:30 +0200
Subject: [PATCH v2 8/8] ARM: LPC32xx: Device tree support
In-Reply-To: <1334682507-15055-9-git-send-email-stigge@antcom.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <1334682507-15055-9-git-send-email-stigge@antcom.de>
Message-ID: <20120418060230.GC17506@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roland Stigge wrote:
> This patch does the actual device tree switch for the LPC32xx SoC.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> ---
> 
> Applies to v3.4-rc3
> 
>  Documentation/devicetree/bindings/arm/lpc32xx-mic.txt |   38 +++
>  Documentation/devicetree/bindings/arm/lpc32xx.txt     |    8 
>  arch/arm/Kconfig                                      |    1 
>  arch/arm/mach-lpc32xx/Kconfig                         |   26 --
>  arch/arm/mach-lpc32xx/clock.c                         |   77 +++----
>  arch/arm/mach-lpc32xx/common.c                        |  192 ------------------
>  arch/arm/mach-lpc32xx/common.h                        |   14 -
>  arch/arm/mach-lpc32xx/irq.c                           |   78 +++++--

Could this perhaps be split into another patch. Basically this is a
conversion to IRQ domain *and* device tree support. But maybe it isn't worth
the effort.

>  arch/arm/mach-lpc32xx/phy3250.c                       |  146 +++++--------

While at it, this should probably be renamed board-dt.c or something similar
since it is no longer phy3250 specific.

[...]
> --- linux-2.6.orig/arch/arm/mach-lpc32xx/phy3250.c
> +++ linux-2.6/arch/arm/mach-lpc32xx/phy3250.c
[...]
> -static void __init phy3250_board_init(void)
> +static void __init lpc3250_machine_init(void)
>  {
>  	u32 tmp;
> -	int i;
> -
> -	lpc32xx_gpio_init();
> -
> -	/* Register GPIOs used on this board */
> -	if (gpio_request(SPI0_CS_GPIO, "spi0 cs"))
> -		printk(KERN_ERR "Error requesting gpio %u",
> -			SPI0_CS_GPIO);
> -	else if (gpio_direction_output(SPI0_CS_GPIO, 1))
> -		printk(KERN_ERR "Error setting gpio %u to output",
> -			SPI0_CS_GPIO);
> -
> -	/* Setup network interface for RMII mode */
> -	tmp = __raw_readl(LPC32XX_CLKPWR_MACCLK_CTRL);
> -	tmp &= ~LPC32XX_CLKPWR_MACCTRL_PINS_MSK;
> -	tmp |= LPC32XX_CLKPWR_MACCTRL_USE_RMII_PINS;
> -	__raw_writel(tmp, LPC32XX_CLKPWR_MACCLK_CTRL);
>  
>  	/* Setup SLC NAND controller muxing */
>  	__raw_writel(LPC32XX_CLKPWR_NANDCLK_SEL_SLC,
> @@ -300,6 +265,12 @@ static void __init phy3250_board_init(vo
>  	tmp |= LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_TFT16;
>  	__raw_writel(tmp, LPC32XX_CLKPWR_LCDCLK_CTRL);
>  
> +	/* Set up USB power */
> +	tmp = __raw_readl(LPC32XX_CLKPWR_USB_CTRL);
> +	tmp |= LPC32XX_CLKPWR_USBCTRL_HCLK_EN |
> +		LPC32XX_CLKPWR_USBCTRL_USBI2C_EN;
> +	__raw_writel(tmp, LPC32XX_CLKPWR_USB_CTRL);
> +
>  	/* Set up I2C pull levels */
>  	tmp = __raw_readl(LPC32XX_CLKPWR_I2C_CLK_CTRL);
>  	tmp |= LPC32XX_CLKPWR_I2CCLK_USBI2CHI_DRIVE |
> @@ -321,33 +292,35 @@ static void __init phy3250_board_init(vo
>  	/*
>  	 * AMBA peripheral clocks need to be enabled prior to AMBA device
>  	 * detection or a data fault will occur, so enable the clocks
> -	 * here. However, we don't want to enable them if the peripheral
> -	 * isn't included in the image
> +	 * here.
>  	 */
> -#ifdef CONFIG_FB_ARMCLCD
>  	tmp = __raw_readl(LPC32XX_CLKPWR_LCDCLK_CTRL);
>  	__raw_writel((tmp | LPC32XX_CLKPWR_LCDCTRL_CLK_EN),
>  		LPC32XX_CLKPWR_LCDCLK_CTRL);
> -#endif
> -#ifdef CONFIG_SPI_PL022
> +
>  	tmp = __raw_readl(LPC32XX_CLKPWR_SSP_CLK_CTRL);
>  	__raw_writel((tmp | LPC32XX_CLKPWR_SSPCTRL_SSPCLK0_EN),
>  		LPC32XX_CLKPWR_SSP_CLK_CTRL);
> -#endif
>  
> -	platform_add_devices(phy3250_devs, ARRAY_SIZE(phy3250_devs));
> -	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
> -		struct amba_device *d = amba_devs[i];
> -		amba_device_register(d, &iomem_resource);
> -	}
> +	tmp = __raw_readl(LPC32XX_CLKPWR_DMA_CLK_CTRL);
> +	__raw_writel((tmp | LPC32XX_CLKPWR_DMACLKCTRL_CLK_EN),
> +		     LPC32XX_CLKPWR_DMA_CLK_CTRL);
>  	/* Test clock needed for UDA1380 initial init */
>  	__raw_writel(LPC32XX_CLKPWR_TESTCLK2_SEL_MOSC |
>  		LPC32XX_CLKPWR_TESTCLK_TESTCLK2_EN,
>  		LPC32XX_CLKPWR_TEST_CLK_SEL);

A lot of these seem to be gratuitous here. Can control of these clocks not be
exposed via the clock framework? That would allow the controllers to only
activate them when actually needed. This could also be done in follow up
patches, though.

[...]
> +	/* Register GPIOs used on this board */
> +	if (gpio_request(SPI0_CS_GPIO, "spi0 cs"))
> +		printk(KERN_ERR "Error requesting gpio %u",
> +			SPI0_CS_GPIO);
> +	else if (gpio_direction_output(SPI0_CS_GPIO, 1))
> +		printk(KERN_ERR "Error setting gpio %u to output",
> +			SPI0_CS_GPIO);

This should be initialized based on data from the device tree.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/97cf50b6/attachment.sig>
