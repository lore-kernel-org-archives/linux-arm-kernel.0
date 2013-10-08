From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Tue,  8 Oct 2013 20:21:42 +0530
Subject: [PATCH] VEXPRESS: Fix VEXPRESS implicit declarations dependence
 errors.
In-Reply-To: <1381228895-24814-1-git-send-email-csmanjuvijay@gmail.com>
References: <1381228895-24814-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1381243903-27952-1-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a inline dummy implementations of_find_node_by_phandle()
and of_get_next_parent() in "#ifdef CONFIG_OF" else part. Without
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

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 include/linux/of.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index f95aee3..968787d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -340,6 +340,15 @@ int of_device_is_stdout_path(struct device_node *dn);
 
 #else /* CONFIG_OF */
 
+static inline struct device_node *of_find_node_by_phandle(phandle handle)
+{
+	return NULL;
+}
+static inline struct device_node *of_get_next_parent(struct device_node *node)
+{
+	return NULL;
+}
+
 static inline const char* of_node_full_name(struct device_node *np)
 {
 	return "<no-node>";
-- 
1.7.9.5
