From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 6 Jun 2011 20:30:33 +0800
Subject: [PATCH 1/2] gpio/mxs: save the unnecessary function
	mxs_gpio_to_irq
In-Reply-To: <20110606080216.GB32632@pengutronix.de>
References: <1307341247-26382-1-git-send-email-shawn.guo@linaro.org>
	<20110606080216.GB32632@pengutronix.de>
Message-ID: <20110606123032.GD21204@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 10:02:16AM +0200, Sascha Hauer wrote:
> Hi Shawn,
> 
> On Mon, Jun 06, 2011 at 02:20:46PM +0800, Shawn Guo wrote:
> > The irq number can be easily calculated from the sum of
> > MXS_GPIO_IRQ_START and gpio number.  The patch directly defines
> > gpio_to_irq for it and removes mxs_gpio_to_irq to simplify the
> > the driver.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/mach-mxs/include/mach/gpio.h |    2 +-
> >  drivers/gpio/gpio-mxs.c               |    9 ---------
> >  2 files changed, 1 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mxs/include/mach/gpio.h b/arch/arm/mach-mxs/include/mach/gpio.h
> > index 828cccc..18017c5 100644
> > --- a/arch/arm/mach-mxs/include/mach/gpio.h
> > +++ b/arch/arm/mach-mxs/include/mach/gpio.h
> > @@ -28,8 +28,8 @@
> >  #define gpio_get_value		__gpio_get_value
> >  #define gpio_set_value		__gpio_set_value
> >  #define gpio_cansleep		__gpio_cansleep
> > -#define gpio_to_irq		__gpio_to_irq
> >  
> >  #define irq_to_gpio(irq)	((irq) - MXS_GPIO_IRQ_START)
> > +#define gpio_to_irq(gpio)	(MXS_GPIO_IRQ_START + (gpio))
> 
> NACK
> 
> This is no good idea. __gpio_to_irq also works correctly for i2c gpio
> expanders and the like whereas your patch limits the gio_to_irq usage to
> internal gpios. Better to keep it like it is.
> 
What I was trying to do is moving gpio-mxs one step closer to
gpio-mxc.  I thought what gpio-mxc is doing should have been proved
fine by a wider users/platforms.  But you are telling this is one
step backward.  Then I will drop the patch.

-- 
Regards,
Shawn
