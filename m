From: jglauber@cavium.com (Jan Glauber)
Date: Mon, 25 Sep 2017 14:34:58 +0200
Subject: [PATCH v10 3/7] edac,
 soc: thunderx: Add wrapper for EDAC LMC PCI device
In-Reply-To: <20170925123502.17289-1-jglauber@cavium.com>
References: <20170925123502.17289-1-jglauber@cavium.com>
Message-ID: <20170925123502.17289-4-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cavium SOCs contain a memory controller that is presented as a
PCI device. This PCI device will be used by an EDAC driver and
by a PMU driver.

To allow both subsystems to access the device a small wrapper is
introduced that multi-plexes PCI probe and removal calls of the
device to the EDAC driver.

The same mechanism will be used later to call the PMU driver.

The ThunderX EDAC driver is limited to only build as module
with this patch. The reason is that with multiple users of the
multi-plexer all users must be either builtin or modules.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/edac/Kconfig            |  2 ++
 drivers/edac/thunderx_edac.c    | 27 ++++++-----------------
 drivers/soc/Kconfig             |  1 +
 drivers/soc/Makefile            |  1 +
 drivers/soc/cavium/Kconfig      |  6 +++++
 drivers/soc/cavium/Makefile     |  1 +
 drivers/soc/cavium/cavium_lmc.c | 49 +++++++++++++++++++++++++++++++++++++++++
 include/linux/soc/cavium/lmc.h  |  9 ++++++++
 8 files changed, 76 insertions(+), 20 deletions(-)
 create mode 100644 drivers/soc/cavium/Kconfig
 create mode 100644 drivers/soc/cavium/Makefile
 create mode 100644 drivers/soc/cavium/cavium_lmc.c
 create mode 100644 include/linux/soc/cavium/lmc.h

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 96afb2aeed18..7330447c43d1 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -371,6 +371,8 @@ config EDAC_THUNDERX
 	tristate "Cavium ThunderX EDAC"
 	depends on ARM64
 	depends on PCI
+	depends on m
+	select CAVIUM_LMC
 	help
 	  Support for error detection and correction on the
 	  Cavium ThunderX memory controllers (LMC), Cache
diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 4803c6468bab..a6a89bf0a457 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/edac.h>
+#include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/string.h>
 #include <linux/stop_machine.h>
@@ -20,6 +21,7 @@
 #include <linux/atomic.h>
 #include <linux/bitfield.h>
 #include <linux/circ_buf.h>
+#include <linux/soc/cavium/lmc.h>
 
 #include <asm/page.h>
 
@@ -654,8 +656,7 @@ static inline int pci_dev_to_mc_idx(struct pci_dev *pdev)
 	return ret;
 }
 
-static int thunderx_lmc_probe(struct pci_dev *pdev,
-				const struct pci_device_id *id)
+int thunderx_edac_lmc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct thunderx_lmc *lmc;
 	struct edac_mc_layer layer;
@@ -795,8 +796,9 @@ static int thunderx_lmc_probe(struct pci_dev *pdev,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(thunderx_edac_lmc_probe);
 
-static void thunderx_lmc_remove(struct pci_dev *pdev)
+void thunderx_edac_lmc_remove(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci = pci_get_drvdata(pdev);
 	struct thunderx_lmc *lmc = mci->pvt_info;
@@ -806,15 +808,7 @@ static void thunderx_lmc_remove(struct pci_dev *pdev)
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
 }
-
-MODULE_DEVICE_TABLE(pci, thunderx_lmc_pci_tbl);
-
-static struct pci_driver thunderx_lmc_driver = {
-	.name     = "thunderx_lmc_edac",
-	.probe    = thunderx_lmc_probe,
-	.remove   = thunderx_lmc_remove,
-	.id_table = thunderx_lmc_pci_tbl,
-};
+EXPORT_SYMBOL_GPL(thunderx_edac_lmc_remove);
 
 /*---------------------- OCX driver ---------------------------------*/
 
@@ -2110,13 +2104,9 @@ static int __init thunderx_edac_init(void)
 {
 	int rc = 0;
 
-	rc = pci_register_driver(&thunderx_lmc_driver);
-	if (rc)
-		return rc;
-
 	rc = pci_register_driver(&thunderx_ocx_driver);
 	if (rc)
-		goto err_lmc;
+		return rc;
 
 	rc = pci_register_driver(&thunderx_l2c_driver);
 	if (rc)
@@ -2125,8 +2115,6 @@ static int __init thunderx_edac_init(void)
 	return rc;
 err_ocx:
 	pci_unregister_driver(&thunderx_ocx_driver);
-err_lmc:
-	pci_unregister_driver(&thunderx_lmc_driver);
 
 	return rc;
 }
@@ -2135,7 +2123,6 @@ static void __exit thunderx_edac_exit(void)
 {
 	pci_unregister_driver(&thunderx_l2c_driver);
 	pci_unregister_driver(&thunderx_ocx_driver);
-	pci_unregister_driver(&thunderx_lmc_driver);
 
 }
 
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index fc9e98047421..f19f6237f336 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -4,6 +4,7 @@ source "drivers/soc/actions/Kconfig"
 source "drivers/soc/amlogic/Kconfig"
 source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
+source "drivers/soc/cavium/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 2fcaff864584..a2027196d0fb 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
+obj-$(CONFIG_ARCH_THUNDER)	+= cavium/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
diff --git a/drivers/soc/cavium/Kconfig b/drivers/soc/cavium/Kconfig
new file mode 100644
index 000000000000..46ded89fb696
--- /dev/null
+++ b/drivers/soc/cavium/Kconfig
@@ -0,0 +1,6 @@
+#
+# Cavium ThunderX Soc drivers
+#
+config CAVIUM_LMC
+        depends on ARCH_THUNDER
+	def_tristate m
diff --git a/drivers/soc/cavium/Makefile b/drivers/soc/cavium/Makefile
new file mode 100644
index 000000000000..4ad0c7f923fa
--- /dev/null
+++ b/drivers/soc/cavium/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_CAVIUM_LMC) += cavium_lmc.o
diff --git a/drivers/soc/cavium/cavium_lmc.c b/drivers/soc/cavium/cavium_lmc.c
new file mode 100644
index 000000000000..87248e83c55b
--- /dev/null
+++ b/drivers/soc/cavium/cavium_lmc.c
@@ -0,0 +1,49 @@
+/*
+ * These PCI devices contain RAS functionality and PMU counters. To allow
+ * independent RAS and PMU drivers this driver registers for the PCI devices
+ * and multi-plexes probe and removal.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright: Cavium, Inc. (C) 2017
+ *
+ */
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/soc/cavium/lmc.h>
+
+static int cvm_lmc_probe(struct pci_dev *pdev,
+			 const struct pci_device_id *ent)
+{
+	if (IS_ENABLED(CONFIG_EDAC_THUNDERX))
+		thunderx_edac_lmc_probe(pdev, ent);
+	return 0;
+}
+
+static void cvm_lmc_remove(struct pci_dev *pdev)
+{
+	if (IS_ENABLED(CONFIG_EDAC_THUNDERX))
+		thunderx_edac_lmc_remove(pdev);
+}
+
+static const struct pci_device_id cvm_lmc_pci_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xa022) },
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, cvm_lmc_pci_table);
+
+static struct pci_driver cvm_lmc_pci_driver = {
+	.name     = "Cavium SOC memory controller",
+	.id_table = cvm_lmc_pci_table,
+	.probe    = cvm_lmc_probe,
+	.remove   = cvm_lmc_remove,
+};
+
+module_pci_driver(cvm_lmc_pci_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Cavium, Inc.");
+MODULE_DESCRIPTION("PCI driver for Cavium SOC memory controller");
diff --git a/include/linux/soc/cavium/lmc.h b/include/linux/soc/cavium/lmc.h
new file mode 100644
index 000000000000..336f467e154f
--- /dev/null
+++ b/include/linux/soc/cavium/lmc.h
@@ -0,0 +1,9 @@
+#ifndef _LMC_H
+#define _LMC_H
+
+#include <linux/pci.h>
+
+int thunderx_edac_lmc_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
+void thunderx_edac_lmc_remove(struct pci_dev *pdev);
+
+#endif
-- 
2.9.0.rc0.21.g7777322
