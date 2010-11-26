From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Nov 2010 14:49:11 +0800
Subject: [PATCH 12/15] ARM: mxs: Dynamically allocate fec devices
In-Reply-To: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1290754154-9428-13-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dynamically allocate fec devices for MX28, which gets dual
fec interface.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/devices-mx28.h                |    6 +++
 arch/arm/mach-mxs/devices/platform-fec.c        |   51 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   12 +++++
 3 files changed, 69 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-fec.c

diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 47c2f04..c509e5d 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -14,3 +14,9 @@
 extern const struct mxs_duart_data mx28_duart_data __initconst;
 #define mx28_add_duart() \
 	mxs_add_duart(&mx28_duart_data)
+
+extern const struct mxs_fec_data mx28_fec_data[] __initconst;
+#define mx28_add_fec(id, pdata) \
+	mxs_add_fec(&mx28_fec_data[id], pdata)
+#define mx28_add_fec0(pdata)	mx28_add_fec(0, pdata)
+#define mx28_add_fec1(pdata)	mx28_add_fec(1, pdata)
diff --git a/arch/arm/mach-mxs/devices/platform-fec.c b/arch/arm/mach-mxs/devices/platform-fec.c
new file mode 100644
index 0000000..a2389b2
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-fec.c
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <asm/sizes.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define mxs_fec_data_entry_single(soc, _id, _size)			\
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _ENET_MAC ## _id ## _BASE_ADDR,	\
+		.iosize = _size,					\
+		.irq = soc ## _INT_ENET_MAC ## _id,			\
+	}
+
+#define mxs_fec_data_entry(soc, _id, _size)				\
+	[_id] = mxs_fec_data_entry_single(soc, _id, _size)
+
+#ifdef CONFIG_SOC_IMX28
+const struct mxs_fec_data mx28_fec_data[] __initconst = {
+#define mx28_fec_data_entry(_id)					\
+	mxs_fec_data_entry(MX28, _id, SZ_16K)
+	mx28_fec_data_entry(0),
+	mx28_fec_data_entry(1),
+};
+#endif
+
+struct platform_device *__init mxs_add_fec(
+		const struct mxs_fec_data *data,
+		const struct fec_platform_data *pdata)
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
+	return mxs_add_platform_device("fec", data->id,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index 07b4439..3da48d4 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -32,3 +32,15 @@ struct mxs_duart_data {
 };
 struct platform_device *__init mxs_add_duart(
 		const struct mxs_duart_data *data);
+
+/* fec */
+#include <linux/fec.h>
+struct mxs_fec_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irq;
+};
+struct platform_device *__init mxs_add_fec(
+		const struct mxs_fec_data *data,
+		const struct fec_platform_data *pdata);
-- 
1.7.1
