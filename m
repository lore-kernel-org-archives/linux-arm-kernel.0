From: zumeng.chen@gmail.com (Zumeng Chen)
Date: Tue, 12 Jun 2012 10:49:00 +0800
Subject: [PATCH 5/5] Input: ads7846: set proper debounce time in driver
 level
In-Reply-To: <4FD602AD.1060304@compulab.co.il>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-6-git-send-email-zumeng.chen@gmail.com>
 <4FD602AD.1060304@compulab.co.il>
Message-ID: <CA+Y31weKZTY5RM+i_6c=DaY6WCdai7HcSzJkytWJO9cDeyKVcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/6/11 Igor Grinberg <grinberg@compulab.co.il>

> Hi,
>
> This is input subsystem, add Dmitry and linux-input.
>
> On 06/11/12 17:00, Zumeng Chen wrote:
> > If we don't set proper debouce time for ads7846, then there are
> > flooded interrupt counters of ads7846 responding to one time
> > touch on screen, so the driver couldn't work well.
> >
> > And since most OMAP3 series boards pass NULL pointer of board_pdata
> > to omap_ads7846_init, so it's more proper to set it in driver level
> > after having gpio_request done.
>
> What about other non-OMAP platforms?
>
Good point, I thought it should be the same situation, and I have no other
boards
to validate it :) Then I'll fall back on my original patch to bracket them
with OMAP3EVM

>
> NULL pointer for board_pdata, only means that the default pdata is used.
> Please, see the common-board-devices.c file more closely.
>
Yes,  I just went through again, two points:

1 )  get_pendown_state is not set for OMAP3 boards, and the state
      will be get by gpio_get_value(gpio-omap.c)
      The second path will be available in the ads7846_setup_pendown
      if (pdata->get_pendown_state) {
                ts->get_pendown_state = pdata->get_pendown_state;
      } else if (gpio_is_valid(pdata->gpio_pendown)) {

2 )  All omap3 boards set gpio_pendown for pdata.
      So it had better we set_debounce in driver level after
gpio_request_one
      having done
      I'll remove DEBOUNCE_TIME in V2 and change into like following:

+#ifdef CONFIG_MACH_OMAP3EVM
+               /* 310 means 10 microsecond for omap3 */
+               gpio_set_debounce(pdata->gpio_pendown, 310);
+#endif


> >
> > This patch has been validated on 3530evm.
> >
> > Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> > Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
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
>
> I think hard coding this value is wrong.
>
Yes, me too.

> Can't it be derived from the pdata->debounce_* fields?
>
Yes, I agreed this way, and to be honest, my first choice
is to find if there is a member for debounce, but no. And
there is no more sense to derive it from debounce_max,
although which is the right value for us.

So I have to use the hardcode here.

Regards,
Zumeng


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
>
> --
> Regards,
> Igor.
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120612/53374852/attachment-0001.html>
