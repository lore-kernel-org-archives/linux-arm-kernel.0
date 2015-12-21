From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 21 Dec 2015 17:39:47 +0100
Subject: [PATCH 4/5] pinctrl: rockchip: add missing of_node_put
In-Reply-To: <1450715988-4770-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1450715988-4770-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1450715988-4770-5-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for_each_child_of_node performs an of_node_get on each iteration, so a
return from the loop requires an of_node_put.

A simplified version of the semantic patch that fixes this problem is as
follows (http://coccinelle.lip6.fr):

// <smpl>
@@
local idexpression n;
expression e,e1;
@@

 for_each_child_of_node(e1,n) {
   ...
(
   of_node_put(n);
|
   e = n
|
   return n;
|
+  of_node_put(n);
?  return ...;
)
   ...
 }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/pinctrl/pinctrl-rockchip.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 2b88a40..d0305a2 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1258,8 +1258,10 @@ static int rockchip_pinctrl_parse_functions(struct device_node *np,
 		func->groups[i] = child->name;
 		grp = &info->groups[grp_index++];
 		ret = rockchip_pinctrl_parse_groups(child, grp, info, i++);
-		if (ret)
+		if (ret) {
+			of_node_put(child);
 			return ret;
+		}
 	}
 
 	return 0;
@@ -1304,6 +1306,7 @@ static int rockchip_pinctrl_parse_dt(struct platform_device *pdev,
 		ret = rockchip_pinctrl_parse_functions(child, info, i++);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to parse function\n");
+			of_node_put(child);
 			return ret;
 		}
 	}
