From: b18965@freescale.com (Alison Wang)
Date: Thu, 14 Sep 2017 14:53:40 +0800
Subject: [PATCH 1/2] drm/fsl-dcu: Fix DCU pixel clock issue in suspend/resume
 functions
Message-ID: <20170914065341.17615-1-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As there is not corresponding clk_prepare_enable() for
fsl_dev->pix_clk in previous contexts, clk_disable_unprepare() for
fsl_dcu->pix_clk in suspend function will fail.

This patch will add clk_prepare_enable() for fsl_dev->pix_clk in
previous contexts and resume function to fix the issue.

This patch is verified on LS1021ATWR board.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 58e9e0601a61..875b0fdc4274 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -230,6 +230,12 @@ static int fsl_dcu_drm_pm_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(fsl_dev->pix_clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable dcu pix clk\n");
+		return ret;
+	}
+
 	if (fsl_dev->tcon)
 		fsl_tcon_bypass_enable(fsl_dev->tcon);
 	fsl_dcu_drm_init_planes(fsl_dev->drm);
@@ -351,6 +357,12 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
+	ret = clk_prepare_enable(fsl_dev->pix_clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable dcu pix clk\n");
+		return ret;
+	}
+
 	fsl_dev->tcon = fsl_tcon_init(dev);
 
 	drm = drm_dev_alloc(driver, dev);
-- 
2.14.1
