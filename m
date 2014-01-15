From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 15 Jan 2014 15:15:59 +0800
Subject: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
In-Reply-To: <CAGa+x85awFYsrU9Gggirpaip3vggtSqu5GinVzss=nfNcp4nww@mail.gmail.com>
References: <CAGa+x85awFYsrU9Gggirpaip3vggtSqu5GinVzss=nfNcp4nww@mail.gmail.com>
Message-ID: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introdeced from commit b7db86adfa58b
CDETECT is ingored since IS_ERR_VALUE(!mmc_gpio_get_cd(mmc)) does not work
Add spin_lock_bh(&host->lock) for atomic accessing DW_MMC_CARD_PRESENT

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reported-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/mmc/host/dw_mmc.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a776f24f4311..9ded62c8225e 100644
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
+		present = !gpio_cd;
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
-- 
1.7.9.5
