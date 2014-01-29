From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Wed, 29 Jan 2014 15:34:16 +0100
Subject: [RFC PATCH v2 06/14] of: mtd: add NAND timing mode retrieval support
In-Reply-To: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <1391006064-28890-7-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to retrieve NAND timing mode (ONFI timing mode) from a given
DT node.

Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
---
 drivers/of/of_mtd.c    |   19 +++++++++++++++++++
 include/linux/of_mtd.h |    8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/of/of_mtd.c b/drivers/of/of_mtd.c
index e8ced61..63155d4 100644
--- a/drivers/of/of_mtd.c
+++ b/drivers/of/of_mtd.c
@@ -108,3 +108,22 @@ bool of_get_nand_on_flash_bbt(struct device_node *np)
 	return of_property_read_bool(np, "nand-on-flash-bbt");
 }
 EXPORT_SYMBOL_GPL(of_get_nand_on_flash_bbt);
+
+/**
+ * of_get_nand_timings - Get nand timings for the given device_node
+ * @np:	Pointer to the given device_node
+ *
+ * return 0 on success errno other wise
+ */
+int of_get_nand_onfi_timing_mode(struct device_node *np)
+{
+	int err;
+	u32 mode;
+
+	err = of_property_read_u32(np, "onfi,nand-timing-mode", &mode);
+	if (err)
+		return err;
+
+	return mode;
+}
+EXPORT_SYMBOL_GPL(of_get_nand_onfi_timing_mode);
diff --git a/include/linux/of_mtd.h b/include/linux/of_mtd.h
index 3bd8c3b..eb9fda6 100644
--- a/include/linux/of_mtd.h
+++ b/include/linux/of_mtd.h
@@ -9,6 +9,8 @@
 #ifndef __LINUX_OF_MTD_H
 #define __LINUX_OF_NET_H
 
+#include <linux/mtd/nand.h>
+
 #ifdef CONFIG_OF_MTD
 
 #include <linux/of.h>
@@ -16,6 +18,7 @@ int of_get_nand_ecc_mode(struct device_node *np);
 int of_get_nand_ecc_level(struct device_node *np, u32 *strengh, u32 *blk_size);
 int of_get_nand_bus_width(struct device_node *np);
 bool of_get_nand_on_flash_bbt(struct device_node *np);
+int of_get_nand_onfi_timing_mode(struct device_node *np);
 
 #else /* CONFIG_OF_MTD */
 
@@ -40,6 +43,11 @@ static inline bool of_get_nand_on_flash_bbt(struct device_node *np)
 	return false;
 }
 
+static inline int of_get_nand_onfi_timing_mode(struct device_node *np)
+{
+	return -ENOSYS;
+}
+
 #endif /* CONFIG_OF_MTD */
 
 #endif /* __LINUX_OF_MTD_H */
-- 
1.7.9.5
