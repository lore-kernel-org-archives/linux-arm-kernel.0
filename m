From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  1 Apr 2016 14:54:32 +0200
Subject: [PATCH 12/12] mtd: nand: move of_get_nand_xxx() helpers into
 nand_base.c
In-Reply-To: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459515272-31011-13-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all drivers go through nand_set_flash_node() to parse the generic
NAND properties, we can move all of_get_nand_xxx() helpers in to
nand_base.c, make them static and remove of_mtd.c and of_mtd.h.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c |  99 ++++++++++++++++++++++++++-
 drivers/of/Makefile          |   1 -
 drivers/of/of_mtd.c          | 155 -------------------------------------------
 include/linux/of_mtd.h       |  56 ----------------
 4 files changed, 98 insertions(+), 213 deletions(-)
 delete mode 100644 drivers/of/of_mtd.c
 delete mode 100644 include/linux/of_mtd.h

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index c3733a1..21f43e3 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -46,7 +46,7 @@
 #include <linux/leds.h>
 #include <linux/io.h>
 #include <linux/mtd/partitions.h>
-#include <linux/of_mtd.h>
+#include <linux/of.h>
 
 /* Define default oob placement schemes for large and small page devices */
 static struct nand_ecclayout nand_oob_8 = {
@@ -3964,6 +3964,103 @@ ident_done:
 	return type;
 }
 
+/**
+ * It maps 'enum nand_ecc_modes_t' found in include/linux/mtd/nand.h
+ * into the device tree binding of 'nand-ecc', so that MTD
+ * device driver can get nand ecc from device tree.
+ */
+static const char * const nand_ecc_modes[] = {
+	[NAND_ECC_NONE]		= "none",
+	[NAND_ECC_SOFT]		= "soft",
+	[NAND_ECC_HW]		= "hw",
+	[NAND_ECC_HW_SYNDROME]	= "hw_syndrome",
+	[NAND_ECC_HW_OOB_FIRST]	= "hw_oob_first",
+	[NAND_ECC_SOFT_BCH]	= "soft_bch",
+};
+
+static int of_get_nand_ecc_mode(struct device_node *np)
+{
+	const char *pm;
+	int err, i;
+
+	err = of_property_read_string(np, "nand-ecc-mode", &pm);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < ARRAY_SIZE(nand_ecc_modes); i++)
+		if (!strcasecmp(pm, nand_ecc_modes[i]))
+			return i;
+
+	return -ENODEV;
+}
+
+static int of_get_nand_ecc_algo(struct device_node *np)
+{
+	const char *pm;
+	int err;
+
+	/*
+	 * TODO: Read ECC algo OF property and map it to enum nand_ecc_algo.
+	 * It's not implemented yet as currently NAND subsystem ignores
+	 * algorithm explicitly set this way. Once it's handled we should
+	 * document & support new property.
+	 */
+
+	/*
+	 * For backward compatibility we also read "nand-ecc-mode" checking
+	 * for some obsoleted values that were specifying ECC algorithm.
+	 */
+	err = of_property_read_string(np, "nand-ecc-mode", &pm);
+	if (err < 0)
+		return err;
+
+	if (!strcasecmp(pm, "soft"))
+		return NAND_ECC_HAMMING;
+	else if (!strcasecmp(pm, "soft_bch"))
+		return NAND_ECC_BCH;
+
+	return -ENODEV;
+}
+
+static int of_get_nand_ecc_step_size(struct device_node *np)
+{
+	int ret;
+	u32 val;
+
+	ret = of_property_read_u32(np, "nand-ecc-step-size", &val);
+	return ret ? ret : val;
+}
+
+static int of_get_nand_ecc_strength(struct device_node *np)
+{
+	int ret;
+	u32 val;
+
+	ret = of_property_read_u32(np, "nand-ecc-strength", &val);
+	return ret ? ret : val;
+}
+
+static int of_get_nand_bus_width(struct device_node *np)
+{
+	u32 val;
+
+	if (of_property_read_u32(np, "nand-bus-width", &val))
+		return 8;
+
+	switch (val) {
+	case 8:
+	case 16:
+		return val;
+	default:
+		return -EIO;
+	}
+}
+
+static bool of_get_nand_on_flash_bbt(struct device_node *np)
+{
+	return of_property_read_bool(np, "nand-on-flash-bbt");
+}
+
 static int nand_dt_init(struct nand_chip *chip)
 {
 	struct device_node *dn = nand_get_flash_node(chip);
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 156c072..e31bdc1 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_OF_UNITTEST) += unittest.o
 obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
 obj-$(CONFIG_OF_PCI)	+= of_pci.o
 obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
-obj-$(CONFIG_OF_MTD)	+= of_mtd.o
 obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
 obj-$(CONFIG_OF_RESOLVE)  += resolver.o
 obj-$(CONFIG_OF_OVERLAY) += overlay.o
diff --git a/drivers/of/of_mtd.c b/drivers/of/of_mtd.c
deleted file mode 100644
index 15d056e..0000000
--- a/drivers/of/of_mtd.c
+++ /dev/null
@@ -1,155 +0,0 @@
-/*
- * Copyright 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
- *
- * OF helpers for mtd.
- *
- * This file is released under the GPLv2
- *
- */
-#include <linux/kernel.h>
-#include <linux/of_mtd.h>
-#include <linux/mtd/nand.h>
-#include <linux/export.h>
-
-/**
- * It maps 'enum nand_ecc_modes_t' found in include/linux/mtd/nand.h
- * into the device tree binding of 'nand-ecc', so that MTD
- * device driver can get nand ecc from device tree.
- */
-static const char *nand_ecc_modes[] = {
-	[NAND_ECC_NONE]		= "none",
-	[NAND_ECC_SOFT]		= "soft",
-	[NAND_ECC_HW]		= "hw",
-	[NAND_ECC_HW_SYNDROME]	= "hw_syndrome",
-	[NAND_ECC_HW_OOB_FIRST]	= "hw_oob_first",
-	[NAND_ECC_SOFT_BCH]	= "soft_bch",
-};
-
-/**
- * of_get_nand_ecc_mode - Get nand ecc mode for given device_node
- * @np:	Pointer to the given device_node
- *
- * The function gets ecc mode string from property 'nand-ecc-mode',
- * and return its index in nand_ecc_modes table, or errno in error case.
- */
-int of_get_nand_ecc_mode(struct device_node *np)
-{
-	const char *pm;
-	int err, i;
-
-	err = of_property_read_string(np, "nand-ecc-mode", &pm);
-	if (err < 0)
-		return err;
-
-	for (i = 0; i < ARRAY_SIZE(nand_ecc_modes); i++)
-		if (!strcasecmp(pm, nand_ecc_modes[i]))
-			return i;
-
-	return -ENODEV;
-}
-EXPORT_SYMBOL_GPL(of_get_nand_ecc_mode);
-
-/**
- * of_get_nand_ecc_algo - Get nand ecc algorithm for given device_node
- * @np:	Pointer to the given device_node
- *
- * The function gets ecc algorithm and returns its enum value, or errno in error
- * case.
- */
-int of_get_nand_ecc_algo(struct device_node *np)
-{
-	const char *pm;
-	int err;
-
-	/*
-	 * TODO: Read ECC algo OF property and map it to enum nand_ecc_algo.
-	 * It's not implemented yet as currently NAND subsystem ignores
-	 * algorithm explicitly set this way. Once it's handled we should
-	 * document & support new property.
-	 */
-
-	/*
-	 * For backward compatibility we also read "nand-ecc-mode" checking
-	 * for some obsoleted values that were specifying ECC algorithm.
-	 */
-	err = of_property_read_string(np, "nand-ecc-mode", &pm);
-	if (err < 0)
-		return err;
-
-	if (!strcasecmp(pm, "soft"))
-		return NAND_ECC_HAMMING;
-	else if (!strcasecmp(pm, "soft_bch"))
-		return NAND_ECC_BCH;
-
-	return -ENODEV;
-}
-EXPORT_SYMBOL_GPL(of_get_nand_ecc_algo);
-
-/**
- * of_get_nand_ecc_step_size - Get ECC step size associated to
- * the required ECC strength (see below).
- * @np:	Pointer to the given device_node
- *
- * return the ECC step size, or errno in error case.
- */
-int of_get_nand_ecc_step_size(struct device_node *np)
-{
-	int ret;
-	u32 val;
-
-	ret = of_property_read_u32(np, "nand-ecc-step-size", &val);
-	return ret ? ret : val;
-}
-EXPORT_SYMBOL_GPL(of_get_nand_ecc_step_size);
-
-/**
- * of_get_nand_ecc_strength - Get required ECC strength over the
- * correspnding step size as defined by 'nand-ecc-size'
- * @np:	Pointer to the given device_node
- *
- * return the ECC strength, or errno in error case.
- */
-int of_get_nand_ecc_strength(struct device_node *np)
-{
-	int ret;
-	u32 val;
-
-	ret = of_property_read_u32(np, "nand-ecc-strength", &val);
-	return ret ? ret : val;
-}
-EXPORT_SYMBOL_GPL(of_get_nand_ecc_strength);
-
-/**
- * of_get_nand_bus_width - Get nand bus witdh for given device_node
- * @np:	Pointer to the given device_node
- *
- * return bus width option, or errno in error case.
- */
-int of_get_nand_bus_width(struct device_node *np)
-{
-	u32 val;
-
-	if (of_property_read_u32(np, "nand-bus-width", &val))
-		return 8;
-
-	switch(val) {
-	case 8:
-	case 16:
-		return val;
-	default:
-		return -EIO;
-	}
-}
-EXPORT_SYMBOL_GPL(of_get_nand_bus_width);
-
-/**
- * of_get_nand_on_flash_bbt - Get nand on flash bbt for given device_node
- * @np:	Pointer to the given device_node
- *
- * return true if present false other wise
- */
-bool of_get_nand_on_flash_bbt(struct device_node *np)
-{
-	return of_property_read_bool(np, "nand-on-flash-bbt");
-}
-EXPORT_SYMBOL_GPL(of_get_nand_on_flash_bbt);
diff --git a/include/linux/of_mtd.h b/include/linux/of_mtd.h
deleted file mode 100644
index 0f6aca5..0000000
--- a/include/linux/of_mtd.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * Copyright 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
- *
- * OF helpers for mtd.
- *
- * This file is released under the GPLv2
- */
-
-#ifndef __LINUX_OF_MTD_H
-#define __LINUX_OF_MTD_H
-
-#ifdef CONFIG_OF_MTD
-
-#include <linux/of.h>
-int of_get_nand_ecc_mode(struct device_node *np);
-int of_get_nand_ecc_algo(struct device_node *np);
-int of_get_nand_ecc_step_size(struct device_node *np);
-int of_get_nand_ecc_strength(struct device_node *np);
-int of_get_nand_bus_width(struct device_node *np);
-bool of_get_nand_on_flash_bbt(struct device_node *np);
-
-#else /* CONFIG_OF_MTD */
-
-static inline int of_get_nand_ecc_mode(struct device_node *np)
-{
-	return -ENOSYS;
-}
-
-static inline int of_get_nand_ecc_algo(struct device_node *np)
-{
-	return -ENOSYS;
-}
-
-static inline int of_get_nand_ecc_step_size(struct device_node *np)
-{
-	return -ENOSYS;
-}
-
-static inline int of_get_nand_ecc_strength(struct device_node *np)
-{
-	return -ENOSYS;
-}
-
-static inline int of_get_nand_bus_width(struct device_node *np)
-{
-	return -ENOSYS;
-}
-
-static inline bool of_get_nand_on_flash_bbt(struct device_node *np)
-{
-	return false;
-}
-
-#endif /* CONFIG_OF_MTD */
-
-#endif /* __LINUX_OF_MTD_H */
-- 
2.5.0
