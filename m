From: viresh.linux@gmail.com (Viresh Kumar)
Date: Sat, 21 Apr 2012 17:17:32 +0530
Subject: [PATCH 05/13] ata/sata_mv: Remove conditional compilation of clk code
In-Reply-To: <cover.1335008617.git.viresh.kumar@st.com>
References: <cover.1335008617.git.viresh.kumar@st.com>
Message-ID: <e8e15e1e8c17195778ab26a1f483076dfe9bb460.1335008617.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With addition of dummy clk_*() calls for non CONFIG_HAVE_CLK cases in clk.h,
there is no need to have clk code enclosed in #ifdef CONFIG_HAVE_CLK, #endif
macros.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: linux-ide at vger.kernel.org
---
 drivers/ata/sata_mv.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 38950ea..3bb9cb7 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -551,9 +551,7 @@ struct mv_host_priv {
 	u32			irq_mask_offset;
 	u32			unmask_all_irqs;
 
-#if defined(CONFIG_HAVE_CLK)
 	struct clk		*clk;
-#endif
 	/*
 	 * These consistent DMA memory pools give us guaranteed
 	 * alignment for hardware-accessed data structures,
@@ -4062,13 +4060,11 @@ static int mv_platform_probe(struct platform_device *pdev)
 				   resource_size(res));
 	hpriv->base -= SATAHC0_REG_BASE;
 
-#if defined(CONFIG_HAVE_CLK)
 	hpriv->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hpriv->clk))
 		dev_notice(&pdev->dev, "cannot get clkdev\n");
 	else
 		clk_enable(hpriv->clk);
-#endif
 
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
@@ -4095,12 +4091,10 @@ static int mv_platform_probe(struct platform_device *pdev)
 		return 0;
 
 err:
-#if defined(CONFIG_HAVE_CLK)
 	if (!IS_ERR(hpriv->clk)) {
 		clk_disable(hpriv->clk);
 		clk_put(hpriv->clk);
 	}
-#endif
 
 	return rc;
 }
@@ -4116,17 +4110,13 @@ err:
 static int __devexit mv_platform_remove(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
-#if defined(CONFIG_HAVE_CLK)
 	struct mv_host_priv *hpriv = host->private_data;
-#endif
 	ata_host_detach(host);
 
-#if defined(CONFIG_HAVE_CLK)
 	if (!IS_ERR(hpriv->clk)) {
 		clk_disable(hpriv->clk);
 		clk_put(hpriv->clk);
 	}
-#endif
 	return 0;
 }
 
-- 
1.7.9
