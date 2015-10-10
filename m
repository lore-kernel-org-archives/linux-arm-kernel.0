From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 10 Oct 2015 14:30:54 +0200
Subject: [PATCH 5/5] arm: add missing of_node_put
In-Reply-To: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1444480254-14399-6-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for_each_child_of_node performs an of_node_get on each iteration, so
a break out of the loop requires an of_node_put.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
iterator name for_each_child_of_node;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
+  of_node_put(child);
?  break;
   ...
}
... when != child
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/arm/kernel/devtree.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 11c54de..432ff34 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -143,6 +143,7 @@ void __init arm_dt_init_cpu_maps(void)
 					       "max cores %u, capping them\n",
 					       cpuidx, nr_cpu_ids)) {
 			cpuidx = nr_cpu_ids;
+			of_node_put(cpu);
 			break;
 		}
 
