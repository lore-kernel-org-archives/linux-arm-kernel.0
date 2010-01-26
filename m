From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 26 Jan 2010 11:49:06 +0100
Subject: [PATCH] ARM: IMX31: configure pins iomux for SDHC setup on
	litekit board.
In-Reply-To: <1264502104-16552-1-git-send-email-vzapolskiy@gmail.com>
References: <1264502104-16552-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <20100126104906.GH18439@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 01:35:04PM +0300, Vladimir Zapolskiy wrote:
> This patch adds SDHC support, and corrects current pins setup.

Just double-checked the schematics and it seems I indeed got the
read-only pin wrong. And I didn't need the 100K pulls, SDHC/MMC worked
fine for me without. But I'm happy to add them, so

Acked-by: Daniel Mack <daniel@caiaq.de>

Thanks for working on this.

Daniel

> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> Cc: Daniel Mack <daniel@caiaq.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx3/mx31lite-db.c |   28 ++++++++++++++++++++--------
>  1 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
> index 694611d..7f4d16a 100644
> --- a/arch/arm/mach-mx3/mx31lite-db.c
> +++ b/arch/arm/mach-mx3/mx31lite-db.c
> @@ -67,6 +67,13 @@ static unsigned int litekit_db_board_pins[] __initdata = {
>  	MX31_PIN_CSPI1_SS0__SS0,
>  	MX31_PIN_CSPI1_SS1__SS1,
>  	MX31_PIN_CSPI1_SS2__SS2,
> +	/* SDHC1 */
> +	MX31_PIN_SD1_DATA0__SD1_DATA0,
> +	MX31_PIN_SD1_DATA1__SD1_DATA1,
> +	MX31_PIN_SD1_DATA2__SD1_DATA2,
> +	MX31_PIN_SD1_DATA3__SD1_DATA3,
> +	MX31_PIN_SD1_CLK__SD1_CLK,
> +	MX31_PIN_SD1_CMD__SD1_CMD,
>  };
>  
>  /* UART */
> @@ -79,11 +86,11 @@ static struct imxuart_platform_data uart_pdata __initdata = {
>  static int gpio_det, gpio_wp;
>  
>  #define MMC_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
> -			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
> +		     PAD_CTL_ODE_CMOS)
>  
>  static int mxc_mmc1_get_ro(struct device *dev)
>  {
> -	return gpio_get_value(IOMUX_TO_GPIO(MX31_PIN_LCS0));
> +	return gpio_get_value(IOMUX_TO_GPIO(MX31_PIN_GPIO1_6));
>  }
>  
>  static int mxc_mmc1_init(struct device *dev,
> @@ -94,12 +101,17 @@ static int mxc_mmc1_init(struct device *dev,
>  	gpio_det = IOMUX_TO_GPIO(MX31_PIN_DCD_DCE1);
>  	gpio_wp = IOMUX_TO_GPIO(MX31_PIN_GPIO1_6);
>  
> -	mxc_iomux_set_pad(MX31_PIN_SD1_DATA0, MMC_PAD_CFG);
> -	mxc_iomux_set_pad(MX31_PIN_SD1_DATA1, MMC_PAD_CFG);
> -	mxc_iomux_set_pad(MX31_PIN_SD1_DATA2, MMC_PAD_CFG);
> -	mxc_iomux_set_pad(MX31_PIN_SD1_DATA3, MMC_PAD_CFG);
> +	mxc_iomux_set_pad(MX31_PIN_SD1_DATA0,
> +			  MMC_PAD_CFG | PAD_CTL_PUE_PUD | PAD_CTL_100K_PU);
> +	mxc_iomux_set_pad(MX31_PIN_SD1_DATA1,
> +			  MMC_PAD_CFG | PAD_CTL_PUE_PUD | PAD_CTL_100K_PU);
> +	mxc_iomux_set_pad(MX31_PIN_SD1_DATA2,
> +			  MMC_PAD_CFG | PAD_CTL_PUE_PUD | PAD_CTL_100K_PU);
> +	mxc_iomux_set_pad(MX31_PIN_SD1_DATA3,
> +			  MMC_PAD_CFG | PAD_CTL_PUE_PUD | PAD_CTL_100K_PU);
> +	mxc_iomux_set_pad(MX31_PIN_SD1_CMD,
> +			  MMC_PAD_CFG | PAD_CTL_PUE_PUD | PAD_CTL_100K_PU);
>  	mxc_iomux_set_pad(MX31_PIN_SD1_CLK, MMC_PAD_CFG);
> -	mxc_iomux_set_pad(MX31_PIN_SD1_CMD, MMC_PAD_CFG);
>  
>  	ret = gpio_request(gpio_det, "MMC detect");
>  	if (ret)
> @@ -133,7 +145,7 @@ static void mxc_mmc1_exit(struct device *dev, void *data)
>  {
>  	gpio_free(gpio_det);
>  	gpio_free(gpio_wp);
> -	free_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO1_1), data);
> +	free_irq(IOMUX_TO_IRQ(MX31_PIN_DCD_DCE1), data);
>  }
>  
>  static struct imxmmc_platform_data mmc_pdata = {
> -- 
> 1.6.5.4
> 
