From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 18 Mar 2015 20:41:27 -0700
Subject: [patch 7/7] dt: dtb version: report dtb info
In-Reply-To: <550A42AC.8060104@gmail.com>
References: <550A42AC.8060104@gmail.com>
Message-ID: <550A4567.5030803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Rowand <frank.rowand@sonymobile.com>

Report the /chosen/dtb-info properties on boot.

Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
---

The beginning of the context for hunk 2 includes a line from
2fa645cb2703d9b3786d850db815414dfeefa51d, which is in 4.0-rc4.  The
author of that commit has submitted a request to revert the commit:
http://lkml.iu.edu/hypermail/linux/kernel/1503.2/02134.html


 drivers/of/base.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

Index: b/drivers/of/base.c
===================================================================
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1880,6 +1880,7 @@ static void of_alias_add(struct alias_pr
 void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 {
 	struct property *pp;
+	struct device_node *dtb_info = NULL;
 
 	of_aliases = of_find_node_by_path("/aliases");
 	of_chosen = of_find_node_by_path("/chosen");
@@ -1899,6 +1900,47 @@ void of_alias_scan(void * (*dt_alloc)(u6
 		}
 	}
 
+	dtb_info = of_find_node_by_path("/chosen/dtb-info");
+	if (dtb_info == NULL)
+		dtb_info = of_find_node_by_path("/chosen at 0/dtb-info");
+
+	if (dtb_info) {
+		const char *string;
+		int len;
+
+		string = of_get_property(dtb_info, "version", &len);
+		if (string) {
+			pr_notice("DTB version ");
+			for ( ; len > 0;
+				len -= (strlen(string) + 1),
+				string += (strlen(string) + 1)) {
+				pr_cont("%s", string);
+			}
+			pr_cont("\n");
+		}
+
+		string = of_get_property(dtb_info, "version-linux", &len);
+		if (string) {
+			pr_notice("DTB linux version ");
+			for ( ; len > 0;
+				len -= (strlen(string) + 1),
+				string += (strlen(string) + 1)) {
+				pr_cont("%s", string);
+			}
+			pr_cont("\n");
+		}
+
+		string = of_get_property(dtb_info, "dts-path", &len);
+		if (string)
+			pr_notice("DTB source %s\n", string);
+
+		string = of_get_property(dtb_info, "dtb-path", &len);
+		if (string)
+			pr_notice("DTB blob %s\n", string);
+
+		of_node_put(dtb_info);
+	}
+
 	if (!of_aliases)
 		return;
 
