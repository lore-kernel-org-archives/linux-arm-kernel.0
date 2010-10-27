From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 27 Oct 2010 12:04:46 +0200
Subject: [patch v3 07/10] efikamx: add support for power key
In-Reply-To: <87lj5k7ylx.fsf@lechat.rtp-net.org>
References: <20101026200723.839428019@rtp-net.org>
	<20101026201002.466426845@rtp-net.org>
	<20101027073044.GY8554@pengutronix.de>
	<87lj5k7ylx.fsf@lechat.rtp-net.org>
Message-ID: <20101027100446.GC8554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 11:51:06AM +0200, Arnaud Patard wrote:
> Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:
> 
> > On Tue, Oct 26, 2010 at 10:07:30PM +0200, Arnaud Patard wrote:
> >> This patch adds support for power key button of the efika mx. It's connected
> >> on  GPIO 2 31.
> >> 
> >> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> >> 
> >> Index: linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c
> >> ===================================================================
> >> --- linux-2.6-submit.orig/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-26 19:57:16.000000000 +0200
> >> +++ linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-26 19:59:16.000000000 +0200
> >> @@ -19,6 +19,8 @@
> >>  #include <linux/i2c.h>
> >>  #include <linux/gpio.h>
> >>  #include <linux/leds.h>
> >> +#include <linux/input.h>
> > Do you really need linux/input.h?
> >
> 
> You need it if you want to have KEY_POWER and EV_POWER definitions
ah, I see.
 
> >> +#include <linux/gpio_keys.h>
> > this is included by devices-common.h (which is included by
> > devices-imx51.h).  So you can drop this.
> >
> >>  #include <linux/delay.h>
> >>  #include <linux/io.h>
> >>  #include <linux/fsl_devices.h>
> >> @@ -48,10 +50,13 @@
> >>  #define EFIKAMX_GREEN_LED	(2*32 + 14)
> >>  #define EFIKAMX_RED_LED		(2*32 + 15)
> >>  
> >> +#define EFIKAMX_POWER_KEY	(1*32 + 31)
> >> +
> >>  /* the pci ids pin have pull up. they're driven low according to board id */
> >>  #define MX51_PAD_PCBID0	IOMUX_PAD(0x518, 0x130, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
> >>  #define MX51_PAD_PCBID1	IOMUX_PAD(0x51C, 0x134, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
> >>  #define MX51_PAD_PCBID2	IOMUX_PAD(0x504, 0x128, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
> >> +#define MX51_PAD_PWRKEY	IOMUX_PAD(0x48c, 0x0f8, 1, 0x0,   0, PAD_CTL_PUS_100K_UP | PAD_CTL_PKE)
> >>  
> >>  static struct pad_desc mx51efikamx_pads[] = {
> >>  	/* UART1 */
> >> @@ -91,6 +96,9 @@
> >>  	MX51_PAD_CSI1_D9__GPIO_3_13,
> >>  	MX51_PAD_CSI1_VSYNC__GPIO_3_14,
> >>  	MX51_PAD_CSI1_HSYNC__GPIO_3_15,
> >> +
> >> +	/* power key */
> >> +	MX51_PAD_PWRKEY,
> >>  };
> >>  
> >>  /* Serial ports */
> >> @@ -220,6 +228,22 @@
> >>  	},
> >>  };
> >>  
> >> +static struct gpio_keys_button mx51_efikamx_powerkey[] = {
> > this should be const and __initconst
> 
> I guess you meant this for the gpio_keys_platform_data struct instead of
> this one ?
oh, you're right.  Conceptually mx51_efikamx_powerkey should be const,
but probably marking it accordingly generates a compiler warning.

I assume there are no other keys on your machine?  If there are, you
might want to rename mx51_efikamx_powerkey_data and
mx51_efikamx_powerkey to something that doesn't include "power".
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
