From: b32955@freescale.com (Huang Shijie)
Date: Thu, 24 May 2012 18:50:57 +0800
Subject: [PATCH 3/5] dma: mxs-dma: enable apbh-dma for imx6q
In-Reply-To: <1337856659-24812-1-git-send-email-b32955@freescale.com>
References: <1337856659-24812-1-git-send-email-b32955@freescale.com>
Message-ID: <1337856659-24812-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable the apbh-dma for imx6q.

Signed-off-by: Huang Shijie <b32955@freescale.com>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/Kconfig   |    2 +-
 drivers/dma/mxs-dma.c |    9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index aadeb5b..c8416d5 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -237,7 +237,7 @@ config IMX_DMA
 
 config MXS_DMA
 	bool "MXS DMA support"
-	depends on SOC_IMX23 || SOC_IMX28
+	depends on SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q
 	select STMP_DEVICE
 	select DMA_ENGINE
 	help
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index c96ab15..f41eb9e 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -29,7 +29,6 @@
 #include <linux/of_device.h>
 
 #include <asm/irq.h>
-#include <mach/mxs.h>
 
 #include "dmaengine.h"
 
@@ -129,6 +128,7 @@ enum mxs_dma_devtype {
 enum mxs_dma_id {
 	IMX23_DMA,
 	IMX28_DMA,
+	IMX6Q_DMA,
 };
 
 struct mxs_dma_engine {
@@ -159,6 +159,9 @@ static struct mxs_dma_type mxs_dma_types[] = {
 	}, {
 		.id = IMX28_DMA,
 		.type = MXS_DMA_APBX,
+	}, {
+		.id = IMX6Q_DMA,
+		.type = MXS_DMA_APBH,
 	}
 };
 
@@ -176,6 +179,9 @@ static struct platform_device_id mxs_dma_ids[] = {
 		.name = "imx28-dma-apbx",
 		.driver_data = (kernel_ulong_t) &mxs_dma_types[3],
 	}, {
+		.name = "imx6q-dma-apbh",
+		.driver_data = (kernel_ulong_t) &mxs_dma_types[4],
+	}, {
 		/* end of list */
 	}
 };
@@ -185,6 +191,7 @@ static const struct of_device_id mxs_dma_dt_ids[] = {
 	{ .compatible = "fsl,imx23-dma-apbx", .data = &mxs_dma_ids[1], },
 	{ .compatible = "fsl,imx28-dma-apbh", .data = &mxs_dma_ids[2], },
 	{ .compatible = "fsl,imx28-dma-apbx", .data = &mxs_dma_ids[3], },
+	{ .compatible = "fsl,imx6q-dma-apbh", .data = &mxs_dma_ids[4], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mxs_dma_dt_ids);
-- 
1.7.0.4
