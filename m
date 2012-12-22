From: mikedunn@newsguy.com (Mike Dunn)
Date: Sat, 22 Dec 2012 11:31:59 -0800
Subject: [PATCH 3/3] ARM: pxa: palmtreo: add docg4 device initialization
In-Reply-To: <1356204719-3317-1-git-send-email-mikedunn@newsguy.com>
References: <1356204719-3317-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <1356204719-3317-4-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds initialization of the docg4 nand flash device to the treo680.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 arch/arm/mach-pxa/palmtreo.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index cb9cc7b..f3e2d08 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -404,6 +404,36 @@ static void __init palmtreo_leds_init(void)
 }
 
 /******************************************************************************
+ * diskonchip docg4 flash
+ ******************************************************************************/
+#if defined(CONFIG_MACH_TREO680)
+/* REVISIT: does the centro have this device also? */
+#if defined(CONFIG_MTD_NAND_DOCG4) || defined(CONFIG_MTD_NAND_DOCG4_MODULE)
+static struct resource docg4_resources[] = {
+	{
+		.start	= 0x00000000,
+		.end	= 0x00001FFF,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device palmtreo680_docg4_flashdevice = {
+	.name   = "docg4",
+	.id     = -1,
+	.resource = docg4_resources,
+	.num_resources = ARRAY_SIZE(docg4_resources),
+};
+
+static void __init palmtreo680_docg4_flash_init(void)
+{
+	platform_device_register(&palmtreo680_docg4_flashdevice);
+}
+#else
+static inline void palmtreo680_docg4_flash_init(void) {}
+#endif
+#endif
+
+/******************************************************************************
  * Machine init
  ******************************************************************************/
 static void __init treo_reserve(void)
@@ -482,6 +512,7 @@ static void __init treo680_init(void)
 	treo680_lcd_init();
 	palm27x_mmc_init(GPIO_NR_TREO_SD_DETECT_N, GPIO_NR_TREO680_SD_READONLY,
 			GPIO_NR_TREO680_SD_POWER, 0);
+	palmtreo680_docg4_flash_init();
 }
 #endif
 
-- 
1.7.8.6
