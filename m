From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 17 Oct 2018 12:37:53 +0000
Subject: [PATCH v4 2/4] crypto: mxs-dcp - Add support for dcp clk
In-Reply-To: <cover.1539779579.git.leonard.crestez@nxp.com>
References: <cover.1539779579.git.leonard.crestez@nxp.com>
Message-ID: <95dce7010676581691b1ac9906e9298470e0aa1a.1539779579.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6ull and 6sll the DCP block has a clock which needs to be explicitly
enabled.

Add minimal handling for this at probe/remove time.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/crypto/mxs-dcp.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 4e6ff32f8a7e..a2105cf33abb 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -18,10 +18,11 @@
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/stmp_device.h>
+#include <linux/clk.h>
 
 #include <crypto/aes.h>
 #include <crypto/sha.h>
 #include <crypto/internal/hash.h>
 #include <crypto/internal/skcipher.h>
@@ -80,10 +81,11 @@ struct dcp {
 
 	struct completion		completion[DCP_MAX_CHANS];
 	spinlock_t			lock[DCP_MAX_CHANS];
 	struct task_struct		*thread[DCP_MAX_CHANS];
 	struct crypto_queue		queue[DCP_MAX_CHANS];
+	struct clk			*dcp_clk;
 };
 
 enum dcp_chan {
 	DCP_CHAN_HASH_SHA	= 0,
 	DCP_CHAN_CRYPTO		= 2,
@@ -1051,15 +1053,28 @@ static int mxs_dcp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Re-align the structure so it fits the DCP constraints. */
 	sdcp->coh = PTR_ALIGN(sdcp->coh, DCP_ALIGNMENT);
 
-	/* Restart the DCP block. */
-	ret = stmp_reset_block(sdcp->base);
+	/* DCP clock is optional, only used on some SOCs */
+	sdcp->dcp_clk = devm_clk_get(dev, "dcp");
+	if (IS_ERR(sdcp->dcp_clk)) {
+		if (sdcp->dcp_clk != ERR_PTR(-ENOENT))
+			return PTR_ERR(sdcp->dcp_clk);
+		sdcp->dcp_clk = NULL;
+	}
+	ret = clk_prepare_enable(sdcp->dcp_clk);
 	if (ret)
 		return ret;
 
+	/* Restart the DCP block. */
+	ret = stmp_reset_block(sdcp->base);
+	if (ret) {
+		dev_err(dev, "Failed reset\n");
+		goto err_disable_unprepare_clk;
+	}
+
 	/* Initialize control register. */
 	writel(MXS_DCP_CTRL_GATHER_RESIDUAL_WRITES |
 	       MXS_DCP_CTRL_ENABLE_CONTEXT_CACHING | 0xf,
 	       sdcp->base + MXS_DCP_CTRL);
 
@@ -1092,11 +1107,12 @@ static int mxs_dcp_probe(struct platform_device *pdev)
 	/* Create the SHA and AES handler threads. */
 	sdcp->thread[DCP_CHAN_HASH_SHA] = kthread_run(dcp_chan_thread_sha,
 						      NULL, "mxs_dcp_chan/sha");
 	if (IS_ERR(sdcp->thread[DCP_CHAN_HASH_SHA])) {
 		dev_err(dev, "Error starting SHA thread!\n");
-		return PTR_ERR(sdcp->thread[DCP_CHAN_HASH_SHA]);
+		ret = PTR_ERR(sdcp->thread[DCP_CHAN_HASH_SHA]);
+		goto err_disable_unprepare_clk;
 	}
 
 	sdcp->thread[DCP_CHAN_CRYPTO] = kthread_run(dcp_chan_thread_aes,
 						    NULL, "mxs_dcp_chan/aes");
 	if (IS_ERR(sdcp->thread[DCP_CHAN_CRYPTO])) {
@@ -1149,10 +1165,14 @@ static int mxs_dcp_probe(struct platform_device *pdev)
 err_destroy_aes_thread:
 	kthread_stop(sdcp->thread[DCP_CHAN_CRYPTO]);
 
 err_destroy_sha_thread:
 	kthread_stop(sdcp->thread[DCP_CHAN_HASH_SHA]);
+
+err_disable_unprepare_clk:
+	clk_disable_unprepare(sdcp->dcp_clk);
+
 	return ret;
 }
 
 static int mxs_dcp_remove(struct platform_device *pdev)
 {
@@ -1168,10 +1188,12 @@ static int mxs_dcp_remove(struct platform_device *pdev)
 		crypto_unregister_algs(dcp_aes_algs, ARRAY_SIZE(dcp_aes_algs));
 
 	kthread_stop(sdcp->thread[DCP_CHAN_HASH_SHA]);
 	kthread_stop(sdcp->thread[DCP_CHAN_CRYPTO]);
 
+	clk_disable_unprepare(sdcp->dcp_clk);
+
 	platform_set_drvdata(pdev, NULL);
 
 	global_sdcp = NULL;
 
 	return 0;
-- 
2.17.1
