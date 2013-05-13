From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:26 +0400
Subject: [PATCH 04/15] ARM: clps711x: autcpu12: Add support for NOR flash
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-7-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-autcpu12.c        | 39 ++++++++++++++++++++++++--
 arch/arm/mach-clps711x/include/mach/autcpu12.h |  5 ----
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index 78b528a..3e22d0b 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -26,6 +26,7 @@
 #include <linux/gpio.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
+#include <linux/mtd/physmap.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand-gpio.h>
 #include <linux/platform_device.h>
@@ -45,12 +46,17 @@
 #include "common.h"
 #include "devices.h"
 
-#define AUTCPU12_CS8900_BASE	(CS2_PHYS_BASE + 0x300)
-#define AUTCPU12_CS8900_IRQ	(IRQ_EINT3)
+/* NOR flash */
+#define AUTCPU12_FLASH_BASE	(CS0_PHYS_BASE)
 
+/* SmartMedia flash */
 #define AUTCPU12_SMC_BASE	(CS1_PHYS_BASE + 0x06000000)
 #define AUTCPU12_SMC_SEL_BASE	(AUTCPU12_SMC_BASE + 0x10)
 
+/* Ethernet */
+#define AUTCPU12_CS8900_BASE	(CS2_PHYS_BASE + 0x300)
+#define AUTCPU12_CS8900_IRQ	(IRQ_EINT3)
+
 /* NAND flash */
 #define AUTCPU12_MMGPIO_BASE	(CLPS711X_NR_GPIO)
 #define AUTCPU12_SMC_NCE	(AUTCPU12_MMGPIO_BASE + 0) /* Bit 0 */
@@ -160,9 +166,38 @@ static const struct gpio autcpu12_gpios[] __initconst = {
 	{ AUTCPU12_DPOT_UD,	GPIOF_OUT_INIT_LOW,	"DPOT UD" },
 };
 
+static struct mtd_partition autcpu12_flash_partitions[] = {
+	{
+		.name	= "NOR.0",
+		.offset	= 0,
+		.size	= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct physmap_flash_data autcpu12_flash_pdata = {
+	.width		= 4,
+	.parts		= autcpu12_flash_partitions,
+	.nr_parts	= ARRAY_SIZE(autcpu12_flash_partitions),
+};
+
+static struct resource autcpu12_flash_resources[] __initdata = {
+	DEFINE_RES_MEM(AUTCPU12_FLASH_BASE, SZ_8M),
+};
+
+static struct platform_device autcpu12_flash_pdev __initdata = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.resource	= autcpu12_flash_resources,
+	.num_resources	= ARRAY_SIZE(autcpu12_flash_resources),
+	.dev		= {
+		.platform_data	= &autcpu12_flash_pdata,
+	},
+};
+
 static void __init autcpu12_init(void)
 {
 	clps711x_devices_init();
+	platform_device_register(&autcpu12_flash_pdev);
 	platform_device_register_simple("video-clps711x", 0, NULL, 0);
 	platform_device_register_simple("cs89x0", 0, autcpu12_cs8900_resource,
 					ARRAY_SIZE(autcpu12_cs8900_resource));
diff --git a/arch/arm/mach-clps711x/include/mach/autcpu12.h b/arch/arm/mach-clps711x/include/mach/autcpu12.h
index b95d60a..0db6f18 100644
--- a/arch/arm/mach-clps711x/include/mach/autcpu12.h
+++ b/arch/arm/mach-clps711x/include/mach/autcpu12.h
@@ -20,11 +20,6 @@
 #ifndef __ASM_ARCH_AUTCPU12_H
 #define __ASM_ARCH_AUTCPU12_H
 
-/*
- * The flash bank is wired to chip select 0
- */
-#define AUTCPU12_PHYS_FLASH		CS0_PHYS_BASE		/* physical */
-
 /* offset for device specific information structure */
 #define AUTCPU12_LCDINFO_OFFS		(0x00010000)	
 
-- 
1.8.1.5
