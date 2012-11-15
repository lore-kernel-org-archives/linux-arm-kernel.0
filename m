From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Nov 2012 10:31:04 +0100
Subject: [PATCH 1/3] OF: Add helper for matching against linux,stdout-path
In-Reply-To: <1352971866-540-1-git-send-email-s.hauer@pengutronix.de>
References: <1352971866-540-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1352971866-540-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devicetrees may have a linux,stdout-path property in the chosen
node describing the console device. This adds a helper function
to match a device against this property so a driver can call
add_preferred_console for a matching device.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/of/base.c  |   28 ++++++++++++++++++++++++++++
 include/linux/of.h |    7 +++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index af3b22a..737feb8 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1358,3 +1358,31 @@ const char *of_prop_next_string(struct property *prop, const char *cur)
 	return curv;
 }
 EXPORT_SYMBOL_GPL(of_prop_next_string);
+
+/**
+ * of_device_is_stdout_path - check if a device node matches the
+ *                            linux,stdout-path property
+ *
+ * Check if this device node matches the linux,stdout-path property
+ * in the chosen node. return true if yes, false otherwise.
+ */
+int of_device_is_stdout_path(struct device_node *dn)
+{
+	const char *name;
+	struct device_node *dn_stdout;
+	int is_stdout = 0;
+
+	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
+	if (name == NULL)
+		return 0;
+
+	dn_stdout = of_find_node_by_path(name);
+
+	if (dn_stdout && dn_stdout == dn)
+		is_stdout = 1;
+
+	of_node_put(dn_stdout);
+
+	return is_stdout;
+}
+EXPORT_SYMBOL_GPL(of_device_is_stdout_path);
diff --git a/include/linux/of.h b/include/linux/of.h
index b4e50d5..5f857b5 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -310,6 +310,8 @@ const char *of_prop_next_string(struct property *prop, const char *cur);
 		s;						\
 		s = of_prop_next_string(prop, s))
 
+int of_device_is_stdout_path(struct device_node *dn);
+
 #else /* CONFIG_OF */
 
 static inline const char* of_node_full_name(struct device_node *np)
@@ -437,6 +439,11 @@ static inline int of_machine_is_compatible(const char *compat)
 	return 0;
 }
 
+static inline int of_device_is_stdout_path(struct device_node *dn)
+{
+	return 0;
+}
+
 #define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #define of_property_for_each_u32(np, propname, prop, p, u) \
-- 
1.7.10.4
