From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Tue,  4 Sep 2018 17:24:46 +0530
Subject: [PATCH v2 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
In-Reply-To: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <1536062090-30446-12-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@marvell.com>

This patch adds basic template for Marvell OcteonTX2's
CGX ethernet interface driver. Just the probe.
RVU AF driver will use APIs exported by this driver
for various things like PF to physical interface mapping,
loopback mode, interface stats etc. Hence marged both
drivers into a single module.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/soc/marvell/Kconfig            |   3 +-
 drivers/soc/marvell/octeontx2/Makefile |   2 +-
 drivers/soc/marvell/octeontx2/cgx.c    | 102 +++++++++++++++++++++++++++++++++
 drivers/soc/marvell/octeontx2/cgx.h    |  22 +++++++
 drivers/soc/marvell/octeontx2/rvu.c    |  14 ++++-
 5 files changed, 140 insertions(+), 3 deletions(-)
 create mode 100644 drivers/soc/marvell/octeontx2/cgx.c
 create mode 100644 drivers/soc/marvell/octeontx2/cgx.h

diff --git a/drivers/soc/marvell/Kconfig b/drivers/soc/marvell/Kconfig
index 428d22e..8f36f3a 100644
--- a/drivers/soc/marvell/Kconfig
+++ b/drivers/soc/marvell/Kconfig
@@ -11,7 +11,8 @@ config OCTEONTX2_AF
 	tristate "OcteonTX2 RVU Admin Function driver"
 	select OCTEONTX2_MBOX
 	depends on ARM64 && PCI
-	help
+	---help---
 	  This driver supports Marvell's OcteonTX2 Resource Virtualization
 	  Unit's admin function manager which manages all RVU HW resources.
+
 endmenu
diff --git a/drivers/soc/marvell/octeontx2/Makefile b/drivers/soc/marvell/octeontx2/Makefile
index ac17cb9..8646421 100644
--- a/drivers/soc/marvell/octeontx2/Makefile
+++ b/drivers/soc/marvell/octeontx2/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_OCTEONTX2_MBOX) += octeontx2_mbox.o
 obj-$(CONFIG_OCTEONTX2_AF) += octeontx2_af.o
 
 octeontx2_mbox-y := mbox.o
-octeontx2_af-y := rvu.o
+octeontx2_af-y := cgx.o rvu.o
diff --git a/drivers/soc/marvell/octeontx2/cgx.c b/drivers/soc/marvell/octeontx2/cgx.c
new file mode 100644
index 0000000..47aa4cb
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/cgx.c
@@ -0,0 +1,102 @@
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
+struct pci_driver cgx_driver = {
+	.name = DRV_NAME,
+	.id_table = cgx_id_table,
+	.probe = cgx_probe,
+	.remove = cgx_remove,
+};
diff --git a/drivers/soc/marvell/octeontx2/cgx.h b/drivers/soc/marvell/octeontx2/cgx.h
new file mode 100644
index 0000000..a7d4b39
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/cgx.h
@@ -0,0 +1,22 @@
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
+extern struct pci_driver cgx_driver;
+
+#endif /* CGX_H */
diff --git a/drivers/soc/marvell/octeontx2/rvu.c b/drivers/soc/marvell/octeontx2/rvu.c
index 40684c9..daa6fd3 100644
--- a/drivers/soc/marvell/octeontx2/rvu.c
+++ b/drivers/soc/marvell/octeontx2/rvu.c
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 #include <linux/sysfs.h>
 
+#include "cgx.h"
 #include "rvu.h"
 #include "rvu_reg.h"
 
@@ -1605,14 +1606,25 @@ static struct pci_driver rvu_driver = {
 
 static int __init rvu_init_module(void)
 {
+	int err;
+
 	pr_info("%s: %s\n", DRV_NAME, DRV_STRING);
 
-	return pci_register_driver(&rvu_driver);
+	err = pci_register_driver(&cgx_driver);
+	if (err < 0)
+		return err;
+
+	err =  pci_register_driver(&rvu_driver);
+	if (err < 0)
+		pci_unregister_driver(&cgx_driver);
+
+	return err;
 }
 
 static void __exit rvu_cleanup_module(void)
 {
 	pci_unregister_driver(&rvu_driver);
+	pci_unregister_driver(&cgx_driver);
 }
 
 module_init(rvu_init_module);
-- 
2.7.4
