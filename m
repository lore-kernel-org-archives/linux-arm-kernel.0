From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 16 Mar 2011 11:31:06 +0100
Subject: [PATCH v4 3/6] ARM: mxs: dynamically allocate mmc device
In-Reply-To: <20110222183349.GC22310@pengutronix.de>
References: <20110222183349.GC22310@pengutronix.de>
Message-ID: <1300271466-986-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@freescale.com>

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
[ukleinek: fix naming to include complete device name in functions]
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this is not yet ready to be merged as it depends on <mach/mmc.h> which
isn't upstream yet.

Best regards
Uwe

 arch/arm/mach-mxs/clock-mx23.c                  |   15 +++++
 arch/arm/mach-mxs/clock-mx28.c                  |   18 ++++++
 arch/arm/mach-mxs/devices-mx23.h                |    4 +
 arch/arm/mach-mxs/devices-mx28.h                |    4 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-mxs-mmc.c    |   73 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   13 ++++
 8 files changed, 131 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-mmc.c

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index d133c7f..c3577ea 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -521,6 +521,15 @@ static int clk_misc_init(void)
 	__raw_writel(BM_CLKCTRL_CPU_INTERRUPT_WAIT,
 			CLKCTRL_BASE_ADDR + HW_CLKCTRL_CPU_SET);
 
+	/*
+	 * 480 MHz seems too high to be ssp clock source directly,
+	 * so set frac to get a 288 MHz ref_io.
+	 */
+	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC);
+	reg &= ~BM_CLKCTRL_FRAC_IOFRAC;
+	reg |= 30 << BP_CLKCTRL_FRAC_IOFRAC;
+	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC);
+
 	return 0;
 }
 
@@ -528,6 +537,12 @@ int __init mx23_clocks_init(void)
 {
 	clk_misc_init();
 
+	/*
+	 * source ssp clock from ref_io than ref_xtal,
+	 * as ref_xtal only provides 24 MHz as maximum.
+	 */
+	clk_set_parent(&ssp_clk, &ref_io_clk);
+
 	clk_enable(&cpu_clk);
 	clk_enable(&hbus_clk);
 	clk_enable(&xbus_clk);
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index bf789f4..ed1ebfd 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -619,6 +619,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
 	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
 	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
+	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp0_clk)
+	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp1_clk)
 	_REGISTER_CLOCK("flexcan.0", NULL, can0_clk)
 	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
 	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
@@ -738,6 +740,15 @@ static int clk_misc_init(void)
 	reg |= BM_CLKCTRL_ENET_CLK_OUT_EN;
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_ENET);
 
+	/*
+	 * 480 MHz seems too high to be ssp clock source directly,
+	 * so set frac0 to get a 288 MHz ref_io0.
+	 */
+	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC0);
+	reg &= ~BM_CLKCTRL_FRAC0_IO0FRAC;
+	reg |= 30 << BP_CLKCTRL_FRAC0_IO0FRAC;
+	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC0);
+
 	return 0;
 }
 
@@ -745,6 +756,13 @@ int __init mx28_clocks_init(void)
 {
 	clk_misc_init();
 
+	/*
+	 * source ssp clock from ref_io0 than ref_xtal,
+	 * as ref_xtal only provides 24 MHz as maximum.
+	 */
+	clk_set_parent(&ssp0_clk, &ref_io0_clk);
+	clk_set_parent(&ssp1_clk, &ref_io0_clk);
+
 	clk_enable(&cpu_clk);
 	clk_enable(&hbus_clk);
 	clk_enable(&xbus_clk);
diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
index c7e14f4..c6f345f 100644
--- a/arch/arm/mach-mxs/devices-mx23.h
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -21,6 +21,10 @@ extern const struct mxs_auart_data mx23_auart_data[] __initconst;
 #define mx23_add_auart0()		mx23_add_auart(0)
 #define mx23_add_auart1()		mx23_add_auart(1)
 
+extern const struct mxs_mxs_mmc_data mx23_mxs_mmc_data[] __initconst;
+#define mx23_add_mxs_mmc(id, pdata) \
+	mxs_add_mxs_mmc(&mx23_mxs_mmc_data[id], pdata)
+
 #define mx23_add_mxs_pwm(id)		mxs_add_mxs_pwm(MX23_PWM_BASE_ADDR, id)
 
 struct platform_device *__init mx23_add_mxsfb(
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 9d08555..c473edd 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -37,6 +37,10 @@ extern const struct mxs_flexcan_data mx28_flexcan_data[] __initconst;
 extern const struct mxs_i2c_data mx28_mxs_i2c_data[] __initconst;
 #define mx28_add_mxs_i2c(id)		mxs_add_mxs_i2c(&mx28_mxs_i2c_data[id])
 
+extern const struct mxs_mxs_mmc_data mx28_mxs_mmc_data[] __initconst;
+#define mx28_add_mxs_mmc(id, pdata) \
+	mxs_add_mxs_mmc(&mx28_mxs_mmc_data[id], pdata)
+
 #define mx28_add_mxs_pwm(id)		mxs_add_mxs_pwm(MX28_PWM_BASE_ADDR, id)
 
 struct platform_device *__init mx28_add_mxsfb(
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index 1451ad0..acf9eea 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -15,6 +15,9 @@ config MXS_HAVE_PLATFORM_FLEXCAN
 config MXS_HAVE_PLATFORM_MXS_I2C
 	bool
 
+config MXS_HAVE_PLATFORM_MXS_MMC
+	bool
+
 config MXS_HAVE_PLATFORM_MXS_PWM
 	bool
 
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index 0d9bea3..324f282 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -4,5 +4,6 @@ obj-y += platform-dma.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_I2C) += platform-mxs-i2c.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_MMC) += platform-mxs-mmc.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_PWM) += platform-mxs-pwm.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXSFB) += platform-mxsfb.o
diff --git a/arch/arm/mach-mxs/devices/platform-mxs-mmc.c b/arch/arm/mach-mxs/devices/platform-mxs-mmc.c
new file mode 100644
index 0000000..382dacb
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-mxs-mmc.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/init.h>
+
+#include <mach/mx23.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+
+#define mxs_mxs_mmc_data_entry_single(soc, _id, hwid)			\
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _SSP ## hwid ## _BASE_ADDR,		\
+		.dma = soc ## _DMA_SSP ## hwid,				\
+		.irq_err = soc ## _INT_SSP ## hwid ## _ERROR,		\
+		.irq_dma = soc ## _INT_SSP ## hwid ## _DMA,		\
+	}
+
+#define mxs_mxs_mmc_data_entry(soc, _id, hwid)				\
+	[_id] = mxs_mxs_mmc_data_entry_single(soc, _id, hwid)
+
+
+#ifdef CONFIG_SOC_IMX23
+const struct mxs_mxs_mmc_data mx23_mxs_mmc_data[] __initconst = {
+	mxs_mxs_mmc_data_entry(MX23, 0, 1),
+	mxs_mxs_mmc_data_entry(MX23, 1, 2),
+};
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+const struct mxs_mxs_mmc_data mx28_mxs_mmc_data[] __initconst = {
+	mxs_mxs_mmc_data_entry(MX28, 0, 0),
+	mxs_mxs_mmc_data_entry(MX28, 1, 1),
+};
+#endif
+
+struct platform_device *__init mxs_add_mxs_mmc(
+		const struct mxs_mxs_mmc_data *data,
+		const struct mxs_mmc_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start	= data->iobase,
+			.end	= data->iobase + SZ_8K - 1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.start	= data->dma,
+			.end	= data->dma,
+			.flags	= IORESOURCE_DMA,
+		}, {
+			.start	= data->irq_err,
+			.end	= data->irq_err,
+			.flags	= IORESOURCE_IRQ,
+		}, {
+			.start	= data->irq_dma,
+			.end	= data->irq_dma,
+			.flags	= IORESOURCE_IRQ,
+		},
+	};
+
+	return mxs_add_platform_device("mxs-mmc", data->id,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index 71f2448..c5137f1 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -73,6 +73,19 @@ struct mxs_i2c_data {
 };
 struct platform_device * __init mxs_add_mxs_i2c(const struct mxs_i2c_data *data);
 
+/* mmc */
+#include <mach/mmc.h>
+struct mxs_mxs_mmc_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t dma;
+	resource_size_t irq_err;
+	resource_size_t irq_dma;
+};
+struct platform_device *__init mxs_add_mxs_mmc(
+		const struct mxs_mxs_mmc_data *data,
+		const struct mxs_mmc_platform_data *pdata);
+
 /* pwm */
 struct platform_device *__init mxs_add_mxs_pwm(
 		resource_size_t iobase, int id);
-- 
1.7.2.3
