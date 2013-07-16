From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 16 Jul 2013 11:51:19 +0200
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <20130716065130.GB30067@S2101-09.ap.freescale.net>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
 <20130716015038.GD28375@S2101-09.ap.freescale.net>
 <20130716065130.GB30067@S2101-09.ap.freescale.net>
Message-ID: <1373968279.4327.13.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 16.07.2013, 14:51 +0800 schrieb Shawn Guo:
> On Tue, Jul 16, 2013 at 09:50:42AM +0800, Shawn Guo wrote:
> > Hi Philipp,
> > 
> > On Thu, May 30, 2013 at 11:09:00AM +0200, Philipp Zabel wrote:
> > > This driver implements a reset controller device that toggle a gpio
> > > connected to a reset pin of a peripheral IC. The delay between assertion
> > > and de-assertion of the reset signal can be configured via device tree.
> > > 
> > > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > > Reviewed-by: Stephen Warren <swarren@nvidia.com>
> > 
> > I see this patch is very useful, as GPIOs are widely used to reset
> > components/devices on board.  But I do not find the patch in v3.11-rc1.
> > What's your plan about it?
> > 
> > Also, I'm wondering if we should register the driver a little bit
> > early.  Please see the following patch.  If it makes sense to you,
> > I can send the patch to you, or you can just quash it into yours.
> 
> And here is another change request.

Looks good to me. I can squash it into the original patch and resend if
you like.

regards
Philipp

> Shawn
> 
> ----8<---------------
> 
> From 822a0c4fb7c99b371844ba7e957affcaa8cb1cfe Mon Sep 17 00:00:00 2001
> From: Shawn Guo <shawn.guo@linaro.org>
> Date: Sun, 14 Jul 2013 20:28:05 +0800
> Subject: [PATCH] ENGR00269945: reset: handle cansleep case in gpio-reset
> 
> Some gpio reset may be backed by a gpio that can sleep, e.g. pca953x
> gpio output.  For such gpio, gpio_set_value_cansleep() should be
> called.  Otherwise, the WARN_ON(chip->can_sleep) in gpiod_set_value()
> will be hit.  Add a gpio_cansleep() check to handle cansleep gpio.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/reset/gpio-reset.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/gpio-reset.c b/drivers/reset/gpio-reset.c
> index 5d2515a..4f372f9 100644
> --- a/drivers/reset/gpio-reset.c
> +++ b/drivers/reset/gpio-reset.c
> @@ -32,7 +32,10 @@ static void gpio_reset_set(struct reset_controller_dev *rcdev, int asserted)
>  	if (drvdata->active_low)
>  		value = !value;
>  
> -	gpio_set_value(drvdata->gpio, value);
> +	if (gpio_cansleep(drvdata->gpio))
> +		gpio_set_value_cansleep(drvdata->gpio, value);
> +	else
> +		gpio_set_value(drvdata->gpio, value);
>  }
>  
>  static int gpio_reset(struct reset_controller_dev *rcdev, unsigned long id)
