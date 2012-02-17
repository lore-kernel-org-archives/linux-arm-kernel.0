From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 17 Feb 2012 16:47:10 +0100
Subject: [PATCH v3] of/mtd/nand: add generic bindings and helpers
Message-ID: <1329493630-19415-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- nand-ecc-mode : String, operation mode of the NAND ecc mode.
  Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
  "soft_bch".
- nand-bus-width : 8 or 16 bus width if not present 8
- nand-on-flash-bbt: boolean to enable on flash bbt option if not present false

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss at lists.ozlabs.org
---
 Documentation/devicetree/bindings/mtd/nand.txt |    7 ++
 drivers/of/Kconfig                             |    4 +
 drivers/of/Makefile                            |    1 +
 drivers/of/of_mtd.c                            |   85 ++++++++++++++++++++++++
 include/linux/of_mtd.h                         |   19 +++++
 5 files changed, 116 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/nand.txt
 create mode 100644 drivers/of/of_mtd.c
 create mode 100644 include/linux/of_mtd.h

diff --git a/Documentation/devicetree/bindings/mtd/nand.txt b/Documentation/devicetree/bindings/mtd/nand.txt
new file mode 100644
index 0000000..03855c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/nand.txt
@@ -0,0 +1,7 @@
+* MTD generic binding
+
+- nand-ecc-mode : String, operation mode of the NAND ecc mode.
+  Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
+  "soft_bch".
+- nand-bus-width : 8 or 16 bus width if not present 8
+- nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 268163d..fa666a9 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -90,4 +90,8 @@ config OF_PCI_IRQ
 	help
 	  OpenFirmware PCI IRQ routing helpers
 
+config OF_MTD
+	depends on MTD
+	def_bool y
+
 endmenu # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index a73f5a5..aa90e60 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_OF_SELFTEST) += selftest.o
 obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
 obj-$(CONFIG_OF_PCI)	+= of_pci.o
 obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
+obj-$(CONFIG_OF_MTD)	+= of_mtd.o
diff --git a/drivers/of/of_mtd.c b/drivers/of/of_mtd.c
new file mode 100644
index 0000000..e6a1074
--- /dev/null
+++ b/drivers/of/of_mtd.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * OF helpers for mtd.
+ *
+ * This file is released under the GPLv2
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/of_mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/export.h>
+
+/**
+ * It maps 'enum nand_ecc_modes_t' found in include/linux/mtd/nand.h
+ * into the device tree binding of 'nand-ecc', so that MTD
+ * device driver can get nand ecc from device tree.
+ */
+static const char *nand_ecc_modes[] = {
+	[NAND_ECC_NONE]		= "none",
+	[NAND_ECC_SOFT]		= "soft",
+	[NAND_ECC_HW]		= "hw",
+	[NAND_ECC_HW_SYNDROME]	= "hw_syndrome",
+	[NAND_ECC_HW_OOB_FIRST]	= "hw_oob_first",
+	[NAND_ECC_SOFT_BCH]	= "soft_bch",
+};
+
+/**
+ * of_get_nand_ecc_mode - Get nand ecc mode for given device_node
+ * @np:	Pointer to the given device_node
+ *
+ * The function gets ecc mode string from property 'nand-ecc-mode',
+ * and return its index in nand_ecc_modes table, or errno in error case.
+ */
+const int of_get_nand_ecc_mode(struct device_node *np)
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
+EXPORT_SYMBOL_GPL(of_get_nand_ecc_mode);
+
+/**
+ * of_get_nand_bus_width - Get nand bus witdh for given device_node
+ * @np:	Pointer to the given device_node
+ *
+ * return bus width option, or errno in error case.
+ */
+int of_get_nand_bus_width(struct device_node *np)
+{
+	u32 val;
+
+	if (of_property_read_u32(np, "nand-bus-width", &val))
+		return 8;
+
+	switch(val) {
+	case 8:
+	case 16:
+		return val;
+	default:
+		return -EIO;
+	}
+}
+EXPORT_SYMBOL_GPL(of_get_nand_bus_width);
+
+/**
+ * of_get_nand_on_flash_bbt - Get nand on flash bbt for given device_node
+ * @np:	Pointer to the given device_node
+ *
+ * return true if 1 false other wise
+ */
+bool of_get_nand_on_flash_bbt(struct device_node *np)
+{
+	return !!of_property_read_bool(np, "nand-on-flash-bbt");
+}
+EXPORT_SYMBOL_GPL(of_get_nand_on_flash_bbt);
diff --git a/include/linux/of_mtd.h b/include/linux/of_mtd.h
new file mode 100644
index 0000000..bae1b60
--- /dev/null
+++ b/include/linux/of_mtd.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * OF helpers for mtd.
+ *
+ * This file is released under the GPLv2
+ */
+
+#ifndef __LINUX_OF_MTD_H
+#define __LINUX_OF_NET_H
+
+#ifdef CONFIG_OF_MTD
+#include <linux/of.h>
+extern const int of_get_nand_ecc_mode(struct device_node *np);
+int of_get_nand_bus_width(struct device_node *np);
+bool of_get_nand_on_flash_bbt(struct device_node *np);
+#endif
+
+#endif /* __LINUX_OF_MTD_H */
-- 
1.7.7
