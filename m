From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Fri, 31 Aug 2012 17:54:18 +0000
Subject: [PATCH 4/5] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <20120831160402.GN1303@atomide.com>
References: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
 <1346405361-29711-5-git-send-email-anilkumar@ti.com>
 <20120831160402.GN1303@atomide.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA2329D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Thanks for the review,

On Fri, Aug 31, 2012 at 21:34:04, Tony Lindgren wrote:
> * AnilKumar Ch <anilkumar@ti.com> [120831 02:30]:
> > Adopt pinctrl support to leds-gpio driver, based on the device
> > pointer (leds-gpio) pinctrl driver configure SoC pins to GPIO
> > mode.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  drivers/leds/leds-gpio.c |   31 ++++++++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> > index c032b21..d98dfb9 100644
> > --- a/drivers/leds/leds-gpio.c
> > +++ b/drivers/leds/leds-gpio.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/module.h>
> > +#include <linux/pinctrl/consumer.h>
> >  
> >  struct gpio_led_data {
> >  	struct led_classdev cdev;
> > @@ -236,14 +237,23 @@ static int __devinit gpio_led_probe(struct platform_device *pdev)
> >  {
> >  	struct gpio_led_platform_data *pdata = pdev->dev.platform_data;
> >  	struct gpio_leds_priv *priv;
> > -	int i, ret = 0;
> > +	struct pinctrl *pinctrl;
> > +	int i = 0;
> > +	int ret = 0;
> > +
> > +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> > +	if (IS_ERR(pinctrl)) {
> > +		return PTR_ERR(pinctrl);
> > +	}
> 
> I think you need to just print out a warning here as most systems don't
> have the pinctrl implemented. And some people just do static pinmuxing
> in the bootloader.
> 

Yes, that is better approach I will fix this in my next version.
I will separate out this patch from the series because these changes are
leds-gpio driver specific which are different from DT data (pinctrl and
d_can).

Thanks
AnilKumar
