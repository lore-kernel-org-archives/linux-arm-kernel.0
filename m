From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri,  3 Jun 2016 22:29:26 +0200
Subject: [PATCH] ARM: pxa: remove devicetree boards from pxa_defconfig
Message-ID: <1464985766-20754-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If both legacy and device-tree machines are mixed in the same defconfig,
the legacy boards don't boot up anymore with gpio request deferral
errors.

This is seen when attempting to run akita, borzoi, spitz, terrier, or
tosa in qemu with pxa_defconfig.

The real reason behind is that gpio handling for pxa in its current
state cannot be built for _both_ a devicetree machine (ie. pxa-dt.c) and
a non devicetree machine (ie. corgi, tosa, ...).

This is turn is because for devicetree a pinctrl is enforced for the
machine, and a pinctrl driver is required. If it's not available,
pxa_gpio_request() fails on pinctrl_request_gpio() and returns
-EPROBE_DEFER.  It was introduced by commit f806dac5938b
("ARM: pxa: activate pinctrl for device-tree machines").

Now the true chicken and egg problem is than machine files,
ie. arch/arm/mach-pxa/xxx.c are using gpio before the drivers are
probed, in the init_machine() function, and that's why pinctrl/gpio for
legacy machine files is a bit difficult.

As for now, to keep the compilation coverage and testing of legacy
machines, this patch removes the 2 devicetree machines from
pxa_defconfig.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Tested-by: Guenter Roeck <linux@roeck-us.net>
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
