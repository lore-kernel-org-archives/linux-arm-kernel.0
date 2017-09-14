From: b18965@freescale.com (Alison Wang)
Date: Thu, 14 Sep 2017 14:53:41 +0800
Subject: [PATCH 2/2] drm/fsl-dcu: Fix the interrupt issue in suspend/resume
 functions
In-Reply-To: <20170914065341.17615-1-b18965@freescale.com>
References: <20170914065341.17615-1-b18965@freescale.com>
Message-ID: <20170914065341.17615-2-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_atomic_helper_suspend()/drm_atomic_helper_resume() are used in
suspend/resume functions. Interrupt can not be disabled when calling
drm_atomic_helper_resume(). Or else vblank interrupt will not generate
and the error about vblank wait timed out will occur.

This patch will enable interrupt before calling
drm_atomic_helper_resume().

The patch is verified on LS1021ATWR board.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 875b0fdc4274..aa0393d32661 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -192,7 +192,6 @@ static int fsl_dcu_drm_pm_suspend(struct device *dev)
 	if (!fsl_dev)
 		return 0;
 
-	disable_irq(fsl_dev->irq);
 	drm_kms_helper_poll_disable(fsl_dev->drm);
 
 	console_lock();
@@ -210,6 +209,8 @@ static int fsl_dcu_drm_pm_suspend(struct device *dev)
 		return PTR_ERR(fsl_dev->state);
 	}
 
+	disable_irq(fsl_dev->irq);
+
 	clk_disable_unprepare(fsl_dev->pix_clk);
 	clk_disable_unprepare(fsl_dev->clk);
 
@@ -236,6 +237,8 @@ static int fsl_dcu_drm_pm_resume(struct device *dev)
 		return ret;
 	}
 
+	enable_irq(fsl_dev->irq);
+
 	if (fsl_dev->tcon)
 		fsl_tcon_bypass_enable(fsl_dev->tcon);
 	fsl_dcu_drm_init_planes(fsl_dev->drm);
@@ -246,7 +249,6 @@ static int fsl_dcu_drm_pm_resume(struct device *dev)
 	console_unlock();
 
 	drm_kms_helper_poll_enable(fsl_dev->drm);
-	enable_irq(fsl_dev->irq);
 
 	return 0;
 }
-- 
2.14.1
