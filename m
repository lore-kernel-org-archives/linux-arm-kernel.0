From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  8 Aug 2017 21:05:10 +0200
Subject: [PATCH] mtd: physmap_of: Retire Gemini pad control
Message-ID: <20170808190510.11496-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I wrote a proper pin control driver for the Gemini. Retire this
SoC-specific pad control and rely on the pin controller to manage
this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/maps/physmap_of_gemini.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of_gemini.c b/drivers/mtd/maps/physmap_of_gemini.c
index 05b286b5289f..4ed1a6bb4d3c 100644
--- a/drivers/mtd/maps/physmap_of_gemini.c
+++ b/drivers/mtd/maps/physmap_of_gemini.c
@@ -43,13 +43,6 @@
 
 #define FLASH_PARALLEL_HIGH_PIN_CNT	(1 << 20)	/* else low pin cnt */
 
-/* Miscellaneous Control Register */
-#define GLOBAL_MISC_CTRL		0x30
-#define FLASH_PADS_MASK			0x07
-#define NAND_PADS_DISABLE		BIT(2)
-#define PFLASH_PADS_DISABLE		BIT(1)
-#define SFLASH_PADS_DISABLE		BIT(0)
-
 static const struct of_device_id syscon_match[] = {
 	{ .compatible = "cortina,gemini-syscon" },
 	{ },
@@ -102,15 +95,6 @@ int of_flash_probe_gemini(struct platform_device *pdev,
 				 map->bankwidth * 8);
 	}
 
-	/* Activate parallel (NOR flash) mode */
-	ret = regmap_update_bits(rmap, GLOBAL_MISC_CTRL,
-				 FLASH_PADS_MASK,
-				 SFLASH_PADS_DISABLE | NAND_PADS_DISABLE);
-	if (ret) {
-		dev_err(dev, "unable to set up physmap pads\n");
-		return -ENODEV;
-	}
-
 	dev_info(&pdev->dev, "initialized Gemini-specific physmap control\n");
 
 	return 0;
-- 
2.9.4
