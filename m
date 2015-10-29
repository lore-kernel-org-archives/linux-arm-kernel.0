From: eric@anholt.net (Eric Anholt)
Date: Thu, 29 Oct 2015 12:02:24 -0700
Subject: [RFC] rpi: add support to enable usb power domain
In-Reply-To: <1446064810-5064-1-git-send-email-alex.aring@gmail.com>
References: <1446064810-5064-1-git-send-email-alex.aring@gmail.com>
Message-ID: <87a8r1pkfz.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Aring <alex.aring@gmail.com> writes:

> This patch adds support for RPi several Power Domains and enable support
> to enable the USB Power Domain when it's not enabled before.
>
> This patch based on Eric Anholt's patch to support Power Domains. He had
> an issue about -EPROBE_DEFER inside the power domain subsystem, this
> issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
> if we fail to init or turn-on domain").
>
> It was tested with barebox and the following scripts before booting
> linux:
>
> /env/a_off:
>
>  # cat /env/a_off
>  #turn off which are enabled by default
>  regulator -n bcm2835_mci0 -s disable
>  regulator -n uart0-pl0110 -s disable
>
> /env/a_on:
>
>  # cat /env/a_on
>  #turn off which are enabled by default
>  regulator -n bcm2835_mci0 -s disable
>  regulator -n uart0-pl0110 -s disable
>
>  regulator -n bcm2835_mci0 -s enable
>  regulator -n uart0-pl0110 -s enable
>  regulator -n uart0-pl0111 -s enable
>  regulator -n bcm2835_usb -s enable
>  regulator -n bcm2835_i2c0 -s enable
>  regulator -n bcm2835_i2c1 -s enable
>  regulator -n bcm2835_i2c2 -s enable
>  regulator -n bcm2835_spi -s enable
>  regulator -n bcm2835_ccp2tx -s enable
>  regulator -n bcm2835_dsi -s enable
>
> /env/b:
>
>  # cat /env/b
>  sh /env/a_on
>
>  regulator -n bcm2835_mci0 -s disable
>  regulator -n uart0-pl0110 -s disable
>  regulator -n uart0-pl0111 -s disable
>  regulator -n bcm2835_usb -s disable
>  regulator -n bcm2835_i2c0 -s disable
>  regulator -n bcm2835_i2c1 -s disable
>  regulator -n bcm2835_i2c2 -s disable
>  regulator -n bcm2835_spi -s disable
>  regulator -n bcm2835_ccp2tx -s disable
>  regulator -n bcm2835_dsi -s disable
>
> /env/c:
>
>  # cat /env/c
>  sh ./env/b
>
>  regulator -n bcm2835_mci0 -s enable
>  regulator -n uart0-pl0110 -s enable
>  regulator -n uart0-pl0111 -s enable
>  regulator -n bcm2835_usb -s enable
>  regulator -n bcm2835_i2c0 -s enable
>  regulator -n bcm2835_i2c1 -s enable
>  regulator -n bcm2835_i2c2 -s enable
>  regulator -n bcm2835_spi -s enable
>  regulator -n bcm2835_ccp2tx -s enable
>  regulator -n bcm2835_dsi -s enable
>
> These scripts enables/disable all regulators inside the bootloader. It
> was running with a "hard" and "soft" reset without any issues. These
> testcases should fit to Stephen Warren suggestions:
>
> "(a) before having explicitly turned the power domain on or off at all (b)
> after having turned it on (c) after having turned it off, and for all
> power domains."
>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> First:
> I cc'ed Andy Whitcroft and Joe Perches here, because this patch will
> generate a false positive for checkpatch and checkpatch told me to
> cc checkpatch maintainers if this occurs:
>
> ERROR: Macros with complex values should be enclosed in parentheses
> #191: FILE: drivers/firmware/raspberrypi.c:26:
> +#define RPI_POWER_DOMAIN(_domain, _name)			\
> +	[_domain] =						\
> +	{							\
> ...
>
> Second:
> This patch based on linus/master and requires the rpi-firmware patch.
>
> Third:
> The barebox regulator doesn't support right now to enable/disable
> regulators at runtime but I want to bring this mainline in the next
> days. So you can't check yourself if the above scripts working right
> now. I describe it here to show you what exactly I tested.
>
> changes since Eric Anholts "power domain" patch:
>  - add for me all known power domains of the RPi, it contains the domains
>    0 - 9.

Note: None of the power domain enums other than the ones I'd had in my
patch are actually connected to anything in the firmware.  I don't think
we should be adding them, given that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151029/433f6e15/attachment.sig>
