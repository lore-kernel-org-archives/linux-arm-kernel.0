From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Fri, 22 Jan 2016 23:38:38 +0530
Subject: [PATCH] bus: vexpress-config: Add missing of_node_put
Message-ID: <20160122180838.GA12069@amitoj-Inspiron-3542>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for_each_compatible_node performs an of_node_get on each iteration, so
to break out of the loop an of_node_put is required.

Found using Coccinelle. The semantic patch used for this is as follows:

// <smpl>
@@
expression e;
local idexpression n;
@@

 for_each_compatible_node(n, ...) {
   ... when != of_node_put(n)
       when != e = n
(
   return n;
+  of_node_put(n);
?  return ...;
)
   ...
 }
// </smpl>

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/bus/vexpress-config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index 6575c0f..c3cb76b 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -192,8 +192,10 @@ static int __init vexpress_config_init(void)
 	/* Need the config devices early, before the "normal" devices... */
 	for_each_compatible_node(node, NULL, "arm,vexpress,config-bus") {
 		err = vexpress_config_populate(node);
-		if (err)
+		if (err) {
+			of_node_put(node);
 			break;
+		}
 	}
 
 	return err;
-- 
1.9.1
