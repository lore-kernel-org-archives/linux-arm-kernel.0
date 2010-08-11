From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 11 Aug 2010 10:36:28 +0200
Subject: [PATCH 3/3] [RFC] change the way imx-uarts are registered
In-Reply-To: <1281515788-9989-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1281515788-9989-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1281515788-9989-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For mx1_defconfig this yields:

	add/remove: 1/0 grow/shrink: 1/4 up/down: 49/-108 (-59)
	function                                     old     new   delta
	imx1_imx_uart_data                             -      48     +48
	kernel_config_data                          7277    7278      +1
	imx_add_imx_uart_1irq                        132     128      -4
	imx_add_imx_uart_3irq                        164     156      -8
	scb9328_init                                  96      64     -32
	mx1ads_init                                  220     156     -64

for mx21_defconfig this yields:

	add/remove: 1/0 grow/shrink: 0/3 up/down: 64/-52 (12)
	function                                     old     new   delta
	imx21_imx_uart_data                            -      64     +64
	imx_add_imx_uart_3irq                        160     156      -4
	imx_add_imx_uart_1irq                        140     136      -4
	mx21ads_board_init                           220     176     -44

for a random mx25 config this yields:

	add/remove: 1/0 grow/shrink: 0/5 up/down: 80/-56 (24)
	function                                     old     new   delta
	imx25_imx_uart_data                            -      80     +80
	imx_add_imx_uart_3irq                        160     156      -4
	imx_add_imx_uart_1irq                        140     136      -4
	mx25pdk_init                                 288     272     -16
	eukrea_mbimxsd_baseboard_init                272     256     -16
	eukrea_cpuimx25_init                         252     236     -16

for mx27_defconfig this yields:

	add/remove: 1/0 grow/shrink: 0/10 up/down: 96/-280 (-184)
	function                                     old     new   delta
	imx27_imx_uart_data                            -      96     +96
	imx_add_imx_uart_3irq                        160     156      -4
	imx_add_imx_uart_1irq                        140     136      -4
	pca100_init                                  560     544     -16
	mx27pdk_init                                 112      96     -16
	mx27lite_init                                 92      76     -16
	eukrea_cpuimx27_init                         332     316     -16
	pcm038_init                                  388     348     -40
	mxt_td60_board_init                          320     280     -40
	eukrea_mbimx27_baseboard_init                476     436     -40
	mx27ads_board_init                           368     280     -88

and finally for mx3_defconfig:

	add/remove: 2/0 grow/shrink: 0/9 up/down: 128/-344 (-216)
	function                                     old     new   delta
	imx31_imx_uart_data                            -      80     +80
	imx35_imx_uart_data                            -      48     +48
	imx_add_imx_uart_1irq                        132     128      -4
	imx_add_imx_uart_3irq                        164     152     -12
	mx31moboard_devboard_init                    360     344     -16
	mx31lite_db_init                             176     160     -16
	mx31moboard_smartbot_init                    384     360     -24
	kzm_board_init                               232     208     -24
	armadillo5x0_init                            392     364     -28
	mx31lilly_db_init                            248     208     -40
	mxc_board_init                              3760    3580    -180

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Makefile                      |    6 ++--
 arch/arm/mach-imx/devices-imx1.c                |   23 +++++++++++++
 arch/arm/mach-imx/devices-imx1.h                |    9 +++--
 arch/arm/mach-imx/devices-imx21.c               |   23 +++++++++++++
 arch/arm/mach-imx/devices-imx21.h               |   15 ++++----
 arch/arm/mach-imx/devices-imx27.c               |   26 ++++++++++++++
 arch/arm/mach-imx/devices-imx27.h               |   21 +++++-------
 arch/arm/mach-mx25/Makefile                     |    2 +-
 arch/arm/mach-mx25/devices-imx25.c              |   24 +++++++++++++
 arch/arm/mach-mx25/devices-imx25.h              |   18 ++++-----
 arch/arm/mach-mx3/Makefile                      |    4 +-
 arch/arm/mach-mx3/devices-imx31.c               |   25 ++++++++++++++
 arch/arm/mach-mx3/devices-imx31.h               |   18 ++++-----
 arch/arm/mach-mx3/devices-imx35.c               |   22 ++++++++++++
 arch/arm/mach-mx3/devices-imx35.h               |   12 +++---
 arch/arm/plat-mxc/devices/platform-imx-uart.c   |   41 ++++++++++------------
 arch/arm/plat-mxc/include/mach/devices-common.h |   27 +++++++++++----
 17 files changed, 231 insertions(+), 85 deletions(-)
 create mode 100644 arch/arm/mach-imx/devices-imx1.c
 create mode 100644 arch/arm/mach-imx/devices-imx21.c
 create mode 100644 arch/arm/mach-imx/devices-imx27.c
 create mode 100644 arch/arm/mach-mx25/devices-imx25.c
 create mode 100644 arch/arm/mach-mx3/devices-imx31.c
 create mode 100644 arch/arm/mach-mx3/devices-imx35.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 46a9fdf..749d2fa 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -8,11 +8,11 @@ obj-y	:=  devices.o
 
 obj-$(CONFIG_IMX_HAVE_DMA_V1) += dma-v1.o
 
-obj-$(CONFIG_ARCH_MX1) += clock-imx1.o mm-imx1.o
-obj-$(CONFIG_MACH_MX21) += clock-imx21.o mm-imx21.o
+obj-$(CONFIG_ARCH_MX1) += clock-imx1.o devices-imx1.o mm-imx1.o
+obj-$(CONFIG_MACH_MX21) += clock-imx21.o devices-imx21.o mm-imx21.o
 
 obj-$(CONFIG_MACH_MX27) += cpu-imx27.o pm-imx27.o
-obj-$(CONFIG_MACH_MX27) += clock-imx27.o mm-imx27.o
+obj-$(CONFIG_MACH_MX27) += clock-imx27.o devices-imx27.o mm-imx27.o
 
 # Support for CMOS sensor interface
 obj-$(CONFIG_MX1_VIDEO)	+= mx1-camera-fiq.o mx1-camera-fiq-ksym.o
diff --git a/arch/arm/mach-imx/devices-imx1.c b/arch/arm/mach-imx/devices-imx1.c
new file mode 100644
index 0000000..9e6abff
--- /dev/null
+++ b/arch/arm/mach-imx/devices-imx1.c
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include "devices-imx1.h"
+
+const struct imx_uart_3irq_data imx1_imx_uart_data[] __initconst = {
+#define imx1_imx_uart_data_entry(_id, _hwid)				\
+	[_id] = {							\
+		.id = _id,						\
+		.iobase = MX1_UART ## _hwid ## _BASE_ADDR,		\
+		.iosize = 0xd0,						\
+		.irqrx = MX1_INT_UART ## _hwid ## RX,			\
+		.irqtx = MX1_INT_UART ## _hwid ## TX,			\
+		.irqrts = MX1_INT_UART ## _hwid ## RTS,			\
+	}
+	imx1_imx_uart_data_entry(0, 1),
+	imx1_imx_uart_data_entry(1, 2),
+};
diff --git a/arch/arm/mach-imx/devices-imx1.h b/arch/arm/mach-imx/devices-imx1.h
index a8d94f0..d268a7a 100644
--- a/arch/arm/mach-imx/devices-imx1.h
+++ b/arch/arm/mach-imx/devices-imx1.h
@@ -12,7 +12,8 @@
 #define imx1_add_i2c_imx(pdata)		\
 	imx_add_imx_i2c(0, MX1_I2C_BASE_ADDR, SZ_4K, MX1_INT_I2C, pdata)
 
-#define imx1_add_imx_uart0(pdata)	\
-	imx_add_imx_uart_3irq(0, MX1_UART1_BASE_ADDR, 0xd0, MX1_INT_UART1RX, MX1_INT_UART1TX, MX1_INT_UART1RTS, pdata)
-#define imx1_add_imx_uart1(pdata)	\
-	imx_add_imx_uart_3irq(0, MX1_UART2_BASE_ADDR, 0xd0, MX1_INT_UART2RX, MX1_INT_UART2TX, MX1_INT_UART2RTS, pdata)
+extern const struct imx_uart_3irq_data imx1_imx_uart_data[] __initconst;
+#define imx1_add_imx_uart0(pdata)	imx1_add_imx_uart(0, pdata)
+#define imx1_add_imx_uart1(pdata)	imx1_add_imx_uart(1, pdata)
+#define imx1_add_imx_uart(id, pdata)	\
+	imx_add_imx_uart_3irq(&imx1_imx_uart_data[id], pdata)
diff --git a/arch/arm/mach-imx/devices-imx21.c b/arch/arm/mach-imx/devices-imx21.c
new file mode 100644
index 0000000..9e1f09f
--- /dev/null
+++ b/arch/arm/mach-imx/devices-imx21.c
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include "devices-imx21.h"
+
+const struct imx_uart_1irq_data imx21_imx_uart_data[] __initconst = {
+#define imx21_imx_uart_data_entry(_id, _hwid)				\
+	[_id] = {							\
+		.id = _id,						\
+		.iobase = MX21_UART ## _hwid ## _BASE_ADDR,		\
+		.iosize = SZ_4K,					\
+		.irq = MX21_INT_UART ## _hwid,				\
+	}
+	imx21_imx_uart_data_entry(0, 1),
+	imx21_imx_uart_data_entry(1, 2),
+	imx21_imx_uart_data_entry(2, 3),
+	imx21_imx_uart_data_entry(3, 4),
+};
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index 42788e9..6acd7e3 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -12,14 +12,13 @@
 #define imx21_add_i2c_imx(pdata)	\
 	imx_add_imx_i2c(0, MX2x_I2C_BASE_ADDR, SZ_4K, MX2x_INT_I2C, pdata)
 
-#define imx21_add_imx_uart0(pdata)	\
-	imx_add_imx_uart_1irq(0, MX21_UART1_BASE_ADDR, SZ_4K, MX21_INT_UART1, pdata)
-#define imx21_add_imx_uart1(pdata)	\
-	imx_add_imx_uart_1irq(1, MX21_UART2_BASE_ADDR, SZ_4K, MX21_INT_UART2, pdata)
-#define imx21_add_imx_uart2(pdata)	\
-	imx_add_imx_uart_1irq(2, MX21_UART3_BASE_ADDR, SZ_4K, MX21_INT_UART3, pdata)
-#define imx21_add_imx_uart3(pdata)	\
-	imx_add_imx_uart_1irq(3, MX21_UART4_BASE_ADDR, SZ_4K, MX21_INT_UART4, pdata)
+extern const struct imx_uart_1irq_data imx21_imx_uart_data[] __initconst;
+#define imx21_add_imx_uart0(pdata)	imx21_add_imx_uart(0, pdata)
+#define imx21_add_imx_uart1(pdata)	imx21_add_imx_uart(1, pdata)
+#define imx21_add_imx_uart2(pdata)	imx21_add_imx_uart(2, pdata)
+#define imx21_add_imx_uart3(pdata)	imx21_add_imx_uart(3, pdata)
+#define imx21_add_imx_uart(id, pdata)	\
+	imx_add_imx_uart_1irq(&imx21_imx_uart_data[id], pdata)
 
 #define imx21_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX21_NFC_BASE_ADDR, MX21_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-imx/devices-imx27.c b/arch/arm/mach-imx/devices-imx27.c
new file mode 100644
index 0000000..280f54d
--- /dev/null
+++ b/arch/arm/mach-imx/devices-imx27.c
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/hardware.h> /* XXX: for IMX_IO_ADDRESS */
+#include "devices-imx27.h"
+
+const struct imx_uart_1irq_data imx27_imx_uart_data[] __initconst = {
+#define imx27_imx_uart_data_entry(_id, _hwid)				\
+	[_id] = {							\
+		.id = _id,						\
+		.iobase = MX27_UART ## _hwid ## _BASE_ADDR,		\
+		.iosize = SZ_4K,					\
+		.irq = MX27_INT_UART ## _hwid,				\
+	}
+	imx27_imx_uart_data_entry(0, 1),
+	imx27_imx_uart_data_entry(1, 2),
+	imx27_imx_uart_data_entry(2, 3),
+	imx27_imx_uart_data_entry(3, 4),
+	imx27_imx_uart_data_entry(4, 5),
+	imx27_imx_uart_data_entry(5, 6),
+};
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 65e7bb7..70afd23 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -14,18 +14,15 @@
 #define imx27_add_i2c_imx1(pdata)	\
 	imx_add_imx_i2c(1, MX27_I2C2_BASE_ADDR, SZ_4K, MX27_INT_I2C2, pdata)
 
-#define imx27_add_imx_uart0(pdata)	\
-	imx_add_imx_uart_1irq(0, MX27_UART1_BASE_ADDR, SZ_4K, MX27_INT_UART1, pdata)
-#define imx27_add_imx_uart1(pdata)	\
-	imx_add_imx_uart_1irq(1, MX27_UART2_BASE_ADDR, SZ_4K, MX27_INT_UART2, pdata)
-#define imx27_add_imx_uart2(pdata)	\
-	imx_add_imx_uart_1irq(2, MX27_UART3_BASE_ADDR, SZ_4K, MX27_INT_UART3, pdata)
-#define imx27_add_imx_uart3(pdata)	\
-	imx_add_imx_uart_1irq(3, MX27_UART4_BASE_ADDR, SZ_4K, MX27_INT_UART4, pdata)
-#define imx27_add_imx_uart4(pdata)	\
-	imx_add_imx_uart_1irq(4, MX27_UART5_BASE_ADDR, SZ_4K, MX27_INT_UART5, pdata)
-#define imx27_add_imx_uart5(pdata)	\
-	imx_add_imx_uart_1irq(5, MX27_UART6_BASE_ADDR, SZ_4K, MX27_INT_UART6, pdata)
+extern const struct imx_uart_1irq_data imx27_imx_uart_data[] __initconst;
+#define imx27_add_imx_uart0(pdata)	imx27_add_imx_uart(0, pdata)
+#define imx27_add_imx_uart1(pdata)	imx27_add_imx_uart(1, pdata)
+#define imx27_add_imx_uart2(pdata)	imx27_add_imx_uart(2, pdata)
+#define imx27_add_imx_uart3(pdata)	imx27_add_imx_uart(3, pdata)
+#define imx27_add_imx_uart4(pdata)	imx27_add_imx_uart(4, pdata)
+#define imx27_add_imx_uart5(pdata)	imx27_add_imx_uart(5, pdata)
+#define imx27_add_imx_uart(id, pdata)	\
+	imx_add_imx_uart_1irq(&imx27_imx_uart_data[id], pdata)
 
 #define imx27_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX27_NFC_BASE_ADDR, MX27_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-mx25/Makefile b/arch/arm/mach-mx25/Makefile
index d9e46ce..b50321f 100644
--- a/arch/arm/mach-mx25/Makefile
+++ b/arch/arm/mach-mx25/Makefile
@@ -1,5 +1,5 @@
 obj-y				:= mm.o devices.o
-obj-$(CONFIG_ARCH_MX25)		+= clock.o
+obj-$(CONFIG_ARCH_MX25)		+= clock.o devices-imx25.o
 obj-$(CONFIG_MACH_MX25_3DS)	+= mach-mx25_3ds.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX25)		+= mach-cpuimx25.o
 obj-$(CONFIG_MACH_EUKREA_MBIMXSD25_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
diff --git a/arch/arm/mach-mx25/devices-imx25.c b/arch/arm/mach-mx25/devices-imx25.c
new file mode 100644
index 0000000..60d303c
--- /dev/null
+++ b/arch/arm/mach-mx25/devices-imx25.c
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include "devices-imx25.h"
+
+const struct imx_uart_1irq_data imx25_imx_uart_data[] __initconst = {
+#define imx25_imx_uart_data_entry(_id, _hwid)				\
+	[_id] = {							\
+		.id = _id,						\
+		.iobase = MX25_UART ## _hwid ## _BASE_ADDR,		\
+		.iosize = SZ_16K,					\
+		.irq = MX25_INT_UART ## _hwid,				\
+	}
+	imx25_imx_uart_data_entry(0, 1),
+	imx25_imx_uart_data_entry(1, 2),
+	imx25_imx_uart_data_entry(2, 3),
+	imx25_imx_uart_data_entry(3, 4),
+	imx25_imx_uart_data_entry(4, 5),
+};
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index d86a7c3..c331449 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -21,16 +21,14 @@
 #define imx25_add_imx_i2c2(pdata)	\
 	imx_add_imx_i2c(2, MX25_I2C3_BASE_ADDR, SZ_16K, MX25_INT_I2C3, pdata)
 
-#define imx25_add_imx_uart0(pdata)	\
-	imx_add_imx_uart_1irq(0, MX25_UART1_BASE_ADDR, SZ_16K, MX25_INT_UART1, pdata)
-#define imx25_add_imx_uart1(pdata)	\
-	imx_add_imx_uart_1irq(1, MX25_UART2_BASE_ADDR, SZ_16K, MX25_INT_UART2, pdata)
-#define imx25_add_imx_uart2(pdata)	\
-	imx_add_imx_uart_1irq(2, MX25_UART3_BASE_ADDR, SZ_16K, MX25_INT_UART3, pdata)
-#define imx25_add_imx_uart3(pdata)	\
-	imx_add_imx_uart_1irq(3, MX25_UART4_BASE_ADDR, SZ_16K, MX25_INT_UART4, pdata)
-#define imx25_add_imx_uart4(pdata)	\
-	imx_add_imx_uart_1irq(4, MX25_UART5_BASE_ADDR, SZ_16K, MX25_INT_UART5, pdata)
+extern const struct imx_uart_1irq_data imx25_imx_uart_data[] __initconst;
+#define imx25_add_imx_uart0(pdata)	imx25_add_imx_uart(0, pdata)
+#define imx25_add_imx_uart1(pdata)	imx25_add_imx_uart(1, pdata)
+#define imx25_add_imx_uart2(pdata)	imx25_add_imx_uart(2, pdata)
+#define imx25_add_imx_uart3(pdata)	imx25_add_imx_uart(3, pdata)
+#define imx25_add_imx_uart4(pdata)	imx25_add_imx_uart(4, pdata)
+#define imx25_add_imx_uart(id, pdata)	\
+	imx_add_imx_uart_1irq(&imx25_imx_uart_data[id], pdata)
 
 #define imx25_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v21(MX25_NFC_BASE_ADDR, MX25_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index 2bd7bec..ce49888 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -8,8 +8,8 @@ obj-y				:= mm.o devices.o cpu.o
 CFLAGS_mm.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
 CFLAGS_devices.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
 CFLAGS_cpu.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
-obj-$(CONFIG_ARCH_MX31)		+= clock-imx31.o iomux-imx31.o
-obj-$(CONFIG_ARCH_MX35)		+= clock-imx35.o
+obj-$(CONFIG_ARCH_MX31)		+= clock-imx31.o devices-imx31.o iomux-imx31.o
+obj-$(CONFIG_ARCH_MX35)		+= clock-imx35.o devices-imx35.o
 obj-$(CONFIG_MACH_MX31ADS)	+= mach-mx31ads.o
 obj-$(CONFIG_MACH_MX31LILLY)	+= mach-mx31lilly.o mx31lilly-db.o
 obj-$(CONFIG_MACH_MX31LITE)	+= mach-mx31lite.o mx31lite-db.o
diff --git a/arch/arm/mach-mx3/devices-imx31.c b/arch/arm/mach-mx3/devices-imx31.c
new file mode 100644
index 0000000..07b8f8a
--- /dev/null
+++ b/arch/arm/mach-mx3/devices-imx31.c
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/hardware.h> /* XXX: for IMX_IO_ADDRESS */
+#include "devices-imx31.h"
+
+const struct imx_uart_1irq_data imx31_imx_uart_data[] __initconst = {
+#define imx31_imx_uart_data_entry(_id, _hwid)				\
+	[_id] = {							\
+		.id = _id,						\
+		.iobase = MX31_UART ## _hwid ## _BASE_ADDR,		\
+		.iosize = SZ_4K,					\
+		.irq = MX31_INT_UART ## _hwid,				\
+	}
+	imx31_imx_uart_data_entry(0, 1),
+	imx31_imx_uart_data_entry(1, 2),
+	imx31_imx_uart_data_entry(2, 3),
+	imx31_imx_uart_data_entry(3, 4),
+	imx31_imx_uart_data_entry(4, 5),
+};
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index 3b1a44a..99acf54 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -16,16 +16,14 @@
 #define imx31_add_imx_i2c2(pdata)	\
 	imx_add_imx_i2c(2, MX31_I2C3_BASE_ADDR, SZ_4K, MX31_INT_I2C3, pdata)
 
-#define imx31_add_imx_uart0(pdata)	\
-	imx_add_imx_uart_1irq(0, MX31_UART1_BASE_ADDR, SZ_16K, MX31_INT_UART1, pdata)
-#define imx31_add_imx_uart1(pdata)	\
-	imx_add_imx_uart_1irq(1, MX31_UART2_BASE_ADDR, SZ_16K, MX31_INT_UART2, pdata)
-#define imx31_add_imx_uart2(pdata)	\
-	imx_add_imx_uart_1irq(2, MX31_UART3_BASE_ADDR, SZ_16K, MX31_INT_UART3, pdata)
-#define imx31_add_imx_uart3(pdata)	\
-	imx_add_imx_uart_1irq(3, MX31_UART4_BASE_ADDR, SZ_16K, MX31_INT_UART4, pdata)
-#define imx31_add_imx_uart4(pdata)	\
-	imx_add_imx_uart_1irq(4, MX31_UART5_BASE_ADDR, SZ_16K, MX31_INT_UART5, pdata)
+extern const struct imx_uart_1irq_data imx31_imx_uart_data[] __initconst;
+#define imx31_add_imx_uart0(pdata)	imx31_add_imx_uart(0, pdata)
+#define imx31_add_imx_uart1(pdata)	imx31_add_imx_uart(1, pdata)
+#define imx31_add_imx_uart2(pdata)	imx31_add_imx_uart(2, pdata)
+#define imx31_add_imx_uart3(pdata)	imx31_add_imx_uart(3, pdata)
+#define imx31_add_imx_uart4(pdata)	imx31_add_imx_uart(4, pdata)
+#define imx31_add_imx_uart(id, pdata)	\
+	imx_add_imx_uart_1irq(&imx31_imx_uart_data[id], pdata)
 
 #define imx31_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX31_NFC_BASE_ADDR, MX31_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-mx3/devices-imx35.c b/arch/arm/mach-mx3/devices-imx35.c
new file mode 100644
index 0000000..00ca7a8
--- /dev/null
+++ b/arch/arm/mach-mx3/devices-imx35.c
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include "devices-imx35.h"
+
+const struct imx_uart_1irq_data imx35_imx_uart_data[] __initconst = {
+#define imx35_imx_uart_data_entry(_id, _hwid)				\
+	[_id] = {							\
+		.id = _id,						\
+		.iobase = MX35_UART ## _hwid ## _BASE_ADDR,		\
+		.iosize = SZ_16K,					\
+		.irq = MX35_INT_UART ## _hwid,				\
+	}
+	imx35_imx_uart_data_entry(0, 1),
+	imx35_imx_uart_data_entry(1, 2),
+	imx35_imx_uart_data_entry(2, 3),
+};
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index f6a431a..efa4587 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -21,12 +21,12 @@
 #define imx35_add_imx_i2c2(pdata)	\
 	imx_add_imx_i2c(2, MX35_I2C3_BASE_ADDR, SZ_4K, MX35_INT_I2C3, pdata)
 
-#define imx35_add_imx_uart0(pdata)	\
-	imx_add_imx_uart_1irq(0, MX35_UART1_BASE_ADDR, SZ_16K, MX35_INT_UART1, pdata)
-#define imx35_add_imx_uart1(pdata)	\
-	imx_add_imx_uart_1irq(1, MX35_UART2_BASE_ADDR, SZ_16K, MX35_INT_UART2, pdata)
-#define imx35_add_imx_uart2(pdata)	\
-	imx_add_imx_uart_1irq(2, MX35_UART3_BASE_ADDR, SZ_16K, MX35_INT_UART3, pdata)
+extern const struct imx_uart_1irq_data imx35_imx_uart_data[] __initconst;
+#define imx35_add_imx_uart0(pdata)	imx35_add_imx_uart(0, pdata)
+#define imx35_add_imx_uart1(pdata)	imx35_add_imx_uart(1, pdata)
+#define imx35_add_imx_uart2(pdata)	imx35_add_imx_uart(2, pdata)
+#define imx35_add_imx_uart(id, pdata)	\
+	imx_add_imx_uart_1irq(&imx35_imx_uart_data[id], pdata)
 
 #define imx35_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v21(MX35_NFC_BASE_ADDR, MX35_INT_NANDFC, pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
index fa3dff1..052a35d 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
@@ -8,53 +8,50 @@
  */
 #include <mach/devices-common.h>
 
-struct platform_device *__init imx_add_imx_uart_3irq(int id,
-		resource_size_t iobase, resource_size_t iosize,
-		resource_size_t irqrx, resource_size_t irqtx,
-		resource_size_t irqrts,
+struct platform_device *__init imx_add_imx_uart_3irq(
+		const struct imx_uart_3irq_data *data,
 		const struct imxuart_platform_data *pdata)
 {
 	struct resource res[] = {
 		{
-			.start = iobase,
-			.end = iobase + iosize - 1,
+			.start = data->iobase,
+			.end = data->iobase + data->iosize - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
-			.start = irqrx,
-			.end = irqrx,
+			.start = data->irqrx,
+			.end = data->irqrx,
 			.flags = IORESOURCE_IRQ,
 		}, {
-			.start = irqtx,
-			.end = irqtx,
+			.start = data->irqtx,
+			.end = data->irqtx,
 			.flags = IORESOURCE_IRQ,
 		}, {
-			.start = irqrts,
-			.end = irqrx,
+			.start = data->irqrts,
+			.end = data->irqrx,
 			.flags = IORESOURCE_IRQ,
 		},
 	};
 
-	return imx_add_platform_device("imx-uart", id, res, ARRAY_SIZE(res),
-			pdata, sizeof(*pdata));
+	return imx_add_platform_device("imx-uart", data->id, res,
+			ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
 
-struct platform_device *__init imx_add_imx_uart_1irq(int id,
-		resource_size_t iobase, resource_size_t iosize,
-		resource_size_t irq,
+struct platform_device *__init imx_add_imx_uart_1irq(
+		const struct imx_uart_1irq_data *data,
 		const struct imxuart_platform_data *pdata)
 {
 	struct resource res[] = {
 		{
-			.start = iobase,
-			.end = iobase + iosize - 1,
+			.start = data->iobase,
+			.end = data->iobase + data->iosize - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
-			.start = irq,
-			.end = irq,
+			.start = data->irq,
+			.end = data->irq,
 			.flags = IORESOURCE_IRQ,
 		},
 	};
 
-	return imx_add_platform_device("imx-uart", id, res, ARRAY_SIZE(res),
+	return imx_add_platform_device("imx-uart", data->id, res, ARRAY_SIZE(res),
 			pdata, sizeof(*pdata));
 }
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index c5f68c5..ca9e5ae 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -38,14 +38,27 @@ struct platform_device *__init imx_add_imx_i2c(int id,
 		const struct imxi2c_platform_data *pdata);
 
 #include <mach/imx-uart.h>
-struct platform_device *__init imx_add_imx_uart_3irq(int id,
-		resource_size_t iobase, resource_size_t iosize,
-		resource_size_t irqrx, resource_size_t irqtx,
-		resource_size_t irqrts,
+struct imx_uart_3irq_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irqrx;
+	resource_size_t irqtx;
+	resource_size_t irqrts;
+};
+
+struct imx_uart_1irq_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irq;
+};
+
+struct platform_device *__init imx_add_imx_uart_3irq(
+		const struct imx_uart_3irq_data *data,
 		const struct imxuart_platform_data *pdata);
-struct platform_device *__init imx_add_imx_uart_1irq(int id,
-		resource_size_t iobase, resource_size_t iosize,
-		resource_size_t irq,
+struct platform_device *__init imx_add_imx_uart_1irq(
+		const struct imx_uart_1irq_data *data,
 		const struct imxuart_platform_data *pdata);
 
 #include <mach/mxc_nand.h>
-- 
1.7.1
