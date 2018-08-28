From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Tue, 28 Aug 2018 16:27:14 +0530
Subject: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
In-Reply-To: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@marvell.com>

This patch adds basic template for Marvell OcteonTX2's
CGX ethernet interface driver. Just the probe.
RVU AF driver will use APIs exported by this driver
for various things like PF to physical interface mapping,
loopback mode, interface stats etc.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/soc/marvell/Kconfig            |  10 +++
 drivers/soc/marvell/octeontx2/Makefile |   2 +
 drivers/soc/marvell/octeontx2/cgx.c    | 117 +++++++++++++++++++++++++++++++++
 drivers/soc/marvell/octeontx2/cgx.h    |  20 ++++++
 4 files changed, 149 insertions(+)
 create mode 100644 drivers/soc/marvell/octeontx2/cgx.c
 create mode 100644 drivers/soc/marvell/octeontx2/cgx.h

diff --git a/drivers/soc/marvell/Kconfig b/drivers/soc/marvell/Kconfig
index 4499caf..73c8f8d 100644
--- a/drivers/soc/marvell/Kconfig
+++ b/drivers/soc/marvell/Kconfig
@@ -7,7 +7,17 @@ menu "Marvell SoC drivers"
 config OCTEONTX2_AF
 	tristate "OcteonTX2 RVU Admin Function driver"
 	depends on ARM64 && PCI
+	select OCTEONTX2_CGX
 	help
 	  This driver supports Marvell's OcteonTX2 Resource Virtualization
 	  Unit's admin function manager which manages all RVU HW resources.
+
+config OCTEONTX2_CGX
+	tristate "OcteonTX2 MAC interface (CGX) driver"
+	depends on ARM64 && PCI
+	select PHYLIB
+	help
+	  This driver supports programming and controlling of MAC
+	  interfaces from RVU Admin Function driver.
+
 endmenu
diff --git a/drivers/soc/marvell/octeontx2/Makefile b/drivers/soc/marvell/octeontx2/Makefile
index 8737ec3..50b8f74 100644
--- a/drivers/soc/marvell/octeontx2/Makefile
+++ b/drivers/soc/marvell/octeontx2/Makefile
@@ -3,6 +3,8 @@
 # Makefile for Marvell's OcteonTX2 RVU Admin Function driver
 #
 
+obj-$(CONFIG_OCTEONTX2_CGX) += octeontx2_cgx.o
 obj-$(CONFIG_OCTEONTX2_AF) += octeontx2_af.o
 
+octeontx2_cgx-y := cgx.o
 octeontx2_af-y := rvu.o mbox.o
diff --git a/drivers/soc/marvell/octeontx2/cgx.c b/drivers/soc/marvell/octeontx2/cgx.c
new file mode 100644
index 0000000..6f0b6f4
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/cgx.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell OcteonTx2 CGX driver
+ *
+ * Copyright (C) 2018 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/phy.h>
+#include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+
+#include "cgx.h"
+
+#define DRV_NAME	"octeontx2-cgx"
+#define DRV_STRING      "Marvell OcteonTX2 CGX/MAC Driver"
+#define DRV_VERSION	"1.0"
+
+struct cgx {
+	void __iomem		*reg_base;
+	struct pci_dev		*pdev;
+	u8			cgx_id;
+};
+
+/* Supported devices */
+static const struct pci_device_id cgx_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_CGX) },
+	{ 0, }  /* end of table */
+};
+
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_DESCRIPTION(DRV_STRING);
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
+MODULE_DEVICE_TABLE(pci, cgx_id_table);
+
+static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int err;
+	struct device *dev = &pdev->dev;
+	struct cgx *cgx;
+
+	cgx = devm_kzalloc(dev, sizeof(*cgx), GFP_KERNEL);
+	if (!cgx)
+		return -ENOMEM;
+	cgx->pdev = pdev;
+
+	pci_set_drvdata(pdev, cgx);
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Failed to enable PCI device\n");
+		pci_set_drvdata(pdev, NULL);
+		return err;
+	}
+
+	err = pci_request_regions(pdev, DRV_NAME);
+	if (err) {
+		dev_err(dev, "PCI request regions failed 0x%x\n", err);
+		goto err_disable_device;
+	}
+
+	/* MAP configuration registers */
+	cgx->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
+	if (!cgx->reg_base) {
+		dev_err(dev, "CGX: Cannot map CSR memory space, aborting\n");
+		err = -ENOMEM;
+		goto err_release_regions;
+	}
+
+	return 0;
+
+err_release_regions:
+	pci_release_regions(pdev);
+err_disable_device:
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+	return err;
+}
+
+static void cgx_remove(struct pci_dev *pdev)
+{
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static struct pci_driver cgx_driver = {
+	.name = DRV_NAME,
+	.id_table = cgx_id_table,
+	.probe = cgx_probe,
+	.remove = cgx_remove,
+};
+
+static int __init cgx_init_module(void)
+{
+	pr_info("%s: %s\n", DRV_NAME, DRV_STRING);
+
+	return pci_register_driver(&cgx_driver);
+}
+
+static void __exit cgx_cleanup_module(void)
+{
+	pci_unregister_driver(&cgx_driver);
+}
+
+module_init(cgx_init_module);
+module_exit(cgx_cleanup_module);
diff --git a/drivers/soc/marvell/octeontx2/cgx.h b/drivers/soc/marvell/octeontx2/cgx.h
new file mode 100644
index 0000000..8056264
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/cgx.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Marvell OcteonTx2 CGX driver
+ *
+ * Copyright (C) 2018 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef CGX_H
+#define CGX_H
+
+ /* PCI device IDs */
+#define	PCI_DEVID_OCTEONTX2_CGX			0xA059
+
+/* PCI BAR nos */
+#define PCI_CFG_REG_BAR_NUM			0
+
+#endif /* CGX_H */
-- 
2.7.4
