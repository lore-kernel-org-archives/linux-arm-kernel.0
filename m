From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Aug 2011 12:59:18 +0100
Subject: [PATCH 03/17] mach-realview and mach-versatile: retire custom
	LED code
In-Reply-To: <1312364089-32380-4-git-send-email-bryan.wu@canonical.com>
References: <1312364089-32380-1-git-send-email-bryan.wu@canonical.com>
	<1312364089-32380-4-git-send-email-bryan.wu@canonical.com>
Message-ID: <20110803115918.GA23953@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2011 at 05:34:35PM +0800, Bryan Wu wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This replaces the custom LED trigger code in mach-realview with
> some overarching platform code for the plat-versatile family that
> will lock down LEDs 2 thru 5 for CPU activity indication. The
> day we have 8 core ARM systems the plat-versatile code will have
> to become more elaborate.
> 
> Tested on RealView PB11MPCore by invoking four different CPU
> hogs (yes > /dev/null&) and see the LEDs go on one at a time.
> They all go off as the hogs are killed. Tested on the PB1176
> as well - just one activity led (led 2) goes on and off with
> CPU activity.
> 
> (bryan.wu at canonical.com: use ledtrig-cpu instead of ledtrig-arm-cpu)

This is broken.  More than that, this LEDS stuff is broken.

With CONFIG_NEW_LEDS=y and CONFIG_LEDS_CLASS=n,

  CC      arch/arm/plat-versatile/leds.o
arch/arm/plat-versatile/leds.c: In function 'versatile_leds_init':
arch/arm/plat-versatile/leds.c:91: error: 'struct led_classdev' has no member named 'trigger_data'

I wasn't offered LEDS_TRIGGERS to select.  It looks like this leds
stuff really is broken:

config LEDS_CLASS
        bool "LED Class Support"
        help
          This option enables the led sysfs class in /sys/class/leds.  You'll
          need this to do anything useful with LEDs.  If unsure, say N.

Okay, this says its for sysfs support.  But then:

config LEDS_TRIGGERS
        bool "LED Trigger support"
        depends on LEDS_CLASS
        help
          This option enables trigger support for the leds class.
          These triggers allow kernel events to drive the LEDs and can
          be configured via sysfs. If unsure, say Y.

you can only have LED triggers if you have LED class support.  So what's
the point of NEW_LEDS=y and LEDS_CLASS=n?  From those descriptions,
LEDS_CLASS should control the sysfs interfaces, and LEDS_TRIGGERS should
control the kernel internal interfaces _independently_.

As things stand, this looks completely crazy.  So no, I'm not acking these
patches until the LEDs layer gets a modicum of sanity.
