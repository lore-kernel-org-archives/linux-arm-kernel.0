From: cjb@laptop.org (Chris Ball)
Date: Mon, 22 Apr 2013 16:03:15 -0400
Subject: [PATCH 1/3] mmc: mvsdio: Support inverted CD and WP GPIO lines
In-Reply-To: <1366660500-26835-2-git-send-email-gmbnomis@gmail.com> (Simon
 Baatz's message of "Mon, 22 Apr 2013 21:54:58 +0200")
References: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
 <1366660500-26835-2-git-send-email-gmbnomis@gmail.com>
Message-ID: <87wqrutjss.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Apr 22 2013, Simon Baatz wrote:
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index 145cdaf..d444efd 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -691,6 +691,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
>  	struct resource *r;
>  	int ret, irq;
>  	int gpio_card_detect, gpio_write_protect;
> +	enum of_gpio_flags gpio_flags;
>  	struct pinctrl *pinctrl;
>  
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -731,8 +732,17 @@ static int __init mvsd_probe(struct platform_device *pdev)
>  		}
>  
>  		host->base_clock = clk_get_rate(host->clk) / 2;
> -		gpio_card_detect = of_get_named_gpio(np, "cd-gpios", 0);
> -		gpio_write_protect = of_get_named_gpio(np, "wp-gpios", 0);
> +		gpio_card_detect = of_get_named_gpio_flags(np, "cd-gpios", 0,
> +						     &gpio_flags);
> +		if (gpio_is_valid(gpio_card_detect) &&
> +		    !(gpio_flags & OF_GPIO_ACTIVE_LOW))
> +			mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
> +
> +		gpio_write_protect = of_get_named_gpio_flags(np, "wp-gpios", 0,
> +						       &gpio_flags);
> +		if (gpio_is_valid(gpio_write_protect) &&
> +		    !(gpio_flags & OF_GPIO_ACTIVE_LOW))
> +			mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
>  	} else {
>  		const struct mvsdio_platform_data *mvsd_data;
>  		mvsd_data = pdev->dev.platform_data;

The core function mmc_of_parse() (new in 3.9) will do all of this DT
parsing for you, and will also take care of the driver's later calls
to mmc_gpio_request_{cd,wp}().  Could you try using that function
instead, please?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
