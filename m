From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 1 Apr 2011 09:51:03 +0200
Subject: [PATCH] mach-ux500: split per-SoC clock trees
Message-ID: <1301644263-14012-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rickard Evertsson <rickard.evertsson@stericsson.com>

This splits the ux500 clock tree in per-chip variants, previously
the DB8500 clock tree was used also for DB5500 which was not good.
This new version makes use of the new PRCMU interface submitted
in the previous patch series.

Signed-off-by: Rickard Evertsson <rickard.evertsson@stericsson.com>
Signed-off-by: Daniel Willerud <daniel.willerud@stericsson.com>
Signed-off-by: Deepak Karda <deepak.karda@stericsson.com>
Signed-off-by: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Makefile       |    3 +-
 arch/arm/mach-ux500/clock-db8500.c | 1291 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/clock.c        |  904 +++++++------------------
 arch/arm/mach-ux500/clock.h        |  225 +++----
 4 files changed, 1647 insertions(+), 776 deletions(-)
 create mode 100644 arch/arm/mach-ux500/clock-db8500.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 923c833..adab0c3 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -6,7 +6,8 @@ obj-y				:= clock.o cpu.o devices.o devices-common.o \
 				   id.o usb.o
 obj-y				+= pm/
 obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o dma-db5500.o prcmu-db5500.o
-obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu-db8500.o
+obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o \
+				   prcmu-db8500.o clock-db8500.o
 obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-regulators.o \
 				board-mop500-uib.o board-mop500-stuib.o \
diff --git a/arch/arm/mach-ux500/clock-db8500.c b/arch/arm/mach-ux500/clock-db8500.c
new file mode 100644
index 0000000..50a9deb
--- /dev/null
+++ b/arch/arm/mach-ux500/clock-db8500.c
@@ -0,0 +1,1291 @@
+/*
+ *  Copyright (C) 2009 ST-Ericsson SA
+ *  Copyright (C) 2009 STMicroelectronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/mfd/ab8500/sysctrl.h>
+#include <linux/workqueue.h>
+#include <linux/regulator/consumer.h>
+
+#include <plat/pincfg.h>
+
+#include <mach/hardware.h>
+#include <mach/prcmu-fw-api.h>
+
+#include "clock.h"
+#include "pins-db8500.h"
+
+#define PRCM_SDMMCCLK_MGT	0x024
+#define PRCM_TCR		0x1C8
+#define PRCM_TCR_STOPPED	(1 << 16)
+#define PRCM_TCR_DOZE_MODE	(1 << 17)
+#define SD_CLK_DIV_MASK		0x1F
+#define SD_CLK_DIV_VAL		8
+
+static DEFINE_MUTEX(sysclk_mutex);
+static DEFINE_MUTEX(ab_ulpclk_mutex);
+static DEFINE_MUTEX(audioclk_mutex);
+
+static struct delayed_work sysclk_disable_work;
+
+/* PLL operations. */
+
+static int clk_pllsrc_enable(struct clk *clk)
+{
+	/* To enable pll */
+	return 0;
+}
+
+static void clk_pllsrc_disable(struct clk *clk)
+{
+	/* To disable pll */
+}
+
+static struct clkops pll_clk_ops = {
+	.enable = clk_pllsrc_enable,
+	.disable = clk_pllsrc_disable,
+};
+
+/* SysClk operations. */
+
+static int request_sysclk(bool enable)
+{
+	static int requests;
+
+	if ((enable && (requests++ == 0)) || (!enable && (--requests == 0)))
+		return prcmu_request_clock(PRCMU_SYSCLK, enable);
+	return 0;
+}
+
+static int sysclk_enable(struct clk *clk)
+{
+	static bool swat_enable;
+	int r;
+
+	if (!swat_enable) {
+		r = ab8500_sysctrl_set(AB8500_SWATCTRL,
+			AB8500_SWATCTRL_SWATENABLE);
+		if (r)
+			return r;
+
+		swat_enable = true;
+	}
+
+	r = request_sysclk(true);
+	if (r)
+		return r;
+
+	if (clk->cg_sel) {
+		r = ab8500_sysctrl_set(AB8500_SYSULPCLKCTRL1, (u8)clk->cg_sel);
+		if (r)
+			(void)request_sysclk(false);
+	}
+	return r;
+}
+
+static void sysclk_disable(struct clk *clk)
+{
+	int r;
+
+	if (clk->cg_sel) {
+		r = ab8500_sysctrl_clear(AB8500_SYSULPCLKCTRL1,
+			(u8)clk->cg_sel);
+		if (r)
+			goto disable_failed;
+	}
+	r = request_sysclk(false);
+	if (r)
+		goto disable_failed;
+	return;
+
+disable_failed:
+	pr_err("clock: failed to disable %s.\n", clk->name);
+}
+
+static struct clkops sysclk_ops = {
+	.enable = sysclk_enable,
+	.disable = sysclk_disable,
+};
+
+/* AB8500 UlpClk operations */
+
+static int ab_ulpclk_enable(struct clk *clk)
+{
+	int err;
+
+	if (clk->regulator == NULL) {
+		struct regulator *reg;
+
+		reg = regulator_get(NULL, "v-intcore");
+		if (IS_ERR(reg))
+			return PTR_ERR(reg);
+		clk->regulator = reg;
+	}
+	err = regulator_enable(clk->regulator);
+	if (err)
+		return err;
+	err = ab8500_sysctrl_clear(AB8500_SYSULPCLKCONF,
+		AB8500_SYSULPCLKCONF_ULPCLKCONF_MASK);
+	if (err)
+		return err;
+	return ab8500_sysctrl_set(AB8500_SYSULPCLKCTRL1,
+		AB8500_SYSULPCLKCTRL1_ULPCLKREQ);
+}
+
+static void ab_ulpclk_disable(struct clk *clk)
+{
+	if (ab8500_sysctrl_clear(AB8500_SYSULPCLKCTRL1,
+		AB8500_SYSULPCLKCTRL1_ULPCLKREQ))
+		goto out_err;
+	if (clk->regulator != NULL) {
+		if (regulator_disable(clk->regulator))
+			goto out_err;
+	}
+	return;
+
+out_err:
+	pr_err("clock: %s failed to disable %s.\n", __func__, clk->name);
+}
+
+static struct clkops ab_ulpclk_ops = {
+	.enable = ab_ulpclk_enable,
+	.disable = ab_ulpclk_disable,
+};
+
+/* AB8500 audio clock operations */
+
+static int audioclk_enable(struct clk *clk)
+{
+	return ab8500_sysctrl_set(AB8500_SYSULPCLKCTRL1,
+		AB8500_SYSULPCLKCTRL1_AUDIOCLKENA);
+}
+
+static void audioclk_disable(struct clk *clk)
+{
+	if (ab8500_sysctrl_clear(AB8500_SYSULPCLKCTRL1,
+		AB8500_SYSULPCLKCTRL1_AUDIOCLKENA)) {
+		pr_err("clock: %s failed to disable %s.\n", __func__,
+			clk->name);
+	}
+}
+
+static int audioclk_set_parent(struct clk *clk, struct clk *parent)
+{
+	if (parent->ops == &sysclk_ops) {
+		return ab8500_sysctrl_clear(AB8500_SYSULPCLKCTRL1,
+			AB8500_SYSULPCLKCTRL1_SYSULPCLKINTSEL_MASK);
+	} else if (parent->ops == &ab_ulpclk_ops) {
+		return ab8500_sysctrl_write(AB8500_SYSULPCLKCTRL1,
+			AB8500_SYSULPCLKCTRL1_SYSULPCLKINTSEL_MASK,
+			(1 << AB8500_SYSULPCLKCTRL1_SYSULPCLKINTSEL_SHIFT));
+	} else {
+		return -EINVAL;
+	}
+}
+
+static struct clkops audioclk_ops = {
+	.enable = audioclk_enable,
+	.disable = audioclk_disable,
+	.set_parent = audioclk_set_parent,
+};
+
+/* Primary camera clock operations */
+static int clkout0_enable(struct clk *clk)
+{
+	int r;
+
+	r = prcmu_config_clkout(0, PRCMU_CLKSRC_SYSCLK, 4);
+	if (r)
+		return r;
+	return nmk_config_pin(GPIO227_CLKOUT1, false);
+}
+
+static void clkout0_disable(struct clk *clk)
+{
+	int r;
+
+	r = nmk_config_pin(GPIO227_GPIO, false);
+	if (r)
+		goto disable_failed;
+	r = prcmu_config_clkout(0, PRCMU_CLKSRC_SYSCLK, 0);
+	if (!r)
+		return;
+disable_failed:
+	pr_err("clock: failed to disable %s.\n", clk->name);
+}
+
+/* Touch screen/secondary camera clock operations. */
+static int clkout1_enable(struct clk *clk)
+{
+	int r;
+
+	r = prcmu_config_clkout(1, PRCMU_CLKSRC_SYSCLK, 4);
+	if (r)
+		return r;
+	return nmk_config_pin(GPIO228_CLKOUT2, false);
+}
+
+static void clkout1_disable(struct clk *clk)
+{
+	int r;
+
+	r = nmk_config_pin(GPIO228_GPIO, false);
+	if (r)
+		goto disable_failed;
+	r = prcmu_config_clkout(1, PRCMU_CLKSRC_SYSCLK, 0);
+	if (!r)
+		return;
+disable_failed:
+	pr_err("clock: failed to disable %s.\n", clk->name);
+}
+
+static struct clkops clkout0_ops = {
+	.enable = clkout0_enable,
+	.disable = clkout0_disable,
+};
+
+static struct clkops clkout1_ops = {
+	.enable = clkout1_enable,
+	.disable = clkout1_disable,
+};
+
+#define DEF_PER1_PCLK(_cg_bit, _name) \
+	DEF_PRCC_PCLK(_name, U8500_CLKRST1_BASE, _cg_bit, &per1clk)
+#define DEF_PER2_PCLK(_cg_bit, _name) \
+	DEF_PRCC_PCLK(_name, U8500_CLKRST2_BASE, _cg_bit, &per2clk)
+#define DEF_PER3_PCLK(_cg_bit, _name) \
+	DEF_PRCC_PCLK(_name, U8500_CLKRST3_BASE, _cg_bit, &per3clk)
+#define DEF_PER5_PCLK(_cg_bit, _name) \
+	DEF_PRCC_PCLK(_name, U8500_CLKRST5_BASE, _cg_bit, &per5clk)
+#define DEF_PER6_PCLK(_cg_bit, _name) \
+	DEF_PRCC_PCLK(_name, U8500_CLKRST6_BASE, _cg_bit, &per6clk)
+#define DEF_PER7_PCLK(_cg_bit, _name) \
+	DEF_PRCC_PCLK(_name, U8500_CLKRST7_BASE_ED, _cg_bit, &per7clk)
+
+#define DEF_PER1_KCLK(_cg_bit, _name, _parent) \
+	DEF_PRCC_KCLK(_name, U8500_CLKRST1_BASE, _cg_bit, _parent)
+#define DEF_PER2_KCLK(_cg_bit, _name, _parent) \
+	DEF_PRCC_KCLK(_name, U8500_CLKRST2_BASE, _cg_bit, _parent)
+#define DEF_PER3_KCLK(_cg_bit, _name, _parent) \
+	DEF_PRCC_KCLK(_name, U8500_CLKRST3_BASE, _cg_bit, _parent)
+#define DEF_PER5_KCLK(_cg_bit, _name, _parent) \
+	DEF_PRCC_KCLK(_name, U8500_CLKRST5_BASE, _cg_bit, _parent)
+#define DEF_PER6_KCLK(_cg_bit, _name, _parent) \
+	DEF_PRCC_KCLK(_name, U8500_CLKRST6_BASE, _cg_bit, _parent)
+#define DEF_PER7_KCLK(_cg_bit, _name, _parent) \
+	DEF_PRCC_KCLK(_name, U8500_CLKRST7_BASE_ED, _cg_bit, _parent)
+
+#define DEF_MTU_CLK(_cg_sel, _name, _bus_parent) \
+	struct clk _name = { \
+		.name = #_name, \
+		.ops = &mtu_clk_ops, \
+		.cg_sel = _cg_sel, \
+		.bus_parent = _bus_parent, \
+	}
+
+/* Clock sources. */
+
+static struct clk soc0_pll = {
+	.name = "soc0_pll",
+	.ops = &pll_clk_ops,
+};
+
+static struct clk soc1_pll = {
+	.name = "soc1_pll",
+	.ops = &pll_clk_ops,
+};
+
+static struct clk ddr_pll = {
+	.name = "ddr_pll",
+	.ops = &pll_clk_ops,
+};
+
+static struct clk ulp38m4 = {
+	.name = "ulp38m4",
+};
+
+static struct clk sysclk = {
+	.name = "sysclk",
+	.ops = &sysclk_ops,
+	.rate = 38400000,
+	.mutex = &sysclk_mutex,
+};
+
+static struct clk sysclk2 = {
+	.name = "sysclk2",
+	.ops = &sysclk_ops,
+	.cg_sel = AB8500_SYSULPCLKCTRL1_SYSCLKBUF2REQ,
+	.mutex = &sysclk_mutex,
+};
+
+static struct clk sysclk3 = {
+	.name = "sysclk3",
+	.ops = &sysclk_ops,
+	.cg_sel = AB8500_SYSULPCLKCTRL1_SYSCLKBUF3REQ,
+	.mutex = &sysclk_mutex,
+};
+
+static struct clk sysclk4 = {
+	.name = "sysclk4",
+	.ops = &sysclk_ops,
+	.cg_sel = AB8500_SYSULPCLKCTRL1_SYSCLKBUF4REQ,
+	.mutex = &sysclk_mutex,
+};
+
+static struct clk rtc32k = {
+	.name = "rtc32k",
+	.rate = 32768,
+};
+
+static struct clk clkout0 = {
+	.name = "clkout0",
+	.ops = &clkout0_ops,
+	.parent = &sysclk,
+	.rate = 9600000,
+	.mutex = &sysclk_mutex,
+};
+
+static struct clk clkout1 = {
+	.name = "clkout1",
+	.ops = &clkout1_ops,
+	.parent = &sysclk,
+	.rate = 9600000,
+	.mutex = &sysclk_mutex,
+};
+
+static struct clk ab_ulpclk = {
+	.name = "ab_ulpclk",
+	.ops = &ab_ulpclk_ops,
+	.rate = 38400000,
+	.mutex = &ab_ulpclk_mutex,
+};
+
+static struct clk *audioclk_parents[] = { &sysclk, &ab_ulpclk, NULL };
+
+static struct clk audioclk = {
+	.name = "audioclk",
+	.ops = &audioclk_ops,
+	.mutex = &audioclk_mutex,
+	.parent = &sysclk,
+	.parents = audioclk_parents,
+};
+
+static DEF_PRCMU_CLK(sgaclk, PRCMU_SGACLK, 320000000);
+static DEF_PRCMU_CLK(uartclk, PRCMU_UARTCLK, 38400000);
+static DEF_PRCMU_CLK(msp02clk, PRCMU_MSP02CLK, 19200000);
+static DEF_PRCMU_CLK(msp1clk, PRCMU_MSP1CLK, 19200000);
+static DEF_PRCMU_CLK(i2cclk, PRCMU_I2CCLK, 24000000);
+static DEF_PRCMU_CLK(slimclk, PRCMU_SLIMCLK, 19200000);
+static DEF_PRCMU_CLK(per1clk, PRCMU_PER1CLK, 133330000);
+static DEF_PRCMU_CLK(per2clk, PRCMU_PER2CLK, 133330000);
+static DEF_PRCMU_CLK(per3clk, PRCMU_PER3CLK, 133330000);
+static DEF_PRCMU_CLK(per5clk, PRCMU_PER5CLK, 133330000);
+static DEF_PRCMU_CLK(per6clk, PRCMU_PER6CLK, 133330000);
+static DEF_PRCMU_CLK(per7clk, PRCMU_PER7CLK, 100000000);
+static DEF_PRCMU_CLK(lcdclk, PRCMU_LCDCLK, 48000000);
+static DEF_PRCMU_OPP100_CLK(bmlclk, PRCMU_BMLCLK, 200000000);
+static DEF_PRCMU_CLK(hsitxclk, PRCMU_HSITXCLK, 100000000);
+static DEF_PRCMU_CLK(hsirxclk, PRCMU_HSIRXCLK, 200000000);
+static DEF_PRCMU_CLK(hdmiclk, PRCMU_HDMICLK, 76800000);
+static DEF_PRCMU_CLK(apeatclk, PRCMU_APEATCLK, 160000000);
+static DEF_PRCMU_CLK(apetraceclk, PRCMU_APETRACECLK, 160000000);
+static DEF_PRCMU_CLK(mcdeclk, PRCMU_MCDECLK, 160000000);
+static DEF_PRCMU_OPP100_CLK(ipi2cclk, PRCMU_IPI2CCLK, 24000000);
+static DEF_PRCMU_CLK(dsialtclk, PRCMU_DSIALTCLK, 384000000);
+static DEF_PRCMU_CLK(dmaclk, PRCMU_DMACLK, 200000000);
+static DEF_PRCMU_CLK(b2r2clk, PRCMU_B2R2CLK, 200000000);
+static DEF_PRCMU_CLK(tvclk, PRCMU_TVCLK, 76800000);
+/* TODO: For SSPCLK, the spec says 24MHz, while the old driver says 48MHz. */
+static DEF_PRCMU_CLK(sspclk, PRCMU_SSPCLK, 24000000);
+static DEF_PRCMU_CLK(rngclk, PRCMU_RNGCLK, 19200000);
+static DEF_PRCMU_CLK(uiccclk, PRCMU_UICCCLK, 48000000);
+static DEF_PRCMU_CLK(timclk, PRCMU_TIMCLK, 2400000);
+/* 100 MHz until 3.0.1, 50 MHz Since PRCMU FW 3.0.2 */
+static DEF_PRCMU_CLK(sdmmcclk, PRCMU_SDMMCCLK, 50000000);
+
+/* PRCC PClocks */
+
+static DEF_PER1_PCLK(0, p1_pclk0);
+static DEF_PER1_PCLK(1, p1_pclk1);
+static DEF_PER1_PCLK(2, p1_pclk2);
+static DEF_PER1_PCLK(3, p1_pclk3);
+static DEF_PER1_PCLK(4, p1_pclk4);
+static DEF_PER1_PCLK(5, p1_pclk5);
+static DEF_PER1_PCLK(6, p1_pclk6);
+static DEF_PER1_PCLK(7, p1_pclk7);
+static DEF_PER1_PCLK(8, p1_pclk8);
+static DEF_PER1_PCLK(9, p1_pclk9);
+static DEF_PER1_PCLK(10, p1_pclk10);
+static DEF_PER1_PCLK(11, p1_pclk11);
+
+static DEF_PER2_PCLK(0, p2_pclk0);
+static DEF_PER2_PCLK(1, p2_pclk1);
+static DEF_PER2_PCLK(2, p2_pclk2);
+static DEF_PER2_PCLK(3, p2_pclk3);
+static DEF_PER2_PCLK(4, p2_pclk4);
+static DEF_PER2_PCLK(5, p2_pclk5);
+static DEF_PER2_PCLK(6, p2_pclk6);
+static DEF_PER2_PCLK(7, p2_pclk7);
+static DEF_PER2_PCLK(8, p2_pclk8);
+static DEF_PER2_PCLK(9, p2_pclk9);
+static DEF_PER2_PCLK(10, p2_pclk10);
+static DEF_PER2_PCLK(11, p2_pclk11);
+static DEF_PER2_PCLK(12, p2_pclk12);
+
+static DEF_PER3_PCLK(0, p3_pclk0);
+static DEF_PER3_PCLK(1, p3_pclk1);
+static DEF_PER3_PCLK(2, p3_pclk2);
+static DEF_PER3_PCLK(3, p3_pclk3);
+static DEF_PER3_PCLK(4, p3_pclk4);
+static DEF_PER3_PCLK(5, p3_pclk5);
+static DEF_PER3_PCLK(6, p3_pclk6);
+static DEF_PER3_PCLK(7, p3_pclk7);
+static DEF_PER3_PCLK(8, p3_pclk8);
+
+static DEF_PER5_PCLK(0, p5_pclk0);
+static DEF_PER5_PCLK(1, p5_pclk1);
+
+static DEF_PER6_PCLK(0, p6_pclk0);
+static DEF_PER6_PCLK(1, p6_pclk1);
+static DEF_PER6_PCLK(2, p6_pclk2);
+static DEF_PER6_PCLK(3, p6_pclk3);
+static DEF_PER6_PCLK(4, p6_pclk4);
+static DEF_PER6_PCLK(5, p6_pclk5);
+static DEF_PER6_PCLK(6, p6_pclk6);
+static DEF_PER6_PCLK(7, p6_pclk7);
+
+static DEF_PER7_PCLK(0, p7_pclk0);
+static DEF_PER7_PCLK(1, p7_pclk1);
+static DEF_PER7_PCLK(2, p7_pclk2);
+static DEF_PER7_PCLK(3, p7_pclk3);
+static DEF_PER7_PCLK(4, p7_pclk4);
+
+/* UART0 */
+static DEF_PER1_KCLK(0, p1_uart0_kclk, &uartclk);
+static DEF_PER_CLK(p1_uart0_clk, &p1_pclk0, &p1_uart0_kclk);
+
+/* UART1 */
+static DEF_PER1_KCLK(1, p1_uart1_kclk, &uartclk);
+static DEF_PER_CLK(p1_uart1_clk, &p1_pclk1, &p1_uart1_kclk);
+
+/* I2C1 */
+static DEF_PER1_KCLK(2, p1_i2c1_kclk, &i2cclk);
+static DEF_PER_CLK(p1_i2c1_clk, &p1_pclk2, &p1_i2c1_kclk);
+
+/* MSP0 */
+static DEF_PER1_KCLK(3, p1_msp0_kclk, &msp02clk);
+static DEF_PER_CLK(p1_msp0_clk, &p1_pclk3, &p1_msp0_kclk);
+
+/* MSP1 */
+static DEF_PER1_KCLK(4, p1_msp1_kclk, &msp1clk);
+static DEF_PER_CLK(p1_msp1_clk, &p1_pclk4, &p1_msp1_kclk);
+
+static DEF_PER1_KCLK(4, p1_msp1_ed_kclk, &msp02clk);
+static DEF_PER_CLK(p1_msp1_ed_clk, &p1_pclk4, &p1_msp1_ed_kclk);
+
+/* SDI0 */
+static DEF_PER1_KCLK(5, p1_sdi0_kclk, &sdmmcclk);
+static DEF_PER_CLK(p1_sdi0_clk, &p1_pclk5, &p1_sdi0_kclk);
+
+/* I2C2 */
+static DEF_PER1_KCLK(6, p1_i2c2_kclk, &i2cclk);
+static DEF_PER_CLK(p1_i2c2_clk, &p1_pclk6, &p1_i2c2_kclk);
+
+/* SLIMBUS0 */
+static DEF_PER1_KCLK(3, p1_slimbus0_kclk, &slimclk);
+static DEF_PER_CLK(p1_slimbus0_clk, &p1_pclk8, &p1_slimbus0_kclk);
+
+/* I2C4 */
+static DEF_PER1_KCLK(9, p1_i2c4_kclk, &i2cclk);
+static DEF_PER_CLK(p1_i2c4_clk, &p1_pclk10, &p1_i2c4_kclk);
+
+/* MSP3 */
+static DEF_PER1_KCLK(10, p1_msp3_kclk, &msp1clk);
+static DEF_PER_CLK(p1_msp3_clk, &p1_pclk11, &p1_msp3_kclk);
+
+/* I2C3 */
+static DEF_PER2_KCLK(0, p2_i2c3_kclk, &i2cclk);
+static DEF_PER_CLK(p2_i2c3_clk, &p2_pclk0, &p2_i2c3_kclk);
+
+/* SDI4 */
+static DEF_PER2_KCLK(2, p2_sdi4_kclk, &sdmmcclk);
+static DEF_PER_CLK(p2_sdi4_clk, &p2_pclk4, &p2_sdi4_kclk);
+
+/* MSP2 */
+static DEF_PER2_KCLK(3, p2_msp2_kclk, &msp02clk);
+static DEF_PER_CLK(p2_msp2_clk, &p2_pclk5, &p2_msp2_kclk);
+
+static DEF_PER2_KCLK(4, p2_msp2_ed_kclk, &msp02clk);
+static DEF_PER_CLK(p2_msp2_ed_clk, &p2_pclk6, &p2_msp2_ed_kclk);
+
+/* SDI1 */
+static DEF_PER2_KCLK(4, p2_sdi1_kclk, &sdmmcclk);
+static DEF_PER_CLK(p2_sdi1_clk, &p2_pclk6, &p2_sdi1_kclk);
+
+/* These are probably broken now. */
+static DEF_PER2_KCLK(5, p2_sdi1_ed_kclk, &sdmmcclk);
+static DEF_PER_CLK(p2_sdi1_ed_clk, &p2_pclk7, &p2_sdi1_ed_kclk);
+
+/* SDI3 */
+static DEF_PER2_KCLK(5, p2_sdi3_kclk, &sdmmcclk);
+static DEF_PER_CLK(p2_sdi3_clk, &p2_pclk7, &p2_sdi3_kclk);
+
+/* These are probably broken now. */
+static DEF_PER2_KCLK(6, p2_sdi3_ed_kclk, &sdmmcclk);
+static DEF_PER_CLK(p2_sdi3_ed_clk, &p2_pclk8, &p2_sdi3_ed_kclk);
+
+/* SSP0 */
+static DEF_PER3_KCLK(1, p3_ssp0_kclk, &sspclk);
+static DEF_PER_CLK(p3_ssp0_clk, &p3_pclk1, &p3_ssp0_kclk);
+
+static DEF_PER3_KCLK(1, p3_ssp0_ed_kclk, &i2cclk);
+static DEF_PER_CLK(p3_ssp0_ed_clk, &p3_pclk1, &p3_ssp0_ed_kclk);
+
+/* SSP1 */
+static DEF_PER3_KCLK(2, p3_ssp1_kclk, &sspclk);
+static DEF_PER_CLK(p3_ssp1_clk, &p3_pclk2, &p3_ssp1_kclk);
+
+static DEF_PER3_KCLK(2, p3_ssp1_ed_kclk, &i2cclk);
+static DEF_PER_CLK(p3_ssp1_ed_clk, &p3_pclk2, &p3_ssp1_ed_kclk);
+
+/* I2C0 */
+static DEF_PER3_KCLK(3, p3_i2c0_kclk, &i2cclk);
+static DEF_PER_CLK(p3_i2c0_clk, &p3_pclk3, &p3_i2c0_kclk);
+
+/* SDI2 */
+static DEF_PER3_KCLK(4, p3_sdi2_kclk, &sdmmcclk);
+static DEF_PER_CLK(p3_sdi2_clk, &p3_pclk4, &p3_sdi2_kclk);
+
+/* SKE */
+static DEF_PER3_KCLK(5, p3_ske_kclk, &rtc32k);
+static DEF_PER_CLK(p3_ske_clk, &p3_pclk5, &p3_ske_kclk);
+
+/* UART2 */
+static DEF_PER3_KCLK(6, p3_uart2_kclk, &uartclk);
+static DEF_PER_CLK(p3_uart2_clk, &p3_pclk6, &p3_uart2_kclk);
+
+/* SDI5 */
+static DEF_PER3_KCLK(7, p3_sdi5_kclk, &sdmmcclk);
+static DEF_PER_CLK(p3_sdi5_clk, &p3_pclk7, &p3_sdi5_kclk);
+
+/* USB */
+static DEF_PER5_KCLK(0, p5_usb_ed_kclk, &i2cclk);
+static DEF_PER_CLK(p5_usb_ed_clk, &p5_pclk0, &p5_usb_ed_kclk);
+
+/* RNG */
+static DEF_PER6_KCLK(0, p6_rng_kclk, &rngclk);
+static DEF_PER_CLK(p6_rng_clk, &p6_pclk0, &p6_rng_kclk);
+
+static DEF_PER6_KCLK(0, p6_rng_ed_kclk, &i2cclk);
+static DEF_PER_CLK(p6_rng_ed_clk, &p6_pclk0, &p6_rng_ed_kclk);
+
+
+/* MTU:S */
+
+/* MTU0 */
+static DEF_PER_CLK(p6_mtu0_clk, &p6_pclk6, &timclk);
+static DEF_PER_CLK(p7_mtu0_ed_clk, &p7_pclk2, &timclk);
+
+/* MTU1 */
+static DEF_PER_CLK(p6_mtu1_clk, &p6_pclk7, &timclk);
+static DEF_PER_CLK(p7_mtu1_ed_clk, &p7_pclk3, &timclk);
+
+#ifdef CONFIG_DEBUG_FS
+
+struct clk_debug_info {
+	struct clk *clk;
+	struct dentry *dir;
+	struct dentry *enable;
+	struct dentry *requests;
+	int enabled;
+};
+
+static struct dentry *clk_dir;
+static struct dentry *clk_show;
+static struct dentry *clk_show_enabled_only;
+
+static struct clk_debug_info dbg_clks[] = {
+	/* Clock sources */
+	{ .clk = &soc0_pll, },
+	{ .clk = &soc1_pll, },
+	{ .clk = &ddr_pll, },
+	{ .clk = &ulp38m4, },
+	{ .clk = &sysclk, },
+	{ .clk = &rtc32k, },
+	/* PRCMU clocks */
+	{ .clk = &sgaclk, },
+	{ .clk = &uartclk, },
+	{ .clk = &msp02clk, },
+	{ .clk = &msp1clk, },
+	{ .clk = &i2cclk, },
+	{ .clk = &sdmmcclk, },
+	{ .clk = &slimclk, },
+	{ .clk = &per1clk, },
+	{ .clk = &per2clk, },
+	{ .clk = &per3clk, },
+	{ .clk = &per5clk, },
+	{ .clk = &per6clk, },
+	{ .clk = &per7clk, },
+	{ .clk = &lcdclk, },
+	{ .clk = &bmlclk, },
+	{ .clk = &hsitxclk, },
+	{ .clk = &hsirxclk, },
+	{ .clk = &hdmiclk, },
+	{ .clk = &apeatclk, },
+	{ .clk = &apetraceclk, },
+	{ .clk = &mcdeclk, },
+	{ .clk = &ipi2cclk, },
+	{ .clk = &dsialtclk, },
+	{ .clk = &dmaclk, },
+	{ .clk = &b2r2clk, },
+	{ .clk = &tvclk, },
+	{ .clk = &sspclk, },
+	{ .clk = &rngclk, },
+	{ .clk = &uiccclk, },
+};
+
+static struct clk_debug_info dbg_clks_v2[] = {
+	/* Clock sources */
+	{ .clk = &sysclk2, },
+	{ .clk = &clkout0, },
+	{ .clk = &clkout1, },
+};
+
+static int clk_show_print(struct seq_file *s, void *p)
+{
+	int i;
+	int enabled_only = (int)s->private;
+
+	seq_printf(s, "\n%-20s %s\n", "name", "enabled (kernel + debug)");
+	for (i = 0; i < ARRAY_SIZE(dbg_clks); i++) {
+		if (enabled_only && !dbg_clks[i].clk->enabled)
+			continue;
+		seq_printf(s,
+			   "%-20s %5d + %d\n",
+			   dbg_clks[i].clk->name,
+			   dbg_clks[i].clk->enabled - dbg_clks[i].enabled,
+			   dbg_clks[i].enabled);
+	}
+	if (cpu_is_u8500v2()) {
+		for (i = 0; i < ARRAY_SIZE(dbg_clks_v2); i++) {
+			if (enabled_only && !dbg_clks_v2[i].clk->enabled)
+				continue;
+			seq_printf(s,
+				   "%-20s %5d + %d\n",
+				   dbg_clks_v2[i].clk->name,
+				   (dbg_clks_v2[i].clk->enabled -
+				    dbg_clks_v2[i].enabled),
+				   dbg_clks_v2[i].enabled);
+		}
+	}
+
+	return 0;
+}
+
+static int clk_show_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, clk_show_print, inode->i_private);
+}
+
+static int clk_enable_print(struct seq_file *s, void *p)
+{
+	struct clk_debug_info *cdi = s->private;
+
+	return seq_printf(s, "%d\n", cdi->enabled);
+}
+
+static int clk_enable_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, clk_enable_print, inode->i_private);
+}
+
+static ssize_t clk_enable_write(struct file *file, const char __user *user_buf,
+	size_t count, loff_t *ppos)
+{
+	struct clk_debug_info *cdi;
+	char buf[32];
+	ssize_t buf_size;
+	long user_val;
+	int err;
+
+	cdi = ((struct seq_file *)(file->private_data))->private;
+
+	buf_size = min(count, (sizeof(buf) - 1));
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+	buf[buf_size] = '\0';
+
+	err = strict_strtol(buf, 0, &user_val);
+	if (err)
+		return -EINVAL;
+	if ((user_val > 0) && (!cdi->enabled)) {
+		err = clk_enable(cdi->clk);
+		if (err) {
+			pr_err("clock: clk_enable(%s) failed.\n",
+				cdi->clk->name);
+			return -EFAULT;
+		}
+		cdi->enabled = 1;
+	} else if ((user_val <= 0) && (cdi->enabled)) {
+		clk_disable(cdi->clk);
+		cdi->enabled = 0;
+	}
+	return buf_size;
+}
+
+static int clk_requests_print(struct seq_file *s, void *p)
+{
+	struct clk_debug_info *cdi = s->private;
+
+	return seq_printf(s, "%d\n", cdi->clk->enabled);
+}
+
+static int clk_requests_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, clk_requests_print, inode->i_private);
+}
+
+static const struct file_operations clk_enable_fops = {
+	.open = clk_enable_open,
+	.write = clk_enable_write,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+static const struct file_operations clk_requests_fops = {
+	.open = clk_requests_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+static const struct file_operations clk_show_fops = {
+	.open = clk_show_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+static int create_clk_dirs(struct clk_debug_info *cdi, int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		cdi[i].dir = debugfs_create_dir(cdi[i].clk->name, clk_dir);
+		if (!cdi[i].dir)
+			goto no_dir;
+	}
+
+	for (i = 0; i < size; i++) {
+		cdi[i].enable = debugfs_create_file("enable",
+						    (S_IRUGO | S_IWUGO),
+						    cdi[i].dir, &cdi[i],
+						    &clk_enable_fops);
+		if (!cdi[i].enable)
+			goto no_enable;
+	}
+	for (i = 0; i < size; i++) {
+		cdi[i].requests = debugfs_create_file("requests", S_IRUGO,
+						       cdi[i].dir, &cdi[i],
+						       &clk_requests_fops);
+		if (!cdi[i].requests)
+			goto no_requests;
+	}
+	return 0;
+
+no_requests:
+	while (i--)
+		debugfs_remove(cdi[i].requests);
+	i = size;
+no_enable:
+	while (i--)
+		debugfs_remove(cdi[i].enable);
+	i = size;
+no_dir:
+	while (i--)
+		debugfs_remove(cdi[i].dir);
+
+	return -ENOMEM;
+}
+
+static void remove_clk_dirs(struct clk_debug_info *cdi, int size)
+{
+	int i;
+	for (i = 0; i < size; i++) {
+		debugfs_remove(cdi[i].requests);
+		debugfs_remove(cdi[i].enable);
+		debugfs_remove(cdi[i].dir);
+	}
+}
+
+static int __init clk_debug_init(void)
+{
+	clk_dir = debugfs_create_dir("clk", NULL);
+	if (!clk_dir)
+		goto no_dir;
+
+	clk_show = debugfs_create_file("show", S_IRUGO, clk_dir, (void *)0,
+				       &clk_show_fops);
+	if (!clk_show)
+		goto no_show;
+
+	clk_show_enabled_only = debugfs_create_file("show-enabled-only",
+					       S_IRUGO, clk_dir, (void *)1,
+					       &clk_show_fops);
+	if (!clk_show_enabled_only)
+		goto no_enabled_only;
+
+	if (create_clk_dirs(&dbg_clks[0], ARRAY_SIZE(dbg_clks)))
+		goto no_clks;
+
+	if (cpu_is_u8500v2()) {
+		if (create_clk_dirs(&dbg_clks_v2[0], ARRAY_SIZE(dbg_clks_v2)))
+			goto common_clks;
+	}
+	return 0;
+
+common_clks:
+	remove_clk_dirs(&dbg_clks[0], ARRAY_SIZE(dbg_clks));
+no_clks:
+	debugfs_remove(clk_show_enabled_only);
+no_enabled_only:
+	debugfs_remove(clk_show);
+no_show:
+	debugfs_remove(clk_dir);
+no_dir:
+	return -ENOMEM;
+}
+
+static void __exit clk_debug_exit(void)
+{
+	remove_clk_dirs(&dbg_clks[0], ARRAY_SIZE(dbg_clks));
+	if (cpu_is_u8500v2())
+		remove_clk_dirs(&dbg_clks_v2[0], ARRAY_SIZE(dbg_clks_v2));
+
+	debugfs_remove(clk_show);
+	debugfs_remove(clk_show_enabled_only);
+	debugfs_remove(clk_dir);
+}
+
+subsys_initcall(clk_debug_init);
+module_exit(clk_debug_exit);
+#endif /* CONFIG_DEBUG_FS */
+
+/*
+ * TODO: Ensure names match with devices and then remove unnecessary entries
+ * when all drivers use the clk API.
+ */
+
+#define CLK_LOOKUP(_clk, _dev_id, _con_id) \
+	{ .dev_id = _dev_id, .con_id = _con_id, .clk = &_clk }
+
+static struct clk_lookup u8500_common_clock_sources[] = {
+	CLK_LOOKUP(soc0_pll, NULL, "soc0_pll"),
+	CLK_LOOKUP(soc1_pll, NULL, "soc1_pll"),
+	CLK_LOOKUP(ddr_pll, NULL, "ddr_pll"),
+	CLK_LOOKUP(ulp38m4, NULL, "ulp38m4"),
+	CLK_LOOKUP(sysclk, NULL, "sysclk"),
+	CLK_LOOKUP(rtc32k, NULL, "clk32k"),
+	CLK_LOOKUP(sysclk, "ab8500-usb.0", "sysclk"),
+	CLK_LOOKUP(sysclk, "ab8500-codec.0", "sysclk"),
+	CLK_LOOKUP(ab_ulpclk, "ab8500-codec.0", "ulpclk"),
+	CLK_LOOKUP(audioclk, "ab8500-codec.0", "audioclk"),
+};
+
+static struct clk_lookup u8500_v2_sysclks[] = {
+	CLK_LOOKUP(sysclk2, NULL, "sysclk2"),
+	CLK_LOOKUP(sysclk3, NULL, "sysclk3"),
+	CLK_LOOKUP(sysclk4, NULL, "sysclk4"),
+};
+
+static struct clk_lookup u8500_common_prcmu_clocks[] = {
+	CLK_LOOKUP(sgaclk, "mali", NULL),
+	CLK_LOOKUP(uartclk, "UART", NULL),
+	CLK_LOOKUP(msp02clk, "MSP02", NULL),
+	CLK_LOOKUP(i2cclk, "I2C", NULL),
+	CLK_LOOKUP(sdmmcclk, "sdmmc", NULL),
+	CLK_LOOKUP(slimclk, "slim", NULL),
+	CLK_LOOKUP(per1clk, "PERIPH1", NULL),
+	CLK_LOOKUP(per2clk, "PERIPH2", NULL),
+	CLK_LOOKUP(per3clk, "PERIPH3", NULL),
+	CLK_LOOKUP(per5clk, "PERIPH5", NULL),
+	CLK_LOOKUP(per6clk, "PERIPH6", NULL),
+	CLK_LOOKUP(per7clk, "PERIPH7", NULL),
+	CLK_LOOKUP(lcdclk, "lcd", NULL),
+	CLK_LOOKUP(bmlclk, "bml", NULL),
+	CLK_LOOKUP(hsitxclk, "stm-hsi.0", NULL),
+	CLK_LOOKUP(hsirxclk, "stm-hsi.1", NULL),
+	CLK_LOOKUP(lcdclk, "mcde", "lcd"),
+	CLK_LOOKUP(hdmiclk, "hdmi", NULL),
+	CLK_LOOKUP(hdmiclk, "mcde", "hdmi"),
+	CLK_LOOKUP(apeatclk, "apeat", NULL),
+	CLK_LOOKUP(apetraceclk, "apetrace", NULL),
+	CLK_LOOKUP(mcdeclk, "mcde", NULL),
+	CLK_LOOKUP(mcdeclk, "mcde", "mcde"),
+	CLK_LOOKUP(ipi2cclk, "ipi2", NULL),
+	CLK_LOOKUP(dmaclk, "dma40.0", NULL),
+	CLK_LOOKUP(b2r2clk, "b2r2", NULL),
+	CLK_LOOKUP(b2r2clk, "b2r2_bus", NULL),
+	CLK_LOOKUP(b2r2clk, "U8500-B2R2.0", NULL),
+	CLK_LOOKUP(tvclk, "tv", NULL),
+	CLK_LOOKUP(tvclk, "mcde", "tv"),
+};
+
+static struct clk_lookup u8500_common_prcc_clocks[] = {
+	/* PERIPH 1 */
+	CLK_LOOKUP(p1_uart0_clk, "uart0", NULL),
+	CLK_LOOKUP(p1_uart1_clk, "uart1", NULL),
+	CLK_LOOKUP(p1_i2c1_clk, "nmk-i2c.1", NULL),
+	CLK_LOOKUP(p1_msp0_clk, "msp0", NULL),
+	CLK_LOOKUP(p1_msp0_clk, "MSP_I2S.0", NULL),
+	CLK_LOOKUP(p1_sdi0_clk, "sdi0", NULL),
+	CLK_LOOKUP(p1_i2c2_clk, "nmk-i2c.2", NULL),
+	CLK_LOOKUP(p1_slimbus0_clk, "slimbus0", NULL),
+	CLK_LOOKUP(p1_pclk9, "gpio.0", NULL),
+	CLK_LOOKUP(p1_pclk9, "gpio.1", NULL),
+	CLK_LOOKUP(p1_pclk9, "gpioblock0", NULL),
+
+	/* PERIPH 2 */
+	CLK_LOOKUP(p2_i2c3_clk, "nmk-i2c.3", NULL),
+	CLK_LOOKUP(p2_pclk1, "spi2", NULL),
+	CLK_LOOKUP(p2_pclk2, "spi1", NULL),
+	CLK_LOOKUP(p2_pclk3, "pwl", NULL),
+	CLK_LOOKUP(p2_sdi4_clk, "sdi4", NULL),
+
+	/* PERIPH 3 */
+	CLK_LOOKUP(p3_pclk0, "fsmc", NULL),
+	CLK_LOOKUP(p3_i2c0_clk, "nmk-i2c.0", NULL),
+	CLK_LOOKUP(p3_sdi2_clk, "sdi2", NULL),
+	CLK_LOOKUP(p3_ske_clk, "ske", NULL),
+	CLK_LOOKUP(p3_ske_clk, "nmk-ske-keypad", NULL),
+	CLK_LOOKUP(p3_uart2_clk, "uart2", NULL),
+	CLK_LOOKUP(p3_sdi5_clk, "sdi5", NULL),
+	CLK_LOOKUP(p3_pclk8, "gpio.2", NULL),
+	CLK_LOOKUP(p3_pclk8, "gpio.3", NULL),
+	CLK_LOOKUP(p3_pclk8, "gpio.4", NULL),
+	CLK_LOOKUP(p3_pclk8, "gpio.5", NULL),
+	CLK_LOOKUP(p3_pclk8, "gpioblock2", NULL),
+
+	/* PERIPH 5 */
+	CLK_LOOKUP(p5_pclk1, "gpio.8", NULL),
+	CLK_LOOKUP(p5_pclk1, "gpioblock3", NULL),
+
+	/* PERIPH 6 */
+	CLK_LOOKUP(p6_pclk1, "cryp0", NULL),
+	CLK_LOOKUP(p6_pclk2, "hash0", NULL),
+	CLK_LOOKUP(p6_pclk3, "pka", NULL),
+};
+
+static struct clk_lookup u8500_ed_prcc_clocks[] = {
+	/* PERIPH 1 */
+	CLK_LOOKUP(p1_msp1_ed_clk, "msp1", NULL),
+	CLK_LOOKUP(p1_msp1_ed_clk, "MSP_I2S.1", NULL),
+	CLK_LOOKUP(p1_pclk7, "spi3", NULL),
+
+	/* PERIPH 2 */
+	CLK_LOOKUP(p2_msp2_ed_clk, "msp2", NULL),
+	CLK_LOOKUP(p2_msp2_ed_clk, "MSP_I2S.2", NULL),
+	CLK_LOOKUP(p2_sdi1_ed_clk, "sdi1", NULL),
+	CLK_LOOKUP(p2_sdi3_ed_clk, "sdi3", NULL),
+	CLK_LOOKUP(p2_pclk9, "spi0", NULL),
+	CLK_LOOKUP(p2_pclk10, "ssirx", NULL),
+	CLK_LOOKUP(p2_pclk11, "ssitx", NULL),
+	CLK_LOOKUP(p2_pclk12, "gpio.6", NULL),
+	CLK_LOOKUP(p2_pclk12, "gpio.7", NULL),
+	CLK_LOOKUP(p2_pclk12, "gpioblock1", NULL),
+
+	/* PERIPH 3 */
+	CLK_LOOKUP(p3_ssp0_ed_clk, "ssp0", NULL),
+	CLK_LOOKUP(p3_ssp1_ed_clk, "ssp1", NULL),
+
+	/* PERIPH 5 */
+	CLK_LOOKUP(p5_usb_ed_clk, "musb_hdrc.0", "usb"),
+
+	/* PERIPH 6 */
+	CLK_LOOKUP(p6_rng_ed_clk, "rng", NULL),
+	CLK_LOOKUP(p6_pclk4, "cryp1", NULL),
+	CLK_LOOKUP(p6_pclk5, "hash1", NULL),
+	CLK_LOOKUP(p6_pclk6, "dmc", NULL),
+
+	/* PERIPH 7 */
+	CLK_LOOKUP(p7_pclk0, "cfgreg", NULL),
+	CLK_LOOKUP(p7_pclk1, "wdg", NULL),
+	CLK_LOOKUP(p7_mtu0_ed_clk, "mtu0", NULL),
+	CLK_LOOKUP(p7_mtu1_ed_clk, "mtu1", NULL),
+	CLK_LOOKUP(p7_pclk4, "tzpc0", NULL),
+};
+
+static struct clk_lookup u8500_v1_v2_prcmu_clocks[] = {
+	CLK_LOOKUP(msp1clk, "MSP1", NULL),
+	CLK_LOOKUP(dsialtclk, "dsialt", NULL),
+	CLK_LOOKUP(sspclk, "SSP", NULL),
+	CLK_LOOKUP(rngclk, "rngclk", NULL),
+	CLK_LOOKUP(uiccclk, "uicc", NULL),
+};
+
+static struct clk_lookup u8500_v1_v2_prcc_clocks[] = {
+	/* PERIPH 1 */
+	CLK_LOOKUP(p1_msp1_clk, "msp1", NULL),
+	CLK_LOOKUP(p1_msp1_clk, "MSP_I2S.1", NULL),
+	CLK_LOOKUP(p1_pclk7, "spi3", NULL),
+	CLK_LOOKUP(p1_i2c4_clk, "nmk-i2c.4", NULL),
+
+	/* PERIPH 2 */
+	CLK_LOOKUP(p2_msp2_clk, "msp2", NULL),
+	CLK_LOOKUP(p2_msp2_clk, "MSP_I2S.2", NULL),
+	CLK_LOOKUP(p2_sdi1_clk, "sdi1", NULL),
+	CLK_LOOKUP(p2_sdi3_clk, "sdi3", NULL),
+	CLK_LOOKUP(p2_pclk8, "spi0", NULL),
+	CLK_LOOKUP(p2_pclk9, "ssirx", NULL),
+	CLK_LOOKUP(p2_pclk10, "ssitx", NULL),
+	CLK_LOOKUP(p2_pclk11, "gpio.6", NULL),
+	CLK_LOOKUP(p2_pclk11, "gpio.7", NULL),
+	CLK_LOOKUP(p2_pclk11, "gpioblock1", NULL),
+
+	/* PERIPH 3 */
+	CLK_LOOKUP(p3_ssp0_clk, "ssp0", NULL),
+	CLK_LOOKUP(p3_ssp1_clk, "ssp1", NULL),
+
+	/* PERIPH 5 */
+	CLK_LOOKUP(p5_pclk0, "musb_hdrc.0", "usb"),
+
+	/* PERIPH 6 */
+	CLK_LOOKUP(p6_pclk5, "hash1", NULL),
+	CLK_LOOKUP(p6_pclk4, "cryp1", NULL),
+	CLK_LOOKUP(p6_rng_clk, "rng", NULL),
+};
+
+static struct clk_lookup u8500_v2_prcmu_clocks[] = {
+	CLK_LOOKUP(clkout0, "pri-cam", NULL),
+	CLK_LOOKUP(clkout1, "3-005c", NULL),
+	CLK_LOOKUP(clkout1, "3-005d", NULL),
+	CLK_LOOKUP(clkout1, "sec-cam", NULL),
+};
+
+static struct clk_lookup u8500_v2_prcc_clocks[] = {
+	/* PERIPH 1 */
+	CLK_LOOKUP(p1_msp3_clk, "msp3", NULL),
+	CLK_LOOKUP(p1_msp3_clk, "MSP_I2S.3", NULL),
+
+	/* PERIPH 6 */
+	CLK_LOOKUP(p6_pclk4, "hash1", NULL),
+	CLK_LOOKUP(p6_pclk4, "cryp1", NULL),
+	CLK_LOOKUP(p6_pclk5, "cfgreg", NULL),
+	CLK_LOOKUP(p6_mtu0_clk, "mtu0", NULL),
+	CLK_LOOKUP(p6_mtu1_clk, "mtu1", NULL),
+};
+
+/* these are the clocks which are default from the bootloader */
+static const char *u8500_boot_clk[] = {
+	"uart0",
+	"uart1",
+	"uart2",
+	"gpioblock0",
+	"gpioblock1",
+	"gpioblock2",
+	"gpioblock3",
+	"mtu0",
+	"mtu1",
+	"ssp0",
+	"ssp1",
+	"spi0",
+	"spi1",
+	"spi2",
+	"spi3",
+	"msp0",
+	"msp1",
+	"msp2",
+	"nmk-i2c.0",
+	"nmk-i2c.1",
+	"nmk-i2c.2",
+	"nmk-i2c.3",
+	"nmk-i2c.4",
+};
+
+static void sysclk_init_disable(struct work_struct *not_used)
+{
+	int i;
+
+	mutex_lock(&sysclk_mutex);
+
+	/* Enable SWAT  */
+	if (ab8500_sysctrl_set(AB8500_SWATCTRL, AB8500_SWATCTRL_SWATENABLE))
+		goto err_swat;
+
+	for (i = 0; i < ARRAY_SIZE(u8500_v2_sysclks); i++) {
+		struct clk *clk = u8500_v2_sysclks[i].clk;
+
+		/* Disable sysclks */
+		if (!clk->enabled && clk->cg_sel) {
+			if (ab8500_sysctrl_clear(AB8500_SYSULPCLKCTRL1,
+				(u8)clk->cg_sel))
+				goto err_sysclk;
+		}
+	}
+	goto unlock_and_exit;
+
+err_sysclk:
+	pr_err("clock: Disable %s failed", u8500_v2_sysclks[i].clk->name);
+	ab8500_sysctrl_clear(AB8500_SWATCTRL, AB8500_SWATCTRL_SWATENABLE);
+	goto unlock_and_exit;
+
+err_swat:
+	pr_err("clock: Enable SWAT failed");
+
+unlock_and_exit:
+	mutex_unlock(&sysclk_mutex);
+}
+
+static struct clk *boot_clks[ARRAY_SIZE(u8500_boot_clk)];
+
+/* we disable a majority of peripherals enabled by default
+ * but without drivers
+ */
+static int __init u8500_boot_clk_disable(void)
+{
+	unsigned int i = 0;
+
+	for (i = 0; i < ARRAY_SIZE(u8500_boot_clk); i++) {
+		if (!boot_clks[i])
+			continue;
+
+		clk_disable(boot_clks[i]);
+		clk_put(boot_clks[i]);
+	}
+
+	INIT_DELAYED_WORK(&sysclk_disable_work, sysclk_init_disable);
+	schedule_delayed_work(&sysclk_disable_work, 10 * HZ);
+
+	return 0;
+}
+late_initcall_sync(u8500_boot_clk_disable);
+
+static void u8500_amba_clk_enable(void)
+{
+	unsigned int i = 0;
+
+	writel(~0x0  & ~(1 << 9), __io_address(U8500_PER1_BASE + 0xF000
+					       + 0x04));
+	writel(~0x0, __io_address(U8500_PER1_BASE + 0xF000 + 0x0C));
+
+	writel(~0x0 & ~(1 << 11), __io_address(U8500_PER2_BASE + 0xF000
+					       + 0x04));
+	writel(~0x0, __io_address(U8500_PER2_BASE + 0xF000 + 0x0C));
+
+	/* GPIO,UART2 are enabled for booting */
+	writel(0xBF, __io_address(U8500_PER3_BASE + 0xF000 + 0x04));
+	writel(~0x0 & ~(1 << 6), __io_address(U8500_PER3_BASE + 0xF000
+					      + 0x0C));
+
+	for (i = 0; i < ARRAY_SIZE(u8500_boot_clk); i++) {
+		boot_clks[i] = clk_get_sys(u8500_boot_clk[i], NULL);
+		clk_enable(boot_clks[i]);
+	}
+}
+
+int __init db8500_clk_init(void)
+{
+	if (cpu_is_u8500ed()) {
+		pr_err("clock: U8500 ED is no longer supported.\n");
+		return -ENOSYS;
+	} else if (cpu_is_u8500v1()) {
+		pr_err("clock: U8500 V1 is no longer supported.\n");
+		return -ENOSYS;
+	} else if (cpu_is_u5500()) {
+		per6clk.rate = 26000000;
+		uartclk.rate = 36360000;
+	}
+
+	if (cpu_is_u5500() || ux500_is_svp()) {
+		sysclk_ops.enable = NULL;
+		sysclk_ops.disable = NULL;
+		prcmu_clk_ops.enable = NULL;
+		prcmu_clk_ops.disable = NULL;
+		prcmu_opp100_clk_ops.enable = NULL;
+		prcmu_opp100_clk_ops.disable = NULL;
+		prcc_pclk_ops.enable = NULL;
+		prcc_pclk_ops.disable = NULL;
+		prcc_kclk_ops.enable = NULL;
+		prcc_kclk_ops.disable = NULL;
+		clkout0_ops.enable = NULL;
+		clkout0_ops.disable = NULL;
+		clkout1_ops.enable = NULL;
+		clkout1_ops.disable = NULL;
+	}
+
+	clks_register(u8500_common_clock_sources,
+		ARRAY_SIZE(u8500_common_clock_sources));
+	clks_register(u8500_common_prcmu_clocks,
+		ARRAY_SIZE(u8500_common_prcmu_clocks));
+	clks_register(u8500_common_prcc_clocks,
+		ARRAY_SIZE(u8500_common_prcc_clocks));
+
+	if (cpu_is_u5500()) {
+		clks_register(u8500_ed_prcc_clocks,
+			ARRAY_SIZE(u8500_ed_prcc_clocks));
+	} else if (cpu_is_u8500v2()) {
+		clks_register(u8500_v2_sysclks,
+			ARRAY_SIZE(u8500_v2_sysclks));
+		clks_register(u8500_v1_v2_prcmu_clocks,
+			ARRAY_SIZE(u8500_v1_v2_prcmu_clocks));
+		clks_register(u8500_v2_prcmu_clocks,
+			ARRAY_SIZE(u8500_v2_prcmu_clocks));
+		clks_register(u8500_v1_v2_prcc_clocks,
+			ARRAY_SIZE(u8500_v1_v2_prcc_clocks));
+		clks_register(u8500_v2_prcc_clocks,
+			ARRAY_SIZE(u8500_v2_prcc_clocks));
+	}
+
+	if (cpu_is_u8500())
+		u8500_amba_clk_enable();
+
+	/*
+	 * The following clks are shared with secure world.
+	 * Currently this leads to a limitation where we need to
+	 * enable them at all times.
+	 */
+	clk_enable(&p6_pclk1);
+	clk_enable(&p6_pclk2);
+	clk_enable(&p6_pclk3);
+	if (cpu_is_u8500() && !ux500_is_svp())
+		clk_enable(&p6_rng_clk);
+
+	/*
+	 * APEATCLK and APETRACECLK are enabled at boot and needed
+	 * in order to debug with lauterbach
+	 */
+	clk_enable(&apeatclk);
+	clk_enable(&apetraceclk);
+#ifdef CONFIG_DEBUG_NO_LAUTERBACH
+	clk_disable(&apeatclk);
+	clk_disable(&apetraceclk);
+#endif
+	/* periph 7's clock is enabled at boot, but should be off */
+	clk_enable(&per7clk);
+	clk_disable(&per7clk);
+
+	/* the hsirx clock is enabled@boot, but should be off */
+	clk_enable(&hsirxclk);
+	clk_disable(&hsirxclk);
+
+	return 0;
+}
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 32ce908..9259373 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -7,784 +7,374 @@
  * published by the Free Software Foundation.
  */
 #include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
 #include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/clkdev.h>
+#include <linux/spinlock.h>
+#include <linux/mfd/ab8500/sysctrl.h>
+#include <mach/prcmu-fw-api.h>
 
-#include <plat/mtu.h>
-#include <mach/hardware.h>
 #include "clock.h"
 
-#ifdef CONFIG_DEBUG_FS
-#include <linux/debugfs.h>
-#include <linux/uaccess.h>	/* for copy_from_user */
-static LIST_HEAD(clk_list);
-#endif
-
-#define PRCC_PCKEN		0x00
-#define PRCC_PCKDIS		0x04
-#define PRCC_KCKEN		0x08
-#define PRCC_KCKDIS		0x0C
-
-#define PRCM_YYCLKEN0_MGT_SET	0x510
-#define PRCM_YYCLKEN1_MGT_SET	0x514
-#define PRCM_YYCLKEN0_MGT_CLR	0x518
-#define PRCM_YYCLKEN1_MGT_CLR	0x51C
-#define PRCM_YYCLKEN0_MGT_VAL	0x520
-#define PRCM_YYCLKEN1_MGT_VAL	0x524
-
-#define PRCM_SVAMMDSPCLK_MGT	0x008
-#define PRCM_SIAMMDSPCLK_MGT	0x00C
-#define PRCM_SGACLK_MGT		0x014
-#define PRCM_UARTCLK_MGT	0x018
-#define PRCM_MSP02CLK_MGT	0x01C
-#define PRCM_MSP1CLK_MGT	0x288
-#define PRCM_I2CCLK_MGT		0x020
-#define PRCM_SDMMCCLK_MGT	0x024
-#define PRCM_SLIMCLK_MGT	0x028
-#define PRCM_PER1CLK_MGT	0x02C
-#define PRCM_PER2CLK_MGT	0x030
-#define PRCM_PER3CLK_MGT	0x034
-#define PRCM_PER5CLK_MGT	0x038
-#define PRCM_PER6CLK_MGT	0x03C
-#define PRCM_PER7CLK_MGT	0x040
-#define PRCM_LCDCLK_MGT		0x044
-#define PRCM_BMLCLK_MGT		0x04C
-#define PRCM_HSITXCLK_MGT	0x050
-#define PRCM_HSIRXCLK_MGT	0x054
-#define PRCM_HDMICLK_MGT	0x058
-#define PRCM_APEATCLK_MGT	0x05C
-#define PRCM_APETRACECLK_MGT	0x060
-#define PRCM_MCDECLK_MGT	0x064
-#define PRCM_IPI2CCLK_MGT	0x068
-#define PRCM_DSIALTCLK_MGT	0x06C
-#define PRCM_DMACLK_MGT		0x074
-#define PRCM_B2R2CLK_MGT	0x078
-#define PRCM_TVCLK_MGT		0x07C
-#define PRCM_TCR		0x1C8
-#define PRCM_TCR_STOPPED	(1 << 16)
-#define PRCM_TCR_DOZE_MODE	(1 << 17)
-#define PRCM_UNIPROCLK_MGT	0x278
-#define PRCM_SSPCLK_MGT		0x280
-#define PRCM_RNGCLK_MGT		0x284
-#define PRCM_UICCCLK_MGT	0x27C
-
-#define PRCM_MGT_ENABLE		(1 << 8)
-
-static DEFINE_SPINLOCK(clocks_lock);
-
-static void __clk_enable(struct clk *clk)
-{
-	if (clk->enabled++ == 0) {
-		if (clk->parent_cluster)
-			__clk_enable(clk->parent_cluster);
+#define PRCC_PCKEN 0x0
+#define PRCC_PCKDIS 0x4
+#define PRCC_KCKEN 0x8
+#define PRCC_KCKDIS 0xC
+#define PRCC_PCKSR 0x10
+#define PRCC_KCKSR 0x14
+
+DEFINE_MUTEX(clk_opp100_mutex);
+static DEFINE_SPINLOCK(clk_spin_lock);
+#define NO_LOCK &clk_spin_lock
 
-		if (clk->parent_periph)
-			__clk_enable(clk->parent_periph);
+static void __iomem *prcmu_base;
 
-		if (clk->ops && clk->ops->enable)
-			clk->ops->enable(clk);
+static void __clk_lock(struct clk *clk, void *last_lock, unsigned long *flags)
+{
+	if (clk->mutex != last_lock) {
+		if (clk->mutex == NULL)
+			spin_lock_irqsave(&clk_spin_lock, *flags);
+		else
+			mutex_lock(clk->mutex);
 	}
 }
 
-int clk_enable(struct clk *clk)
+static void __clk_unlock(struct clk *clk, void *last_lock, unsigned long flags)
+{
+	if (clk->mutex != last_lock) {
+		if (clk->mutex == NULL)
+			spin_unlock_irqrestore(&clk_spin_lock, flags);
+		else
+			mutex_unlock(clk->mutex);
+	}
+}
+
+static void __clk_disable(struct clk *clk, void *current_lock)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&clocks_lock, flags);
-	__clk_enable(clk);
-	spin_unlock_irqrestore(&clocks_lock, flags);
+	if (clk == NULL)
+		return;
 
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
+	__clk_lock(clk, current_lock, &flags);
 
-static void __clk_disable(struct clk *clk)
-{
-	if (--clk->enabled == 0) {
-		if (clk->ops && clk->ops->disable)
+	if (clk->enabled && (--clk->enabled == 0)) {
+		if ((clk->ops != NULL) && (clk->ops->disable != NULL))
 			clk->ops->disable(clk);
+		__clk_disable(clk->parent, clk->mutex);
+		__clk_disable(clk->bus_parent, clk->mutex);
+	}
 
-		if (clk->parent_periph)
-			__clk_disable(clk->parent_periph);
+	__clk_unlock(clk, current_lock, flags);
 
-		if (clk->parent_cluster)
-			__clk_disable(clk->parent_cluster);
-	}
+	return;
 }
 
-void clk_disable(struct clk *clk)
+static int __clk_enable(struct clk *clk, void *current_lock)
 {
+	int err;
 	unsigned long flags;
 
-	WARN_ON(!clk->enabled);
+	if (clk == NULL)
+		return 0;
 
-	spin_lock_irqsave(&clocks_lock, flags);
-	__clk_disable(clk);
-	spin_unlock_irqrestore(&clocks_lock, flags);
-}
-EXPORT_SYMBOL(clk_disable);
+	__clk_lock(clk, current_lock, &flags);
 
-/*
- * The MTU has a separate, rather complex muxing setup
- * with alternative parents (peripheral cluster or
- * ULP or fixed 32768 Hz) depending on settings
- */
-static unsigned long clk_mtu_get_rate(struct clk *clk)
-{
-	void __iomem *addr;
-	u32 tcr;
-	int mtu = (int) clk->data;
-	/*
-	 * One of these is selected eventually
-	 * TODO: Replace the constant with a reference
-	 * to the ULP source once this is modeled.
-	 */
-	unsigned long clk32k = 32768;
-	unsigned long mturate;
-	unsigned long retclk;
-
-	if (cpu_is_u5500())
-		addr = __io_address(U5500_PRCMU_BASE);
-	else if (cpu_is_u8500())
-		addr = __io_address(U8500_PRCMU_BASE);
-	else
-		ux500_unknown_soc();
+	if (!clk->enabled) {
+		err = __clk_enable(clk->bus_parent, clk->mutex);
+		if (unlikely(err))
+			goto bus_parent_error;
 
-	/*
-	 * On a startup, always conifgure the TCR to the doze mode;
-	 * bootloaders do it for us. Do this in the kernel too.
-	 */
-	writel(PRCM_TCR_DOZE_MODE, addr + PRCM_TCR);
+		err = __clk_enable(clk->parent, clk->mutex);
+		if (unlikely(err))
+			goto parent_error;
 
-	tcr = readl(addr + PRCM_TCR);
+		if ((clk->ops != NULL) && (clk->ops->enable != NULL)) {
+			err = clk->ops->enable(clk);
+			if (unlikely(err))
+				goto enable_error;
+		}
+	}
+	clk->enabled++;
 
-	/* Get the rate from the parent as a default */
-	if (clk->parent_periph)
-		mturate = clk_get_rate(clk->parent_periph);
-	else if (clk->parent_cluster)
-		mturate = clk_get_rate(clk->parent_cluster);
-	else
-		/* We need to be connected SOMEWHERE */
-		BUG();
+	__clk_unlock(clk, current_lock, flags);
 
-	/* Return the clock selected for this MTU */
-	if (tcr & (1 << mtu))
-		retclk = clk32k;
-	else
-		retclk = mturate;
+	return 0;
 
-	pr_info("MTU%d clock rate: %lu Hz\n", mtu, retclk);
-	return retclk;
+enable_error:
+	__clk_disable(clk->parent, clk->mutex);
+parent_error:
+	__clk_disable(clk->bus_parent, clk->mutex);
+bus_parent_error:
+
+	__clk_unlock(clk, current_lock, flags);
+
+	return err;
 }
 
-unsigned long clk_get_rate(struct clk *clk)
+unsigned long __clk_get_rate(struct clk *clk, void *current_lock)
 {
 	unsigned long rate;
+	unsigned long flags;
 
-	/*
-	 * If there is a custom getrate callback for this clock,
-	 * it will take precedence.
-	 */
-	if (clk->get_rate)
-		return clk->get_rate(clk);
-
-	if (clk->ops && clk->ops->get_rate)
-		return clk->ops->get_rate(clk);
-
-	rate = clk->rate;
-	if (!rate) {
-		if (clk->parent_periph)
-			rate = clk_get_rate(clk->parent_periph);
-		else if (clk->parent_cluster)
-			rate = clk_get_rate(clk->parent_cluster);
-	}
+	if (clk == NULL)
+		return 0;
 
-	return rate;
-}
-EXPORT_SYMBOL(clk_get_rate);
+	__clk_lock(clk, current_lock, &flags);
+
+	if ((clk->ops != NULL) && (clk->ops->get_rate != NULL))
+		rate = clk->ops->get_rate(clk);
+	else if (clk->rate)
+		rate = clk->rate;
+	else
+		rate = __clk_get_rate(clk->parent, clk->mutex);
+
+	__clk_unlock(clk, current_lock, flags);
 
-long clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	/*TODO*/
 	return rate;
 }
-EXPORT_SYMBOL(clk_round_rate);
 
-int clk_set_rate(struct clk *clk, unsigned long rate)
+static unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	clk->rate = rate;
-	return 0;
+	if ((clk->ops != NULL) && (clk->ops->round_rate != NULL))
+		return clk->ops->round_rate(clk, rate);
+
+	return -ENOSYS;
 }
-EXPORT_SYMBOL(clk_set_rate);
 
-static void clk_prcmu_enable(struct clk *clk)
+static int __clk_set_rate(struct clk *clk, unsigned long rate)
 {
-	void __iomem *cg_set_reg = __io_address(U8500_PRCMU_BASE)
-				   + PRCM_YYCLKEN0_MGT_SET + clk->prcmu_cg_off;
+	if ((clk->ops != NULL) && (clk->ops->set_rate != NULL))
+		return clk->ops->set_rate(clk, rate);
 
-	writel(1 << clk->prcmu_cg_bit, cg_set_reg);
+	return -ENOSYS;
 }
 
-static void clk_prcmu_disable(struct clk *clk)
+int clk_enable(struct clk *clk)
 {
-	void __iomem *cg_clr_reg = __io_address(U8500_PRCMU_BASE)
-				   + PRCM_YYCLKEN0_MGT_CLR + clk->prcmu_cg_off;
+	if (clk == NULL)
+		return -EINVAL;
 
-	writel(1 << clk->prcmu_cg_bit, cg_clr_reg);
+	return __clk_enable(clk, NO_LOCK);
 }
+EXPORT_SYMBOL(clk_enable);
 
-/* ED doesn't have the combined set/clr registers */
-static void clk_prcmu_ed_enable(struct clk *clk)
+void clk_disable(struct clk *clk)
 {
-	void __iomem *addr = __io_address(U8500_PRCMU_BASE)
-			     + clk->prcmu_cg_mgt;
 
-	writel(readl(addr) | PRCM_MGT_ENABLE, addr);
+	if (clk == NULL)
+		return;
+
+	WARN_ON(!clk->enabled);
+	__clk_disable(clk, NO_LOCK);
 }
+EXPORT_SYMBOL(clk_disable);
 
-static void clk_prcmu_ed_disable(struct clk *clk)
+unsigned long clk_get_rate(struct clk *clk)
 {
-	void __iomem *addr = __io_address(U8500_PRCMU_BASE)
-			     + clk->prcmu_cg_mgt;
+	if (clk == NULL)
+		return 0;
 
-	writel(readl(addr) & ~PRCM_MGT_ENABLE, addr);
+	return __clk_get_rate(clk, NO_LOCK);
 }
+EXPORT_SYMBOL(clk_get_rate);
 
-static struct clkops clk_prcmu_ops = {
-	.enable = clk_prcmu_enable,
-	.disable = clk_prcmu_disable,
-};
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long flags;
 
-static unsigned int clkrst_base[] = {
-	[1] = U8500_CLKRST1_BASE,
-	[2] = U8500_CLKRST2_BASE,
-	[3] = U8500_CLKRST3_BASE,
-	[5] = U8500_CLKRST5_BASE,
-	[6] = U8500_CLKRST6_BASE,
-	[7] = U8500_CLKRST7_BASE_ED,
-};
+	if (clk == NULL)
+		return -EINVAL;
 
-static void clk_prcc_enable(struct clk *clk)
-{
-	void __iomem *addr = __io_address(clkrst_base[clk->cluster]);
+	__clk_lock(clk, NO_LOCK, &flags);
 
-	if (clk->prcc_kernel != -1)
-		writel(1 << clk->prcc_kernel, addr + PRCC_KCKEN);
+	rate = __clk_round_rate(clk, rate);
 
-	if (clk->prcc_bus != -1)
-		writel(1 << clk->prcc_bus, addr + PRCC_PCKEN);
+	__clk_unlock(clk, NO_LOCK, flags);
+
+	return rate;
 }
+EXPORT_SYMBOL(clk_round_rate);
 
-static void clk_prcc_disable(struct clk *clk)
+int clk_set_rate(struct clk *clk, unsigned long rate)
 {
-	void __iomem *addr = __io_address(clkrst_base[clk->cluster]);
+	int err;
+	unsigned long flags;
 
-	if (clk->prcc_bus != -1)
-		writel(1 << clk->prcc_bus, addr + PRCC_PCKDIS);
+	if (clk == NULL)
+		return -EINVAL;
 
-	if (clk->prcc_kernel != -1)
-		writel(1 << clk->prcc_kernel, addr + PRCC_KCKDIS);
-}
+	__clk_lock(clk, NO_LOCK, &flags);
 
-static struct clkops clk_prcc_ops = {
-	.enable = clk_prcc_enable,
-	.disable = clk_prcc_disable,
-};
+	err =  __clk_set_rate(clk, rate);
 
-static struct clk clk_32khz = {
-	.name =  "clk_32khz",
-	.rate = 32000,
-};
+	__clk_unlock(clk, NO_LOCK, flags);
 
-/*
- * PRCMU level clock gating
- */
+	return err;
+}
+EXPORT_SYMBOL(clk_set_rate);
 
-/* Bank 0 */
-static DEFINE_PRCMU_CLK(svaclk,		0x0, 2, SVAMMDSPCLK);
-static DEFINE_PRCMU_CLK(siaclk,		0x0, 3, SIAMMDSPCLK);
-static DEFINE_PRCMU_CLK(sgaclk,		0x0, 4, SGACLK);
-static DEFINE_PRCMU_CLK_RATE(uartclk,	0x0, 5, UARTCLK, 38400000);
-static DEFINE_PRCMU_CLK(msp02clk,	0x0, 6, MSP02CLK);
-static DEFINE_PRCMU_CLK(msp1clk,	0x0, 7, MSP1CLK); /* v1 */
-static DEFINE_PRCMU_CLK_RATE(i2cclk,	0x0, 8, I2CCLK, 48000000);
-static DEFINE_PRCMU_CLK_RATE(sdmmcclk,	0x0, 9, SDMMCCLK, 100000000);
-static DEFINE_PRCMU_CLK(slimclk,	0x0, 10, SLIMCLK);
-static DEFINE_PRCMU_CLK(per1clk,	0x0, 11, PER1CLK);
-static DEFINE_PRCMU_CLK(per2clk,	0x0, 12, PER2CLK);
-static DEFINE_PRCMU_CLK(per3clk,	0x0, 13, PER3CLK);
-static DEFINE_PRCMU_CLK(per5clk,	0x0, 14, PER5CLK);
-static DEFINE_PRCMU_CLK_RATE(per6clk,	0x0, 15, PER6CLK, 133330000);
-static DEFINE_PRCMU_CLK_RATE(per7clk,	0x0, 16, PER7CLK, 100000000);
-static DEFINE_PRCMU_CLK(lcdclk,		0x0, 17, LCDCLK);
-static DEFINE_PRCMU_CLK(bmlclk,		0x0, 18, BMLCLK);
-static DEFINE_PRCMU_CLK(hsitxclk,	0x0, 19, HSITXCLK);
-static DEFINE_PRCMU_CLK(hsirxclk,	0x0, 20, HSIRXCLK);
-static DEFINE_PRCMU_CLK(hdmiclk,	0x0, 21, HDMICLK);
-static DEFINE_PRCMU_CLK(apeatclk,	0x0, 22, APEATCLK);
-static DEFINE_PRCMU_CLK(apetraceclk,	0x0, 23, APETRACECLK);
-static DEFINE_PRCMU_CLK(mcdeclk,	0x0, 24, MCDECLK);
-static DEFINE_PRCMU_CLK(ipi2clk,	0x0, 25, IPI2CCLK);
-static DEFINE_PRCMU_CLK(dsialtclk,	0x0, 26, DSIALTCLK); /* v1 */
-static DEFINE_PRCMU_CLK(dmaclk,		0x0, 27, DMACLK);
-static DEFINE_PRCMU_CLK(b2r2clk,	0x0, 28, B2R2CLK);
-static DEFINE_PRCMU_CLK(tvclk,		0x0, 29, TVCLK);
-static DEFINE_PRCMU_CLK(uniproclk,	0x0, 30, UNIPROCLK); /* v1 */
-static DEFINE_PRCMU_CLK_RATE(sspclk,	0x0, 31, SSPCLK, 48000000); /* v1 */
-
-/* Bank 1 */
-static DEFINE_PRCMU_CLK(rngclk,		0x4, 0, RNGCLK); /* v1 */
-static DEFINE_PRCMU_CLK(uiccclk,	0x4, 1, UICCCLK); /* v1 */
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	int err = -EINVAL;
+	unsigned long flags;
+	struct clk **p;
 
-/*
- * PRCC level clock gating
- * Format: per#, clk, PCKEN bit, KCKEN bit, parent
- */
+	if ((clk == NULL) || (clk->parents == NULL))
+		return -EINVAL;
+	for (p = clk->parents; *p != parent; p++) {
+		if (*p == NULL) /* invalid parent */
+			return -EINVAL;
+	}
 
-/* Peripheral Cluster #1 */
-static DEFINE_PRCC_CLK(1, i2c4,		10, 9, &clk_i2cclk);
-static DEFINE_PRCC_CLK(1, gpio0,	9, -1, NULL);
-static DEFINE_PRCC_CLK(1, slimbus0,	8,  8, &clk_slimclk);
-static DEFINE_PRCC_CLK(1, spi3_ed,	7,  7, NULL);
-static DEFINE_PRCC_CLK(1, spi3_v1,	7, -1, NULL);
-static DEFINE_PRCC_CLK(1, i2c2,		6,  6, &clk_i2cclk);
-static DEFINE_PRCC_CLK(1, sdi0,		5,  5, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(1, msp1_ed,	4,  4, &clk_msp02clk);
-static DEFINE_PRCC_CLK(1, msp1_v1,	4,  4, &clk_msp1clk);
-static DEFINE_PRCC_CLK(1, msp0,		3,  3, &clk_msp02clk);
-static DEFINE_PRCC_CLK(1, i2c1,		2,  2, &clk_i2cclk);
-static DEFINE_PRCC_CLK(1, uart1,	1,  1, &clk_uartclk);
-static DEFINE_PRCC_CLK(1, uart0,	0,  0, &clk_uartclk);
-
-/* Peripheral Cluster #2 */
-
-static DEFINE_PRCC_CLK(2, gpio1_ed,	12, -1, NULL);
-static DEFINE_PRCC_CLK(2, ssitx_ed,	11, -1, NULL);
-static DEFINE_PRCC_CLK(2, ssirx_ed,	10, -1, NULL);
-static DEFINE_PRCC_CLK(2, spi0_ed,	 9, -1, NULL);
-static DEFINE_PRCC_CLK(2, sdi3_ed,	 8,  6, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(2, sdi1_ed,	 7,  5, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(2, msp2_ed,	 6,  4, &clk_msp02clk);
-static DEFINE_PRCC_CLK(2, sdi4_ed,	 4,  2, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(2, pwl_ed,	 3,  1, NULL);
-static DEFINE_PRCC_CLK(2, spi1_ed,	 2, -1, NULL);
-static DEFINE_PRCC_CLK(2, spi2_ed,	 1, -1, NULL);
-static DEFINE_PRCC_CLK(2, i2c3_ed,	 0,  0, &clk_i2cclk);
-
-static DEFINE_PRCC_CLK(2, gpio1_v1,	11, -1, NULL);
-static DEFINE_PRCC_CLK(2, ssitx_v1,	10,  7, NULL);
-static DEFINE_PRCC_CLK(2, ssirx_v1,	 9,  6, NULL);
-static DEFINE_PRCC_CLK(2, spi0_v1,	 8, -1, NULL);
-static DEFINE_PRCC_CLK(2, sdi3_v1,	 7,  5, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(2, sdi1_v1,	 6,  4, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(2, msp2_v1,	 5,  3, &clk_msp02clk);
-static DEFINE_PRCC_CLK(2, sdi4_v1,	 4,  2, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(2, pwl_v1,	 3,  1, NULL);
-static DEFINE_PRCC_CLK(2, spi1_v1,	 2, -1, NULL);
-static DEFINE_PRCC_CLK(2, spi2_v1,	 1, -1, NULL);
-static DEFINE_PRCC_CLK(2, i2c3_v1,	 0,  0, &clk_i2cclk);
-
-/* Peripheral Cluster #3 */
-static DEFINE_PRCC_CLK(3, gpio2,	8, -1, NULL);
-static DEFINE_PRCC_CLK(3, sdi5,		7,  7, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(3, uart2,	6,  6, &clk_uartclk);
-static DEFINE_PRCC_CLK(3, ske,		5,  5, &clk_32khz);
-static DEFINE_PRCC_CLK(3, sdi2,		4,  4, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(3, i2c0,		3,  3, &clk_i2cclk);
-static DEFINE_PRCC_CLK(3, ssp1_ed,	2,  2, &clk_i2cclk);
-static DEFINE_PRCC_CLK(3, ssp0_ed,	1,  1, &clk_i2cclk);
-static DEFINE_PRCC_CLK(3, ssp1_v1,	2,  2, &clk_sspclk);
-static DEFINE_PRCC_CLK(3, ssp0_v1,	1,  1, &clk_sspclk);
-static DEFINE_PRCC_CLK(3, fsmc,		0, -1, NULL);
-
-/* Peripheral Cluster #4 is in the always on domain */
-
-/* Peripheral Cluster #5 */
-static DEFINE_PRCC_CLK(5, gpio3,	1, -1, NULL);
-static DEFINE_PRCC_CLK(5, usb_ed,	0,  0, &clk_i2cclk);
-static DEFINE_PRCC_CLK(5, usb_v1,	0,  0, NULL);
-
-/* Peripheral Cluster #6 */
-
-/* MTU ID in data */
-static DEFINE_PRCC_CLK_CUSTOM(6, mtu1_v1, 8, -1, NULL, clk_mtu_get_rate, 1);
-static DEFINE_PRCC_CLK_CUSTOM(6, mtu0_v1, 7, -1, NULL, clk_mtu_get_rate, 0);
-static DEFINE_PRCC_CLK(6, cfgreg_v1,	6,  6, NULL);
-static DEFINE_PRCC_CLK(6, dmc_ed,	6,  6, NULL);
-static DEFINE_PRCC_CLK(6, hash1,	5, -1, NULL);
-static DEFINE_PRCC_CLK(6, unipro_v1,	4,  1, &clk_uniproclk);
-static DEFINE_PRCC_CLK(6, cryp1_ed,	4, -1, NULL);
-static DEFINE_PRCC_CLK(6, pka,		3, -1, NULL);
-static DEFINE_PRCC_CLK(6, hash0,	2, -1, NULL);
-static DEFINE_PRCC_CLK(6, cryp0,	1, -1, NULL);
-static DEFINE_PRCC_CLK(6, rng_ed,	0,  0, &clk_i2cclk);
-static DEFINE_PRCC_CLK(6, rng_v1,	0,  0, &clk_rngclk);
-
-/* Peripheral Cluster #7 */
-
-static DEFINE_PRCC_CLK(7, tzpc0_ed,	4, -1, NULL);
-/* MTU ID in data */
-static DEFINE_PRCC_CLK_CUSTOM(7, mtu1_ed, 3, -1, NULL, clk_mtu_get_rate, 1);
-static DEFINE_PRCC_CLK_CUSTOM(7, mtu0_ed, 2, -1, NULL, clk_mtu_get_rate, 0);
-static DEFINE_PRCC_CLK(7, wdg_ed,	1, -1, NULL);
-static DEFINE_PRCC_CLK(7, cfgreg_ed,	0, -1, NULL);
-
-static struct clk clk_dummy_apb_pclk = {
-	.name = "apb_pclk",
-};
+	__clk_lock(clk, NO_LOCK, &flags);
 
-static struct clk_lookup u8500_common_clks[] = {
-	CLK(dummy_apb_pclk, NULL,	"apb_pclk"),
-
-	/* Peripheral Cluster #1 */
-	CLK(gpio0,	"gpio.0",	NULL),
-	CLK(gpio0,	"gpio.1",	NULL),
-	CLK(slimbus0,	"slimbus0",	NULL),
-	CLK(i2c2,	"nmk-i2c.2",	NULL),
-	CLK(sdi0,	"sdi0",		NULL),
-	CLK(msp0,	"msp0",		NULL),
-	CLK(i2c1,	"nmk-i2c.1",	NULL),
-	CLK(uart1,	"uart1",	NULL),
-	CLK(uart0,	"uart0",	NULL),
-
-	/* Peripheral Cluster #3 */
-	CLK(gpio2,	"gpio.2",	NULL),
-	CLK(gpio2,	"gpio.3",	NULL),
-	CLK(gpio2,	"gpio.4",	NULL),
-	CLK(gpio2,	"gpio.5",	NULL),
-	CLK(sdi5,	"sdi5",		NULL),
-	CLK(uart2,	"uart2",	NULL),
-	CLK(ske,	"ske",		NULL),
-	CLK(ske,	"nmk-ske-keypad",	NULL),
-	CLK(sdi2,	"sdi2",		NULL),
-	CLK(i2c0,	"nmk-i2c.0",	NULL),
-	CLK(fsmc,	"fsmc",		NULL),
-
-	/* Peripheral Cluster #5 */
-	CLK(gpio3,	"gpio.8",	NULL),
-
-	/* Peripheral Cluster #6 */
-	CLK(hash1,	"hash1",	NULL),
-	CLK(pka,	"pka",		NULL),
-	CLK(hash0,	"hash0",	NULL),
-	CLK(cryp0,	"cryp0",	NULL),
-
-	/* PRCMU level clock gating */
-
-	/* Bank 0 */
-	CLK(svaclk,	"sva",		NULL),
-	CLK(siaclk,	"sia",		NULL),
-	CLK(sgaclk,	"sga",		NULL),
-	CLK(slimclk,	"slim",		NULL),
-	CLK(lcdclk,	"lcd",		NULL),
-	CLK(bmlclk,	"bml",		NULL),
-	CLK(hsitxclk,	"stm-hsi.0",	NULL),
-	CLK(hsirxclk,	"stm-hsi.1",	NULL),
-	CLK(hdmiclk,	"hdmi",		NULL),
-	CLK(apeatclk,	"apeat",	NULL),
-	CLK(apetraceclk,	"apetrace",	NULL),
-	CLK(mcdeclk,	"mcde",		NULL),
-	CLK(ipi2clk,	"ipi2",		NULL),
-	CLK(dmaclk,	"dma40.0",	NULL),
-	CLK(b2r2clk,	"b2r2",		NULL),
-	CLK(tvclk,	"tv",		NULL),
-};
+	if (clk->enabled) {
+		err = -EINVAL;
+	} else {
+		if ((clk->ops != NULL) && (clk->ops->set_parent != NULL))
+			err = clk->ops->set_parent(clk, parent);
+		if (!err)
+			clk->parent = parent;
+	}
 
-static struct clk_lookup u8500_ed_clks[] = {
-	/* Peripheral Cluster #1 */
-	CLK(spi3_ed,	"spi3",		NULL),
-	CLK(msp1_ed,	"msp1",		NULL),
-
-	/* Peripheral Cluster #2 */
-	CLK(gpio1_ed,	"gpio.6",	NULL),
-	CLK(gpio1_ed,	"gpio.7",	NULL),
-	CLK(ssitx_ed,	"ssitx",	NULL),
-	CLK(ssirx_ed,	"ssirx",	NULL),
-	CLK(spi0_ed,	"spi0",		NULL),
-	CLK(sdi3_ed,	"sdi3",		NULL),
-	CLK(sdi1_ed,	"sdi1",		NULL),
-	CLK(msp2_ed,	"msp2",		NULL),
-	CLK(sdi4_ed,	"sdi4",		NULL),
-	CLK(pwl_ed,	"pwl",		NULL),
-	CLK(spi1_ed,	"spi1",		NULL),
-	CLK(spi2_ed,	"spi2",		NULL),
-	CLK(i2c3_ed,	"nmk-i2c.3",	NULL),
-
-	/* Peripheral Cluster #3 */
-	CLK(ssp1_ed,	"ssp1",		NULL),
-	CLK(ssp0_ed,	"ssp0",		NULL),
-
-	/* Peripheral Cluster #5 */
-	CLK(usb_ed,	"musb-ux500.0",	"usb"),
-
-	/* Peripheral Cluster #6 */
-	CLK(dmc_ed,	"dmc",		NULL),
-	CLK(cryp1_ed,	"cryp1",	NULL),
-	CLK(rng_ed,	"rng",		NULL),
-
-	/* Peripheral Cluster #7 */
-	CLK(tzpc0_ed,	"tzpc0",	NULL),
-	CLK(mtu1_ed,	"mtu1",		NULL),
-	CLK(mtu0_ed,	"mtu0",		NULL),
-	CLK(wdg_ed,	"wdg",		NULL),
-	CLK(cfgreg_ed,	"cfgreg",	NULL),
-};
+	__clk_unlock(clk, NO_LOCK, flags);
 
-static struct clk_lookup u8500_v1_clks[] = {
-	/* Peripheral Cluster #1 */
-	CLK(i2c4,	"nmk-i2c.4",	NULL),
-	CLK(spi3_v1,	"spi3",		NULL),
-	CLK(msp1_v1,	"msp1",		NULL),
-
-	/* Peripheral Cluster #2 */
-	CLK(gpio1_v1,	"gpio.6",	NULL),
-	CLK(gpio1_v1,	"gpio.7",	NULL),
-	CLK(ssitx_v1,	"ssitx",	NULL),
-	CLK(ssirx_v1,	"ssirx",	NULL),
-	CLK(spi0_v1,	"spi0",		NULL),
-	CLK(sdi3_v1,	"sdi3",		NULL),
-	CLK(sdi1_v1,	"sdi1",		NULL),
-	CLK(msp2_v1,	"msp2",		NULL),
-	CLK(sdi4_v1,	"sdi4",		NULL),
-	CLK(pwl_v1,	"pwl",		NULL),
-	CLK(spi1_v1,	"spi1",		NULL),
-	CLK(spi2_v1,	"spi2",		NULL),
-	CLK(i2c3_v1,	"nmk-i2c.3",	NULL),
-
-	/* Peripheral Cluster #3 */
-	CLK(ssp1_v1,	"ssp1",		NULL),
-	CLK(ssp0_v1,	"ssp0",		NULL),
-
-	/* Peripheral Cluster #5 */
-	CLK(usb_v1,	"musb-ux500.0",	"usb"),
-
-	/* Peripheral Cluster #6 */
-	CLK(mtu1_v1,	"mtu1",		NULL),
-	CLK(mtu0_v1,	"mtu0",		NULL),
-	CLK(cfgreg_v1,	"cfgreg",	NULL),
-	CLK(hash1,	"hash1",	NULL),
-	CLK(unipro_v1,	"unipro",	NULL),
-	CLK(rng_v1,	"rng",		NULL),
-
-	/* PRCMU level clock gating */
-
-	/* Bank 0 */
-	CLK(uniproclk,	"uniproclk",	NULL),
-	CLK(dsialtclk,	"dsialt",	NULL),
-
-	/* Bank 1 */
-	CLK(rngclk,	"rng",		NULL),
-	CLK(uiccclk,	"uicc",		NULL),
-};
+	return err;
+}
 
-#ifdef CONFIG_DEBUG_FS
-/*
- *	debugfs support to trace clock tree hierarchy and attributes with
- *	powerdebug
- */
-static struct dentry *clk_debugfs_root;
+/* PRCMU clock operations. */
 
-void __init clk_debugfs_add_table(struct clk_lookup *cl, size_t num)
+static int prcmu_clk_enable(struct clk *clk)
 {
-	while (num--) {
-		/* Check that the clock has not been already registered */
-		if (!(cl->clk->list.prev != cl->clk->list.next))
-			list_add_tail(&cl->clk->list, &clk_list);
+	return prcmu_request_clock(clk->cg_sel, true);
+}
 
-		cl++;
+static void prcmu_clk_disable(struct clk *clk)
+{
+	if (prcmu_request_clock(clk->cg_sel, false)) {
+		pr_err("clock: %s failed to disable %s.\n", __func__,
+			clk->name);
 	}
 }
 
-static ssize_t usecount_dbg_read(struct file *file, char __user *buf,
-						  size_t size, loff_t *off)
+static int request_ape_opp100(bool enable)
 {
-	struct clk *clk = file->f_dentry->d_inode->i_private;
-	char cusecount[128];
-	unsigned int len;
+	static unsigned int requests;
+
+	if (enable) {
+	       if (0 == requests++) {
+		       return prcmu_qos_add_requirement(PRCMU_QOS_APE_OPP,
+			       "clock", 100);
+	       }
+	} else if (1 == requests--) {
+		prcmu_qos_remove_requirement(PRCMU_QOS_APE_OPP, "clock");
+	}
+	return 0;
+}
+
+static int prcmu_opp100_clk_enable(struct clk *clk)
+{
+	int r;
 
-	len = sprintf(cusecount, "%u\n", clk->enabled);
-	return simple_read_from_buffer(buf, size, off, cusecount, len);
+	r = request_ape_opp100(true);
+	if (r) {
+		pr_err("clock: %s failed to request APE OPP 100%% for %s.\n",
+			__func__, clk->name);
+		return r;
+	}
+	return prcmu_request_clock(clk->cg_sel, true);
 }
 
-static ssize_t rate_dbg_read(struct file *file, char __user *buf,
-					  size_t size, loff_t *off)
+static void prcmu_opp100_clk_disable(struct clk *clk)
 {
-	struct clk *clk = file->f_dentry->d_inode->i_private;
-	char crate[128];
-	unsigned int rate;
-	unsigned int len;
-
-	rate = clk_get_rate(clk);
-	len = sprintf(crate, "%u\n", rate);
-	return simple_read_from_buffer(buf, size, off, crate, len);
+	if (prcmu_request_clock(clk->cg_sel, false))
+		goto out_error;
+	if (request_ape_opp100(false))
+		goto out_error;
+	return;
+
+out_error:
+	pr_err("clock: %s failed to disable %s.\n", __func__, clk->name);
 }
 
-static const struct file_operations usecount_fops = {
-	.read = usecount_dbg_read,
+struct clkops prcmu_clk_ops = {
+	.enable = prcmu_clk_enable,
+	.disable = prcmu_clk_disable,
 };
 
-static const struct file_operations set_rate_fops = {
-	.read = rate_dbg_read,
+struct clkops prcmu_opp100_clk_ops = {
+	.enable = prcmu_opp100_clk_enable,
+	.disable = prcmu_opp100_clk_disable,
 };
 
-static struct dentry *clk_debugfs_register_dir(struct clk *c,
-						struct dentry *p_dentry)
+/* PRCC clock operations. */
+
+static int prcc_pclk_enable(struct clk *clk)
 {
-	struct dentry *d, *clk_d, *child, *child_tmp;
-	char s[255];
-	char *p = s;
+	void __iomem *io_base = __io_address(clk->io_base);
 
-	if (c->name == NULL)
-		p += sprintf(p, "BUG");
-	else
-		p += sprintf(p, "%s", c->name);
-
-	clk_d = debugfs_create_dir(s, p_dentry);
-	if (!clk_d)
-		return NULL;
-
-	d = debugfs_create_file("usecount", S_IRUGO,
-				clk_d, c, &usecount_fops);
-	if (!d)
-		goto err_out;
-	d = debugfs_create_file("rate", S_IRUGO,
-				clk_d, c, &set_rate_fops);
-	if (!d)
-		goto err_out;
-	/*
-	 * TODO : not currently available in ux500
-	 * d = debugfs_create_x32("flags", S_IRUGO, clk_d, (u32 *)&c->flags);
-	 * if (!d)
-	 *	goto err_out;
-	 */
-
-	return clk_d;
-
-err_out:
-	d = clk_d;
-	list_for_each_entry_safe(child, child_tmp, &d->d_subdirs, d_u.d_child)
-		debugfs_remove(child);
-	debugfs_remove(clk_d);
-	return NULL;
+	writel(clk->cg_sel, (io_base + PRCC_PCKEN));
+	while (!(readl(io_base + PRCC_PCKSR) & clk->cg_sel))
+		cpu_relax();
+	return 0;
 }
 
-static void clk_debugfs_remove_dir(struct dentry *cdentry)
+static void prcc_pclk_disable(struct clk *clk)
 {
-	struct dentry *d, *child, *child_tmp;
+	void __iomem *io_base = __io_address(clk->io_base);
 
-	d = cdentry;
-	list_for_each_entry_safe(child, child_tmp, &d->d_subdirs, d_u.d_child)
-		debugfs_remove(child);
-	debugfs_remove(cdentry);
-	return ;
+	writel(clk->cg_sel, (io_base + PRCC_PCKDIS));
 }
 
-static int clk_debugfs_register_one(struct clk *c)
+struct clkops prcc_pclk_ops = {
+	.enable = prcc_pclk_enable,
+	.disable = prcc_pclk_disable,
+};
+
+static int prcc_kclk_enable(struct clk *clk)
 {
-	struct clk *pa = c->parent_periph;
-	struct clk *bpa = c->parent_cluster;
-
-	if (!(bpa && !pa)) {
-		c->dent = clk_debugfs_register_dir(c,
-				pa ? pa->dent : clk_debugfs_root);
-		if (!c->dent)
-			return -ENOMEM;
-	}
+	void __iomem *io_base = __io_address(clk->io_base);
 
-	if (bpa) {
-		c->dent_bus = clk_debugfs_register_dir(c,
-				bpa->dent_bus ? bpa->dent_bus : bpa->dent);
-		if ((!c->dent_bus) &&  (c->dent)) {
-			clk_debugfs_remove_dir(c->dent);
-			c->dent = NULL;
-			return -ENOMEM;
-		}
-	}
+	writel(clk->cg_sel, (io_base + PRCC_KCKEN));
+	while (!(readl(io_base + PRCC_KCKSR) & clk->cg_sel))
+		cpu_relax();
 	return 0;
 }
 
-static int clk_debugfs_register(struct clk *c)
+static void prcc_kclk_disable(struct clk *clk)
 {
-	int err;
-	struct clk *pa = c->parent_periph;
-	struct clk *bpa = c->parent_cluster;
-
-	if (pa && (!pa->dent && !pa->dent_bus)) {
-		err = clk_debugfs_register(pa);
-		if (err)
-			return err;
-	}
-
-	if (bpa && (!bpa->dent && !bpa->dent_bus)) {
-		err = clk_debugfs_register(bpa);
-		if (err)
-			return err;
-	}
+	void __iomem *io_base = __io_address(clk->io_base);
 
-	if ((!c->dent) && (!c->dent_bus)) {
-		err = clk_debugfs_register_one(c);
-		if (err)
-			return err;
-	}
-	return 0;
+	writel(clk->cg_sel, (io_base + PRCC_KCKDIS));
 }
 
-static int __init clk_debugfs_init(void)
-{
-	struct clk *c;
-	struct dentry *d;
-	int err;
+struct clkops prcc_kclk_ops = {
+	.enable = prcc_kclk_enable,
+	.disable = prcc_kclk_disable,
+};
 
-	d = debugfs_create_dir("clock", NULL);
-	if (!d)
-		return -ENOMEM;
-	clk_debugfs_root = d;
+void clks_register(struct clk_lookup *clks, size_t num)
+{
+	unsigned int i;
 
-	list_for_each_entry(c, &clk_list, list) {
-		err = clk_debugfs_register(c);
-		if (err)
-			goto err_out;
-	}
-	return 0;
-err_out:
-	debugfs_remove_recursive(clk_debugfs_root);
-	return err;
+	for (i = 0; i < num; i++)
+		clkdev_add(&clks[i]);
 }
 
-late_initcall(clk_debugfs_init);
-#endif /* defined(CONFIG_DEBUG_FS) */
-
 int __init clk_init(void)
 {
-	if (cpu_is_u8500ed()) {
-		clk_prcmu_ops.enable = clk_prcmu_ed_enable;
-		clk_prcmu_ops.disable = clk_prcmu_ed_disable;
-		clk_per6clk.rate = 100000000;
+	if (cpu_is_u8500()) {
+		prcmu_base = __io_address(U8500_PRCMU_BASE);
 	} else if (cpu_is_u5500()) {
-		/* Clock tree for U5500 not implemented yet */
-		clk_prcc_ops.enable = clk_prcc_ops.disable = NULL;
-		clk_prcmu_ops.enable = clk_prcmu_ops.disable = NULL;
-		clk_uartclk.rate = 36360000;
-		clk_sdmmcclk.rate = 99900000;
+		prcmu_base = __io_address(U5500_PRCMU_BASE);
+	} else {
+		pr_err("clock: Unknown DB Asic.\n");
+		return -EIO;
 	}
 
-	clkdev_add_table(u8500_common_clks, ARRAY_SIZE(u8500_common_clks));
-	if (cpu_is_u8500ed())
-		clkdev_add_table(u8500_ed_clks, ARRAY_SIZE(u8500_ed_clks));
-	else
-		clkdev_add_table(u8500_v1_clks, ARRAY_SIZE(u8500_v1_clks));
+	if (cpu_is_u8500())
+		db8500_clk_init();
+	/* Here the DB5500 clock tree will be added */
 
-#ifdef CONFIG_DEBUG_FS
-	clk_debugfs_add_table(u8500_common_clks, ARRAY_SIZE(u8500_common_clks));
-	if (cpu_is_u8500ed())
-		clk_debugfs_add_table(u8500_ed_clks, ARRAY_SIZE(u8500_ed_clks));
-	else
-		clk_debugfs_add_table(u8500_v1_clks, ARRAY_SIZE(u8500_v1_clks));
-#endif
 	return 0;
 }
diff --git a/arch/arm/mach-ux500/clock.h b/arch/arm/mach-ux500/clock.h
index 0744907..e37e401 100644
--- a/arch/arm/mach-ux500/clock.h
+++ b/arch/arm/mach-ux500/clock.h
@@ -1,11 +1,53 @@
 /*
- *  Copyright (C) 2010 ST-Ericsson
+ *  Copyright (C) 2010 ST-Ericsson SA
  *  Copyright (C) 2009 STMicroelectronics
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifndef UX500_CLOCK_H
+#define UX500_CLOCK_H
+
+#include <linux/clkdev.h>
+
+/**
+ * struct clk
+ * @ops:	The hardware specific operations defined for the clock.
+ * @name:	The name of the clock.
+ * @mutex:	The mutex to lock when operating on the clock. %NULL means that
+ *		the common clock spinlock will be used.
+ * @enabled:	A reference counter of the enable requests for the clock.
+ * @opp100:	A flag saying whether the clock is requested to run at the
+ *		OPP 100%% frequency.
+ * @rate:	The frequency of the clock. For scalable and scaling clocks,
+ *		this is the OPP 100%% frequency.
+ * @io_base:	An IO memory base address, meaningful only when considered
+ *		together with the defined @ops.
+ * @cg_sel:	Clock gate selector, meaningful only when considered together
+ *		with the specified @ops.
+ * @parent:	The current (or only) parent clock of the clock.
+ * @bus_parent:	The (optional) auxiliary bus clock "parent" of the clock.
+ * @parents:	A list of the possible parents the clock can have. This should
+ *		be a %NULL-terminated &struct_clk array. Present if and only
+ *		if clk_set_parent() is implemented for the clock.
+ * @regulator:	The regulator needed to have the clock functional, if any.
+ */
+struct clk {
+	const struct clkops *ops;
+	const char *name;
+	struct mutex *mutex;
+	unsigned int enabled;
+	bool opp100;
+	unsigned long rate;
+	unsigned int io_base;
+	u32 cg_sel;
+	struct clk *parent;
+	struct clk *bus_parent;
+	struct clk **parents;
+	struct regulator *regulator;
+	struct list_head list;
+};
 
 /**
  * struct clkops - ux500 clock operations
@@ -18,134 +60,81 @@
  * NULL, the rate in the struct clk will be used.
  */
 struct clkops {
-	void (*enable) (struct clk *);
-	void (*disable) (struct clk *);
-	unsigned long (*get_rate) (struct clk *);
+	int (*enable)(struct clk *);
+	void (*disable)(struct clk *);
+	unsigned long (*get_rate)(struct clk *);
+	int (*set_rate)(struct clk *, unsigned long);
+	unsigned long (*round_rate)(struct clk *, unsigned long);
+	int (*set_parent)(struct clk *, struct clk *);
 };
 
-/**
- * struct clk - ux500 clock structure
- * @ops:		pointer to clkops struct used to control this clock
- * @name:		name, for debugging
- * @enabled:		refcount. positive if enabled, zero if disabled
- * @get_rate:		custom callback for getting the clock rate
- * @data:		custom per-clock data for example for the get_rate
- *			callback
- * @rate:		fixed rate for clocks which don't implement
- * 			ops->getrate
- * @prcmu_cg_off:	address offset of the combined enable/disable register
- * 			(used on u8500v1)
- * @prcmu_cg_bit:	bit in the combined enable/disable register (used on
- * 			u8500v1)
- * @prcmu_cg_mgt:	address of the enable/disable register (used on
- * 			u8500ed)
- * @cluster:		peripheral cluster number
- * @prcc_bus:		bit for the bus clock in the peripheral's CLKRST
- * @prcc_kernel:	bit for the kernel clock in the peripheral's CLKRST.
- * 			-1 if no kernel clock exists.
- * @parent_cluster:	pointer to parent's cluster clk struct
- * @parent_periph:	pointer to parent's peripheral clk struct
- *
- * Peripherals are organised into clusters, and each cluster has an associated
- * bus clock.  Some peripherals also have a parent peripheral clock.
- *
- * In order to enable a clock for a peripheral, we need to enable:
- * 	(1) the parent cluster (bus) clock at the PRCMU level
- * 	(2) the parent peripheral clock (if any) at the PRCMU level
- * 	(3) the peripheral's bus & kernel clock at the PRCC level
- *
- * (1) and (2) are handled by defining clk structs (DEFINE_PRCMU_CLK) for each
- * of the cluster and peripheral clocks, and hooking these as the parents of
- * the individual peripheral clocks.
- *
- * (3) is handled by specifying the bits in the PRCC control registers required
- * to enable these clocks and modifying them in the ->enable and
- * ->disable callbacks of the peripheral clocks (DEFINE_PRCC_CLK).
- *
- * This structure describes both the PRCMU-level clocks and PRCC-level clocks.
- * The prcmu_* fields are only used for the PRCMU clocks, and the cluster,
- * prcc, and parent pointers are only used for the PRCC-level clocks.
- */
-struct clk {
-	const struct clkops	*ops;
-	const char 		*name;
-	unsigned int		enabled;
-	unsigned long		(*get_rate)(struct clk *);
-	void			*data;
-
-	unsigned long		rate;
-	struct list_head	list;
+extern struct clkops prcmu_clk_ops;
+extern struct clkops prcmu_opp100_clk_ops;
+extern struct mutex clk_opp100_mutex;
+extern struct clkops prcc_pclk_ops;
+extern struct clkops prcc_kclk_ops;
+extern struct clkops sga_clk_ops;
 
-	/* These three are only for PRCMU clks */
-
-	unsigned int		prcmu_cg_off;
-	unsigned int		prcmu_cg_bit;
-	unsigned int		prcmu_cg_mgt;
-
-	/* The rest are only for PRCC clks */
-
-	int			cluster;
-	unsigned int		prcc_bus;
-	unsigned int		prcc_kernel;
-
-	struct clk		*parent_cluster;
-	struct clk		*parent_periph;
-#if defined(CONFIG_DEBUG_FS)
-	struct dentry		*dent;		/* For visible tree hierarchy */
-	struct dentry		*dent_bus;	/* For visible tree hierarchy */
-#endif
-};
-
-#define DEFINE_PRCMU_CLK(_name, _cg_off, _cg_bit, _reg)		\
-struct clk clk_##_name = {					\
-		.name		= #_name,			\
-		.ops    	= &clk_prcmu_ops, 		\
-		.prcmu_cg_off	= _cg_off, 			\
-		.prcmu_cg_bit	= _cg_bit,			\
-		.prcmu_cg_mgt	= PRCM_##_reg##_MGT		\
+/* Define PRCMU Clock */
+#define DEF_PRCMU_CLK(_name, _cg_sel, _rate) \
+	struct clk _name = { \
+		.name = #_name, \
+		.ops = &prcmu_clk_ops, \
+		.cg_sel = _cg_sel, \
+		.rate = _rate, \
 	}
 
-#define DEFINE_PRCMU_CLK_RATE(_name, _cg_off, _cg_bit, _reg, _rate)	\
-struct clk clk_##_name = {						\
-		.name		= #_name,				\
-		.ops    	= &clk_prcmu_ops, 			\
-		.prcmu_cg_off	= _cg_off, 				\
-		.prcmu_cg_bit	= _cg_bit,				\
-		.rate		= _rate,				\
-		.prcmu_cg_mgt	= PRCM_##_reg##_MGT			\
+/* Use this for clocks that are only defined at OPP 100%. */
+#define DEF_PRCMU_OPP100_CLK(_name, _cg_sel, _rate) \
+	struct clk _name = { \
+		.name = #_name, \
+		.ops = &prcmu_opp100_clk_ops, \
+		.cg_sel = _cg_sel, \
+		.rate = _rate, \
+		.mutex = &clk_opp100_mutex, \
 	}
 
-#define DEFINE_PRCC_CLK(_pclust, _name, _bus_en, _kernel_en, _kernclk)	\
-struct clk clk_##_name = {						\
-		.name		= #_name,				\
-		.ops    	= &clk_prcc_ops, 			\
-		.cluster 	= _pclust,				\
-		.prcc_bus 	= _bus_en, 				\
-		.prcc_kernel 	= _kernel_en, 				\
-		.parent_cluster = &clk_per##_pclust##clk,		\
-		.parent_periph 	= _kernclk				\
+/* Define PRCC clock */
+#define DEF_PRCC_PCLK(_name, _io_base, _cg_bit, _parent) \
+	struct clk _name = { \
+		.name = #_name, \
+		.ops = &prcc_pclk_ops, \
+		.io_base = _io_base, \
+		.cg_sel = BIT(_cg_bit), \
+		.parent = _parent, \
 	}
 
-#define DEFINE_PRCC_CLK_CUSTOM(_pclust, _name, _bus_en, _kernel_en, _kernclk, _callback, _data) \
-struct clk clk_##_name = {						\
-		.name		= #_name,				\
-		.ops		= &clk_prcc_ops,			\
-		.cluster	= _pclust,				\
-		.prcc_bus	= _bus_en,				\
-		.prcc_kernel	= _kernel_en,				\
-		.parent_cluster = &clk_per##_pclust##clk,		\
-		.parent_periph	= _kernclk,				\
-		.get_rate	= _callback,				\
-		.data		= (void *) _data			\
+#define DEF_PRCC_KCLK(_name, _io_base, _cg_bit, _parent) \
+	struct clk _name = { \
+		.name = #_name, \
+		.ops = &prcc_kclk_ops, \
+		.io_base = _io_base, \
+		.cg_sel = BIT(_cg_bit), \
+		.parent = _parent, \
 	}
 
-
-#define CLK(_clk, _devname, _conname)			\
-	{						\
-		.clk	= &clk_##_clk,			\
-		.dev_id	= _devname,			\
-		.con_id = _conname,			\
+#define DEF_PER_CLK(_name, _bus_parent, _parent) \
+	struct clk _name = { \
+		.name = #_name, \
+		.parent = _parent, \
+		.bus_parent = _bus_parent, \
 	}
 
-int __init clk_db8500_ed_fixup(void);
+/* Functions defined in clock.c */
 int __init clk_init(void);
+void clks_register(struct clk_lookup *clks, size_t num);
+unsigned long __clk_get_rate(struct clk *clk, void *current_lock);
+
+#ifdef CONFIG_UX500_SOC_DB8500
+int __init db8500_clk_init(void);
+#else
+static inline int db8500_clk_init(void) { return 0; }
+#endif
+
+#ifdef CONFIG_UX500_SOC_DB5500
+int __init db5500_clk_init(void);
+#else
+static inline int db5500_clk_init(void) { return 0; }
+#endif
+
+#endif
-- 
1.7.3.2
