From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 20 Aug 2013 12:01:05 +0200
Subject: [PATCH] of: reduce the number of PROBE_DEFERs
Message-ID: <20130820120105.55a4c0ce@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch populates the platform from the device tree into two steps:
the first step creates the nodes that are referenced by a phandle,
the second step creates the other nodes.

This permits to reduce the number of PROBE_DEFERs.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
A better way to reduce probe deferral could be sorting the nodes
according to their phandle level in the DT blob at compilation time ...
---
 drivers/of/platform.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index e0a6514..a2ea858 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -382,8 +382,23 @@ static int of_platform_bus_create(struct device_node *bus,
 	if (!dev || !of_match_node(matches, bus))
 		return 0;
 
+	/* first step: create the nodes that are referenced by phandle */
 	for_each_child_of_node(bus, child) {
-		pr_debug("   create child: %s\n", child->full_name);
+		if (child->phandle == 0)
+			continue;
+		pr_debug("   create child 1: %s\n", child->full_name);
+		rc = of_platform_bus_create(child, matches, lookup, &dev->dev, strict);
+		if (rc) {
+			of_node_put(child);
+			return rc;
+		}
+	}
+
+	/* second step: create the other nodes */
+	for_each_child_of_node(bus, child) {
+		if (child->phandle != 0)
+			continue;
+		pr_debug("   create child 2: %s\n", child->full_name);
 		rc = of_platform_bus_create(child, matches, lookup, &dev->dev, strict);
 		if (rc) {
 			of_node_put(child);


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
