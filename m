From: zumeng.chen@gmail.com (Zumeng Chen)
Date: Wed, 13 Jun 2012 00:37:17 +0800
Subject: [PATCH 5/5] Input: ads7846: set proper debounce time in driver
 level
In-Reply-To: <20120612064757.GE12766@atomide.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-6-git-send-email-zumeng.chen@gmail.com>
 <20120612064757.GE12766@atomide.com>
Message-ID: <CA+Y31wdGaMDrT6ySE1y2Z5sw5ah8fE7im_=BvH=s+U+P619O=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/6/12 Tony Lindgren <tony@atomide.com>

> * Zumeng Chen <zumeng.chen@gmail.com> [120611 07:05]:
> > If we don't set proper debouce time for ads7846, then there are
> > flooded interrupt counters of ads7846 responding to one time
> > touch on screen, so the driver couldn't work well.
> >
> > And since most OMAP3 series boards pass NULL pointer of board_pdata
> > to omap_ads7846_init, so it's more proper to set it in driver level
> > after having gpio_request done.
> >
> > This patch has been validated on 3530evm.
> >
> > Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> > Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> Please remove my Signed-off-by, where does that come from?
>
HI Tony,

This comes from git://arago-project.org/git/projects/linux-omap3.git
The commit ID is 53c5ec31, we set gpio_debounce in arch/board
level.

+static void ads7846_dev_init(void)
+{
+       if (gpio_request(OMAP3_EVM_TS_GPIO, "ADS7846 pendown") < 0)
+               printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
+
+       gpio_direction_input(OMAP3_EVM_TS_GPIO);
+
+       omap_set_gpio_debounce(OMAP3_EVM_TS_GPIO, 1);
+       omap_set_gpio_debounce_time(OMAP3_EVM_TS_GPIO, 0xa);
+}

in 3.4 kernel, I think we can set pendown in driver level. this is the
story.

Regards,
Zumeng

>
> Tony
>
>
> >  drivers/input/touchscreen/ads7846.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/input/touchscreen/ads7846.c
> b/drivers/input/touchscreen/ads7846.c
> > index f02028e..a82a5fb 100644
> > --- a/drivers/input/touchscreen/ads7846.c
> > +++ b/drivers/input/touchscreen/ads7846.c
> > @@ -61,6 +61,7 @@
> >
> >  /* this driver doesn't aim at the peak continuous sample rate */
> >  #define      SAMPLE_BITS     (8 /*cmd*/ + 16 /*sample*/ + 2 /* before,
> after */)
> > +#define      DEBOUNCE_TIME   310 /* About 10 ms */
> >
> >  struct ts_event {
> >       /*
> > @@ -980,6 +981,7 @@ static int __devinit ads7846_setup_pendown(struct
> spi_device *spi, struct ads784
> >               }
> >
> >               ts->gpio_pendown = pdata->gpio_pendown;
> > +             gpio_set_debounce(pdata->gpio_pendown, DEBOUNCE_TIME);
> >
> >       } else {
> >               dev_err(&spi->dev, "no get_pendown_state nor
> gpio_pendown?\n");
> > --
> > 1.7.5.4
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120613/899bd633/attachment-0001.html>
