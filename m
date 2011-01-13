From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 13 Jan 2011 14:14:36 +0100
Subject: [PATCH 2/2] ARM MXS: Add auart platform support for i.MX28
In-Reply-To: <1294924476-10653-1-git-send-email-s.hauer@pengutronix.de>
References: <1294924476-10653-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1294924476-10653-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/clock-mx28.c                  |    5 ++
 arch/arm/mach-mxs/devices-mx28.h                |    8 +++
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-auart.c      |   54 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   10 ++++
 6 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-auart.c

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 74e2103..9f65934 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -603,6 +603,11 @@ _DEFINE_CLOCK(fec_clk, ENET, DISABLE, &hbus_clk);
 
 static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxs-duart.0", NULL, uart_clk)
+	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
+	_REGISTER_CLOCK("mxs-auart.1", NULL, uart_clk)
+	_REGISTER_CLOCK("mxs-auart.2", NULL, uart_clk)
+	_REGISTER_CLOCK("mxs-auart.3", NULL, uart_clk)
+	_REGISTER_CLOCK("mxs-auart.4", NULL, uart_clk)
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
 	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 00b736c..a0b70df 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -15,6 +15,14 @@ extern const struct mxs_duart_data mx28_duart_data __initconst;
 #define mx28_add_duart() \
 	mxs_add_duart(&mx28_duart_data)
 
+extern const struct mxs_auart_data mx28_auart_data[] __initconst;
+#define mx28_add_auart(id)	mxs_add_auart(&mx28_auart_data[id])
+#define mx28_add_auart0()		mx28_add_auart(0)
+#define mx28_add_auart1()		mx28_add_auart(1)
+#define mx28_add_auart2()		mx28_add_auart(2)
+#define mx28_add_auart3()		mx28_add_auart(3)
+#define mx28_add_auart4()		mx28_add_auart(4)
+
 extern const struct mxs_fec_data mx28_fec_data[] __initconst;
 #define mx28_add_fec(id, pdata) \
 	mxs_add_fec(&mx28_fec_data[id], pdata)
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index a35a2dc..9d16540 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -1,5 +1,8 @@
 config MXS_HAVE_PLATFORM_DUART
 	bool
 
+config MXS_HAVE_PLATFORM_AUART
+	bool
+
 config MXS_HAVE_PLATFORM_FEC
 	bool
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index 4b5266a..b46d18d 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_MXS_HAVE_PLATFORM_DUART) += platform-duart.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
diff --git a/arch/arm/mach-mxs/devices/platform-auart.c b/arch/arm/mach-mxs/devices/platform-auart.c
new file mode 100644
index 0000000..f0dbf8a
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-auart.c
@@ -0,0 +1,54 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <asm/sizes.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+
+#define mxs_auart_data_entry_single(soc, _id)				\
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _AUART ## _id ## _BASE_ADDR,		\
+		.irq = soc ## _INT_AUART ## _id,			\
+	}
+
+#define mxs_auart_data_entry(soc, _id)					\
+	[_id] = mxs_auart_data_entry_single(soc, _id)
+
+#ifdef CONFIG_SOC_IMX28
+const struct mxs_auart_data mx28_auart_data[] __initconst = {
+#define mx28_auart_data_entry(_id)					\
+	mxs_auart_data_entry(MX28, _id)
+	mx28_auart_data_entry(0),
+	mx28_auart_data_entry(1),
+	mx28_auart_data_entry(2),
+	mx28_auart_data_entry(3),
+	mx28_auart_data_entry(4),
+};
+#endif
+
+struct platform_device *__init mxs_add_auart(
+		const struct mxs_auart_data *data)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_8K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return mxs_add_platform_device_dmamask("mxs-auart", data->id,
+					res, ARRAY_SIZE(res), NULL, 0,
+					DMA_BIT_MASK(32));
+}
+
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index 3da48d4..b8ab332 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -33,6 +33,16 @@ struct mxs_duart_data {
 struct platform_device *__init mxs_add_duart(
 		const struct mxs_duart_data *data);
 
+/* auart */
+struct mxs_auart_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irq;
+};
+struct platform_device *__init mxs_add_auart(
+		const struct mxs_auart_data *data);
+
 /* fec */
 #include <linux/fec.h>
 struct mxs_fec_data {
-- 
1.7.2.3
