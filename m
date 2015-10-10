From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 10 Oct 2015 23:41:42 +0200 (CEST)
Subject: [PATCH 5/5 v2] arm: add missing of_node_put
In-Reply-To: <8965654.Mi98YpI4rM@wuerfel>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
 <8655275.vMqHQfLN9g@wuerfel>
 <alpine.DEB.2.02.1510102307570.2053@localhost6.localdomain6>
 <8965654.Mi98YpI4rM@wuerfel>
Message-ID: <alpine.DEB.2.02.1510102339290.2053@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for_each_child_of_node performs an of_node_get on each iteration, so
a break out of the loop requires an of_node_put.

The of_node_put is duplicated in front of each error return, because the
function contains a later error return that is beyond the end of the
for_each_child_of_node and thus doesn't need of_node_put.

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
(
   return child;
|
+  of_node_put(child);
?  return ...;
)
   ...
 }

@@
expression root,e;
local idexpression child;
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

Additionally, concatenated a string in an affected line to avoid introducing
a checkpatch warning.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

v2: Fixed the returns as well, adjusted a string in a test expression.

 arch/arm/kernel/devtree.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 11c54de..65addcb 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -101,6 +101,7 @@ void __init arm_dt_init_cpu_maps(void)
 		if (of_property_read_u32(cpu, "reg", &hwid)) {
 			pr_debug(" * %s missing reg property\n",
 				     cpu->full_name);
+			of_node_put(cpu);
 			return;
 		}
 
@@ -108,8 +109,10 @@ void __init arm_dt_init_cpu_maps(void)
 		 * 8 MSBs must be set to 0 in the DT since the reg property
 		 * defines the MPIDR[23:0].
 		 */
-		if (hwid & ~MPIDR_HWID_BITMASK)
+		if (hwid & ~MPIDR_HWID_BITMASK) {
+			of_node_put(cpu);
 			return;
+		}
 
 		/*
 		 * Duplicate MPIDRs are a recipe for disaster.
@@ -119,9 +122,11 @@ void __init arm_dt_init_cpu_maps(void)
 		 * to avoid matching valid MPIDR[23:0] values.
 		 */
 		for (j = 0; j < cpuidx; j++)
-			if (WARN(tmp_map[j] == hwid, "Duplicate /cpu reg "
-						     "properties in the DT\n"))
+			if (WARN(tmp_map[j] == hwid,
+				 "Duplicate /cpu reg properties in the DT\n")) {
+				of_node_put(cpu);
 				return;
+			}
 
 		/*
 		 * Build a stashed array of MPIDR values. Numbering scheme
@@ -143,6 +148,7 @@ void __init arm_dt_init_cpu_maps(void)
 					       "max cores %u, capping them\n",
 					       cpuidx, nr_cpu_ids)) {
 			cpuidx = nr_cpu_ids;
+			of_node_put(cpu);
 			break;
 		}
 
