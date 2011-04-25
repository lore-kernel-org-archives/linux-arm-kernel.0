From: weitway@gmail.com (weitway at gmail.com)
Date: Mon, 25 Apr 2011 21:38:29 +0800
Subject: [PATCH 2/9] ARM i.MX5: Add IPU device support
Message-ID: <1303738709-27562-1-git-send-email-weitway@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Chen <b02280@freescale.com>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Jason Chen <Jason.Chen@freescale.com>
Signed-off-by: Jason Chen <Jason.Chen@linaro.org>
---
 arch/arm/mach-mx5/devices-imx51.h               |    4 +
 arch/arm/mach-mx5/devices-imx53.h               |    4 +
 arch/arm/plat-mxc/devices/Kconfig               |    4 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-imx_ipuv3.c  |   87 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   13 ++++
 arch/arm/plat-mxc/include/mach/mx53.h           |    2 +-
 7 files changed, 114 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index e11bc0e..058a86f 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -52,3 +52,7 @@ extern const struct imx_mxc_pwm_data imx51_mxc_pwm_data[];
 extern const struct imx_imx_keypad_data imx51_imx_keypad_data;
 #define imx51_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx51_imx_keypad_data, pdata)
+
+extern const struct imx_ipuv3_data imx51_ipuv3_data __initconst;
+#define imx51_add_ipuv3(id, pdata)	\
+	imx_add_ipuv3(id, &imx51_ipuv3_data, pdata)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index 48f4c8c..664473a 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -32,3 +32,7 @@ extern const struct imx_spi_imx_data imx53_ecspi_data[];
 extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[];
 #define imx53_add_imx2_wdt(id, pdata)	\
 	imx_add_imx2_wdt(&imx53_imx2_wdt_data[id])
+
+extern const struct imx_ipuv3_data imx53_ipuv3_data __initconst;
+#define imx53_add_ipuv3(id, pdata)	\
+	imx_add_ipuv3(id, &imx53_ipuv3_data, pdata)
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index bd294ad..029880e 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -76,3 +76,7 @@ config IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 
 config IMX_HAVE_PLATFORM_SPI_IMX
 	bool
+
+config IMX_HAVE_PLATFORM_IMX_IPUV3
+	bool
+
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index ad2922a..2d4d16f 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RTC) += platform-mxc_rtc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) += platform-sdhci-esdhc-imx.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_IPUV3) +=  platform-imx_ipuv3.o
diff --git a/arch/arm/plat-mxc/devices/platform-imx_ipuv3.c b/arch/arm/plat-mxc/devices/platform-imx_ipuv3.c
new file mode 100644
index 0000000..b5487ec
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-imx_ipuv3.c
@@ -0,0 +1,87 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define imx5_ipuv3_data_entry_single(soc, size, ipu_init)	        \
+	{                                                               \
+		.iobase = soc ## _IPU_CTRL_BASE_ADDR,                   \
+		.irq_err = soc ## _INT_IPU_ERR,                         \
+		.irq = soc ## _INT_IPU_SYN,                             \
+		.irq_start = MXC_IPU_IRQ_START,                         \
+		.iosize = size,                                         \
+		.init = ipu_init,                                       \
+	}
+
+#ifdef CONFIG_SOC_IMX51
+int __init mx51_ipuv3_init(void)
+{
+	int ret = 0;
+	u32 val;
+
+	/* hard reset the IPU */
+	val = readl(MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
+	val |= 1 << 3;
+	writel(val, MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
+
+	return ret;
+}
+
+const struct imx_ipuv3_data imx51_ipuv3_data __initconst =
+			imx5_ipuv3_data_entry_single(MX51,
+			SZ_512M, mx51_ipuv3_init);
+#endif /* ifdef CONFIG_SOC_IMX51 */
+
+#ifdef CONFIG_SOC_IMX53
+int __init mx53_ipuv3_init(void)
+{
+	int ret = 0;
+	u32 val;
+
+	/* hard reset the IPU */
+	val = readl(MX53_IO_ADDRESS(MX53_SRC_BASE_ADDR));
+	val |= 1 << 3;
+	writel(val, MX53_IO_ADDRESS(MX53_SRC_BASE_ADDR));
+
+	return ret;
+}
+
+const struct imx_ipuv3_data imx53_ipuv3_data __initconst =
+			imx5_ipuv3_data_entry_single(MX53,
+			SZ_128M, mx53_ipuv3_init);
+#endif
+
+struct platform_device *__init imx_add_ipuv3(
+		int id, const struct imx_ipuv3_data *data,
+		struct imx_ipuv3_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + data->iosize - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->irq_err,
+			.end = data->irq_err,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	pdata->init = data->init;
+	pdata->irq_start = data->irq_start;
+
+	return imx_add_platform_device("imx-ipuv3", id,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+}
+
+
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index fa84773..bc6764b 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -291,3 +291,16 @@ struct imx_spi_imx_data {
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
 		const struct spi_imx_master *pdata);
+
+#include <mach/ipu-v3.h>
+struct imx_ipuv3_data {
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irq_err;
+	resource_size_t irq;
+	unsigned int irq_start;
+	int (*init) (void);
+};
+struct platform_device *__init imx_add_ipuv3(
+		int id, const struct imx_ipuv3_data *data,
+		struct imx_ipuv3_platform_data *pdata);
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index 9d2a1ef..645d250 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -31,7 +31,7 @@
 /*
  * Graphics Memory of GPU
  */
-#define MX53_IPU_CTRL_BASE_ADDR	0x18000000
+#define MX53_IPU_CTRL_BASE_ADDR	0x00000000 /*real is 0x18000000, for codeing convenience*/
 #define MX53_GPU2D_BASE_ADDR		0x20000000
 #define MX53_GPU_BASE_ADDR		0x30000000
 #define MX53_GPU_GMEM_BASE_ADDR	0xF8020000
-- 
1.7.1
