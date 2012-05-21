From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 21 May 2012 09:22:18 +0200
Subject: [PATCH 4/4] MXS-MMC: Add wp-inverted property
In-Reply-To: <1337562140-5739-4-git-send-email-marex@denx.de>
References: <1337562140-5739-1-git-send-email-marex@denx.de>
 <1337562140-5739-4-git-send-email-marex@denx.de>
Message-ID: <20409.60714.663812.681159@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Marek Vasut writes:
> The write-protect GPIO is inverted on some boards. Handle such case.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  Documentation/devicetree/bindings/mmc/mxs-mmc.txt |    1 +
>  drivers/mmc/host/mxs-mmc.c                        |   11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
> index 14d870a..0a7d2cd 100644
> --- a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
> @@ -13,6 +13,7 @@ Required properties:
>  
>  Optional properties:
>  - wp-gpios: Specify GPIOs for write protection
> +- wp-inverted: Set if the write protection GPIO is inverted
>  
>  Examples:
>  
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 277161d..119beb9 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -164,16 +164,23 @@ struct mxs_mmc_host {
>  	spinlock_t			lock;
>  	int				sdio_irq_en;
>  	int				wp_gpio;
> +	int				wp_inverted:1;
>  };
>  
>  static int mxs_mmc_get_ro(struct mmc_host *mmc)
>  {
>  	struct mxs_mmc_host *host = mmc_priv(mmc);
> +	int ret;
>  
>  	if (!gpio_is_valid(host->wp_gpio))
>  		return -EINVAL;
>  
> -	return gpio_get_value(host->wp_gpio);
> +	ret = gpio_get_value(host->wp_gpio);
> +
> +	if (host->wp_inverted)
> +		ret = !ret;
> +
> +	return ret;
>  }
>  
>  static int mxs_mmc_get_cd(struct mmc_host *mmc)
> @@ -786,6 +793,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  		else if (bus_width == 8)
>  			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
>  		host->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
> +		if (of_find_property(np, "wp-inverted", NULL))
> +			host->wp_inverted = 1;
>
Why not simply specify the GPIO in question as being active-low in the
GPIO definition and use of_get_named_gpio_flags()?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
