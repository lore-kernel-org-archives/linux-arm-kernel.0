From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 30 Oct 2017 19:36:40 +0100
Subject: [PATCH] pinctrl: sirf: Use common error handling code in
 sirfsoc_dt_node_to_map()
Message-ID: <80911d4b-d819-335c-106e-70d7672e645b@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 30 Oct 2017 19:26:56 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pinctrl/sirf/pinctrl-sirf.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index d64add0b84cc..5ec2f37f5180 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -89,16 +89,12 @@ static int sirfsoc_dt_node_to_map(struct pinctrl_dev *pctldev,
 	/* calculate number of maps required */
 	for_each_child_of_node(np_config, np) {
 		ret = of_property_read_string(np, "sirf,function", &function);
-		if (ret < 0) {
-			of_node_put(np);
-			return ret;
-		}
+		if (ret < 0)
+			goto put_node;
 
 		ret = of_property_count_strings(np, "sirf,pins");
-		if (ret < 0) {
-			of_node_put(np);
-			return ret;
-		}
+		if (ret < 0)
+			goto put_node;
 
 		count += ret;
 	}
@@ -125,6 +121,10 @@ static int sirfsoc_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = count;
 
 	return 0;
+
+put_node:
+	of_node_put(np);
+	return ret;
 }
 
 static void sirfsoc_dt_free_map(struct pinctrl_dev *pctldev,
-- 
2.14.3
