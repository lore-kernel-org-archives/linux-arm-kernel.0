From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 6 Aug 2010 16:45:03 +0200
Subject: [PATCH] ARM: fix inverted MMC card detect in U300
Message-ID: <1281105903-14557-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the U300 to uninverted logic for MMCI card detect,
fixing a regression in the current tree.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/mmc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
index 3acb710..2382175 100644
--- a/arch/arm/mach-u300/mmc.c
+++ b/arch/arm/mach-u300/mmc.c
@@ -77,16 +77,16 @@ static void _mmci_callback(struct work_struct *ws)
 
 	mdelay(20);
 
-	mmci_card->mmc_inserted = !!gpio_get_value(U300_GPIO_PIN_MMC_CD);
+	mmci_card->mmc_inserted = !gpio_get_value(U300_GPIO_PIN_MMC_CD);
 
 	input_report_switch(mmci_card->mmc_input, KEY_INSERT,
-			    !mmci_card->mmc_inserted);
+			    mmci_card->mmc_inserted);
 	input_sync(mmci_card->mmc_input);
 
 	pr_debug("MMC/SD card was %s\n",
-		 mmci_card->mmc_inserted ? "removed" : "inserted");
+		 mmci_card->mmc_inserted ? "inserted" : "removed");
 
-	enable_irq_on_gpio_pin(U300_GPIO_PIN_MMC_CD, !mmci_card->mmc_inserted);
+	enable_irq_on_gpio_pin(U300_GPIO_PIN_MMC_CD, mmci_card->mmc_inserted);
 }
 
 int __devinit mmc_init(struct amba_device *adev)
-- 
1.6.3.3
