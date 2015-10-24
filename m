From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 24 Oct 2015 16:42:34 +0200
Subject: [PATCH 8/9] soc: ti: knav_qmss_queue: add missing of_node_put
In-Reply-To: <1445697755-26341-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1445697755-26341-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1445697755-26341-9-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for_each_child_of_node performs an of_node_get on each iteration, so
a break out of the loop requires an of_node_put.

A simplified version of the semantic patch that fixes this problem is as
follows (http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
(
   return child;
|
+  of_node_put(child);
?  return ...;
)
   ...
 }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/soc/ti/knav_qmss_queue.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 89789e2..6f3d12b 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1074,6 +1074,7 @@ static int knav_queue_setup_regions(struct knav_device *kdev,
 		region = devm_kzalloc(dev, sizeof(*region), GFP_KERNEL);
 		if (!region) {
 			dev_err(dev, "out of memory allocating region\n");
+			of_node_put(child);
 			return -ENOMEM;
 		}
 
@@ -1373,6 +1374,7 @@ static int knav_queue_init_qmgrs(struct knav_device *kdev,
 		qmgr = devm_kzalloc(dev, sizeof(*qmgr), GFP_KERNEL);
 		if (!qmgr) {
 			dev_err(dev, "out of memory allocating qmgr\n");
+			of_node_put(child);
 			return -ENOMEM;
 		}
 
@@ -1450,6 +1452,7 @@ static int knav_queue_init_pdsps(struct knav_device *kdev,
 		pdsp = devm_kzalloc(dev, sizeof(*pdsp), GFP_KERNEL);
 		if (!pdsp) {
 			dev_err(dev, "out of memory allocating pdsp\n");
+			of_node_put(child);
 			return -ENOMEM;
 		}
 		pdsp->name = knav_queue_find_name(child);
