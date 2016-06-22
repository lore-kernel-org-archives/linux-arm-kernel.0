From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 22 Jun 2016 08:58:52 -0500
Subject: [PATCHv5 1/8] EDAC, altera: Check parent status for Arria10 EDAC block
In-Reply-To: <1466603939-7526-1-git-send-email-tthayer@opensource.altera.com>
References: <1466603939-7526-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1466603939-7526-2-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for the Arria10 ECC modules, check the status
of the parent in the device tree to ensure the block is enabled.
Skip if no parent phandle is set in the device tree.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  No change
v3  Move check into validate_parent_available().
v4  Match maintainer's changes
v5  Change "parent" string to "altr,ecc-parent"
---
 drivers/edac/altera_edac.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 6f5d586..0101dd0 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1125,6 +1125,20 @@ static void altr_edac_a10_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int validate_parent_available(struct device_node *np)
+{
+	struct device_node *parent;
+	int ret = 0;
+
+	/* Ensure parent device is enabled if parent node exists */
+	parent = of_parse_phandle(np, "altr,ecc-parent", 0);
+	if (parent && !of_device_is_available(parent))
+		ret = -ENODEV;
+
+	of_node_put(parent);
+	return ret;
+}
+
 static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 				    struct device_node *np)
 {
@@ -1146,6 +1160,9 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 	if (IS_ERR_OR_NULL(prv))
 		return -ENODEV;
 
+	if (validate_parent_available(np))
+		return -ENODEV;
+
 	if (!devres_open_group(edac->dev, altr_edac_a10_device_add, GFP_KERNEL))
 		return -ENOMEM;
 
-- 
1.7.9.5
