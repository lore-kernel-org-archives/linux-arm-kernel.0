From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 23:37:37 +0100
Subject: [PATCH v2 02/19] DMA: shdma: Enable the driver on all ARM platforms
In-Reply-To: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383086274-11049-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
COMPILE_TEST.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/Kconfig  | 2 +-
 drivers/dma/sh/shdmac.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index dadd9e01..ee0906d 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -4,7 +4,7 @@
 
 config SH_DMAE_BASE
 	bool "Renesas SuperH DMA Engine support"
-	depends on (SUPERH && SH_DMA) || (ARM && ARCH_SHMOBILE)
+	depends on (SUPERH && SH_DMA) || ARM || COMPILE_TEST
 	depends on !SH_DMA_API
 	default y
 	select DMA_ENGINE
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 1069e88..3625078 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -787,7 +787,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	if (err)
 		goto rst_err;
 
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
+#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARM)
 	chanirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
 
 	if (!chanirq_res)
@@ -812,7 +812,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 
 #else
 	chanirq_res = errirq_res;
-#endif /* CONFIG_CPU_SH4 || CONFIG_ARCH_SHMOBILE */
+#endif /* CONFIG_CPU_SH4 || CONFIG_ARM */
 
 	if (chanirq_res->start == chanirq_res->end &&
 	    !platform_get_resource(pdev, IORESOURCE_IRQ, 1)) {
@@ -879,7 +879,7 @@ edmadevreg:
 chan_probe_err:
 	sh_dmae_chan_remove(shdev);
 
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
+#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARM)
 eirq_err:
 #endif
 rst_err:
-- 
1.8.1.5
