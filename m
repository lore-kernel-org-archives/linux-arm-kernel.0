From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Mon, 12 Aug 2013 18:25:15 +0530
Subject: [PATCH V2] MFD: Make VEXPRESS MFD controller depends on VEXPRESS
 systems
In-Reply-To: <1375592514-14213-1-git-send-email-manjunath.goudar@linaro.org>
References: <1375592514-14213-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1376312115-10326-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a of_find_node_by_phandle() and of_get_next_parent()
function declaration dependence on"#ifdef CONFIG_OF" in "include/linux/of.h"
else part return inline dummy implementations (returning NULL). Without
this patch,build system can lead to issues. This was discovered during
randconfig testing,in which VEXPRESS_CONFIG was enabled w/o CONFIG_OF
being enabled,leading to the following error:

CC      drivers/mfd/vexpress-config.o
drivers/mfd/vexpress-config.c: In function ?__vexpress_config_func_get?:
drivers/mfd/vexpress-config.c:117:4: error: implicit declaration of function
?of_find_node_by_phandle? [-Werror=implicit-function-declaration]
    bridge_node = of_find_node_by_phandle(
    ^
drivers/mfd/vexpress-config.c:117:16: warning: assignment makes pointer from
integer without a cast [enabled by default]
    bridge_node = of_find_node_by_phandle(

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Deepak Saxena <dsaxena@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>

V2:
 -Made of_find_node_by_phandle() and of_get_next_parent() function declaration
  dependence on"#ifdef CONFIG_OF" in "include/linux/of.h" instead of Kconfig
  dependence setting in V1 patch and else part return inline dummy implementations
  (returning NULL) to fix the above randconfig error.
---
 include/linux/of.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 90a8811..4be252a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -196,10 +196,22 @@ static inline struct device_node *of_find_matching_node(
 #define for_each_matching_node_and_match(dn, matches, match) \
 	for (dn = of_find_matching_node_and_match(NULL, matches, match); \
 	     dn; dn = of_find_matching_node_and_match(dn, matches, match))
-extern struct device_node *of_find_node_by_path(const char *path);
+
+#ifdef CONFIG_OF
 extern struct device_node *of_find_node_by_phandle(phandle handle);
-extern struct device_node *of_get_parent(const struct device_node *node);
 extern struct device_node *of_get_next_parent(struct device_node *node);
+#else
+static inline struct device_node *of_find_node_by_phandle(phandle handle)
+{
+	return NULL;
+}
+static inline struct device_node *of_get_next_parent(struct device_node *node)
+{
+	return NULL;
+}
+#endif
+extern struct device_node *of_find_node_by_path(const char *path);
+extern struct device_node *of_get_parent(const struct device_node *node);
 extern struct device_node *of_get_next_child(const struct device_node *node,
 					     struct device_node *prev);
 extern struct device_node *of_get_next_available_child(
-- 
1.8.1.2
