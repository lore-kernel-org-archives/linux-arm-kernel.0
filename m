From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 6 Jun 2014 15:41:34 +0800
Subject: [PATCH 1/2] misc: atmel-ssc: support to read ssc version
Message-ID: <1402040495-10320-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Read SSC IP version to check whether it supports frame sync
length extension feature.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 drivers/misc/atmel-ssc.c  | 7 +++++++
 include/linux/atmel-ssc.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index 22de137..9f49bcb 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -136,6 +136,7 @@ static int ssc_probe(struct platform_device *pdev)
 	struct resource *regs;
 	struct ssc_device *ssc;
 	const struct atmel_ssc_platform_data *plat_dat;
+	u32 version;
 
 	ssc = devm_kzalloc(&pdev->dev, sizeof(struct ssc_device), GFP_KERNEL);
 	if (!ssc) {
@@ -173,8 +174,14 @@ static int ssc_probe(struct platform_device *pdev)
 	clk_prepare_enable(ssc->clk);
 	ssc_writel(ssc->regs, IDR, -1);
 	ssc_readl(ssc->regs, SR);
+	version = ssc_readl(ssc->regs, VERSION);
 	clk_disable_unprepare(ssc->clk);
 
+	if (version >= 0x300)
+		ssc->has_fslen_ext = 1;
+	else
+		ssc->has_fslen_ext = 0;
+
 	ssc->irq = platform_get_irq(pdev, 0);
 	if (!ssc->irq) {
 		dev_dbg(&pdev->dev, "could not get irq\n");
diff --git a/include/linux/atmel-ssc.h b/include/linux/atmel-ssc.h
index 571a12e..9ee1b68 100644
--- a/include/linux/atmel-ssc.h
+++ b/include/linux/atmel-ssc.h
@@ -19,6 +19,7 @@ struct ssc_device {
 	int			user;
 	int			irq;
 	bool			clk_from_rk_pin;
+	int			has_fslen_ext;
 };
 
 struct ssc_device * __must_check ssc_request(unsigned int ssc_num);
@@ -258,6 +259,8 @@ void ssc_free(struct ssc_device *ssc);
 #define SSC_IMR_TXSYN_SIZE			 1
 #define SSC_IMR_TXSYN_OFFSET			10
 
+#define SSC_VERSION			0x000000fc
+
 /* SSC PDC Receive Pointer Register */
 #define SSC_PDC_RPR			0x00000100
 
-- 
1.8.5.2
