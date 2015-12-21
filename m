From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 21 Dec 2015 17:39:45 +0100
Subject: [PATCH 2/5] pinctrl: sirf: add missing of_node_put
In-Reply-To: <1450715988-4770-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1450715988-4770-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1450715988-4770-3-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/pinctrl/sirf/pinctrl-sirf.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index ae97bdc..18fe46d 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -85,12 +85,16 @@ static int sirfsoc_dt_node_to_map(struct pinctrl_dev *pctldev,
 	/* calculate number of maps required */
 	for_each_child_of_node(np_config, np) {
 		ret = of_property_read_string(np, "sirf,function", &function);
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(np);
 			return ret;
+		}
 
 		ret = of_property_count_strings(np, "sirf,pins");
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(np);
 			return ret;
+		}
 
 		count += ret;
 	}
