From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 15 Dec 2011 00:03:39 +0800
Subject: [RFC PATCH v2 1/4] dt: add of_get_child_number helper function
In-Reply-To: <1323878622-26602-1-git-send-email-b29396@freescale.com>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
Message-ID: <1323878622-26602-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Currently most code to get child number in kernel are almost same,
add a helper to implement this function for dt to use.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 include/linux/of.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 4948552..09d53dc 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -189,6 +189,18 @@ extern struct device_node *of_get_next_child(const struct device_node *node,
 	for (child = of_get_next_child(parent, NULL); child != NULL; \
 	     child = of_get_next_child(parent, child))
 
+static inline int of_get_child_number(struct device_node *np)
+
+{
+	struct device_node *child = NULL;
+	int num = 0;
+
+	while((child = of_get_next_child(np, child)))
+		num++;
+
+	return num;
+}
+
 extern struct device_node *of_find_node_with_property(
 	struct device_node *from, const char *prop_name);
 #define for_each_node_with_property(dn, prop_name) \
@@ -262,6 +274,11 @@ static inline bool of_have_populated_dt(void)
 #define for_each_child_of_node(parent, child) \
 	while (0)
 
+static inline int of_get_child_number(struct device_node *np)
+{
+	return -ENOSYS;
+}
+
 static inline int of_device_is_compatible(const struct device_node *device,
 					  const char *name)
 {
-- 
1.7.0.4
