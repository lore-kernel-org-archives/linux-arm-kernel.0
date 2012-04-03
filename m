From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  3 Apr 2012 16:20:06 -0300
Subject: [PATCH 2/3] ARM: mx28: Add SPI resources
In-Reply-To: <1333480807-10480-1-git-send-email-festevam@gmail.com>
References: <1333480807-10480-1-git-send-email-festevam@gmail.com>
Message-ID: <1333480807-10480-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPI resources.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/devices-mx28.h                |    4 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-mxs-spi.c    |   74 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   11 ++++
 5 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-spi.c

diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 9dbeae1..9b9206d 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -55,3 +55,7 @@ extern const struct mxs_saif_data mx28_saif_data[] __initconst;
 	mxs_add_saif(&mx28_saif_data[id], pdata)
 
 struct platform_device *__init mx28_add_rtc_stmp3xxx(void);
+
+extern const struct mxs_mxs_spi_data mx28_mxs_spi_data[] __initconst;
+#define mx28_add_mxs_spi(id) \
+		mxs_add_mxs_spi(&mx28_mxs_spi_data[id])
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index b8913df..8ba5fca 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -30,5 +30,8 @@ config MXS_HAVE_PLATFORM_MXSFB
 config MXS_HAVE_PLATFORM_MXS_SAIF
 	bool
 
+config MXS_HAVE_PLATFORM_MXS_SPI
+	bool
+
 config MXS_HAVE_PLATFORM_RTC_STMP3XXX
 	bool
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index c8f5c95..1664049 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -11,3 +11,4 @@ obj-y += platform-gpio-mxs.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXSFB) += platform-mxsfb.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_SAIF) += platform-mxs-saif.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_RTC_STMP3XXX) += platform-rtc-stmp3xxx.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_SPI) += platform-mxs-spi.o
diff --git a/arch/arm/mach-mxs/devices/platform-mxs-spi.c b/arch/arm/mach-mxs/devices/platform-mxs-spi.c
new file mode 100644
index 0000000..b9e78d3
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-mxs-spi.c
@@ -0,0 +1,74 @@
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
+#define mxs_mxs_spi_data_entry_single(soc, _id, hwid)			\
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _SSP ## hwid ## _BASE_ADDR,		\
+		.dma = soc ## _DMA_SSP ## hwid,				\
+		.irq_err = soc ## _INT_SSP ## hwid ## _ERROR,		\
+		.irq_dma = soc ## _INT_SSP ## hwid ## _DMA,		\
+	}
+
+#define mxs_mxs_spi_data_entry(soc, _id, hwid)				\
+	[_id] = mxs_mxs_spi_data_entry_single(soc, _id, hwid)
+
+
+#ifdef CONFIG_SOC_IMX23
+const struct mxs_mxs_spi_data mx23_mxs_spi_data[] __initconst = {
+	mxs_mxs_spi_data_entry(MX23, 0, 1),
+	mxs_mxs_spi_data_entry(MX23, 1, 2),
+};
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+const struct mxs_mxs_spi_data mx28_mxs_spi_data[] __initconst = {
+	mxs_mxs_spi_data_entry(MX28, 0, 0),
+	mxs_mxs_spi_data_entry(MX28, 1, 1),
+	mxs_mxs_spi_data_entry(MX28, 2, 2),
+	mxs_mxs_spi_data_entry(MX28, 3, 3),
+};
+#endif
+
+struct platform_device *__init mxs_add_mxs_spi(
+		const struct mxs_mxs_spi_data *data)
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
+	return mxs_add_platform_device("mxs-spi", data->id,
+			res, ARRAY_SIZE(res), NULL, 0);
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index f2e3839..2bb1d9e 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -116,3 +116,14 @@ struct mxs_saif_data {
 struct platform_device *__init mxs_add_saif(
 		const struct mxs_saif_data *data,
 		const struct mxs_saif_platform_data *pdata);
+
+/* spi */
+struct mxs_mxs_spi_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t dma;
+	resource_size_t irq_err;
+	resource_size_t irq_dma;
+};
+struct platform_device *__init mxs_add_mxs_spi(
+		const struct mxs_mxs_spi_data *data);
-- 
1.7.1
