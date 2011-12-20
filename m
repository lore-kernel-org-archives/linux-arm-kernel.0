From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 21 Dec 2011 01:40:36 +0800
Subject: [RFC PATCH v3 1/5] dt: add of_get_child_count helper function
In-Reply-To: <1324402840-32451-1-git-send-email-b29396@freescale.com>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
Message-ID: <1324402840-32451-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Currently most code to get child count in kernel are almost same,
add a helper to implement this function for dt to use.

---
Changes v1->v2:
 * change the name from of_get_child_number to of_get_child_count

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 include/linux/of.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 4948552..d0d91a1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -189,6 +189,17 @@ extern struct device_node *of_get_next_child(const struct device_node *node,
 	for (child = of_get_next_child(parent, NULL); child != NULL; \
 	     child = of_get_next_child(parent, child))
 
+static inline int of_get_child_count(const struct device_node *np)
+{
+	struct device_node *child = NULL;
+	int num = 0;
+
+	while ((child = of_get_next_child(np, child)))
+		num++;
+
+	return num;
+}
+
 extern struct device_node *of_find_node_with_property(
 	struct device_node *from, const char *prop_name);
 #define for_each_node_with_property(dn, prop_name) \
@@ -262,6 +273,11 @@ static inline bool of_have_populated_dt(void)
 #define for_each_child_of_node(parent, child) \
 	while (0)
 
+static inline int of_get_child_count(const struct device_node *np)
+{
+	return -ENOSYS;
+}
+
 static inline int of_device_is_compatible(const struct device_node *device,
 					  const char *name)
 {
-- 
1.7.0.4
