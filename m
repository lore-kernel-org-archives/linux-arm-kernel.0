From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  6 Oct 2010 12:00:17 +0200
Subject: [PATCH 1/3] ARM: imx: fix/define clocks and create devices for imx dma
Message-ID: <1286359219-5869-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx31.c              |    4 +-
 arch/arm/mach-mx3/clock-imx35.c              |    2 +-
 arch/arm/mach-mx5/clock-mx51.c               |    5 +
 arch/arm/plat-mxc/devices/Makefile           |    1 +
 arch/arm/plat-mxc/devices/platform-imx-dma.c |  128 ++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mx51.h        |    2 +-
 6 files changed, 138 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-dma.c

diff --git a/arch/arm/mach-mx3/clock-imx31.c b/arch/arm/mach-mx3/clock-imx31.c
index 18e98f1..109e98f 100644
--- a/arch/arm/mach-mx3/clock-imx31.c
+++ b/arch/arm/mach-mx3/clock-imx31.c
@@ -477,7 +477,7 @@ DEFINE_CLOCK(epit1_clk,   0, MXC_CCM_CGR0,  6, NULL, NULL, &perclk_clk);
 DEFINE_CLOCK(epit2_clk,   1, MXC_CCM_CGR0,  8, NULL, NULL, &perclk_clk);
 DEFINE_CLOCK(iim_clk,     0, MXC_CCM_CGR0, 10, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(ata_clk,     0, MXC_CCM_CGR0, 12, NULL, NULL, &ipg_clk);
-DEFINE_CLOCK(sdma_clk1,   0, MXC_CCM_CGR0, 14, NULL, &sdma_clk1, &ahb_clk);
+DEFINE_CLOCK(sdma_clk1,   0, MXC_CCM_CGR0, 14, NULL, NULL, &ahb_clk);
 DEFINE_CLOCK(cspi3_clk,   2, MXC_CCM_CGR0, 16, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(rng_clk,     0, MXC_CCM_CGR0, 18, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(uart1_clk,   0, MXC_CCM_CGR0, 20, NULL, NULL, &perclk_clk);
@@ -564,7 +564,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "ata", ata_clk)
 	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
 	_REGISTER_CLOCK(NULL, "rng", rng_clk)
-	_REGISTER_CLOCK(NULL, "sdma_ahb", sdma_clk1)
+	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk1)
 	_REGISTER_CLOCK(NULL, "sdma_ipg", sdma_clk2)
 	_REGISTER_CLOCK(NULL, "mstick", mstick1_clk)
 	_REGISTER_CLOCK(NULL, "mstick", mstick2_clk)
diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 708c2b3..dcabed0 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -482,7 +482,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
 	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
 	_REGISTER_CLOCK(NULL, "scc", scc_clk)
-	_REGISTER_CLOCK(NULL, "sdma", sdma_clk)
+	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk)
 	_REGISTER_CLOCK(NULL, "spba", spba_clk)
 	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index e6c17d7..21cecc0 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -977,6 +977,10 @@ DEFINE_CLOCK(cspi_ipg_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG9_OFFSET,
 DEFINE_CLOCK(cspi_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG13_OFFSET,
 		NULL, NULL, &ipg_clk, &cspi_ipg_clk);
 
+/* SDMA */
+DEFINE_CLOCK(sdma_clk, 1, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG15_OFFSET,
+		NULL, NULL, &ahb_clk, NULL);
+
 #define _REGISTER_CLOCK(d, n, c) \
        { \
 		.dev_id = d, \
@@ -1003,6 +1007,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc_nand", NULL, nfc_clk)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
+	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk)
 	_REGISTER_CLOCK(NULL, "ckih", ckih_clk)
 	_REGISTER_CLOCK(NULL, "ckih2", ckih2_clk)
 	_REGISTER_CLOCK(NULL, "gpt_32k", gpt_32k_clk)
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index ac77383..2663fb1 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
+obj-y += platform-imx-dma.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_SSI) += platform-imx-ssi.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
new file mode 100644
index 0000000..95f35c8
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -0,0 +1,128 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/init.h>
+
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+#ifdef SDMA_IS_MERGED
+#include <mach/sdma.h>
+#else
+struct sdma_platform_data {
+	int sdma_version;
+	char *cpu_name;
+	int to_version;
+};
+#endif
+
+struct imx_imx_sdma_data {
+	resource_size_t iobase;
+	resource_size_t irq;
+	struct sdma_platform_data pdata;
+};
+
+#define imx_imx_sdma_data_entry_single(soc, _sdma_version, _cpu_name, _to_version)\
+	{								\
+		.iobase = soc ## _SDMA ## _BASE_ADDR,			\
+		.irq = soc ## _INT_SDMA,				\
+		.pdata = {						\
+			.sdma_version = _sdma_version,			\
+			.cpu_name = _cpu_name,				\
+			.to_version = _to_version,			\
+		},							\
+	}
+
+#ifdef CONFIG_ARCH_MX25
+const struct imx_imx_sdma_data imx25_imx_sdma_data __initconst =
+	imx_imx_sdma_data_entry_single(MX25, 1, "imx25", 0);
+#endif /* ifdef CONFIG_ARCH_MX25 */
+
+#ifdef CONFIG_ARCH_MX31
+struct imx_imx_sdma_data imx31_imx_sdma_data __initdata =
+	imx_imx_sdma_data_entry_single(MX31, 1, "imx31", 0);
+#endif /* ifdef CONFIG_ARCH_MX31 */
+
+#ifdef CONFIG_ARCH_MX35
+const struct imx_imx_sdma_data imx35_imx_sdma_data __initconst =
+	imx_imx_sdma_data_entry_single(MX35, 2, "imx35", 2);
+#endif /* ifdef CONFIG_ARCH_MX35 */
+
+#ifdef CONFIG_ARCH_MX51
+const struct imx_imx_sdma_data imx51_imx_sdma_data __initconst =
+	imx_imx_sdma_data_entry_single(MX51, 2, "imx51", 0);
+#endif /* ifdef CONFIG_ARCH_MX51 */
+
+static struct platform_device __init __maybe_unused *imx_add_imx_sdma(
+		const struct imx_imx_sdma_data *data)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return imx_add_platform_device("imx-sdma", -1,
+			res, ARRAY_SIZE(res),
+			&data->pdata, sizeof(data->pdata));
+}
+
+static struct platform_device __init __maybe_unused *imx_add_imx_dma(void)
+{
+	return imx_add_platform_device("imx-dma", -1, NULL, 0, NULL, 0);
+}
+
+static int __init imxXX_add_imx_dma(void)
+{
+	struct platform_device *ret;
+
+#if defined(CONFIG_SOC_IMX21) || defined(CONFIG_SOC_IMX27)
+	if (cpu_is_mx21() || cpu_is_mx27())
+		ret = imx_add_imx_dma();
+	else
+#endif
+
+#if defined(CONFIG_ARCH_MX25)
+	if (cpu_is_mx25())
+		ret = imx_add_imx_sdma(&imx25_imx_sdma_data);
+	else
+#endif
+
+#if defined(CONFIG_ARCH_MX31)
+	if (cpu_is_mx31()) {
+		imx31_imx_sdma_data.pdata.to_version = mx31_revision() >> 4;
+		ret = imx_add_imx_sdma(&imx31_imx_sdma_data);
+	} else
+#endif
+
+#if defined(CONFIG_ARCH_MX35)
+	if (cpu_is_mx35())
+		ret = imx_add_imx_sdma(&imx35_imx_sdma_data);
+	else
+#endif
+
+#if defined(CONFIG_ARCH_MX51)
+	if (cpu_is_mx51())
+		ret = imx_add_imx_sdma(&imx51_imx_sdma_data);
+	else
+#endif
+		ret = ERR_PTR(-ENODEV);
+
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	return 0;
+}
+arch_initcall(imxXX_add_imx_dma);
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index c99eeab..1906ee5a5 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -285,7 +285,7 @@
 #define MX51_MXC_INT_MMC_SDHC3		3
 #define MX51_MXC_INT_MMC_SDHC4		4
 #define MX51_MXC_INT_RESV5		5
-#define MX51_MXC_INT_SDMA		6
+#define MX51_INT_SDMA			6
 #define MX51_MXC_INT_IOMUX		7
 #define MX51_INT_NFC			8
 #define MX51_MXC_INT_VPU		9
-- 
1.7.2.3
