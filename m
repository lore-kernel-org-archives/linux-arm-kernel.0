From: abhilash.kv@ti.com (Abhilash K V)
Date: Fri, 19 Aug 2011 17:22:31 +0530
Subject: [PATCH 2/2] AM3517: Support for MMC1
In-Reply-To: <1313754751-11752-2-git-send-email-abhilash.kv@ti.com>
References: <1313754751-11752-1-git-send-email-abhilash.kv@ti.com>
	<1313754751-11752-2-git-send-email-abhilash.kv@ti.com>
Message-ID: <1313754751-11752-3-git-send-email-abhilash.kv@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following error message which appears
while intializing MMC1 on the AM3517 EVM base-board:
    mmc0: host doesn't support card's voltages
    mmc0: error -22 whilst initialising SD card
The ocr_mask, which enumerates the volatges supported by the
MMC card was not being indicated before, assuming that a separate
Vcc regulator maybe another controllable regulator driver would be
doing this. This patch statically specifies a subset of the voltages
supported by the MMC driver, which are provided by the current fixed
voltage regulator on AM3517 EVM.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index a9b45c7..9dee2e1 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -350,7 +350,15 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	 *
 	 * temporary HACK: ocr_mask instead of fixed supply
 	 */
-	mmc->slots[0].ocr_mask = c->ocr_mask;
+	if (cpu_is_omap3505() || cpu_is_omap3517())
+		mmc->slots[0].ocr_mask = MMC_VDD_165_195 |
+					 MMC_VDD_26_27 |
+					 MMC_VDD_27_28 |
+					 MMC_VDD_29_30 |
+					 MMC_VDD_30_31 |
+					 MMC_VDD_31_32;
+	else
+		mmc->slots[0].ocr_mask = c->ocr_mask;
 
 	if (cpu_is_omap3517() || cpu_is_omap3505())
 		mmc->slots[0].set_power = nop_mmc_set_power;
-- 
1.7.1
