From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:07 -0700
Subject: [PATCH 12/31] dma: tegra: use reset framework
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-13-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra's clock driver now provides an implementation of the common
reset API (include/linux/reset.h). Use this instead of the old Tegra-
specific API; that will soon be removed.

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 drivers/dma/tegra20-apb-dma.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 73654e33f13b..afa5844c9346 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -32,8 +32,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
-#include <linux/clk/tegra.h>
 
 #include "dmaengine.h"
 
@@ -208,6 +208,7 @@ struct tegra_dma {
 	struct dma_device		dma_dev;
 	struct device			*dev;
 	struct clk			*dma_clk;
+	struct reset_control		*rst;
 	spinlock_t			global_lock;
 	void __iomem			*base_addr;
 	const struct tegra_dma_chip_data *chip_data;
@@ -1282,6 +1283,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(tdma->dma_clk);
 	}
 
+	tdma->rst = devm_reset_control_get(&pdev->dev, "dma");
+	if (IS_ERR(tdma->rst)) {
+		dev_err(&pdev->dev, "Error: Missing reset\n");
+		return PTR_ERR(tdma->rst);
+	}
+
 	spin_lock_init(&tdma->global_lock);
 
 	pm_runtime_enable(&pdev->dev);
@@ -1302,9 +1309,9 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	}
 
 	/* Reset DMA controller */
-	tegra_periph_reset_assert(tdma->dma_clk);
+	reset_control_assert(tdma->rst);
 	udelay(2);
-	tegra_periph_reset_deassert(tdma->dma_clk);
+	reset_control_deassert(tdma->rst);
 
 	/* Enable global DMA registers */
 	tdma_write(tdma, TEGRA_APBDMA_GENERAL, TEGRA_APBDMA_GENERAL_ENABLE);
-- 
1.8.1.5
