From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 20 Jul 2018 16:56:06 +0200
Subject: [PATCH RESEND 3/7] of: address: Add parent pointer to the
 __of_translate_address args
In-Reply-To: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
References: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
Message-ID: <2f1db1ad423dcc845cab311432826da4976d2363.1532098561.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __of_translate_address function is used to translate the device tree
addresses to physical addresses using the various ranges property to create
the offset.

However, it's shared between the CPU addresses (based on the ranges
property) and the DMA addresses (based on dma-ranges). Since we're going to
add support for a DMA parent node that is not the DT parent node, we need
to change the logic a bit to have an optional parent node that we should
use.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/of/address.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 53349912ac75..9e637bf8102c 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -569,10 +569,10 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
  * relative to that node.
  */
 static u64 __of_translate_address(struct device_node *dev,
+				  struct device_node *parent,
 				  const __be32 *in_addr, const char *rprop,
 				  struct device_node **host)
 {
-	struct device_node *parent = NULL;
 	struct of_bus *bus, *pbus;
 	__be32 addr[OF_MAX_ADDR_CELLS];
 	int na, ns, pna, pns;
@@ -583,11 +583,14 @@ static u64 __of_translate_address(struct device_node *dev,
 	/* Increase refcount at current level */
 	of_node_get(dev);
 
-	*host = NULL;
-	/* Get parent & match bus type */
-	parent = of_get_parent(dev);
-	if (parent == NULL)
-		goto bail;
+	if (!parent) {
+		*host = NULL;
+		/* Get parent & match bus type */
+		parent = of_get_parent(dev);
+		if (parent == NULL)
+			goto bail;
+	}
+
 	bus = of_match_bus(parent);
 
 	/* Count address cells & copy address locally */
@@ -665,7 +668,7 @@ u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
 	struct device_node *host;
 	u64 ret;
 
-	ret = __of_translate_address(dev, in_addr, "ranges", &host);
+	ret = __of_translate_address(dev, NULL, in_addr, "ranges", &host);
 	if (host) {
 		of_node_put(host);
 		return OF_BAD_ADDR;
@@ -680,7 +683,7 @@ u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
 	struct device_node *host;
 	u64 ret;
 
-	ret = __of_translate_address(dev, in_addr, "dma-ranges", &host);
+	ret = __of_translate_address(dev, NULL, in_addr, "dma-ranges", &host);
 
 	if (host) {
 		of_node_put(host);
-- 
git-series 0.9.1
