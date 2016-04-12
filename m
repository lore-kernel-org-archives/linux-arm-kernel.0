From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 12 Apr 2016 17:12:56 -0500
Subject: [PATCH 1/6] EDAC, altera: Check parent status for Arria10 EDAC block
In-Reply-To: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
References: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1460499181-23080-2-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for the Arria10 ECC modules, check the status
of the parent in the device tree to ensure the block is enabled.
Skip if no parent phandle is set in the device tree.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 drivers/edac/altera_edac.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 11775dc..c3e040d 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1115,6 +1115,7 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 	struct resource res;
 	int edac_idx;
 	int rc = 0;
+	struct device_node *parent;
 	const struct edac_device_prv_data *prv;
 	/* Get matching node and check for valid result */
 	const struct of_device_id *pdev_id =
@@ -1127,6 +1128,14 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 	if (IS_ERR_OR_NULL(prv))
 		return -ENODEV;
 
+	/* If there is a parent parameter, exit if it is not available. */
+	parent = of_parse_phandle(np, "parent", 0);
+	if (parent && !of_device_is_available(parent)) {
+		of_node_put(parent);
+		return -ENODEV;
+	}
+	of_node_put(parent);
+
 	if (!devres_open_group(edac->dev, altr_edac_a10_device_add, GFP_KERNEL))
 		return -ENOMEM;
 
-- 
1.7.9.5
