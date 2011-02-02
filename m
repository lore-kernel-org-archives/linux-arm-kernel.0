From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed,  2 Feb 2011 13:50:30 +0100
Subject: [PATCH 2/2] ARM: mxs: dynamically register flexcan devices for mx28
In-Reply-To: <1296651030-30792-1-git-send-email-mkl@pengutronix.de>
References: <1296651030-30792-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1296651030-30792-3-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxs/devices-mx28.h                |    6 +++
 arch/arm/mach-mxs/devices/Kconfig               |    4 ++
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-flexcan.c    |   51 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   12 +++++
 5 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-flexcan.c

diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 1ab7bf0..3b18304 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -26,3 +26,9 @@ extern const struct mxs_auart_data mx28_auart_data[] __initconst;
 extern const struct mxs_fec_data mx28_fec_data[] __initconst;
 #define mx28_add_fec(id, pdata) \
 	mxs_add_fec(&mx28_fec_data[id], pdata)
+
+extern const struct mxs_flexcan_data mx28_flexcan_data[] __initconst;
+#define mx28_add_flexcan(id, pdata)	\
+	mxs_add_flexcan(&mx28_flexcan_data[id], pdata)
+#define mx28_add_flexcan0(pdata)	mx28_add_flexcan(0, pdata)
+#define mx28_add_flexcan1(pdata)	mx28_add_flexcan(1, pdata)
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index 3001b75..6c65b67 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -7,3 +7,7 @@ config MXS_HAVE_PLATFORM_AUART
 
 config MXS_HAVE_PLATFORM_FEC
 	bool
+
+config MXS_HAVE_PLATFORM_FLEXCAN
+	select HAVE_CAN_FLEXCAN if CAN
+	bool
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index c814d05..a8dc8d5 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_MXS_HAVE_AMBA_DUART) += amba-duart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
diff --git a/arch/arm/mach-mxs/devices/platform-flexcan.c b/arch/arm/mach-mxs/devices/platform-flexcan.c
new file mode 100644
index 0000000..43a6b4b
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-flexcan.c
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2010, 2011 Pengutronix,
+ *                          Marc Kleine-Budde <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <asm/sizes.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+
+#define mxs_flexcan_data_entry_single(soc, _id, _hwid, _size)		\
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _CAN ## _hwid ## _BASE_ADDR,		\
+		.iosize = _size,					\
+		.irq = soc ## _INT_CAN ## _hwid,			\
+	}
+
+#define mxs_flexcan_data_entry(soc, _id, _hwid, _size)			\
+	[_id] = mxs_flexcan_data_entry_single(soc, _id, _hwid, _size)
+
+#ifdef CONFIG_SOC_IMX28
+const struct mxs_flexcan_data mx28_flexcan_data[] __initconst = {
+#define mx28_flexcan_data_entry(_id, _hwid)				\
+	mxs_flexcan_data_entry_single(MX28, _id, _hwid, SZ_8K)
+	mx28_flexcan_data_entry(0, 0),
+	mx28_flexcan_data_entry(1, 1),
+};
+#endif /* ifdef CONFIG_SOC_IMX28 */
+
+struct platform_device *__init mxs_add_flexcan(
+		const struct mxs_flexcan_data *data,
+		const struct flexcan_platform_data *pdata)
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
+		},
+	};
+
+	return mxs_add_platform_device("flexcan", data->id,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index bed4002..e7aefb4 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -51,3 +51,15 @@ struct mxs_fec_data {
 struct platform_device *__init mxs_add_fec(
 		const struct mxs_fec_data *data,
 		const struct fec_platform_data *pdata);
+
+/* flexcan */
+#include <linux/can/platform/flexcan.h>
+struct mxs_flexcan_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irq;
+};
+struct platform_device *__init mxs_add_flexcan(
+		const struct mxs_flexcan_data *data,
+		const struct flexcan_platform_data *pdata);
-- 
1.7.2.3
