From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Dec 2010 21:05:00 +0900
Subject: [PATCH v5] ARM: s3c244x: Fix mess with gpio {set,get}_pull
	callbacks
In-Reply-To: <201012011217.41602.anarsoul@gmail.com>
References: <4CF55785.5090403@metafoo.de>
	<1291147949-18812-1-git-send-email-anarsoul@gmail.com>
	<001301cb9129$15f1b5c0$41d52140$%kim@samsung.com>
	<201012011217.41602.anarsoul@gmail.com>
Message-ID: <003c01cb914f$fc6d3350$f54799f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick wrote:
> 
> On Wednesday 01 December 2010 09:26:31 Kukjin Kim wrote:
> 
> > How about following...
> >
> > +void __init s3c2440_map_io(void)
> > +{
> > +	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_1up;
> > +	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_1up;
> > +
> > +	s3c244x_map_io();
> > +}
> 
> What's difference except order?
> 
Just same ordering is used in other Samsung S3C SoCs.
Now actually doesn't matter it.

> > Yeah, however, in my opinion, need to add following during
gpiolib_init().
> >
> > @@ -222,6 +222,11 @@ static __init int s3c24xx_gpiolib_init(void)
> >                 if (!chip->config)
> >                         chip->config = &s3c24xx_gpiocfg_default;
> >
> > +               if (!chip->config->set_pull)
> > +                       chip->config->set_pull = s3c_gpio_setpull_1up;
> > +               if (!chip->config->get_pull)
> > +                       chip->config->get_pull = s3c_gpio_getpull_1up;
> > +
> >                 s3c_gpiolib_add(chip);
> >         }
> 
> Pull callbacks are soc-specific, s3c24xx_gpiolib_init is common for all
socs,
> so we can't do like this.
> 
Yeah, right...it depends on each SoCs. But, if there is no setup it in
map_io(), there is no functions of set_pull() and get_pull(). As you know,
used s3c_gpio_{set,get}pull_1up as default before your patch...

Hmm...however, I will think about its necessity again.

> Btw, I've sent v6 version of patch, it still with empty line issues,
should I
> resend v7 version or maintainers can fixup it at their side? :)
> 
Ok..I will do it and will apply.
Then, will be sent to Linus during 37-rc.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
