From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Thu, 24 Mar 2016 22:44:35 +0800
Subject: [PATCH v7 16/17] FDT: Add a helper to get the subnode by given name
In-Reply-To: <1458830676-27075-1-git-send-email-shannon.zhao@linaro.org>
References: <1458830676-27075-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1458830676-27075-17-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes it needs to check if there is a subnode of given node in FDT
by given name. Introduce this helper to get the subnode if it exists.

CC: Rob Herring <robh@kernel.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/of/fdt.c       | 13 +++++++++++++
 include/linux/of_fdt.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 655f79d..09001db 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -645,6 +645,19 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
 }
 
 /**
+ * of_get_flat_dt_subnode_by_name - get the subnode by given name
+ *
+ * @node: the parent node
+ * @uname: the name of subnode
+ * @return offset of the subnode, or -FDT_ERR_NOTFOUND if there is none
+ */
+
+int of_get_flat_dt_subnode_by_name(unsigned long node, const char *uname)
+{
+	return fdt_subnode_offset(initial_boot_params, node, uname);
+}
+
+/**
  * of_get_flat_dt_root - find the root node in the flat blob
  */
 unsigned long __init of_get_flat_dt_root(void)
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index df9ef38..fc28162 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -52,6 +52,8 @@ extern char __dtb_end[];
 extern int of_scan_flat_dt(int (*it)(unsigned long node, const char *uname,
 				     int depth, void *data),
 			   void *data);
+extern int of_get_flat_dt_subnode_by_name(unsigned long node,
+					  const char *uname);
 extern const void *of_get_flat_dt_prop(unsigned long node, const char *name,
 				       int *size);
 extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
-- 
2.1.4
