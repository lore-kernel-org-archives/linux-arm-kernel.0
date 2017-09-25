From: jglauber@cavium.com (Jan Glauber)
Date: Mon, 25 Sep 2017 14:34:59 +0200
Subject: [PATCH v10 4/7] edac,
 soc: thunderx: Add wrapper for EDAC OCX PCI device
In-Reply-To: <20170925123502.17289-1-jglauber@cavium.com>
References: <20170925123502.17289-1-jglauber@cavium.com>
Message-ID: <20170925123502.17289-5-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cavium SOCs contain an processor interconnect that is presented as a
PCI device. This PCI device will be used by an EDAC driver and
by a PMU driver.

To allow both subsystems to access the device a small wrapper is
introduced that multi-plexes PCI probe and removal calls of the
device to the EDAC driver.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/edac/Kconfig            |  1 +
 drivers/edac/thunderx_edac.c    | 42 +++++++-------------------------------
 drivers/soc/cavium/Kconfig      |  4 ++++
 drivers/soc/cavium/Makefile     |  1 +
 drivers/soc/cavium/cavium_ocx.c | 45 +++++++++++++++++++++++++++++++++++++++++
 include/linux/soc/cavium/ocx.h  |  9 +++++++++
 6 files changed, 67 insertions(+), 35 deletions(-)
 create mode 100644 drivers/soc/cavium/cavium_ocx.c
 create mode 100644 include/linux/soc/cavium/ocx.h

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 7330447c43d1..830421208374 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -373,6 +373,7 @@ config EDAC_THUNDERX
 	depends on PCI
 	depends on m
 	select CAVIUM_LMC
+	select CAVIUM_OCX
 	help
 	  Support for error detection and correction on the
 	  Cavium ThunderX memory controllers (LMC), Cache
diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index a6a89bf0a457..581517488a80 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -22,6 +22,7 @@
 #include <linux/bitfield.h>
 #include <linux/circ_buf.h>
 #include <linux/soc/cavium/lmc.h>
+#include <linux/soc/cavium/ocx.h>
 
 #include <asm/page.h>
 
@@ -812,8 +813,6 @@ EXPORT_SYMBOL_GPL(thunderx_edac_lmc_remove);
 
 /*---------------------- OCX driver ---------------------------------*/
 
-#define PCI_DEVICE_ID_THUNDER_OCX 0xa013
-
 #define OCX_LINK_INTS		3
 #define OCX_INTS		(OCX_LINK_INTS + 1)
 #define OCX_RX_LANES		24
@@ -1309,11 +1308,6 @@ struct debugfs_entry *ocx_dfs_ents[] = {
 	&debugfs_com_int,
 };
 
-static const struct pci_device_id thunderx_ocx_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_THUNDER_OCX) },
-	{ 0, },
-};
-
 static void thunderx_ocx_clearstats(struct thunderx_ocx *ocx)
 {
 	int lane, stat, cfg;
@@ -1329,8 +1323,8 @@ static void thunderx_ocx_clearstats(struct thunderx_ocx *ocx)
 	}
 }
 
-static int thunderx_ocx_probe(struct pci_dev *pdev,
-			      const struct pci_device_id *id)
+int thunderx_edac_ocx_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
 {
 	struct thunderx_ocx *ocx;
 	struct edac_device_ctl_info *edac_dev;
@@ -1459,8 +1453,9 @@ static int thunderx_ocx_probe(struct pci_dev *pdev,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(thunderx_edac_ocx_probe);
 
-static void thunderx_ocx_remove(struct pci_dev *pdev)
+void thunderx_edac_ocx_remove(struct pci_dev *pdev)
 {
 	struct edac_device_ctl_info *edac_dev = pci_get_drvdata(pdev);
 	struct thunderx_ocx *ocx = edac_dev->pvt_info;
@@ -1478,15 +1473,7 @@ static void thunderx_ocx_remove(struct pci_dev *pdev)
 	edac_device_del_device(&pdev->dev);
 	edac_device_free_ctl_info(edac_dev);
 }
-
-MODULE_DEVICE_TABLE(pci, thunderx_ocx_pci_tbl);
-
-static struct pci_driver thunderx_ocx_driver = {
-	.name     = "thunderx_ocx_edac",
-	.probe    = thunderx_ocx_probe,
-	.remove   = thunderx_ocx_remove,
-	.id_table = thunderx_ocx_pci_tbl,
-};
+EXPORT_SYMBOL_GPL(thunderx_edac_ocx_remove);
 
 /*---------------------- L2C driver ---------------------------------*/
 
@@ -2102,27 +2089,12 @@ static struct pci_driver thunderx_l2c_driver = {
 
 static int __init thunderx_edac_init(void)
 {
-	int rc = 0;
-
-	rc = pci_register_driver(&thunderx_ocx_driver);
-	if (rc)
-		return rc;
-
-	rc = pci_register_driver(&thunderx_l2c_driver);
-	if (rc)
-		goto err_ocx;
-
-	return rc;
-err_ocx:
-	pci_unregister_driver(&thunderx_ocx_driver);
-
-	return rc;
+	return pci_register_driver(&thunderx_l2c_driver);
 }
 
 static void __exit thunderx_edac_exit(void)
 {
 	pci_unregister_driver(&thunderx_l2c_driver);
-	pci_unregister_driver(&thunderx_ocx_driver);
 
 }
 
diff --git a/drivers/soc/cavium/Kconfig b/drivers/soc/cavium/Kconfig
index 46ded89fb696..fe56503d20f4 100644
--- a/drivers/soc/cavium/Kconfig
+++ b/drivers/soc/cavium/Kconfig
@@ -4,3 +4,7 @@
 config CAVIUM_LMC
         depends on ARCH_THUNDER
 	def_tristate m
+
+config CAVIUM_OCX
+	depends on ARCH_THUNDER
+	def_tristate m
diff --git a/drivers/soc/cavium/Makefile b/drivers/soc/cavium/Makefile
index 4ad0c7f923fa..bf7ba252ebb1 100644
--- a/drivers/soc/cavium/Makefile
+++ b/drivers/soc/cavium/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_CAVIUM_LMC) += cavium_lmc.o
+obj-$(CONFIG_CAVIUM_OCX) += cavium_ocx.o
diff --git a/drivers/soc/cavium/cavium_ocx.c b/drivers/soc/cavium/cavium_ocx.c
new file mode 100644
index 000000000000..fa3341b0744f
--- /dev/null
+++ b/drivers/soc/cavium/cavium_ocx.c
@@ -0,0 +1,45 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright: Cavium, Inc. (C) 2017
+ *
+ */
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/soc/cavium/ocx.h>
+
+static int cvm_ocx_probe(struct pci_dev *pdev,
+			 const struct pci_device_id *ent)
+{
+	if (IS_ENABLED(CONFIG_EDAC_THUNDERX))
+		thunderx_edac_ocx_probe(pdev, ent);
+	return 0;
+}
+
+static void cvm_ocx_remove(struct pci_dev *pdev)
+{
+	if (IS_ENABLED(CONFIG_EDAC_THUNDERX))
+		thunderx_edac_ocx_remove(pdev);
+}
+
+static const struct pci_device_id cvm_ocx_pci_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xa013) },
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, cvm_ocx_pci_table);
+
+static struct pci_driver cvm_ocx_pci_driver = {
+	.name     = "Cavium ThunderX interconnect",
+	.id_table = cvm_ocx_pci_table,
+	.probe    = cvm_ocx_probe,
+	.remove   = cvm_ocx_remove,
+};
+
+module_pci_driver(cvm_ocx_pci_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Cavium, Inc.");
+MODULE_DESCRIPTION("PCI driver for Cavium ThunderX interconnect");
diff --git a/include/linux/soc/cavium/ocx.h b/include/linux/soc/cavium/ocx.h
new file mode 100644
index 000000000000..29f55b3d3171
--- /dev/null
+++ b/include/linux/soc/cavium/ocx.h
@@ -0,0 +1,9 @@
+#ifndef _OCX_H
+#define _OCX_H
+
+#include <linux/pci.h>
+
+int thunderx_edac_ocx_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
+void thunderx_edac_ocx_remove(struct pci_dev *pdev);
+
+#endif
-- 
2.9.0.rc0.21.g7777322
