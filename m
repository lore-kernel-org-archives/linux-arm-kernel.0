From: horms@verge.net.au (Simon Horman)
Date: Tue, 23 Apr 2013 10:15:25 +0900
Subject: [PATCH] ARM: shmobile: lager: Add GPIO LEDs
In-Reply-To: <1761228.8meccMO5Km@avalon>
References: <1366599990-31751-1-git-send-email-horms+renesas@verge.net.au>
 <1761228.8meccMO5Km@avalon>
Message-ID: <20130423011524.GE12017@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 12:00:02PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thank you for the patch.
> 
> On Monday 22 April 2013 12:06:30 Simon Horman wrote:
> > The board has 3 LEDs connected to GPIOs. Add a led-gpio device to
> > support them.
> > 
> > Based on "ARM: shmobile: marzen: Add GPIO LEDs" by Laurent Pinchart.
> > 
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/mach-shmobile/board-lager.c | 37 +++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > Tested on lager board.
> > Based on the tag renesas-next-20130419 of my renesas tree.
> > 
> > diff --git a/arch/arm/mach-shmobile/board-lager.c
> > b/arch/arm/mach-shmobile/board-lager.c index 6114edd..a8aa04f 100644
> > --- a/arch/arm/mach-shmobile/board-lager.c
> > +++ b/arch/arm/mach-shmobile/board-lager.c
> > @@ -21,13 +21,49 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/irqchip.h>
> >  #include <linux/kernel.h>
> > +#include <linux/leds.h>
> >  #include <linux/pinctrl/machine.h>
> > +#include <linux/platform_data/gpio-rcar.h>
> >  #include <linux/platform_device.h>
> >  #include <mach/common.h>
> >  #include <mach/r8a7790.h>
> >  #include <asm/mach-types.h>
> >  #include <asm/mach/arch.h>
> > 
> > +/* LEDS */
> > +static struct gpio_led lager_leds[] = {
> > +	{
> > +		.name		= "led8",
> > +		.gpio		= RCAR_GP_PIN(5, 17),
> > +		.default_state	= LEDS_GPIO_DEFSTATE_ON,
> > +	}, {
> > +		.name		= "led7",
> > +		.gpio		= RCAR_GP_PIN(4, 23),
> > +		.default_state	= LEDS_GPIO_DEFSTATE_ON,
> > +	}, {
> > +		.name		= "led6",
> > +		.gpio		= RCAR_GP_PIN(4, 22),
> > +		.default_state	= LEDS_GPIO_DEFSTATE_ON,
> 
> Just out of curiosity, why is the default state on ?

Only because thats what the marzen code does.
Would off be a better choice?

> 
> > +	},
> > +};
> > +
> > +static struct gpio_led_platform_data lager_leds_pdata = {
> > +	.leds		= lager_leds,
> > +	.num_leds	= ARRAY_SIZE(lager_leds),
> > +};
> > +
> > +static struct platform_device leds_device = {
> > +	.name	= "leds-gpio",
> > +	.id	= 0,
> 
> As there's a single leds-gpio device, maybe id = -1 ?

Yes, true. I'll fix that.
I think the marzen code should probably be fixed too.

> > +	.dev	= {
> > +		.platform_data  = &lager_leds_pdata,
> > +	},
> > +};
> > +
> > +static struct platform_device *lager_devices[] __initdata = {
> > +	&leds_device,
> > +};
> > +
> >  static const struct pinctrl_map lager_pinctrl_map[] = {
> >  	/* SCIF0 (CN19: DEBUG SERIAL0) */
> >  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
> > @@ -46,6 +82,7 @@ static void __init lager_add_standard_devices(void)
> >  	r8a7790_pinmux_init();
> > 
> >  	r8a7790_add_standard_devices();
> > +	platform_add_devices(lager_devices, ARRAY_SIZE(lager_devices));
> >  }
> > 
> >  static const char *lager_boards_compat_dt[] __initdata = {
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
