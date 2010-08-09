From: rabin.vincent@stericsson.com (Rabin VINCENT)
Date: Mon, 9 Aug 2010 12:29:34 +0530
Subject: [PATCH 16/19] ARM: nomadik: register nmk_gpio_driver using
	platform_driver_probe
In-Reply-To: <1281017333-5563-16-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
	<1281017333-5563-16-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100809065933.GA900@bnru01.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 05, 2010 at 16:08:50 +0200, Uwe Kleine-K?nig wrote:
> diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
> index 977c8f9..9bc1646 100644
> --- a/arch/arm/plat-nomadik/gpio.c
> +++ b/arch/arm/plat-nomadik/gpio.c
> @@ -624,14 +624,13 @@ static struct platform_driver nmk_gpio_driver = {
>  		.owner = THIS_MODULE,
>  		.name = "gpio",
>  		},
> -	.probe = nmk_gpio_probe,
>  	.suspend = NULL, /* to be done */
>  	.resume = NULL,
>  };
>  
>  static int __init nmk_gpio_init(void)
>  {
> -	return platform_driver_register(&nmk_gpio_driver);
> +	return platform_driver_probe(&nmk_gpio_driver, nmk_gpio_probe);
>  }
>  
>  core_initcall(nmk_gpio_init);

This won't quite work, because this is a core_initcall (intentionally),
and the platform devices are not yet registered when nmk_gpio_init() is
called.  nmk_gpio_probe() could be moved to __devinit to fix the modpost
warning.

Rabin
