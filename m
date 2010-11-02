From: neko@genesi-usa.com (Matt Sealey)
Date: Tue, 2 Nov 2010 08:31:39 -0500
Subject: [patch v4 06/10] efikamx: add leds support
In-Reply-To: <20101102083858.GP31158@pengutronix.de>
References: <20101027124044.980739780@rtp-net.org>
	<20101027124347.146428989@rtp-net.org>
	<201010300954.47839.marek.vasut@gmail.com>
	<20101102083858.GP31158@pengutronix.de>
Message-ID: <3753BF4F-E4AE-4361-88E6-CACEC6D7EDFB@genesi-usa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I cant imagine any scenario where you'd not want a power light so the modular "no led gpio class" register function would better set the green one on anyway.

If you did that then I think you'd be defeating the object of modularizing. Efika mx should automatically select kconfig on led gpio and led trigger.

Matt Sealey
Product Development Analyst
Genesi USA, Inc.

On Nov 2, 2010, at 3:38 AM, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
> 
> On Sat, Oct 30, 2010 at 09:54:47AM +0200, Marek Vasut wrote:
>> On Wednesday 27 October 2010 14:40:51 Arnaud Patard wrote:
>>> The efika mx a 3 leds (1 blue, 1 red, 1 green) connected on GPIOS 3
>>> 13/14/15. Also, some special care is done for default trigger of blue led
>>> for mmc as the mmc host used is different between hw revisions
>>> 
>>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>>> Index: linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c
>>> ===================================================================
>>> --- linux-2.6-submit.orig/arch/arm/mach-mx5/board-mx51_efikamx.c    2010-10-27
>>> 11:26:16.000000000 +0200 +++
>>> linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c    2010-10-27
>>> 11:27:38.000000000 +0200 @@ -18,6 +18,7 @@
>>> #include <linux/platform_device.h>
>>> #include <linux/i2c.h>
>>> #include <linux/gpio.h>
>>> +#include <linux/leds.h>
>>> #include <linux/delay.h>
>>> #include <linux/io.h>
>>> #include <linux/fsl_devices.h>
>>> @@ -43,6 +44,10 @@
>>> #define EFIKAMX_PCBID1        (2*32 + 17)
>>> #define EFIKAMX_PCBID2        (2*32 + 11)
>>> 
>>> +#define EFIKAMX_BLUE_LED    (2*32 + 13)
>>> +#define EFIKAMX_GREEN_LED    (2*32 + 14)
>>> +#define EFIKAMX_RED_LED        (2*32 + 15)
>>> +
>>> /* the pci ids pin have pull up. they're driven low according to board id
>>> */ #define MX51_PAD_PCBID0    IOMUX_PAD(0x518, 0x130, 3, 0x0,   0,
>>> PAD_CTL_PUS_100K_UP) #define MX51_PAD_PCBID1    IOMUX_PAD(0x51C, 0x134, 3,
>>> 0x0,   0, PAD_CTL_PUS_100K_UP) @@ -81,6 +86,11 @@
>>>    MX51_PAD_GPIO_1_1__ESDHC1_WP,
>>>    MX51_PAD_GPIO_1_7__ESDHC2_WP,
>>>    MX51_PAD_GPIO_1_8__ESDHC2_CD,
>>> +
>>> +    /* leds */
>>> +    MX51_PAD_CSI1_D9__GPIO_3_13,
>>> +    MX51_PAD_CSI1_VSYNC__GPIO_3_14,
>>> +    MX51_PAD_CSI1_HSYNC__GPIO_3_15,
>>> };
>>> 
>>> /* Serial ports */
>>> @@ -179,6 +189,37 @@
>>>    }
>>> }
>> 
>> Maybe this could be modularized ?
>> 
>> #ifdef CONFIG_LEDS_GPIO
>> ... the platform_data stuff below ...
>> 
>> efikamx_register_leds()
>> {
>>    platform_device_register();
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
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
