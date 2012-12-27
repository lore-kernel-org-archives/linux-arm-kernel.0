From: mikedunn@newsguy.com (Mike Dunn)
Date: Thu, 27 Dec 2012 10:02:19 -0800
Subject: [PATCH v2 3/4] ARM: palmtreo: add docg4 device initialization
In-Reply-To: <1356631340-30328-1-git-send-email-mikedunn@newsguy.com>
References: <1356631340-30328-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <1356631340-30328-4-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds initialization of the docg4 nand flash device to the treo680.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 arch/arm/mach-pxa/palmtreo.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 5775128..8ca152b 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -397,6 +397,36 @@ static void __init palmtreo_leds_init(void)
 }
 
 /******************************************************************************
+ * diskonchip docg4 flash
+ ******************************************************************************/
+#if defined(CONFIG_MACH_TREO680)
+/* REVISIT: does the centro have this device also? */
+#if IS_ENABLED(CONFIG_MTD_NAND_DOCG4)
+static struct resource docg4_resources[] = {
+	{
+		.start	= 0x00000000,
+		.end	= 0x00001FFF,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device treo680_docg4_flash = {
+	.name   = "docg4",
+	.id     = -1,
+	.resource = docg4_resources,
+	.num_resources = ARRAY_SIZE(docg4_resources),
+};
+
+static void __init treo680_docg4_flash_init(void)
+{
+	platform_device_register(&treo680_docg4_flash);
+}
+#else
+static inline void treo680_docg4_flash_init(void) {}
+#endif
+#endif
+
+/******************************************************************************
  * Machine init
  ******************************************************************************/
 static void __init treo_reserve(void)
@@ -480,6 +510,7 @@ static void __init treo680_init(void)
 	treo680_gpio_init();
 	palm27x_mmc_init(GPIO_NR_TREO_SD_DETECT_N, GPIO_NR_TREO680_SD_READONLY,
 			GPIO_NR_TREO680_SD_POWER, 0);
+	treo680_docg4_flash_init();
 }
 #endif
 
-- 
1.7.8.6
