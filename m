From: b32955@freescale.com (Huang Shijie)
Date: Fri, 5 Jul 2013 16:43:38 +0800
Subject: [PATCH] of: match the compatible in the order set by the dts file
Message-ID: <1373013818-11365-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we set the uart compatible in the dts file like this:
   ------------------------------------------------------
    compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
   ------------------------------------------------------

and we set the uart compatible in the uart driver like this:
   ------------------------------------------------------
	{ .compatible = "fsl,imx1-uart", ... },
	{ .compatible = "fsl,imx21-uart", ... },
	{ .compatible = "fsl,imx6q-uart", ... },
	{ /* sentinel */ }
   ------------------------------------------------------

the current code will match the "fsl,imx21-uart" in the end.

Of course, this is not what we want. We want it to match the "fsl,imx6q-uart".

This patch rewrites the match code, and make it to check the compatible
in the order set by the DTS file.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/of/base.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 0d61fc5..b13846b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -622,10 +622,14 @@ static
 const struct of_device_id *__of_match_node(const struct of_device_id *matches,
 					   const struct device_node *node)
 {
+	struct of_device_id *old = (struct of_device_id *)matches;
+	const char *cp;
+	int cplen, l;
+
 	if (!matches)
 		return NULL;
 
-	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
+	while (matches->name[0] || matches->type[0]) {
 		int match = 1;
 		if (matches->name[0])
 			match &= node->name
@@ -633,13 +637,30 @@ const struct of_device_id *__of_match_node(const struct of_device_id *matches,
 		if (matches->type[0])
 			match &= node->type
 				&& !strcmp(matches->type, node->type);
-		if (matches->compatible[0])
-			match &= __of_device_is_compatible(node,
-							   matches->compatible);
 		if (match)
 			return matches;
 		matches++;
 	}
+
+	/* Check the compatible in the order set by the DTS file. */
+	cp = __of_get_property(node, "compatible", &cplen);
+	if (!cp)
+		return NULL;
+
+	while (cplen > 0) {
+		matches = old;
+
+		while (matches->compatible[0]) {
+			if (!of_compat_cmp(cp, matches->compatible,
+						strlen(matches->compatible)))
+				return matches;
+			matches++;
+		}
+
+		l = strlen(cp) + 1;
+		cp += l;
+		cplen -= l;
+	}
 	return NULL;
 }
 
-- 
1.7.1
