From: yong.mao@mediatek.com (Yong Mao)
Date: Tue, 3 Jan 2017 16:49:57 +0800
Subject: [PATCH v2 2/2] mmc: mediatek: correct the implementation of
 msdc_card_busy
In-Reply-To: <1483433397-11756-1-git-send-email-yong.mao@mediatek.com>
References: <1483433397-11756-1-git-send-email-yong.mao@mediatek.com>
Message-ID: <1483433397-11756-3-git-send-email-yong.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: yong mao <yong.mao@mediatek.com>

msdc_card_busy only need check if the data0 is low.
In sdio data1 irq mode, data1 may be low because of interruption.

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 10ef2ae..80ba034 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1074,11 +1074,8 @@ static int msdc_card_busy(struct mmc_host *mmc)
 	struct msdc_host *host = mmc_priv(mmc);
 	u32 status = readl(host->base + MSDC_PS);
 
-	/* check if any pin between dat[0:3] is low */
-	if (((status >> 16) & 0xf) != 0xf)
-		return 1;
-
-	return 0;
+	/* only check if data0 is low */
+	return !(status & BIT(16));
 }
 
 static void msdc_request_timeout(struct work_struct *work)
-- 
1.7.9.5
