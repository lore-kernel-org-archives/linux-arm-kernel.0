From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 9 Aug 2011 16:35:22 +0530
Subject: [PATCH 5/6] spi/spi-pl022: Call pl022_dma_remove(pl022) only if
	enable_dma is true
In-Reply-To: <cover.1312887860.git.viresh.kumar@st.com>
References: <cover.1312887860.git.viresh.kumar@st.com>
Message-ID: <2d178d5821cd51a14ccd097b0738c1745c6dc64c.1312887860.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pl022_dma_remove() should be called only if enable_dma is true. There is no
point calling it when pl022_dma_probe() is not called, which again depends on
enable_dma.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/spi/spi-pl022.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index e0cfb8c..e2333e7 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2234,7 +2234,9 @@ err_spi_register:
 err_start_queue:
 err_init_queue:
 	destroy_queue(pl022);
-	pl022_dma_remove(pl022);
+	if (platform_info->enable_dma)
+		pl022_dma_remove(pl022);
+
 	free_irq(adev->irq[0], pl022);
 	pm_runtime_disable(&adev->dev);
 err_no_irq:
@@ -2262,7 +2264,9 @@ pl022_remove(struct amba_device *adev)
 	if (destroy_queue(pl022) != 0)
 		dev_err(&adev->dev, "queue remove failed\n");
 	load_ssp_default_config(pl022);
-	pl022_dma_remove(pl022);
+	if (pl022->master_info->enable_dma)
+		pl022_dma_remove(pl022);
+
 	free_irq(adev->irq[0], pl022);
 	clk_disable(pl022->clk);
 	clk_put(pl022->clk);
-- 
1.7.2.2
