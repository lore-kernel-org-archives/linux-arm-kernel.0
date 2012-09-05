From: marex@denx.de (Marek Vasut)
Date: Wed, 5 Sep 2012 05:13:08 +0200
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <CAK5ve-Jqc1xpXa0VM7=+MN1cvm=8ysg9W9WRiG66yq7GRfh+Gw@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CAK5ve-Jqc1xpXa0VM7=+MN1cvm=8ysg9W9WRiG66yq7GRfh+Gw@mail.gmail.com>
Message-ID: <201209050513.08588.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bryan Wu,

> On Sat, Sep 1, 2012 at 4:16 PM, AnilKumar Ch <anilkumar@ti.com> wrote:
> > Adopt pinctrl support to leds-gpio driver based on leds-gpio
> > device pointer, pinctrl driver configure SoC pins to GPIO
> > mode according to definitions provided in .dts file.
> 
> Thanks for this, actually Marek Vasut submitted a similar patch
> before. I'm pretty fine with this patch.

Thanks for submitting this actually ... I didn't have time to properly 
investigate this.

> But without proper DT setting, it will also give us warning I think.
> or we can provide some dummy functions as a temp solution as Shawn
> pointed out before.

But this driver is also used on hardware that's not yet coverted to DT, so I'd 
say dev_warn() if CONFIG_OF is enabled and otherwise simply go on ? Actually, 
can we not skip whole this pinctrl thing if CONFIG_OF is disabled? Actually (2), 
what's the relationship between OF and pinctrl?

> -Bryan
> 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> > 
> > Changes from v1:
> >         - Seperated from "Add DT for AM33XX devices" patch series
> >         - Incorporated Tony's comments on v1
> >         
> >           * Changed to warning message instead od error return
> >  
> >  drivers/leds/leds-gpio.c |    7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> > index c032b21..ad577f4 100644
> > --- a/drivers/leds/leds-gpio.c
> > +++ b/drivers/leds/leds-gpio.c
> > @@ -20,6 +20,7 @@
> > 
> >  #include <linux/slab.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/module.h>
> > 
> > +#include <linux/pinctrl/consumer.h>
> > 
> >  struct gpio_led_data {
> >  
> >         struct led_classdev cdev;
> > 
> > @@ -236,8 +237,14 @@ static int __devinit gpio_led_probe(struct
> > platform_device *pdev)
> > 
> >  {
> >  
> >         struct gpio_led_platform_data *pdata = pdev->dev.platform_data;
> >         struct gpio_leds_priv *priv;
> > 
> > +       struct pinctrl *pinctrl;
> > 
> >         int i, ret = 0;
> > 
> > +       pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> > +       if (IS_ERR(pinctrl))
> > +               dev_warn(&pdev->dev,
> > +                       "pins are not configured from the driver\n");
> > +
> > 
> >         if (pdata && pdata->num_leds) {
> >         
> >                 priv = devm_kzalloc(&pdev->dev,
> >                 
> >                                 sizeof_gpio_leds_priv(pdata->num_leds),
> > 
> > --
> > 1.7.9.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-leds" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

Best regards,
Marek Vasut
