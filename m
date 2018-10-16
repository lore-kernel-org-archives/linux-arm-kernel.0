From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 16 Oct 2018 15:57:43 +0000
Subject: [PATCH v3 2/4] crypto: mxs-dcp - Add support for dcp clk
In-Reply-To: <cover.1539705285.git.leonard.crestez@nxp.com>
References: <cover.1539705285.git.leonard.crestez@nxp.com>
Message-ID: <dcbcaf888bbd0a35dcf34228df2d9eb4fd762ea7.1539705286.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6ull and 6sll the DCP block has a clock which needs to be explicitly
enabled.

Add minimal handling for this at probe/remove time.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/crypto/mxs-dcp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 4e6ff32f8a7e..a9855f622e05 100644
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
@@ -1027,10 +1029,21 @@ static int mxs_dcp_probe(struct platform_device *pdev)
 	sdcp->dev = dev;
 	sdcp->base = devm_ioremap_resource(dev, iores);
 	if (IS_ERR(sdcp->base))
 		return PTR_ERR(sdcp->base);
 
+	/* DCP clock is optional, only used on some SOCs */
+	sdcp->dcp_clk = devm_clk_get(dev, "dcp");
+	if (IS_ERR(sdcp->dcp_clk)) {
+		if (sdcp->dcp_clk != ERR_PTR(-ENOENT))
+			return PTR_ERR(sdcp->dcp_clk);
+		sdcp->dcp_clk = NULL;
+	}
+
+	ret = clk_prepare_enable(sdcp->dcp_clk);
+	if (ret)
+		return ret;
 
 	ret = devm_request_irq(dev, dcp_vmi_irq, mxs_dcp_irq, 0,
 			       "dcp-vmi-irq", sdcp);
 	if (ret) {
 		dev_err(dev, "Failed to claim DCP VMI IRQ!\n");
@@ -1168,10 +1181,12 @@ static int mxs_dcp_remove(struct platform_device *pdev)
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
