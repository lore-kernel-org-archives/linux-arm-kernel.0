From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 10 Jan 2012 19:13:19 +0800
Subject: [PATCH RESEND v3 2/2] [media] V4L: atmel-isi: add
 clk_prepare()/clk_unprepare() functions
Message-ID: <1326193999-7609-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi, Mauro

The first patch of this serie, [PATCH 1/2 v3] V4L: atmel-isi: add code to enable/disable ISI_MCK clock, is already queued in media tree. 
But this patch (the second one of this serie) is not acked yet. Would it be ok to for you to ack this patch?

Best Regards,
Josh Wu

v2: made the label name to be consistent.

 drivers/media/video/atmel-isi.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/atmel-isi.c b/drivers/media/video/atmel-isi.c
index ea4eef4..91ebcfb 100644
--- a/drivers/media/video/atmel-isi.c
+++ b/drivers/media/video/atmel-isi.c
@@ -922,7 +922,9 @@ static int __devexit atmel_isi_remove(struct platform_device *pdev)
 			isi->fb_descriptors_phys);
 
 	iounmap(isi->regs);
+	clk_unprepare(isi->mck);
 	clk_put(isi->mck);
+	clk_unprepare(isi->pclk);
 	clk_put(isi->pclk);
 	kfree(isi);
 
@@ -955,6 +957,12 @@ static int __devinit atmel_isi_probe(struct platform_device *pdev)
 	if (IS_ERR(pclk))
 		return PTR_ERR(pclk);
 
+	ret = clk_prepare(pclk);
+	if (ret) {
+		clk_put(pclk);
+		return ret;
+	}
+
 	isi = kzalloc(sizeof(struct atmel_isi), GFP_KERNEL);
 	if (!isi) {
 		ret = -ENOMEM;
@@ -978,6 +986,10 @@ static int __devinit atmel_isi_probe(struct platform_device *pdev)
 		goto err_clk_get;
 	}
 
+	ret = clk_prepare(isi->mck);
+	if (ret)
+		goto err_clk_prepare_mck;
+
 	/* Set ISI_MCK's frequency, it should be faster than pixel clock */
 	ret = clk_set_rate(isi->mck, pdata->mck_hz);
 	if (ret < 0)
@@ -1059,10 +1071,13 @@ err_alloc_ctx:
 			isi->fb_descriptors_phys);
 err_alloc_descriptors:
 err_set_mck_rate:
+	clk_unprepare(isi->mck);
+err_clk_prepare_mck:
 	clk_put(isi->mck);
 err_clk_get:
 	kfree(isi);
 err_alloc_isi:
+	clk_unprepare(pclk);
 	clk_put(pclk);
 
 	return ret;
-- 
1.6.3.3
