From: weitway@gmail.com (weitway at gmail.com)
Date: Wed, 13 Apr 2011 23:53:31 +0800
Subject: [PATCH 2/7] ARM i.MX5: Add IPU device support
In-Reply-To: <1302710016-3569-1-git-send-email-weitway@gmail.com>
References: <1302710016-3569-1-git-send-email-weitway@gmail.com>
Message-ID: <1302710016-3569-2-git-send-email-weitway@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Chen <b02280@freescale.com>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Jason Chen <Jason.Chen@freescale.com>
---
 arch/arm/mach-mx5/devices-imx51.h               |    4 +
 arch/arm/mach-mx5/devices-imx53.h               |    4 +
 arch/arm/plat-mxc/devices/Kconfig               |    4 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-imx_ipuv3.c  |   94 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   12 +++
 6 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 7fff485..1bd73b3 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -55,3 +55,7 @@ extern const struct imx_mxc_pwm_data imx51_mxc_pwm_data[] __initconst;
 extern const struct imx_imx_keypad_data imx51_imx_keypad_data __initconst;
 #define imx51_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx51_imx_keypad_data, pdata)
+
+extern const struct imx_ipuv3_data imx51_ipuv3_data __initconst;
+#define imx51_add_ipuv3(pdata)	\
+	imx_add_ipuv3(&imx51_ipuv3_data, pdata)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index 9251008..8049039 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -33,3 +33,7 @@ extern const struct imx_spi_imx_data imx53_ecspi_data[] __initconst;
 extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[] __initconst;
 #define imx53_add_imx2_wdt(id, pdata)	\
 	imx_add_imx2_wdt(&imx53_imx2_wdt_data[id])
+
+extern const struct imx_ipuv3_data imx53_ipuv3_data __initconst;
+#define imx53_add_ipuv3(pdata)	\
+	imx_add_ipuv3(&imx53_ipuv3_data, pdata)
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index b9ab1d5..f99317e 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -71,3 +71,7 @@ config IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 
 config IMX_HAVE_PLATFORM_SPI_IMX
 	bool
+
+config IMX_HAVE_PLATFORM_IMX_IPUV3
+	bool
+
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 75cd2ec..0a6be0a 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RNGA) += platform-mxc_rnga.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) += platform-sdhci-esdhc-imx.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_IPUV3) +=  platform-imx_ipuv3.o
diff --git a/arch/arm/plat-mxc/devices/platform-imx_ipuv3.c b/arch/arm/plat-mxc/devices/platform-imx_ipuv3.c
new file mode 100644
index 0000000..fe76cf1
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-imx_ipuv3.c
@@ -0,0 +1,94 @@
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
+		.iosize = size,                                         \
+		.init = ipu_init,                                       \
+	}
+
+#ifdef CONFIG_SOC_IMX51
+int __init mx51_ipuv3_init(struct platform_device *pdev)
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
+int __init mx53_ipuv3_init(struct platform_device *pdev)
+{
+	int ret = 0;
+	u32 val;
+	int i;
+
+	/* fixup ipu base address */
+	for (i = 0; i < pdev->num_resources; i++) {
+		struct resource *r = &pdev->resource[i];
+
+		if (IORESOURCE_MEM == resource_type(r))
+			r->start -= 0x18000000;
+	}
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
+		const struct imx_ipuv3_data *data,
+		struct imx_ipuv3_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + data->iosize - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq_err,
+			.end = data->irq_err,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	pdata->init = data->init;
+
+	return imx_add_platform_device("imx-ipuv3", -1,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+}
+
+
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 8658c9c..c65ea3a 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -264,3 +264,15 @@ struct imx_spi_imx_data {
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
+	int (*init) (struct platform_device *);
+};
+struct platform_device *__init imx_add_ipuv3(
+		const struct imx_ipuv3_data *data,
+		struct imx_ipuv3_platform_data *pdata);
-- 
1.7.1
