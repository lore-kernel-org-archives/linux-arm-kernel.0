From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Mon, 16 Aug 2010 17:00:50 +0200
Subject: [PATCH] ARM: AB8500 I2C platform configration and irq
Message-ID: <1281970850-6639-1-git-send-email-mattias.wallin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the platform part of the AB8500 PRCMU I2C
access driver. The old irq name AB4500 is changed to AB8500.

Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c      |   27 +++++++++++++++++++++++++--
 arch/arm/mach-ux500/include/mach/irqs.h |    2 +-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index a908824..d62f689 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -31,6 +31,7 @@
 #include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
+#include <mach/irqs.h>
 
 #include "pins-db8500.h"
 #include "board-mop500.h"
@@ -105,9 +106,27 @@ static struct ab8500_platform_data ab8500_platdata = {
 	},
 };
 
+static struct resource ab8500_resources[] = {
+	[0] = {
+		.start = IRQ_AB8500,
+		.end = IRQ_AB8500,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+struct platform_device ux500_ab8500_device = {
+	.name = "ab8500-i2c",
+	.id = 0,
+	.dev = {
+		.platform_data = &ab8500_platdata,
+	},
+	.num_resources = 1,
+	.resource = ab8500_resources,
+};
+
 static struct spi_board_info u8500_spi_devices[] = {
 	{
-		.modalias = "ab8500",
+		.modalias = "ab8500-spi",
 		.controller_data = &ab4500_chip_info,
 		.platform_data = &ab8500_platdata,
 		.max_speed_hz = 12000000,
@@ -210,8 +229,12 @@ static void __init u8500_init_machine(void)
 
 	mop500_sdi_init();
 
-	spi_register_board_info(u8500_spi_devices,
+	/* If HW is early drop(ed) or v1.0 then use spi to access ab8500 */
+	if (cpu_is_u8500ed() || cpu_is_u8500v10())
+		spi_register_board_info(u8500_spi_devices,
 			ARRAY_SIZE(u8500_spi_devices));
+	else /* If HW is v.1.1 or later use i2c to access ab8500 */
+		platform_device_register(&ux500_ab8500_device);
 
 	i2c_register_board_info(0, mop500_i2c0_devices,
 				ARRAY_SIZE(mop500_i2c0_devices));
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index 0e7a2ce..0d552d9 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -40,7 +40,7 @@
 #define IRQ_HSIR_CH1_OVRRUN	(IRQ_SHPI_START + 33)
 #define IRQ_HSIR_CH2_OVRRUN	(IRQ_SHPI_START + 34)
 #define IRQ_HSIR_CH3_OVRRUN	(IRQ_SHPI_START + 35)
-#define IRQ_AB4500		(IRQ_SHPI_START + 40)
+#define IRQ_AB8500		(IRQ_SHPI_START + 40)
 #define IRQ_PRCMU               (IRQ_SHPI_START + 47)
 #define IRQ_DISP		(IRQ_SHPI_START + 48)
 #define IRQ_SiPI3		(IRQ_SHPI_START + 49)
-- 
1.6.3.3
