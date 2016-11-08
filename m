From: yong.mao@mediatek.com (Yong Mao)
Date: Tue, 8 Nov 2016 14:09:00 +0800
Subject: [PATCH 3/4] sdio: mediatek: support sdr104_clk_delay in sdio
In-Reply-To: <1478585341-6749-1-git-send-email-yong.mao@mediatek.com>
References: <1478585341-6749-1-git-send-email-yong.mao@mediatek.com>
Message-ID: <1478585341-6749-4-git-send-email-yong.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: yong mao <yong.mao@mediatek.com>

In order to let sdio run stable with 200M clock,
we should setup the value of clock delay.

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 37edf30..fba28f2 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -213,6 +213,7 @@
 
 #define MSDC_PAD_TUNE_DATRRDLY	  (0x1f <<  8)	/* RW */
 #define MSDC_PAD_TUNE_CMDRDLY	  (0x1f << 16)  /* RW */
+#define MSDC_PAD_TUNE_CLKTDLY     (0x1f << 27)  /* RW */
 
 #define PAD_DS_TUNE_DLY1	  (0x1f << 2)   /* RW */
 #define PAD_DS_TUNE_DLY2	  (0x1f << 7)   /* RW */
@@ -335,6 +336,7 @@ struct msdc_host {
 	unsigned char timing;
 	bool vqmmc_enabled;
 	u32 hs400_ds_delay;
+	u32 sdr104_clk_delay;
 	bool hs400_mode;	/* current eMMC will run@hs400 mode */
 	struct msdc_save_para save_para; /* used when gate HCLK */
 	struct msdc_tune_para def_tune_para; /* default tune setting */
@@ -1230,7 +1232,8 @@ static void msdc_init_hw(struct msdc_host *host)
 	writel(val, host->base + MSDC_INT);
 	spin_unlock_irqrestore(&host->irqlock, flags);
 
-	writel(0, host->base + MSDC_PAD_TUNE);
+	sdr_set_field(host->base + MSDC_PAD_TUNE,
+		      MSDC_PAD_TUNE_CLKTDLY, host->sdr104_clk_delay);
 	writel(0, host->base + MSDC_IOCON);
 	sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 0);
 	writel(0x403c0046, host->base + MSDC_PATCH_BIT);
@@ -1671,6 +1674,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "hs400-ds-delay: %x\n",
 			host->hs400_ds_delay);
 
+	if (!of_property_read_u32(pdev->dev.of_node, "sdr104-clk-delay",
+				  &host->sdr104_clk_delay))
+		dev_dbg(&pdev->dev, "sdr104-clk-delay: %x\n",
+			host->sdr104_clk_delay);
+
 	host->dev = &pdev->dev;
 	host->mmc = mmc;
 	host->src_clk_freq = clk_get_rate(host->src_clk);
-- 
1.7.9.5
