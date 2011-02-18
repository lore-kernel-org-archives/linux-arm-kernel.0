From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 18 Feb 2011 18:18:27 +0100
Subject: [PATCH 2/2] arm: mxs: add i2c-devices
In-Reply-To: <1298049507-6987-1-git-send-email-w.sang@pengutronix.de>
References: <1298049507-6987-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1298049507-6987-3-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/devices-mx28.h                |    3 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-i2c.c        |   56 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |    9 ++++
 5 files changed, 72 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-i2c.c

diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 3b18304..c581b26 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -32,3 +32,6 @@ extern const struct mxs_flexcan_data mx28_flexcan_data[] __initconst;
 	mxs_add_flexcan(&mx28_flexcan_data[id], pdata)
 #define mx28_add_flexcan0(pdata)	mx28_add_flexcan(0, pdata)
 #define mx28_add_flexcan1(pdata)	mx28_add_flexcan(1, pdata)
+
+extern const struct mxs_i2c_data mx28_i2c_data[] __initconst;
+#define mx28_add_i2c(id)	mxs_add_i2c(&mx28_i2c_data[id])
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index 6c65b67..c9f80e1 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -11,3 +11,6 @@ config MXS_HAVE_PLATFORM_FEC
 config MXS_HAVE_PLATFORM_FLEXCAN
 	select HAVE_CAN_FLEXCAN if CAN
 	bool
+
+config MXS_HAVE_PLATFORM_I2C
+	bool
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index a8dc8d5..4fb4d9a 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_MXS_HAVE_AMBA_DUART) += amba-duart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_I2C) += platform-i2c.o
diff --git a/arch/arm/mach-mxs/devices/platform-i2c.c b/arch/arm/mach-mxs/devices/platform-i2c.c
new file mode 100644
index 0000000..22236b2
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-i2c.c
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2011 Pengutronix
+ * Wolfram Sang <w.sang@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <asm/sizes.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+
+/* helper defines to fix MX23 naming anomaly */
+#define MX23_I2C0_BASE_ADDR	MX23_I2C_BASE_ADDR
+#define MX23_INT_I2C0_ERROR	MX23_INT_I2C_ERROR
+#define MX23_INT_I2C0_DMA	MX23_INT_I2C_DMA
+
+#define mxs_i2c_data_entry_single(soc, _id)				\
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _I2C ## _id ## _BASE_ADDR,		\
+		.errirq = soc ## _INT_I2C ## _id ## _ERROR,		\
+		.dmairq = soc ## _INT_I2C ## _id ## _DMA,		\
+	}
+
+#define mxs_i2c_data_entry(soc, _id)					\
+	[_id] = mxs_i2c_data_entry_single(soc, _id)
+
+#ifdef CONFIG_SOC_IMX28
+const struct mxs_i2c_data mx28_i2c_data[] __initconst = {
+	mxs_i2c_data_entry(MX28, 0),
+	mxs_i2c_data_entry(MX28, 1),
+};
+#endif
+
+struct platform_device *__init mxs_add_i2c(const struct mxs_i2c_data *data)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_8K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->errirq,
+			.end = data->errirq,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->dmairq,
+			.end = data->dmairq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return mxs_add_platform_device("mxs-i2c", data->id, res,
+					ARRAY_SIZE(res), NULL, 0);
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index e7aefb4..e385ece 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -63,3 +63,12 @@ struct mxs_flexcan_data {
 struct platform_device *__init mxs_add_flexcan(
 		const struct mxs_flexcan_data *data,
 		const struct flexcan_platform_data *pdata);
+
+/* i2c */
+struct mxs_i2c_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t errirq;
+	resource_size_t dmairq;
+};
+struct platform_device * __init mxs_add_i2c(const struct mxs_i2c_data *data);
-- 
1.7.2.3
