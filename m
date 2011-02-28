From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 28 Feb 2011 17:40:04 +0100
Subject: [PATCH 1/2] arm: mxs: add i2c-devices for mx28
In-Reply-To: <1298911205-3070-1-git-send-email-w.sang@pengutronix.de>
References: <1298911205-3070-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1298911205-3070-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxs/devices-mx28.h                |    3 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-mxs-i2c.c    |   51 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |    9 ++++
 5 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-i2c.c

diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 69d19ea..a9eecdc 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -33,4 +33,7 @@ extern const struct mxs_flexcan_data mx28_flexcan_data[] __initconst;
 #define mx28_add_flexcan0(pdata)	mx28_add_flexcan(0, pdata)
 #define mx28_add_flexcan1(pdata)	mx28_add_flexcan(1, pdata)
 
+extern const struct mxs_i2c_data mx28_mxs_i2c_data[] __initconst;
+#define mx28_add_mxs_i2c(id)		mxs_add_mxs_i2c(&mx28_mxs_i2c_data[id])
+
 #define mx28_add_mxs_pwm(id)		mxs_add_mxs_pwm(MX28_PWM_BASE_ADDR, id)
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index 3aeec24..a878915 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -12,5 +12,8 @@ config MXS_HAVE_PLATFORM_FLEXCAN
 	select HAVE_CAN_FLEXCAN if CAN
 	bool
 
+config MXS_HAVE_PLATFORM_MXS_I2C
+	bool
+
 config MXS_HAVE_PLATFORM_MXS_PWM
 	bool
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index 978310f..345b839 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -2,4 +2,5 @@ obj-$(CONFIG_MXS_HAVE_AMBA_DUART) += amba-duart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_I2C) += platform-mxs-i2c.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_PWM) += platform-mxs-pwm.o
diff --git a/arch/arm/mach-mxs/devices/platform-mxs-i2c.c b/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
new file mode 100644
index 0000000..eab3a06
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
@@ -0,0 +1,51 @@
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
+const struct mxs_i2c_data mx28_mxs_i2c_data[] __initconst = {
+	mxs_i2c_data_entry(MX28, 0),
+	mxs_i2c_data_entry(MX28, 1),
+};
+#endif
+
+struct platform_device *__init mxs_add_mxs_i2c(const struct mxs_i2c_data *data)
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
index d460d30..71f2448 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -64,6 +64,15 @@ struct platform_device *__init mxs_add_flexcan(
 		const struct mxs_flexcan_data *data,
 		const struct flexcan_platform_data *pdata);
 
+/* i2c */
+struct mxs_i2c_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t errirq;
+	resource_size_t dmairq;
+};
+struct platform_device * __init mxs_add_mxs_i2c(const struct mxs_i2c_data *data);
+
 /* pwm */
 struct platform_device *__init mxs_add_mxs_pwm(
 		resource_size_t iobase, int id);
-- 
1.7.2.3
