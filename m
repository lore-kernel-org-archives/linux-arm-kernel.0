From: rubini@gnudd.com (Alessandro Rubini)
Date: Wed, 30 May 2012 19:45:43 +0200
Subject: [PATCH RFC 1/3] i2c-nomadik: move header from <plat/i2c.h> to
 <linux/i2c-nomadik.h>
In-Reply-To: <cover.1338398567.git.rubini@gnudd.com>
References: <cover.1338398567.git.rubini@gnudd.com>
Message-ID: <ca47a47e0a4db31545549ed978e1dc7b3aad4377.1338398567.git.rubini@gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header and driver were only used by arm/mach-nomadik and
arm/mach-u8500.  The STA2X11 I/O Hub exports on PCIe a number of
devices, including i2c-nomadik.  This patch allows compilation of
the driver under x86.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
---
 arch/arm/mach-ux500/board-mop500.c       |    2 +-
 arch/arm/mach-ux500/devices-common.h     |    2 +-
 arch/arm/plat-nomadik/include/plat/i2c.h |   39 ------------------------------
 drivers/i2c/busses/i2c-nomadik.c         |    3 +-
 include/linux/i2c-nomadik.h              |   39 ++++++++++++++++++++++++++++++
 5 files changed, 42 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/plat-nomadik/include/plat/i2c.h
 create mode 100644 include/linux/i2c-nomadik.h

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index fba8ade..2117683 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
+#include <linux/i2c-nomadik.h>
 #include <linux/gpio.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl022.h>
@@ -39,7 +40,6 @@
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
 
-#include <plat/i2c.h>
 #include <plat/ste_dma40.h>
 #include <plat/gpio-nomadik.h>
 
diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
index 6e47065..50d1292 100644
--- a/arch/arm/mach-ux500/devices-common.h
+++ b/arch/arm/mach-ux500/devices-common.h
@@ -12,7 +12,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/sys_soc.h>
 #include <linux/amba/bus.h>
-#include <plat/i2c.h>
+#include <linux/i2c-nomadik.h>
 #include <mach/crypto-ux500.h>
 
 struct spi_master_cntlr;
diff --git a/arch/arm/plat-nomadik/include/plat/i2c.h b/arch/arm/plat-nomadik/include/plat/i2c.h
deleted file mode 100644
index 8ba70ff..0000000
--- a/arch/arm/plat-nomadik/include/plat/i2c.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * Copyright (C) 2009 ST-Ericsson
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2, as
- * published by the Free Software Foundation.
- */
-#ifndef __PLAT_I2C_H
-#define __PLAT_I2C_H
-
-enum i2c_freq_mode {
-	I2C_FREQ_MODE_STANDARD,		/* up to 100 Kb/s */
-	I2C_FREQ_MODE_FAST,		/* up to 400 Kb/s */
-	I2C_FREQ_MODE_HIGH_SPEED,	/* up to 3.4 Mb/s */
-	I2C_FREQ_MODE_FAST_PLUS,	/* up to 1 Mb/s */
-};
-
-/**
- * struct nmk_i2c_controller - client specific controller configuration
- * @clk_freq:	clock frequency for the operation mode
- * @slsu:	Slave data setup time in ns.
- *		The needed setup time for three modes of operation
- *		are 250ns, 100ns and 10ns respectively thus leading
- *		to the values of 14, 6, 2 for a 48 MHz i2c clk
- * @tft:	Tx FIFO Threshold in bytes
- * @rft:	Rx FIFO Threshold in bytes
- * @timeout	Slave response timeout(ms)
- * @sm:		speed mode
- */
-struct nmk_i2c_controller {
-	unsigned long	clk_freq;
-	unsigned short	slsu;
-	unsigned char	tft;
-	unsigned char	rft;
-	int timeout;
-	enum i2c_freq_mode	sm;
-};
-
-#endif	/* __PLAT_I2C_H */
diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 5267ab9..09b7589 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -23,8 +23,7 @@
 #include <linux/io.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
-
-#include <plat/i2c.h>
+#include <linux/i2c-nomadik.h>
 
 #define DRIVER_NAME "nmk-i2c"
 
diff --git a/include/linux/i2c-nomadik.h b/include/linux/i2c-nomadik.h
new file mode 100644
index 0000000..9350fe9
--- /dev/null
+++ b/include/linux/i2c-nomadik.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2009 ST-Ericsson
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ */
+#ifndef __LINUX_I2C_NOMADIK_H
+#define __LINUX_I2C_NOMADIK_H
+
+enum i2c_freq_mode {
+	I2C_FREQ_MODE_STANDARD,		/* up to 100 Kb/s */
+	I2C_FREQ_MODE_FAST,		/* up to 400 Kb/s */
+	I2C_FREQ_MODE_HIGH_SPEED,	/* up to 3.4 Mb/s */
+	I2C_FREQ_MODE_FAST_PLUS,	/* up to 1 Mb/s */
+};
+
+/**
+ * struct nmk_i2c_controller - client specific controller configuration
+ * @clk_freq:	clock frequency for the operation mode
+ * @slsu:	Slave data setup time in ns.
+ *		The needed setup time for three modes of operation
+ *		are 250ns, 100ns and 10ns respectively thus leading
+ *		to the values of 14, 6, 2 for a 48 MHz i2c clk
+ * @tft:	Tx FIFO Threshold in bytes
+ * @rft:	Rx FIFO Threshold in bytes
+ * @timeout	Slave response timeout(ms)
+ * @sm:		speed mode
+ */
+struct nmk_i2c_controller {
+	unsigned long	clk_freq;
+	unsigned short	slsu;
+	unsigned char	tft;
+	unsigned char	rft;
+	int timeout;
+	enum i2c_freq_mode	sm;
+};
+
+#endif	/* __LINUX_I2C_NOMADIK_H */
-- 
1.7.7.2
