From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 28 May 2016 10:24:27 +0200
Subject: pxa_defconfig runtime failures due to 'ARM: pxa: activate pinctrl
 for device-tree machines'
In-Reply-To: <20160527202715.GA4841@roeck-us.net> (Guenter Roeck's message of
 "Fri, 27 May 2016 13:27:15 -0700")
References: <20160527202715.GA4841@roeck-us.net>
Message-ID: <87a8jah9ok.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter Roeck <linux@roeck-us.net> writes:

> Hi,
>
> your mainline commit f806dac5938b ("ARM: pxa: activate pinctrl for device-tree
> machines") causes various non-devicetree systems to fail with the following
> error messages when running a pxa_defconfig image.
Ah yes, you're right.

>
> During boot:
>
> Can't request reset_gpio
>
> At reboot:
>
> reboot: Restarting system
> ------------[ cut here ]------------
> kernel BUG at arch/arm/mach-pxa/reset.c:59!
> ...
>
> Added logging shows that the error seen when trying to request the reset gpio
> is -EPROBE_DEFER, and that the pxa gpio driver is not instantiated.
>
> This is seen when attempting to run akita, borzoi, spitz, terrier, or tosa
> in qemu with pxa_defconfig. Reverting your patch fixes the problem.
>
> Is this on purpose ?
Well no :)
The real reason behind is that gpio handling for pxa in its current state cannot
be built for _both_ a devicetree machine (ie. pxa-dt.c) and a non devicetree
machine (ie. corgi, tosa, ...).

This is turn is because for devicetree a pinctrl is enforced for the machine,
and a pinctrl driver is required. If it's not available, pxa_gpio_request()
fails on pinctrl_request_gpio() and returns -EPROBE_DEFER.

Now the true chicken and egg problem is than machine files,
ie. arch/arm/mach-pxa/xxx.c are using gpio before the drivers are probed, in the
init_machine() function, and that's why pinctrl/gpio for legacy machine files is
a bit difficult.

> Unless I am missing something, it effectively means that
> pxa_defconfig no longer works for pxa3xx systems, since those do not support
> devicetree (or at least there is no devicetree file which includes
> pxa3xx.dtsi).
I'd rather say that pxa_defconfig doesn't work anymore on any legacy system.
Its first purpose was to ensure compilation coverage of all legacy pxa systems.
Its second one was to have a single kernel bootable on all legacy pxa systems.

Therefore, would you tell me if the patch in [1] fixes your issue ?

Cheers.

-- 
Robert

[1] One solution
---8<---
>From d6079c9cce351e217df947b4c5e243d350c39823 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 28 May 2016 10:17:33 +0200
Subject: [PATCH] ARM: pxa: remove devicetree boards from pxa_defconfig

If both legacy and device-tree machines are mixed in the same defconfig,
the legacy boards don't boot up anymore with gpio request deferral
errors.

This is seen when attempting to run akita, borzoi, spitz, terrier, or
tosa in qemu with pxa_defconfig.

The real reason behind is that gpio handling for pxa in its current state cannot
be built for _both_ a devicetree machine (ie. pxa-dt.c) and a non devicetree
machine (ie. corgi, tosa, ...).

This is turn is because for devicetree a pinctrl is enforced for the
machine, and a pinctrl driver is required. If it's not available,
pxa_gpio_request() fails on pinctrl_request_gpio() and returns
-EPROBE_DEFER.  It was introduced by commit :
    f806dac5938b ("ARM: pxa: activate pinctrl for device-tree machines")

Now the true chicken and egg problem is than machine files,
ie. arch/arm/mach-pxa/xxx.c are using gpio before the drivers are probed, in the
init_machine() function, and that's why pinctrl/gpio for legacy machine files is
a bit difficult.

As for now, to keep the compilation coverage and testing of legacy
machines, this patch removes the 2 devicetree machines from pxa_defconfig.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/configs/pxa_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index dc5517eaf09f..a016ecc0084b 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -26,8 +26,6 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_LDM_PARTITION=y
 CONFIG_CMDLINE_PARTITION=y
 CONFIG_ARCH_PXA=y
-CONFIG_MACH_PXA27X_DT=y
-CONFIG_MACH_PXA3XX_DT=y
 CONFIG_ARCH_LUBBOCK=y
 CONFIG_MACH_MAINSTONE=y
 CONFIG_MACH_ZYLONITE300=y
-- 
2.1.4
