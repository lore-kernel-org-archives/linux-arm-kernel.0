From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Nov 2013 13:59:04 +0100
Subject: [PATCH 2/2] ARM: lpc32xx: move custom GPIO header
Message-ID: <1385038744-9780-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move <mach/gpio-lpc32xx.h> to <linux/platform_data/gpio-lpc32xx.h>.

Cc: Roland Stigge <stigge@antcom.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Roland: can you please ACK this patch so I can take this through
the GPIO tree?

BTW: the LPC32xx GPIO driver could use some love, so when you have
the time: get rid of this platform data and break the need for
<linux/platform_data/gpio-lpc32xx.h> altogether. Well, the driver
should not really need to include any <mach/*> header before I'm
really happy actually...
---
 arch/arm/mach-lpc32xx/include/mach/gpio-lpc32xx.h | 50 -----------------------
 arch/arm/mach-lpc32xx/phy3250.c                   |  2 +-
 drivers/gpio/gpio-lpc32xx.c                       |  2 +-
 include/linux/platform_data/gpio-lpc32xx.h        | 50 +++++++++++++++++++++++
 4 files changed, 52 insertions(+), 52 deletions(-)
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/gpio-lpc32xx.h
 create mode 100644 include/linux/platform_data/gpio-lpc32xx.h

diff --git a/arch/arm/mach-lpc32xx/include/mach/gpio-lpc32xx.h b/arch/arm/mach-lpc32xx/include/mach/gpio-lpc32xx.h
deleted file mode 100644
index a544e962a818..000000000000
--- a/arch/arm/mach-lpc32xx/include/mach/gpio-lpc32xx.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- * Author: Kevin Wells <kevin.wells@nxp.com>
- *
- * Copyright (C) 2010 NXP Semiconductors
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef __MACH_GPIO_LPC32XX_H
-#define __MACH_GPIO_LPC32XX_H
-
-/*
- * Note!
- * Muxed GP pins need to be setup to the GP state in the board level
- * code prior to using this driver.
- * GPI pins : 28xP3 group
- * GPO pins : 24xP3 group
- * GPIO pins: 8xP0 group, 24xP1 group, 13xP2 group, 6xP3 group
- */
-
-#define LPC32XX_GPIO_P0_MAX 8
-#define LPC32XX_GPIO_P1_MAX 24
-#define LPC32XX_GPIO_P2_MAX 13
-#define LPC32XX_GPIO_P3_MAX 6
-#define LPC32XX_GPI_P3_MAX 29
-#define LPC32XX_GPO_P3_MAX 24
-
-#define LPC32XX_GPIO_P0_GRP 0
-#define LPC32XX_GPIO_P1_GRP (LPC32XX_GPIO_P0_GRP + LPC32XX_GPIO_P0_MAX)
-#define LPC32XX_GPIO_P2_GRP (LPC32XX_GPIO_P1_GRP + LPC32XX_GPIO_P1_MAX)
-#define LPC32XX_GPIO_P3_GRP (LPC32XX_GPIO_P2_GRP + LPC32XX_GPIO_P2_MAX)
-#define LPC32XX_GPI_P3_GRP (LPC32XX_GPIO_P3_GRP + LPC32XX_GPIO_P3_MAX)
-#define LPC32XX_GPO_P3_GRP (LPC32XX_GPI_P3_GRP + LPC32XX_GPI_P3_MAX)
-
-/*
- * A specific GPIO can be selected with this macro
- * ie, GPIO_05 can be selected with LPC32XX_GPIO(LPC32XX_GPIO_P3_GRP, 5)
- * See the LPC32x0 User's guide for GPIO group numbers
- */
-#define LPC32XX_GPIO(x, y) ((x) + (y))
-
-#endif /* __MACH_GPIO_LPC32XX_H */
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index e54f87ec2e4a..34932e0e31fa 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -36,6 +36,7 @@
 #include <linux/clk.h>
 #include <linux/mtd/lpc32xx_slc.h>
 #include <linux/mtd/lpc32xx_mlc.h>
+#include <linux/platform_data/gpio-lpc32xx.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -44,7 +45,6 @@
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include <mach/board.h>
-#include <mach/gpio-lpc32xx.h>
 #include "common.h"
 
 /*
diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
index 2d5555decf0c..a7093e010149 100644
--- a/drivers/gpio/gpio-lpc32xx.c
+++ b/drivers/gpio/gpio-lpc32xx.c
@@ -25,10 +25,10 @@
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/platform_data/gpio-lpc32xx.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <mach/gpio-lpc32xx.h>
 #include <mach/irqs.h>
 
 #define LPC32XX_GPIO_P3_INP_STATE		_GPREG(0x000)
diff --git a/include/linux/platform_data/gpio-lpc32xx.h b/include/linux/platform_data/gpio-lpc32xx.h
new file mode 100644
index 000000000000..a544e962a818
--- /dev/null
+++ b/include/linux/platform_data/gpio-lpc32xx.h
@@ -0,0 +1,50 @@
+/*
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __MACH_GPIO_LPC32XX_H
+#define __MACH_GPIO_LPC32XX_H
+
+/*
+ * Note!
+ * Muxed GP pins need to be setup to the GP state in the board level
+ * code prior to using this driver.
+ * GPI pins : 28xP3 group
+ * GPO pins : 24xP3 group
+ * GPIO pins: 8xP0 group, 24xP1 group, 13xP2 group, 6xP3 group
+ */
+
+#define LPC32XX_GPIO_P0_MAX 8
+#define LPC32XX_GPIO_P1_MAX 24
+#define LPC32XX_GPIO_P2_MAX 13
+#define LPC32XX_GPIO_P3_MAX 6
+#define LPC32XX_GPI_P3_MAX 29
+#define LPC32XX_GPO_P3_MAX 24
+
+#define LPC32XX_GPIO_P0_GRP 0
+#define LPC32XX_GPIO_P1_GRP (LPC32XX_GPIO_P0_GRP + LPC32XX_GPIO_P0_MAX)
+#define LPC32XX_GPIO_P2_GRP (LPC32XX_GPIO_P1_GRP + LPC32XX_GPIO_P1_MAX)
+#define LPC32XX_GPIO_P3_GRP (LPC32XX_GPIO_P2_GRP + LPC32XX_GPIO_P2_MAX)
+#define LPC32XX_GPI_P3_GRP (LPC32XX_GPIO_P3_GRP + LPC32XX_GPIO_P3_MAX)
+#define LPC32XX_GPO_P3_GRP (LPC32XX_GPI_P3_GRP + LPC32XX_GPI_P3_MAX)
+
+/*
+ * A specific GPIO can be selected with this macro
+ * ie, GPIO_05 can be selected with LPC32XX_GPIO(LPC32XX_GPIO_P3_GRP, 5)
+ * See the LPC32x0 User's guide for GPIO group numbers
+ */
+#define LPC32XX_GPIO(x, y) ((x) + (y))
+
+#endif /* __MACH_GPIO_LPC32XX_H */
-- 
1.8.3.1
