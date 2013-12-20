From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Dec 2013 11:48:37 +0000
Subject: OMAP display subsystem - does it work?
In-Reply-To: <20131220112700.GF32243@n2100.arm.linux.org.uk>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com>
 <20131219175644.GE32243@n2100.arm.linux.org.uk>
 <20131219182252.GP27438@atomide.com>
 <20131220112700.GF32243@n2100.arm.linux.org.uk>
Message-ID: <20131220114837.GH32243@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 11:27:01AM +0000, Russell King - ARM Linux wrote:
> Maybe, but that's the problem - finding out what is missing.  This is the
> endless problem where things keep changing - it's very difficult to keep
> a "working configuration" working because the config symbols keep changing.
> 
> Also, bear in mind that there's many different variants of the LDP hardware
> with stuff connected up in different ways (I'm aware that the keypad is
> just randomly allocated).  I wouldn't be surprised if this also applied
> to how the backlight on the LCD was done.

Or maybe this is getting buggered by the idiotic deferred probing...  It
seems that the GPIOs for controlling the LCD and backlight aren't even
getting claimed if the DSS modules are built in:

# cat /sys/kernel/debug/gpio
...
GPIOs 238-255, platform/twl4030_gpio, twl4030, can sleep:
# echo panel-dpi.0 > /sys/bus/platform/drivers/panel-dpi/unbind
# echo panel-dpi.0 > /sys/bus/platform/drivers/panel-dpi/bind
# cat /sys/kernel/debug/gpio
...
GPIOs 238-255, platform/twl4030_gpio, twl4030, can sleep:
 gpio-245 (panel enable        ) out lo
 gpio-253 (panel backlight     ) out lo

Tony, try this with the stuff not as modules but built-in.
