From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Thu, 22 Nov 2012 16:49:56 -0800
Subject: [PATCH 03/10] [media] mx1_camera: Don't use {en,dis}able_fiq() calls
In-Reply-To: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
References: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
Message-ID: <1353631803-4853-3-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver uses platform-specific mxc_set_irq_fiq() with the VIRQ cookie
passed to it, so it's pretty clear that the driver is absolutely sure
that the FIQ is routed via platform-specific IC, and that the cookie can
be used to mask/unmask FIQs. So, let's switch to the genirq routines,
since we're about to remove FIQ-specific variants.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/media/platform/soc_camera/mx1_camera.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/soc_camera/mx1_camera.c b/drivers/media/platform/soc_camera/mx1_camera.c
index bbe7099..4855a46 100644
--- a/drivers/media/platform/soc_camera/mx1_camera.c
+++ b/drivers/media/platform/soc_camera/mx1_camera.c
@@ -801,7 +801,7 @@ static int __init mx1_camera_probe(struct platform_device *pdev)
 	set_fiq_regs(&regs);
 
 	mxc_set_irq_fiq(irq, 1);
-	enable_fiq(irq);
+	enable_irq(irq);
 
 	pcdev->soc_host.drv_name	= DRIVER_NAME;
 	pcdev->soc_host.ops		= &mx1_soc_camera_host_ops;
@@ -817,7 +817,7 @@ static int __init mx1_camera_probe(struct platform_device *pdev)
 	return 0;
 
 exit_free_irq:
-	disable_fiq(irq);
+	disable_irq(irq);
 	mxc_set_irq_fiq(irq, 0);
 	release_fiq(&fh);
 exit_free_dma:
@@ -842,7 +842,7 @@ static int __exit mx1_camera_remove(struct platform_device *pdev)
 	struct resource *res;
 
 	imx_dma_free(pcdev->dma_chan);
-	disable_fiq(pcdev->irq);
+	disable_irq(pcdev->irq);
 	mxc_set_irq_fiq(pcdev->irq, 0);
 	release_fiq(&fh);
 
-- 
1.8.0
