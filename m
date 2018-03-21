From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 21 Mar 2018 13:08:05 +0100
Subject: [PATCH 6/8] remoteproc: da8xx: prepare and unprepare the clock where
 needed
In-Reply-To: <20180321120807.18032-1-brgl@bgdev.pl>
References: <20180321120807.18032-1-brgl@bgdev.pl>
Message-ID: <20180321120807.18032-7-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We're currently switching the platform to using the common clock
framework. We need to explicitly prepare and unprepare the rproc
clock.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 592bf0fc52e8..83f2d66ad3a9 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -149,9 +149,9 @@ static int da8xx_rproc_start(struct rproc *rproc)
 
 	writel(rproc->bootaddr, drproc->bootreg);
 
-	rv = clk_enable(dsp_clk);
+	rv = clk_prepare_enable(dsp_clk);
 	if (rv) {
-		dev_err(dev, "clk_enable() failed: %d\n", rv);
+		dev_err(dev, "clk_prepare_enable() failed: %d\n", rv);
 		return rv;
 	}
 
@@ -165,7 +165,7 @@ static int da8xx_rproc_stop(struct rproc *rproc)
 	struct da8xx_rproc *drproc = rproc->priv;
 
 	davinci_clk_reset_assert(drproc->dsp_clk);
-	clk_disable(drproc->dsp_clk);
+	clk_disable_unprepare(drproc->dsp_clk);
 
 	return 0;
 }
-- 
2.16.1
