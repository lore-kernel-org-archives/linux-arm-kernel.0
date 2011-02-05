From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 5 Feb 2011 10:08:14 +0800
Subject: [PATCH 3/5] ARM: mxs: dynamically allocate dma device for mx23/28
In-Reply-To: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1296871696-21008-4-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/clock-mx23.c                  |    3 +-
 arch/arm/mach-mxs/clock-mx28.c                  |    4 +-
 arch/arm/mach-mxs/devices-mx23.h                |    6 +++
 arch/arm/mach-mxs/devices-mx28.h                |    6 +++
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-dma.c        |   50 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |    7 +++
 8 files changed, 77 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-dma.c

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index b1a362e..350b28c 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -443,7 +443,8 @@ static struct clk_lookup lookups[] = {
 	/* for amba-pl011 driver */
 	_REGISTER_CLOCK("duart", NULL, uart_clk)
 	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
-	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
+	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
+	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
 	_REGISTER_CLOCK(NULL, "usb", usb_clk)
 	_REGISTER_CLOCK(NULL, "audio", audio_clk)
 	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index c9d7951..a3b4787 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -617,8 +617,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
 	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
-	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
-	_REGISTER_CLOCK(NULL, "xclk", xbus_clk)
+	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
+	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
 	_REGISTER_CLOCK("flexcan.0", NULL, can0_clk)
 	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
 	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
index 1256788..d5595ce 100644
--- a/arch/arm/mach-mxs/devices-mx23.h
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -14,3 +14,9 @@
 extern const struct amba_device mx23_duart_device __initconst;
 #define mx23_add_duart() \
 	mxs_add_duart(&mx23_duart_device)
+
+extern const struct mxs_dma_data mx23_dma_data[] __initconst;
+#define mx23_add_apbh_dma() \
+	mxs_add_dma(&mx23_dma_data[0])
+#define mx23_add_apbx_dma() \
+	mxs_add_dma(&mx23_dma_data[1])
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 3b18304..e3a3bbc 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -23,6 +23,12 @@ extern const struct mxs_auart_data mx28_auart_data[] __initconst;
 #define mx28_add_auart3()		mx28_add_auart(3)
 #define mx28_add_auart4()		mx28_add_auart(4)
 
+extern const struct mxs_dma_data mx28_dma_data[] __initconst;
+#define mx28_add_apbh_dma() \
+	mxs_add_dma(&mx28_dma_data[0])
+#define mx28_add_apbx_dma() \
+	mxs_add_dma(&mx28_dma_data[1])
+
 extern const struct mxs_fec_data mx28_fec_data[] __initconst;
 #define mx28_add_fec(id, pdata) \
 	mxs_add_fec(&mx28_fec_data[id], pdata)
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index 6c65b67..c2ddbc5 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -5,6 +5,9 @@ config MXS_HAVE_AMBA_DUART
 config MXS_HAVE_PLATFORM_AUART
 	bool
 
+config MXS_HAVE_PLATFORM_DMA
+	bool
+
 config MXS_HAVE_PLATFORM_FEC
 	bool
 
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index a8dc8d5..510849d 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_MXS_HAVE_AMBA_DUART) += amba-duart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_DMA) += platform-dma.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
diff --git a/arch/arm/mach-mxs/devices/platform-dma.c b/arch/arm/mach-mxs/devices/platform-dma.c
new file mode 100644
index 0000000..0c15a26
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-dma.c
@@ -0,0 +1,50 @@
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
+#include <mach/mx23.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+
+#define mxs_dma_data_entry_single(soc, type, _devid)			\
+	{								\
+		.devid = _devid,					\
+		.iobase = soc ## _ ## type ## _DMA ## _BASE_ADDR,	\
+	}
+
+#ifdef CONFIG_SOC_IMX23
+struct mxs_dma_data mx23_dma_data[] __initconst = {
+	mxs_dma_data_entry_single(MX23, APBH, "mxs-dma-apbh"),
+	mxs_dma_data_entry_single(MX23, APBX, "mxs-dma-apbx"),
+};
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+struct mxs_dma_data mx28_dma_data[] __initconst = {
+	mxs_dma_data_entry_single(MX28, APBH, "mxs-dma-apbh"),
+	mxs_dma_data_entry_single(MX28, APBX, "mxs-dma-apbx"),
+};
+#endif
+
+struct platform_device *__init mxs_add_dma(
+			const struct mxs_dma_data *data)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_8K - 1,
+			.flags = IORESOURCE_MEM,
+		}
+	};
+
+	return mxs_add_platform_device(data->devid, -1,
+				res, ARRAY_SIZE(res), NULL, 0);
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index e7aefb4..acd74b4 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -40,6 +40,13 @@ struct mxs_auart_data {
 struct platform_device *__init mxs_add_auart(
 		const struct mxs_auart_data *data);
 
+/* dma */
+struct mxs_dma_data {
+	const char *devid;
+	resource_size_t iobase;
+};
+struct platform_device *__init mxs_add_dma(const struct mxs_dma_data *data);
+
 /* fec */
 #include <linux/fec.h>
 struct mxs_fec_data {
-- 
1.7.1
