From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 02 Nov 2010 10:35:41 +0100
Subject: [patch v4 06/10] efikamx: add leds support
In-Reply-To: <20101102083858.GP31158@pengutronix.de> ("Uwe =?utf-8?Q?Klein?=
	=?utf-8?Q?e-K=C3=B6nig=22's?=
	message of "Tue, 2 Nov 2010 09:38:58 +0100")
References: <20101027124044.980739780@rtp-net.org>
	<20101027124347.146428989@rtp-net.org>
	<201010300954.47839.marek.vasut@gmail.com>
	<20101102083858.GP31158@pengutronix.de>
Message-ID: <87fwvk6paq.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

Hi,
> Hello,
>
> On Sat, Oct 30, 2010 at 09:54:47AM +0200, Marek Vasut wrote:
>> On Wednesday 27 October 2010 14:40:51 Arnaud Patard wrote:
>> > The efika mx a 3 leds (1 blue, 1 red, 1 green) connected on GPIOS 3
>> > 13/14/15. Also, some special care is done for default trigger of blue led
>> > for mmc as the mmc host used is different between hw revisions
>> > 
>> > Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> > Index: linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c
>> > ===================================================================
>> > --- linux-2.6-submit.orig/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-27
>> > 11:26:16.000000000 +0200 +++
>> > linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-27
>> > 11:27:38.000000000 +0200 @@ -18,6 +18,7 @@
>> >  #include <linux/platform_device.h>
>> >  #include <linux/i2c.h>
>> >  #include <linux/gpio.h>
>> > +#include <linux/leds.h>
>> >  #include <linux/delay.h>
>> >  #include <linux/io.h>
>> >  #include <linux/fsl_devices.h>
>> > @@ -43,6 +44,10 @@
>> >  #define EFIKAMX_PCBID1		(2*32 + 17)
>> >  #define EFIKAMX_PCBID2		(2*32 + 11)
>> > 
>> > +#define EFIKAMX_BLUE_LED	(2*32 + 13)
>> > +#define EFIKAMX_GREEN_LED	(2*32 + 14)
>> > +#define EFIKAMX_RED_LED		(2*32 + 15)
>> > +
>> >  /* the pci ids pin have pull up. they're driven low according to board id
>> > */ #define MX51_PAD_PCBID0	IOMUX_PAD(0x518, 0x130, 3, 0x0,   0,
>> > PAD_CTL_PUS_100K_UP) #define MX51_PAD_PCBID1	IOMUX_PAD(0x51C, 0x134, 3,
>> > 0x0,   0, PAD_CTL_PUS_100K_UP) @@ -81,6 +86,11 @@
>> >  	MX51_PAD_GPIO_1_1__ESDHC1_WP,
>> >  	MX51_PAD_GPIO_1_7__ESDHC2_WP,
>> >  	MX51_PAD_GPIO_1_8__ESDHC2_CD,
>> > +
>> > +	/* leds */
>> > +	MX51_PAD_CSI1_D9__GPIO_3_13,
>> > +	MX51_PAD_CSI1_VSYNC__GPIO_3_14,
>> > +	MX51_PAD_CSI1_HSYNC__GPIO_3_15,
>> >  };
>> > 
>> >  /* Serial ports */
>> > @@ -179,6 +189,37 @@
>> >  	}
>> >  }
>> 
>> Maybe this could be modularized ?
>> 
>> #ifdef CONFIG_LEDS_GPIO
>> ... the platform_data stuff below ...
>> 
>> efikamx_register_leds()
>> {
>> 	platform_device_register();
>> }
>> #else
>> static inline void efikamx_register_leds() {}
>> #endif
>> 
>> board_init()
>> {
>> ...
>> efikamx_register_leds();
>> ...
>> }
>> 
>> What do you think ? Cheers
> IMHO it's better to register all devices independently of the available
> drivers.  So for me the used approach is OK.

I don't really see the point of doing that. It just looks a good way to
make the code harder to read imho. Moreover, it doesn't bring a lot by
doing that - if you don't want the leds-gpio stuff, just disable it at
kernel configuration and you're done.

Arnaud
