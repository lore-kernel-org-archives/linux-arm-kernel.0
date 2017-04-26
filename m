From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 26 Apr 2017 15:04:43 -0700
Subject: [PATCH 1/2] wcn36xx: Pass used skb to ieee80211_tx_status()
Message-ID: <20170426220444.10539-1-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the tx skbs are collected they should be passed to
ieee80211_tx_status() rather than ieee80211_free_txskb(), as the prior
will take care of monitoring and LED triggers while the latter will
consider the skb dropped.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 87dfdaf9044c..938b7bd733cf 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -371,7 +371,7 @@ static void reap_tx_dxes(struct wcn36xx *wcn, struct wcn36xx_dxe_ch *ch)
 			info = IEEE80211_SKB_CB(ctl->skb);
 			if (!(info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)) {
 				/* Keep frame until TX status comes */
-				ieee80211_free_txskb(wcn->hw, ctl->skb);
+				ieee80211_tx_status(wcn->hw, ctl->skb);
 			}
 			spin_lock(&ctl->skb_lock);
 			if (wcn->queues_stopped) {
-- 
2.12.0
