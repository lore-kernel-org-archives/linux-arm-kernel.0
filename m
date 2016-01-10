From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Sun, 10 Jan 2016 21:11:27 +0530
Subject: [PATCH 2/3] HACK: ARM: DRA7: add pdata-quirks to do reset of PCIe
In-Reply-To: <1452440488-28398-1-git-send-email-kishon@ti.com>
References: <1452440488-28398-1-git-send-email-kishon@ti.com>
Message-ID: <1452440488-28398-3-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pdata-quirks to reset PCIe IP. This is to be used until
a drivers/reset/ interface is available for this purpose.

Reviewed-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c       |   11 +++++++++++
 include/linux/platform_data/pci-dra7xx.h |   22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 include/linux/platform_data/pci-dra7xx.h

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 5814477..f5a65fe 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -23,6 +23,7 @@
 #include <linux/platform_data/pinctrl-single.h>
 #include <linux/platform_data/iommu-omap.h>
 #include <linux/platform_data/wkup_m3.h>
+#include <linux/platform_data/pci-dra7xx.h>
 
 #include "common.h"
 #include "common-board-devices.h"
@@ -404,6 +405,14 @@ static void __init omap5_uevm_legacy_init(void)
 }
 #endif
 
+#ifdef CONFIG_SOC_DRA7XX
+static struct pci_dra7xx_platform_data dra7xx_pci_pdata = {
+	.reset_name = "pcie",
+	.assert_reset = omap_device_assert_hardreset,
+	.deassert_reset = omap_device_deassert_hardreset,
+};
+#endif
+
 static struct pcs_pdata pcs_pdata;
 
 void omap_pcs_legacy_init(int irq, void (*rearm)(void))
@@ -474,6 +483,8 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #endif
 #ifdef CONFIG_SOC_DRA7XX
 	OF_DEV_AUXDATA("ti,dra7-padconf", 0x4a003400, "4a003400.pinmux", &pcs_pdata),
+	OF_DEV_AUXDATA("ti,dra7-pcie", 0x51000000, "51000000.pcie", &dra7xx_pci_pdata),
+	OF_DEV_AUXDATA("ti,dra7-pcie", 0x51800000, "51800000.pcie", &dra7xx_pci_pdata),
 #endif
 #ifdef CONFIG_SOC_AM43XX
 	OF_DEV_AUXDATA("ti,am437-padconf", 0x44e10800, "44e10800.pinmux", &pcs_pdata),
diff --git a/include/linux/platform_data/pci-dra7xx.h b/include/linux/platform_data/pci-dra7xx.h
new file mode 100644
index 0000000..792c8ed
--- /dev/null
+++ b/include/linux/platform_data/pci-dra7xx.h
@@ -0,0 +1,22 @@
+/*
+ * pcie-dra7xx - Platform data for PCIe controller
+ *
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Authors: Kishon Vijay Abraham I <kishon@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __PCI_DRA7XX_H
+#define __PCI_DRA7XX_H
+
+struct pci_dra7xx_platform_data {
+	const char *reset_name;
+
+	int (*assert_reset)(struct platform_device *pdev, const char *name);
+	int (*deassert_reset)(struct platform_device *pdev, const char *name);
+};
+#endif /* __PCI_DRA7XX_H */
-- 
1.7.9.5
