From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri,  6 Jul 2018 15:19:44 +0200
Subject: [PATCH net-next 1/6] net: mvneta: remove data pointer usage from
 device_node structure
In-Reply-To: <20180706131949.2684-1-gregory.clement@bootlin.com>
References: <20180706131949.2684-1-gregory.clement@bootlin.com>
Message-ID: <20180706131949.2684-2-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On year ago Rob Herring wanted to remove the data pointer from the
device_node structure[1]. The mvneta driver seemed to be the only one
which used (abused ?) it. However, the proposal of Rob to remove this
pointer from the driver introduced a regression, and I tested and fixed an
alternative way, but it was never submitted as a proper patch.

Now here it is: Instead of using the device_node structure ->data
pointer, we store the BM private data as the driver data of the BM
platform_device. The core mvneta code can retrieve it by doing a lookup
on which platform_device corresponds to the BM device tree node using
of_find_device_by_node(), and get its driver data

[1]https://www.spinics.net/lists/netdev/msg445197.html

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c    | 18 ++++++++++++------
 drivers/net/ethernet/marvell/mvneta_bm.c | 13 +++++++++++++
 drivers/net/ethernet/marvell/mvneta_bm.h |  5 +++++
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 0ad2f3f7da85..26d68add184f 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4460,12 +4460,16 @@ static int mvneta_probe(struct platform_device *pdev)
 
 	/* Obtain access to BM resources if enabled and already initialized */
 	bm_node = of_parse_phandle(dn, "buffer-manager", 0);
-	if (bm_node && bm_node->data) {
-		pp->bm_priv = bm_node->data;
-		err = mvneta_bm_port_init(pdev, pp);
-		if (err < 0) {
-			dev_info(&pdev->dev, "use SW buffer management\n");
-			pp->bm_priv = NULL;
+	if (bm_node) {
+		pp->bm_priv = mvneta_bm_get(bm_node);
+		if (pp->bm_priv) {
+			err = mvneta_bm_port_init(pdev, pp);
+			if (err < 0) {
+				dev_info(&pdev->dev,
+					 "use SW buffer management\n");
+				mvneta_bm_put(pp->bm_priv);
+				pp->bm_priv = NULL;
+			}
 		}
 	}
 	of_node_put(bm_node);
@@ -4526,6 +4530,7 @@ static int mvneta_probe(struct platform_device *pdev)
 		mvneta_bm_pool_destroy(pp->bm_priv, pp->pool_long, 1 << pp->id);
 		mvneta_bm_pool_destroy(pp->bm_priv, pp->pool_short,
 				       1 << pp->id);
+		mvneta_bm_put(pp->bm_priv);
 	}
 err_free_stats:
 	free_percpu(pp->stats);
@@ -4563,6 +4568,7 @@ static int mvneta_remove(struct platform_device *pdev)
 		mvneta_bm_pool_destroy(pp->bm_priv, pp->pool_long, 1 << pp->id);
 		mvneta_bm_pool_destroy(pp->bm_priv, pp->pool_short,
 				       1 << pp->id);
+		mvneta_bm_put(pp->bm_priv);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
index 466939f8f0cf..01e3152e76c8 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.c
+++ b/drivers/net/ethernet/marvell/mvneta_bm.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/skbuff.h>
 #include <net/hwbm.h>
@@ -392,6 +393,18 @@ static void mvneta_bm_put_sram(struct mvneta_bm *priv)
 		      MVNETA_BM_BPPI_SIZE);
 }
 
+struct mvneta_bm *mvneta_bm_get(struct device_node *node)
+{
+	struct platform_device *pdev = of_find_device_by_node(node);
+
+	return pdev ? platform_get_drvdata(pdev) : NULL;
+}
+
+void mvneta_bm_put(struct mvneta_bm *priv)
+{
+	platform_device_put(priv->pdev);
+}
+
 static int mvneta_bm_probe(struct platform_device *pdev)
 {
 	struct device_node *dn = pdev->dev.of_node;
diff --git a/drivers/net/ethernet/marvell/mvneta_bm.h b/drivers/net/ethernet/marvell/mvneta_bm.h
index a32de432800c..9358626e51ec 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.h
+++ b/drivers/net/ethernet/marvell/mvneta_bm.h
@@ -134,6 +134,9 @@ void *mvneta_frag_alloc(unsigned int frag_size);
 void mvneta_frag_free(unsigned int frag_size, void *data);
 
 #if IS_ENABLED(CONFIG_MVNETA_BM)
+struct mvneta_bm *mvneta_bm_get(struct device_node *node);
+void mvneta_bm_put(struct mvneta_bm *priv);
+
 void mvneta_bm_pool_destroy(struct mvneta_bm *priv,
 			    struct mvneta_bm_pool *bm_pool, u8 port_map);
 void mvneta_bm_bufs_free(struct mvneta_bm *priv, struct mvneta_bm_pool *bm_pool,
@@ -178,5 +181,7 @@ static inline void mvneta_bm_pool_put_bp(struct mvneta_bm *priv,
 static inline u32 mvneta_bm_pool_get_bp(struct mvneta_bm *priv,
 					struct mvneta_bm_pool *bm_pool)
 { return 0; }
+struct mvneta_bm *mvneta_bm_get(struct device_node *node) { return NULL; }
+void mvneta_bm_put(struct mvneta_bm *priv) {}
 #endif /* CONFIG_MVNETA_BM */
 #endif
-- 
2.17.1
