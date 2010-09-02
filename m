From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  2 Sep 2010 16:42:01 +0200
Subject: [PATCH 4/6] ARM: mx51: Add spi clock and spi_imx device registration
In-Reply-To: <20100902143908.GK14214@pengutronix.de>
References: <20100902143908.GK14214@pengutronix.de>
Message-ID: <1283438523-19697-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/clock-mx51.c               |   42 ++++++++++++++++++++++++++
 arch/arm/mach-mx5/devices-imx51.h            |   18 +++++++++++
 arch/arm/plat-mxc/devices/platform-spi_imx.c |   17 ++++++++++
 3 files changed, 77 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx5/devices-imx51.h

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 6af69de..9ab4d17 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -762,6 +762,29 @@ static struct clk kpp_clk = {
 	.id = 0,
 };
 
+static unsigned long clk_cspi_get_rate(struct clk *clk)
+{
+	u32 reg, prediv, podf;
+	unsigned long rate;
+
+	reg = __raw_readl(MXC_CCM_CSCDR2);
+	prediv = ((reg & MXC_CCM_CSCDR2_CSPI_CLK_PRED_MASK) >>
+		  MXC_CCM_CSCDR2_CSPI_CLK_PRED_OFFSET) + 1;
+	if (prediv == 1)
+		BUG();
+	podf = ((reg & MXC_CCM_CSCDR2_CSPI_CLK_PODF_MASK) >>
+		MXC_CCM_CSCDR2_CSPI_CLK_PODF_OFFSET) + 1;
+
+	rate = clk_get_rate(clk->parent) / (prediv * podf);
+
+	return rate;
+}
+
+static struct clk cspi_main_clk = {
+	.parent = &pll3_sw_clk,
+	.get_rate = clk_cspi_get_rate,
+};
+
 #define DEFINE_CLOCK(name, i, er, es, gr, sr, p, s)	\
 	static struct clk name = {			\
 		.id		= i,			\
@@ -810,6 +833,22 @@ DEFINE_CLOCK(i2c2_clk, 1, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG10_OFFSET,
 DEFINE_CLOCK(hsi2c_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG11_OFFSET,
 	NULL, NULL, &ipg_clk, NULL);
 
+/* SPI */
+DEFINE_CLOCK(cspi1_ipg_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG9_OFFSET,
+	NULL, NULL, &ipg_clk, &spba_clk);
+DEFINE_CLOCK(cspi1_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG10_OFFSET,
+	NULL, NULL, &cspi_main_clk, &cspi1_ipg_clk);
+
+DEFINE_CLOCK(cspi2_ipg_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG11_OFFSET,
+	NULL, NULL, &ipg_clk, &spba_clk);
+DEFINE_CLOCK(cspi2_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG12_OFFSET,
+	NULL, NULL, &cspi_main_clk, &cspi2_ipg_clk);
+
+DEFINE_CLOCK(cspi3_ipg_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG9_OFFSET,
+	NULL, NULL, &ipg_clk, &aips_tz2_clk);
+DEFINE_CLOCK(cspi3_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG13_OFFSET,
+	NULL, NULL, &cspi_main_clk, &cspi3_ipg_clk);
+
 /* FEC */
 DEFINE_CLOCK(fec_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG12_OFFSET,
 	NULL,  NULL, &ipg_clk, NULL);
@@ -837,6 +876,9 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
 	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
+	_REGISTER_CLOCK("spi_imx.0", NULL, cspi1_clk)
+	_REGISTER_CLOCK("spi_imx.1", NULL, cspi2_clk)
+	_REGISTER_CLOCK("spi_imx.2", NULL, cspi3_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
new file mode 100644
index 0000000..3901f59
--- /dev/null
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx51.h>
+#include <mach/devices-common.h>
+
+extern const struct imx_spi_imx_data imx51_cspi_imx_data __initconst;
+#define imx51_add_cspi_imx(pdata)	\
+	imx_add_spi_imx(&imx51_cspi_imx_data, pdata)
+
+extern struct imx_spi_imx_data imx51_ecspi_imx_data[] __initconst;
+#define imx51_add_ecspi_imx(id, pdata)	\
+	imx_add_spi_imx(&imx51_ecspi_imx_data[id], pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
index 7b7b005..077f936 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -67,6 +67,23 @@ const struct imx_spi_imx_data imx35_spi_imx_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_ARCH_MX35 */
 
+#ifdef CONFIG_ARCH_MX51
+/*
+ * until the imx-spi supports platform-ids, the cspi device has to use a
+ * different id than the ecspi devices above.  The driver currently hardcodes 2
+ * for the cspi device.
+ */
+const struct imx_spi_imx_data imx51_cspi_imx_data __initconst =
+	imx_spi_imx_data_entry_single(MX51, CSPI, "imx51-cspi", 2, , SZ_4K);
+
+const struct imx_spi_imx_data imx51_ecspi_imx_data[] __initconst = {
+#define imx51_ecspi_imx_data_entry(_id, _hwid)				\
+	imx_spi_imx_data_entry(MX51, ECSPI, "imx51-ecspi", _id, _hwid, SZ_4K)
+	imx51_ecspi_imx_data_entry(0, 1),
+	imx51_ecspi_imx_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_ARCH_MX51 */
+
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
 		const struct spi_imx_master *pdata)
-- 
1.7.1
