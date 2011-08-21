From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 22 Aug 2011 01:04:40 +0800
Subject: [PATCH 1/3] ARM: mx28evk: add platform data for saif
Message-ID: <1313946280-3831-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is for supporting saif record function.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
---
 arch/arm/mach-mxs/clock-mx28.c                  |    9 +++++++++
 arch/arm/mach-mxs/devices-mx28.h                |    4 +++-
 arch/arm/mach-mxs/devices/platform-mxs-saif.c   |    5 +++--
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 +++-
 arch/arm/mach-mxs/include/mach/digctl.h         |   18 ++++++++++++++++++
 arch/arm/mach-mxs/mach-mx28evk.c                |   16 ++++++++++++++--
 6 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 7954013..f589c6c 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -44,6 +44,15 @@ static struct clk saif0_clk;
 static struct clk saif1_clk;
 static struct clk clk32k_clk;
 
+int mxs_saif_clkmux_select(unsigned int clkmux)
+{
+	if (clkmux > 0x3)
+		return -EINVAL;
+
+	__raw_writel(clkmux << 10, DIGCTRL_BASE_ADDR + MXS_SET_ADDR);
+	return 0;
+}
+
 static int _raw_clk_enable(struct clk *clk)
 {
 	u32 reg;
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index c888710..40be649 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -47,6 +47,8 @@ struct platform_device *__init mx28_add_mxsfb(
 		const struct mxsfb_platform_data *pdata);
 
 extern const struct mxs_saif_data mx28_saif_data[] __initconst;
-#define mx28_add_saif(id)              mxs_add_saif(&mx28_saif_data[id])
+#define mx28_add_saif(id, pdata) \
+	mxs_add_saif(&mx28_saif_data[id], pdata)
+
 
 struct platform_device *__init mx28_add_rtc_stmp3xxx(void);
diff --git a/arch/arm/mach-mxs/devices/platform-mxs-saif.c b/arch/arm/mach-mxs/devices/platform-mxs-saif.c
index 1ec965e..f6e3a60 100644
--- a/arch/arm/mach-mxs/devices/platform-mxs-saif.c
+++ b/arch/arm/mach-mxs/devices/platform-mxs-saif.c
@@ -32,7 +32,8 @@ const struct mxs_saif_data mx28_saif_data[] __initconst = {
 };
 #endif
 
-struct platform_device *__init mxs_add_saif(const struct mxs_saif_data *data)
+struct platform_device *__init mxs_add_saif(const struct mxs_saif_data *data,
+				const struct mxs_saif_platform_data *pdata)
 {
 	struct resource res[] = {
 		{
@@ -56,5 +57,5 @@ struct platform_device *__init mxs_add_saif(const struct mxs_saif_data *data)
 	};
 
 	return mxs_add_platform_device("mxs-saif", data->id, res,
-					ARRAY_SIZE(res), NULL, 0);
+				ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index a8080f4..dc369c1 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -94,6 +94,7 @@ struct platform_device *__init mxs_add_mxs_pwm(
 		resource_size_t iobase, int id);
 
 /* saif */
+#include <sound/saif.h>
 struct mxs_saif_data {
 	int id;
 	resource_size_t iobase;
@@ -103,4 +104,5 @@ struct mxs_saif_data {
 };
 
 struct platform_device *__init mxs_add_saif(
-		const struct mxs_saif_data *data);
+		const struct mxs_saif_data *data,
+		const struct mxs_saif_platform_data *pdata);
diff --git a/arch/arm/mach-mxs/include/mach/digctl.h b/arch/arm/mach-mxs/include/mach/digctl.h
new file mode 100644
index 0000000..6231e10
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/digctl.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MACH_DIGCTL_H__
+#define __MACH_DIGCTL_H__
+
+/* MXS DIGCTL SAIF CLKMUX */
+#define MXS_DIGCTL_SAIF_CLKMUX_DIRECT		0x0
+#define MXS_DIGCTL_SAIF_CLKMUX_CROSSINPUT	0x1
+#define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0		0x2
+#define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR1		0x3
+
+#endif
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 4a3cca3..f3ef9e9 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -28,6 +28,7 @@
 
 #include <mach/common.h>
 #include <mach/iomux-mx28.h>
+#include <mach/digctl.h>
 
 #include "devices-mx28.h"
 
@@ -417,6 +418,17 @@ static void __init mx28evk_add_regulators(void)
 static void __init mx28evk_add_regulators(void) {}
 #endif
 
+extern int mxs_saif_clkmux_select(unsigned int clkmux);
+static int mx28evk_mxs_saif_pinit(void)
+{
+	return mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
+}
+
+struct mxs_saif_platform_data mx28evk_mxs_saif_pdata __initdata = {
+	.init = mx28evk_mxs_saif_pinit,
+	.clkmux = MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0,
+};
+
 static void __init mx28evk_init(void)
 {
 	int ret;
@@ -457,8 +469,8 @@ static void __init mx28evk_init(void)
 
 	mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
 
-	mx28_add_saif(0);
-	mx28_add_saif(1);
+	mx28_add_saif(0, &mx28evk_mxs_saif_pdata);
+	mx28_add_saif(1, &mx28evk_mxs_saif_pdata);
 
 	mx28_add_mxs_i2c(0);
 	i2c_register_board_info(0, mxs_i2c0_board_info,
-- 
1.7.0.4
