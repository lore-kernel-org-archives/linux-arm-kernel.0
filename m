From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 10 Oct 2015 14:30:52 +0200
Subject: [PATCH 3/5] ARM: shmobile: R-Mobile: add missing of_node_put
In-Reply-To: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1444480254-14399-4-git-send-email-Julia.Lawall@lip6.fr>
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
 arch/arm/mach-shmobile/pm-rmobile.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 89068c8..46d0a1d 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -313,8 +313,10 @@ static int __init rmobile_add_pm_domains(void __iomem *base,
 		}
 
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
-		if (!pd)
+		if (!pd) {
+			of_node_put(np);
 			return -ENOMEM;
+		}
 
 		pd->genpd.name = np->name;
 		pd->base = base;
