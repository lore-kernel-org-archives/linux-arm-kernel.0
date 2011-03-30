From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 30 Mar 2011 16:02:34 +0200
Subject: [PATCH] mach-ux500: correct MMC/SDI parameters
Message-ID: <1301493754-25442-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

We cannot clock the MMCI blocks more than 50 MHz. A bug prevented
us from seeing the effect of actually driving them to 100 MHz,
which indeed resulted failure, on the external SD card.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index bf0b024..f4bccea 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -67,8 +67,10 @@ static struct stedma40_chan_cfg mop500_sdi0_dma_cfg_tx = {
 static struct mmci_platform_data mop500_sdi0_data = {
 	.vdd_handler	= mop500_sdi0_vdd_handler,
 	.ocr_mask	= MMC_VDD_29_30,
-	.f_max		= 100000000,
-	.capabilities	= MMC_CAP_4_BIT_DATA,
+	.f_max		= 50000000,
+	.capabilities	= MMC_CAP_4_BIT_DATA |
+				MMC_CAP_SD_HIGHSPEED |
+				MMC_CAP_MMC_HIGHSPEED,
 	.gpio_wp	= -1,
 #ifdef CONFIG_STE_DMA40
 	.dma_filter	= stedma40_filter,
@@ -137,7 +139,7 @@ static struct stedma40_chan_cfg mop500_sdi2_dma_cfg_tx = {
 
 static struct mmci_platform_data mop500_sdi2_data = {
 	.ocr_mask	= MMC_VDD_165_195,
-	.f_max		= 100000000,
+	.f_max		= 50000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
@@ -174,7 +176,7 @@ static struct stedma40_chan_cfg mop500_sdi4_dma_cfg_tx = {
 
 static struct mmci_platform_data mop500_sdi4_data = {
 	.ocr_mask	= MMC_VDD_29_30,
-	.f_max		= 100000000,
+	.f_max		= 50000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_MMC_HIGHSPEED,
 	.gpio_cd	= -1,
-- 
1.7.3.2
