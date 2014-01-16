From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 16 Jan 2014 20:48:47 +0800
Subject: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
In-Reply-To: <1389839502-13046-1-git-send-email-zhangfei.gao@linaro.org>
References: <1389839502-13046-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1389876527-13498-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduced from commit bf626e5550f24aec24975a0e85ad8e572ca76a6b
CDETECT is ignored since negated return value of mmc_gpio_get_cd(mmc)
can not be checked by IS_ERR_VALUE.
Add spin_lock_bh(&host->lock) for atomic accessing DW_MMC_CARD_PRESENT,
otherwise sd detect may occasionally fail.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reported-by: Kevin Hilman <khilman@linaro.org>
Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
Tested-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/dw_mmc.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a776f24f4311..55cd110a49c4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1033,7 +1033,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	int present;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci_board *brd = slot->host->pdata;
-	int gpio_cd = !mmc_gpio_get_cd(mmc);
+	struct dw_mci *host = slot->host;
+	int gpio_cd = mmc_gpio_get_cd(mmc);
 
 	/* Use platform get_cd function, else try onboard card detect */
 	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
@@ -1041,11 +1042,12 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	else if (brd->get_cd)
 		present = !brd->get_cd(slot->id);
 	else if (!IS_ERR_VALUE(gpio_cd))
-		present = !!gpio_cd;
+		present = gpio_cd;
 	else
 		present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
 			== 0 ? 1 : 0;
 
+	spin_lock_bh(&host->lock);
 	if (present) {
 		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 		dev_dbg(&mmc->class_dev, "card is present\n");
@@ -1053,6 +1055,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 		dev_dbg(&mmc->class_dev, "card is not present\n");
 	}
+	spin_unlock_bh(&host->lock);
 
 	return present;
 }
@@ -2081,7 +2084,7 @@ static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
 	return gpio;
 }
 
-/* find the cd gpio for a given slot; or -1 if none specified */
+/* find the cd gpio for a given slot */
 static void dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
 					struct mmc_host *mmc)
 {
@@ -2411,6 +2414,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	if (of_find_property(np, "caps2-mmc-hs200-1_2v", NULL))
 		pdata->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
 
+	if (of_get_property(np, "cd-inverted", NULL))
+		pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+
 	return pdata;
 }
 
-- 
1.7.9.5
