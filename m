From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 20 Dec 2013 15:43:30 +0200
Subject: OMAP display subsystem - does it work?
In-Reply-To: <20131220114837.GH32243@n2100.arm.linux.org.uk>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com>
 <20131219175644.GE32243@n2100.arm.linux.org.uk>
 <20131219182252.GP27438@atomide.com>
 <20131220112700.GF32243@n2100.arm.linux.org.uk>
 <20131220114837.GH32243@n2100.arm.linux.org.uk>
Message-ID: <52B44982.4020501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-20 13:48, Russell King - ARM Linux wrote:
> On Fri, Dec 20, 2013 at 11:27:01AM +0000, Russell King - ARM Linux wrote:
>> Maybe, but that's the problem - finding out what is missing.  This is the
>> endless problem where things keep changing - it's very difficult to keep
>> a "working configuration" working because the config symbols keep changing.
>>
>> Also, bear in mind that there's many different variants of the LDP hardware
>> with stuff connected up in different ways (I'm aware that the keypad is
>> just randomly allocated).  I wouldn't be surprised if this also applied
>> to how the backlight on the LCD was done.

I need to cook up a patch for the gpio active-low problem. I tried to
figure out how to do it with the old GPIO API, but as far as I
understand, I have to do it manually in the driver (as it was done in
the old driver).

> Or maybe this is getting buggered by the idiotic deferred probing...  It
> seems that the GPIOs for controlling the LCD and backlight aren't even
> getting claimed if the DSS modules are built in:
> 
> # cat /sys/kernel/debug/gpio
> ...
> GPIOs 238-255, platform/twl4030_gpio, twl4030, can sleep:
> # echo panel-dpi.0 > /sys/bus/platform/drivers/panel-dpi/unbind
> # echo panel-dpi.0 > /sys/bus/platform/drivers/panel-dpi/bind
> # cat /sys/kernel/debug/gpio
> ...
> GPIOs 238-255, platform/twl4030_gpio, twl4030, can sleep:
>  gpio-245 (panel enable        ) out lo
>  gpio-253 (panel backlight     ) out lo

This looks odd... Presuming the panel device was probed successfully, it
should always get the gpios or return an error. Only if gpio_is_valid()
returns false for the gpio, it skips it and continues. But in this case,
the gpio number comes from the platform data, so it should always be valid.

And if it wasn't probed successfully, then there shouldn't be a fb0.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/2431be61/attachment.sig>
