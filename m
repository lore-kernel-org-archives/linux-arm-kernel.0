From: yong.mao@mediatek.com (Yong Mao)
Date: Tue, 8 Nov 2016 14:08:58 +0800
Subject: [PATCH 1/4] mmc: mediatek: Fix CMD6 timeout issue
In-Reply-To: <1478585341-6749-1-git-send-email-yong.mao@mediatek.com>
References: <1478585341-6749-1-git-send-email-yong.mao@mediatek.com>
Message-ID: <1478585341-6749-2-git-send-email-yong.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: yong mao <yong.mao@mediatek.com>

When initializing EMMC, after switch to HS400,
it will issue CMD6 to change ext_csd, if first CMD6 got CRC
error, the repeat CMD6 may get timeout, that's
because SDCBSY was cleared by msdc_reset_hw()

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c |   77 ++++++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 84e9afc..b29683b 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -826,6 +826,15 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 	return true;
 }
 
+static int msdc_card_busy(struct mmc_host *mmc)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+	u32 status = readl(host->base + MSDC_PS);
+
+	/* check if data0 is low */
+	return !(status & BIT(16));
+}
+
 /* It is the core layer's responsibility to ensure card status
  * is correct before issue a request. but host design do below
  * checks recommended.
@@ -835,10 +844,20 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 {
 	/* The max busy time we can endure is 20ms */
 	unsigned long tmo = jiffies + msecs_to_jiffies(20);
+	u32 count = 0;
+
+	if (in_interrupt()) {
+		while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
+		       (count < 1000)) {
+			udelay(1);
+			count++;
+		}
+	} else {
+		while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
+		       time_before(jiffies, tmo))
+			cpu_relax();
+	}
 
-	while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
-			time_before(jiffies, tmo))
-		cpu_relax();
 	if (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) {
 		dev_err(host->dev, "CMD bus busy detected\n");
 		host->error |= REQ_CMD_BUSY;
@@ -846,17 +865,35 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 		return false;
 	}
 
-	if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
-		tmo = jiffies + msecs_to_jiffies(20);
-		/* R1B or with data, should check SDCBUSY */
-		while ((readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) &&
-				time_before(jiffies, tmo))
-			cpu_relax();
-		if (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) {
-			dev_err(host->dev, "Controller busy detected\n");
-			host->error |= REQ_CMD_BUSY;
-			msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
-			return false;
+	if (cmd->opcode != MMC_SEND_STATUS) {
+		count = 0;
+		/* Consider that CMD6 crc error before card was init done,
+		 * mmc_retune() will return directly as host->card is null.
+		 * and CMD6 will retry 3 times, must ensure card is in transfer
+		 * state when retry.
+		 */
+		tmo = jiffies + msecs_to_jiffies(60 * 1000);
+		while (1) {
+			if (msdc_card_busy(host->mmc)) {
+				if (in_interrupt()) {
+					udelay(1);
+					count++;
+				} else {
+					msleep_interruptible(10);
+				}
+			} else {
+				break;
+			}
+			/* Timeout if the device never
+			 * leaves the program state.
+			 */
+			if (count > 1000 || time_after(jiffies, tmo)) {
+				pr_err("%s: Card stuck in programming state! %s\n",
+				       mmc_hostname(host->mmc), __func__);
+				host->error |= REQ_CMD_BUSY;
+				msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
+				return false;
+			}
 		}
 	}
 	return true;
@@ -1070,18 +1107,6 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
 	return ret;
 }
 
-static int msdc_card_busy(struct mmc_host *mmc)
-{
-	struct msdc_host *host = mmc_priv(mmc);
-	u32 status = readl(host->base + MSDC_PS);
-
-	/* check if any pin between dat[0:3] is low */
-	if (((status >> 16) & 0xf) != 0xf)
-		return 1;
-
-	return 0;
-}
-
 static void msdc_request_timeout(struct work_struct *work)
 {
 	struct msdc_host *host = container_of(work, struct msdc_host,
-- 
1.7.9.5
