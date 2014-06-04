From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jun 2014 12:53:22 +0200
Subject: [PATCH] ARM: integrator: fix section mismatch problem
Message-ID: <1401879202-10516-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This addresses a section mismatch problem in the IM-PD1
driver in the Integrator/AP.

The IM-PD1 contains a VIC interrupt controller and therefore
the driver calls vic_init_cascaded() which is marked __init as
irqchips are simply not hot-pluggable and specifically the VIC
is assumed to initiate only on boot.

However the module driver model of the Integrator LM bus
assumes that logic tile drivers can be probed at runtime. This
is not really the case for IM-PD1: these tiles are detected at
boot and they cannot be plugged into a running system. Before
this patch it is of course possible to modprobe them later.

By first forcing the IM-PD1 to bool we make sure this driver
gets compiled into the kernel, and we know it will be probed
only at boot time when the tiles are detected, so we can tag
its probe function __init_refok as we know it won't be called
after boot now, and the section mismatch problem goes away.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly if the solution seems
acceptable.
---
 arch/arm/mach-integrator/Kconfig | 2 +-
 arch/arm/mach-integrator/impd1.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index ba43321001d8..64f8e2564a37 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -28,7 +28,7 @@ config ARCH_CINTEGRATOR
 	bool
 
 config INTEGRATOR_IMPD1
-	tristate "Include support for Integrator/IM-PD1"
+	bool "Include support for Integrator/IM-PD1"
 	depends on ARCH_INTEGRATOR_AP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_VIC
diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 0e870ea818c4..05d845cb8758 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -308,7 +308,12 @@ static struct impd1_device impd1_devs[] = {
  */
 #define IMPD1_VALID_IRQS 0x00000bffU
 
-static int __init impd1_probe(struct lm_device *dev)
+/*
+ * As this module is bool, it is OK to have this as __init_refok() - no
+ * probe calls will be done after the initial system bootup, as devices
+ * are discovered as part of the machine startup.
+ */
+static int __init_refok impd1_probe(struct lm_device *dev)
 {
 	struct impd1_module *impd1;
 	int irq_base;
-- 
1.9.3
