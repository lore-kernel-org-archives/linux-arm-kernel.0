From: york.sun@nxp.com (York Sun)
Date: Tue, 23 Aug 2016 15:14:03 -0700
Subject: [Patch v5 8/9] driver/edac/layerscape_edac: Add Layerscape EDAC
 support
Message-ID: <1471990465-27443-1-git-send-email-york.sun@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DDR EDAC for ARM-based compatible controllers. Both big-endian
and little-endian are supported, as specified in device tree.

Signed-off-by: York Sun <york.sun@nxp.com>

---
Change log
  v5: Update author and copyright for the new driver
      Drop initializing varaible with 0
      Add pr_fmt macro
  v4: Drop adding atomic_scrub() for armv8
      Drop NO_IRQ
  v3: no change
  v2: Create new driver using shared DDR object

 arch/arm64/Kconfig.platforms   |  1 +
 drivers/edac/Kconfig           |  7 ++++
 drivers/edac/Makefile          |  3 ++
 drivers/edac/fsl_ddr_edac.c    |  2 +-
 drivers/edac/layerscape_edac.c | 73 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 drivers/edac/layerscape_edac.c

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index bb2616b..52f30a6 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -55,6 +55,7 @@ config ARCH_EXYNOS
 
 config ARCH_LAYERSCAPE
 	bool "ARMv8 based Freescale Layerscape SoC family"
+	select EDAC_SUPPORT
 	help
 	  This enables support for the Freescale Layerscape SoC family.
 
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 394cd16..49d7900 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -258,6 +258,13 @@ config EDAC_MPC85XX
 	  Support for error detection and correction on the Freescale
 	  MPC8349, MPC8560, MPC8540, MPC8548, T4240
 
+config EDAC_LAYERSCAPE
+	tristate "Freescale Layerscape DDR"
+	depends on EDAC_MM_EDAC && ARCH_LAYERSCAPE
+	help
+	  Support for error detection and correction on Freescale memory
+	  controllers on Layerscape SoCs.
+
 config EDAC_MV64X60
 	tristate "Marvell MV64x60"
 	depends on EDAC_MM_EDAC && MV64X60
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index ee047a4..910dc83 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -54,6 +54,9 @@ obj-$(CONFIG_EDAC_PASEMI)		+= pasemi_edac.o
 mpc85xx_edac_mod-y			:= fsl_ddr_edac.o mpc85xx_edac.o
 obj-$(CONFIG_EDAC_MPC85XX)		+= mpc85xx_edac_mod.o
 
+layerscape_edac_mod-y			:= fsl_ddr_edac.o layerscape_edac.o
+obj-$(CONFIG_EDAC_LAYERSCAPE)		+= layerscape_edac_mod.o
+
 obj-$(CONFIG_EDAC_MV64X60)		+= mv64x60_edac.o
 obj-$(CONFIG_EDAC_CELL)			+= cell_edac.o
 obj-$(CONFIG_EDAC_PPC4XX)		+= ppc4xx_edac.o
diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index d8ce1f6..afade14 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -26,6 +26,7 @@
 
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include "edac_module.h"
 #include "edac_core.h"
 #include "fsl_ddr_edac.h"
@@ -478,7 +479,6 @@ int fsl_mc_err_probe(struct platform_device *op)
 
 	pdata = mci->pvt_info;
 	pdata->name = "fsl_mc_err";
-	pdata->irq = NO_IRQ;
 	mci->pdev = &op->dev;
 	pdata->edac_idx = edac_mc_idx++;
 	dev_set_drvdata(mci->pdev, mci);
diff --git a/drivers/edac/layerscape_edac.c b/drivers/edac/layerscape_edac.c
new file mode 100644
index 0000000..6c59d89
--- /dev/null
+++ b/drivers/edac/layerscape_edac.c
@@ -0,0 +1,73 @@
+/*
+ * Freescale Memory Controller kernel module
+ *
+ * Author: York Sun <york.sun@nxp.com>
+ *
+ * Copyright 2016 NXP Semiconductor
+ *
+ * Derived from mpc85xx_edac.c
+ * Author: Dave Jiang <djiang@mvista.com>
+ *
+ * 2006-2007 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "edac_core.h"
+#include "fsl_ddr_edac.h"
+
+static const struct of_device_id fsl_ddr_mc_err_of_match[] = {
+	{ .compatible = "fsl,qoriq-memory-controller", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, fsl_ddr_mc_err_of_match);
+
+static struct platform_driver fsl_ddr_mc_err_driver = {
+	.probe = fsl_mc_err_probe,
+	.remove = fsl_mc_err_remove,
+	.driver = {
+		.name = "fsl_ddr_mc_err",
+		.of_match_table = fsl_ddr_mc_err_of_match,
+	},
+};
+
+static int __init fsl_ddr_mc_init(void)
+{
+	int res;
+
+	/* make sure error reporting method is sane */
+	switch (edac_op_state) {
+	case EDAC_OPSTATE_POLL:
+	case EDAC_OPSTATE_INT:
+		break;
+	default:
+		edac_op_state = EDAC_OPSTATE_INT;
+		break;
+	}
+
+	res = platform_driver_register(&fsl_ddr_mc_err_driver);
+	if (res) {
+		pr_err("MC fails to register\n");
+		return res;
+	}
+
+	return 0;
+}
+
+module_init(fsl_ddr_mc_init);
+
+static void __exit fsl_ddr_mc_exit(void)
+{
+	platform_driver_unregister(&fsl_ddr_mc_err_driver);
+}
+
+module_exit(fsl_ddr_mc_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("NXP Semiconductor");
+module_param(edac_op_state, int, 0444);
+MODULE_PARM_DESC(edac_op_state,
+		 "EDAC Error Reporting state: 0=Poll, 2=Interrupt");
-- 
2.7.4
