From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 1 Dec 2010 12:17:41 +0200
Subject: [PATCH v5] ARM: s3c244x: Fix mess with gpio {set,
	get}_pull callbacks
In-Reply-To: <001301cb9129$15f1b5c0$41d52140$%kim@samsung.com>
References: <4CF55785.5090403@metafoo.de>
	<1291147949-18812-1-git-send-email-anarsoul@gmail.com>
	<001301cb9129$15f1b5c0$41d52140$%kim@samsung.com>
Message-ID: <201012011217.41602.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 December 2010 09:26:31 Kukjin Kim wrote:

> How about following...
> 
> +void __init s3c2440_map_io(void)
> +{
> +	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_1up;
> +	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_1up;
> +
> +	s3c244x_map_io();
> +}

What's difference except order?
 
> Yeah, however, in my opinion, need to add following during gpiolib_init().
> 
> @@ -222,6 +222,11 @@ static __init int s3c24xx_gpiolib_init(void)
>                 if (!chip->config)
>                         chip->config = &s3c24xx_gpiocfg_default;
> 
> +               if (!chip->config->set_pull)
> +                       chip->config->set_pull = s3c_gpio_setpull_1up;
> +               if (!chip->config->get_pull)
> +                       chip->config->get_pull = s3c_gpio_getpull_1up;
> +
>                 s3c_gpiolib_add(chip);
>         }

Pull callbacks are soc-specific, s3c24xx_gpiolib_init is common for all socs, 
so we can't do like this.

Btw, I've sent v6 version of patch, it still with empty line issues, should I 
resend v7 version or maintainers can fixup it at their side? :)

Regards
Vasily
