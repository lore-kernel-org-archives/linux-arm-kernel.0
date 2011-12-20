From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Dec 2011 01:42:25 +0100
Subject: [PATCH 1/2] ARM: integrator: only hardcode AP PrimeCell IDs
Message-ID: <1324341745-20772-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to hardcode the peripheral IDs for the Integrator/CP,
the numbers found in the hardware are correct anyway.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/core.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 4b38e13..18584be 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -29,6 +29,7 @@
 #include <mach/cm.h>
 #include <asm/system.h>
 #include <asm/leds.h>
+#include <asm/mach-types.h>
 #include <asm/mach/time.h>
 #include <asm/pgtable.h>
 
@@ -44,7 +45,6 @@ static struct amba_device rtc_device = {
 		.flags	= IORESOURCE_MEM,
 	},
 	.irq		= { IRQ_RTCINT, NO_IRQ },
-	.periphid	= 0x00041030,
 };
 
 static struct amba_device uart0_device = {
@@ -58,7 +58,6 @@ static struct amba_device uart0_device = {
 		.flags	= IORESOURCE_MEM,
 	},
 	.irq		= { IRQ_UARTINT0, NO_IRQ },
-	.periphid	= 0x0041010,
 };
 
 static struct amba_device uart1_device = {
@@ -72,7 +71,6 @@ static struct amba_device uart1_device = {
 		.flags	= IORESOURCE_MEM,
 	},
 	.irq		= { IRQ_UARTINT1, NO_IRQ },
-	.periphid	= 0x0041010,
 };
 
 static struct amba_device kmi0_device = {
@@ -85,7 +83,6 @@ static struct amba_device kmi0_device = {
 		.flags	= IORESOURCE_MEM,
 	},
 	.irq		= { IRQ_KMIINT0, NO_IRQ },
-	.periphid	= 0x00041050,
 };
 
 static struct amba_device kmi1_device = {
@@ -98,7 +95,6 @@ static struct amba_device kmi1_device = {
 		.flags	= IORESOURCE_MEM,
 	},
 	.irq		= { IRQ_KMIINT1, NO_IRQ },
-	.periphid	= 0x00041050,
 };
 
 static struct amba_device *amba_devs[] __initdata = {
@@ -157,6 +153,19 @@ static int __init integrator_init(void)
 {
 	int i;
 
+	/*
+	 * The Integrator/AP lacks necessary AMBA PrimeCell IDs, so we need to
+	 * hard-code them. The Integator/CP and forward have proper cell IDs.
+	 * Else we leave them undefined to the bus driver can autoprobe them.
+	 */
+	if (machine_is_integrator()) {
+		rtc_device.periphid	= 0x00041030;
+		uart0_device.periphid	= 0x00041010;
+		uart1_device.periphid	= 0x00041010;
+		kmi0_device.periphid	= 0x00041050;
+		kmi1_device.periphid	= 0x00041050;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
 		amba_device_register(d, &iomem_resource);
-- 
1.7.6.4
