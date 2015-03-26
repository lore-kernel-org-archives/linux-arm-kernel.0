From: b52261@freescale.com (Jianwei Wang)
Date: Thu, 26 Mar 2015 13:37:03 +0800
Subject: [PATCH v3 2/4] arm/layerscape/ls1021a: DCU pixel clock control
In-Reply-To: <1427348225-40731-1-git-send-email-b52261@freescale.com>
References: <1427348225-40731-1-git-send-email-b52261@freescale.com>
Message-ID: <1427348225-40731-2-git-send-email-b52261@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DCU pixel clock when platform devices initinalizing and
provide enable and disable pixel clock functions for drm driver

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <b52261@freescale.com>
---
 arch/arm/mach-imx/mach-ls1021a.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/fsl/dcu.h          | 22 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 include/linux/fsl/dcu.h

diff --git a/arch/arm/mach-imx/mach-ls1021a.c b/arch/arm/mach-imx/mach-ls1021a.c
index b89c858..4fb346d 100644
--- a/arch/arm/mach-imx/mach-ls1021a.c
+++ b/arch/arm/mach-imx/mach-ls1021a.c
@@ -8,9 +8,44 @@
  */
 
 #include <asm/mach/arch.h>
+#include <linux/of_platform.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/fsl/dcu.h>
 
 #include "common.h"
 
+void dcu_pixclk_disable(void)
+{
+	struct regmap *scfg_regmap;
+
+	scfg_regmap = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
+	if (IS_ERR(scfg_regmap)) {
+		pr_err("No syscfg phandle specified\n");
+		return;
+	}
+
+	regmap_write(scfg_regmap, SCFG_PIXCLKCR, PXCK_DISABLE);
+}
+
+void dcu_pixclk_enable(void)
+{
+	struct regmap *scfg_regmap;
+
+	scfg_regmap = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
+	if (IS_ERR(scfg_regmap)) {
+		pr_err("No syscfg phandle specified\n");
+		return;
+	}
+
+	regmap_write(scfg_regmap, SCFG_PIXCLKCR, PXCK_ENABLE);
+}
+
+static void __init ls1021a_init_machine(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	dcu_pixclk_enable();
+}
 static const char * const ls1021a_dt_compat[] __initconst = {
 	"fsl,ls1021a",
 	NULL,
@@ -18,5 +53,6 @@ static const char * const ls1021a_dt_compat[] __initconst = {
 
 DT_MACHINE_START(LS1021A, "Freescale LS1021A")
 	.smp		= smp_ops(ls1021a_smp_ops),
+	.init_machine	= ls1021a_init_machine,
 	.dt_compat	= ls1021a_dt_compat,
 MACHINE_END
diff --git a/include/linux/fsl/dcu.h b/include/linux/fsl/dcu.h
new file mode 100644
index 0000000..1873057
--- /dev/null
+++ b/include/linux/fsl/dcu.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * Freescale DCU drm device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __FSL_DCU_H__
+#define __FSL_DCU_H__
+
+#define SCFG_PIXCLKCR			0x28
+#define PXCK_ENABLE			BIT(31)
+#define PXCK_DISABLE			0
+
+void dcu_pixclk_enable(void);
+void dcu_pixclk_disable(void);
+
+#endif /* __FSL_DCU_H__ */
-- 
2.1.0.27.g96db324
