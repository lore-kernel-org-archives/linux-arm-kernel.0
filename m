From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 21 Oct 2015 22:41:39 +0200
Subject: [PATCH 4/5] clk: imx31: add missing of_node_put
In-Reply-To: <1445460100-26727-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1445460100-26727-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1445460100-26727-5-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for_each_compatible_node performs an of_node_get on each iteration, so a
break out of the loop requires an of_node_put.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
local idexpression n;
expression e;
@@

 for_each_compatible_node(n,...) {
   ...
(
   of_node_put(n);
|
   e = n
|
+  of_node_put(n);
?  break;
)
   ...
 }
... when != n
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/clk/imx/clk-imx31.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index f65b8b1..6a96414 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -233,8 +233,10 @@ int __init mx31_clocks_init_dt(void)
 		if (!of_device_is_compatible(np, "fsl,imx-osc26m"))
 			continue;
 
-		if (!of_property_read_u32(np, "clock-frequency", &fref))
+		if (!of_property_read_u32(np, "clock-frequency", &fref)) {
+			of_node_put(np);
 			break;
+		}
 	}
 
 	_mx31_clocks_init(fref);
