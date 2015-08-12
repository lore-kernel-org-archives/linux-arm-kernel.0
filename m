From: hramrach@gmail.com (Michal Suchanek)
Date: 12 Aug 2015 12:23:10 -0000
Subject: [PATCH 2/3] mmc: dw_mmc: simplify the SDMMC_CLKEN_LOW_PWR logic
In-Reply-To: <cover.1439381423.git.hramrach@gmail.com>
References: <cover.1439381423.git.hramrach@gmail.com>
Message-ID: <3d03bfe2c18789eefa038018467c9c63c94ae4a2.1439381423.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver has open-coded test for SDIO cards. Use the mmc core provided
MMC_QUIRK_BROKEN_CLK_GATING flag instead.

As a bonus this may enable clock gating on SDIO cards that are known to
work with it.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/mmc/host/dw_mmc.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 40e9d8e..3bc9fd7 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1335,27 +1335,24 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
 	 * description of the CLKENA register we should disable low power mode
 	 * for SDIO cards if we need SDIO interrupts to work.
 	 */
-	if (mmc->caps & MMC_CAP_SDIO_IRQ) {
-		const u32 clken_low_pwr = SDMMC_CLKEN_LOW_PWR << slot->id;
-		u32 clk_en_a_old;
-		u32 clk_en_a;
+	const u32 clken_low_pwr = SDMMC_CLKEN_LOW_PWR << slot->id;
+	u32 clk_en_a_old;
+	u32 clk_en_a;
 
-		clk_en_a_old = mci_readl(host, CLKENA);
+	clk_en_a_old = mci_readl(host, CLKENA);
 
-		if (card->type == MMC_TYPE_SDIO ||
-		    card->type == MMC_TYPE_SD_COMBO) {
-			set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
-			clk_en_a = clk_en_a_old & ~clken_low_pwr;
-		} else {
-			clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
-			clk_en_a = clk_en_a_old | clken_low_pwr;
-		}
+	if (card->quirks & MMC_QUIRK_BROKEN_CLK_GATING) {
+		set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
+		clk_en_a = clk_en_a_old & ~clken_low_pwr;
+	} else {
+		clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
+		clk_en_a = clk_en_a_old | clken_low_pwr;
+	}
 
-		if (clk_en_a != clk_en_a_old) {
-			mci_writel(host, CLKENA, clk_en_a);
-			mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
-				     SDMMC_CMD_PRV_DAT_WAIT, 0);
-		}
+	if (clk_en_a != clk_en_a_old) {
+		mci_writel(host, CLKENA, clk_en_a);
+		mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
+				SDMMC_CMD_PRV_DAT_WAIT, 0);
 	}
 }
 
-- 
2.1.4
