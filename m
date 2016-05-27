From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 27 May 2016 13:27:15 -0700
Subject: pxa_defconfig runtime failures due to 'ARM: pxa: activate pinctrl
 for device-tree machines'
Message-ID: <20160527202715.GA4841@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

your mainline commit f806dac5938b ("ARM: pxa: activate pinctrl for device-tree
machines") causes various non-devicetree systems to fail with the following
error messages when running a pxa_defconfig image.

During boot:

Can't request reset_gpio

At reboot:

reboot: Restarting system
------------[ cut here ]------------
kernel BUG at arch/arm/mach-pxa/reset.c:59!
...

Added logging shows that the error seen when trying to request the reset gpio
is -EPROBE_DEFER, and that the pxa gpio driver is not instantiated.

This is seen when attempting to run akita, borzoi, spitz, terrier, or tosa
in qemu with pxa_defconfig. Reverting your patch fixes the problem.

Is this on purpose ? Unless I am missing something, it effectively means that
pxa_defconfig no longer works for pxa3xx systems, since those do not support
devicetree (or at least there is no devicetree file which includes pxa3xx.dtsi).

Thanks,
Guenter
