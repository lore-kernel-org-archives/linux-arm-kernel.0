From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 23 Aug 2018 23:27:38 +0200
Subject: [PATCH] mt76: Fix comparisons with invalid hardware key index
Message-ID: <20180823212738.18431-1-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With gcc 4.1.2:

    drivers/net/wireless/mediatek/mt76/mt76x0/tx.c: In function ?mt76x0_tx?:
    drivers/net/wireless/mediatek/mt76/mt76x0/tx.c:169: warning: comparison is always true due to limited range of data type
    drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c: In function ?mt76x2_tx?:
    drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c:35: warning: comparison is always true due to limited range of data type

While assigning -1 to a u8 works fine, comparing with -1 does not work
as expected.

Fix this by comparing with 0xff, like is already done in some other
places.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
---
 drivers/net/wireless/mediatek/mt76/mt76x0/tx.c        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/tx.c b/drivers/net/wireless/mediatek/mt76/mt76x0/tx.c
index 751b49c28ae53f0f..c45d05d5aab1d207 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/tx.c
@@ -166,7 +166,7 @@ void mt76x0_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 	if (sta) {
 		msta = (struct mt76_sta *) sta->drv_priv;
 		wcid = &msta->wcid;
-	} else if (vif && (!info->control.hw_key && wcid->hw_key_idx != -1)) {
+	} else if (vif && (!info->control.hw_key && wcid->hw_key_idx != 0xff)) {
 		struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 
 		wcid = &mvif->group_wcid;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c b/drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c
index 36afb166fa3ffd29..c0ca0df84ed8b86a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c
@@ -32,7 +32,7 @@ void mt76x2_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 		msta = (struct mt76x2_sta *)control->sta->drv_priv;
 		wcid = &msta->wcid;
 		/* sw encrypted frames */
-		if (!info->control.hw_key && wcid->hw_key_idx != -1)
+		if (!info->control.hw_key && wcid->hw_key_idx != 0xff)
 			control->sta = NULL;
 	}
 
-- 
2.17.1
