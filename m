From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Dec 2011 20:00:36 +0800
Subject: [PATCH 05/12] mmc: mxs-mmc: convert to clk_prepare/clk_unprepare
In-Reply-To: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1324382443-4439-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch converts mxs-mmc driver to clk_prepare/clk_unprepare by
using helper functions clk_prepare_enable/clk_disable_unprepare.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/mxs-mmc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 99b449d..973011f 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -713,7 +713,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		ret = PTR_ERR(host->clk);
 		goto out_iounmap;
 	}
-	clk_enable(host->clk);
+	clk_prepare_enable(host->clk);
 
 	mxs_mmc_reset(host);
 
@@ -772,7 +772,7 @@ out_free_dma:
 	if (host->dmach)
 		dma_release_channel(host->dmach);
 out_clk_put:
-	clk_disable(host->clk);
+	clk_disable_unprepare(host->clk);
 	clk_put(host->clk);
 out_iounmap:
 	iounmap(host->base);
@@ -798,7 +798,7 @@ static int mxs_mmc_remove(struct platform_device *pdev)
 	if (host->dmach)
 		dma_release_channel(host->dmach);
 
-	clk_disable(host->clk);
+	clk_disable_unprepare(host->clk);
 	clk_put(host->clk);
 
 	iounmap(host->base);
@@ -819,7 +819,7 @@ static int mxs_mmc_suspend(struct device *dev)
 
 	ret = mmc_suspend_host(mmc);
 
-	clk_disable(host->clk);
+	clk_disable_unprepare(host->clk);
 
 	return ret;
 }
@@ -830,7 +830,7 @@ static int mxs_mmc_resume(struct device *dev)
 	struct mxs_mmc_host *host = mmc_priv(mmc);
 	int ret = 0;
 
-	clk_enable(host->clk);
+	clk_prepare_enable(host->clk);
 
 	ret = mmc_resume_host(mmc);
 
-- 
1.7.4.1
