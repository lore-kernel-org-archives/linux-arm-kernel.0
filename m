From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 19 Nov 2015 09:08:22 +0100
Subject: [PATCH] i2c: imx: make bus recovery through pinctrl optional
In-Reply-To: <CADRPPNQZye7t2biS2Z8p3y7O6=xw4UcOLRC5ngs2Qvuh0UHXGg@mail.gmail.com>
References: <1447804979-29550-1-git-send-email-leoli@freescale.com>
 <20151118072437.GS22022@pengutronix.de>
 <CADRPPNQZye7t2biS2Z8p3y7O6=xw4UcOLRC5ngs2Qvuh0UHXGg@mail.gmail.com>
Message-ID: <20151119080822.GY22022@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Cc += Linus Walleij, linux-gpio

On Wed, Nov 18, 2015 at 04:59:11PM -0600, Li Yang wrote:
> On Wed, Nov 18, 2015 at 1:24 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Nov 17, 2015 at 06:02:59PM -0600, Li Yang wrote:
> >> @@ -1125,7 +1119,12 @@ static int i2c_imx_probe(struct platform_device *pdev)
> >>               goto clk_disable;
> >>       }
> >>
> >> -     i2c_imx_init_recovery_info(i2c_imx, pdev);
> >> +     /* optional bus recovery feature through pinctrl */
> >> +     i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
> >> +     if (IS_ERR_OR_NULL(i2c_imx->pinctrl))
> >> +             dev_info(&pdev->dev, "can't get pinctrl, bus recovery feature disabled\n");
> >> +     else
> >> +             i2c_imx_init_recovery_info(i2c_imx, pdev);
> >
> > I'm pretty sure this is wrong. If pinctrl isn't available
> > devm_pinctrl_get returns NULL? But AFAIK you must not ignore an error,
> > so the better thing to do is:
> 
> If CONFIG_PINCTRL is not enabled, the devm_pinctrl_get() will return
> NULL directly as defined in the include/linux/pinctrl/consumer.h.
> 
> If CONFIG_PINCTRL is enabled because we are using a multi-platform
> image but the actual hardware used doesn't have a pinctrl driver or
> pinctrl device tree nodes.  It is expected that the devm_pinctrl_get()
> will return error.  But as the pinctrl is only used for bus recovery
> which is just an optional function of this driver.  We shouldn't
> bailout the probe but keep the driver working without the bus recovery
> function.  As for generic errors like (!dev) or out-of-memory, the
> probe will fail elsewhere anyway.

IMHO you shouldn't ignore -ENOMEM from devm_pinctrl_get but just the
case for "there was no pinctrl specified in dt". Also consider the i2c
driver is loaded before the pinctrl driver and devm_pinctrl_get returns
-EPROBE_DEFER (I assume it does, didn't check), this should be handled.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
