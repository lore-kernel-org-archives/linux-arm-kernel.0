From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun,  5 Jun 2011 23:59:05 +0800
Subject: [PATCH v4 3/3] gpio/mxs: Remove the use of gpio-mxs.h
In-Reply-To: <1307289545-6993-1-git-send-email-shawn.guo@linaro.org>
References: <1307289545-6993-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1307289545-6993-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch moves "struct mxs_gpio_port" into gpio-mxs.c, as it needs
not to be public at all.  And then the header
arch/arm/mach-mxs/include/mach/gpio-mxs.h can be deleted.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/gpio-mxs.h |   34 -----------------------------
 drivers/gpio/gpio-mxs.c                   |   10 +++++++-
 2 files changed, 9 insertions(+), 35 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/include/mach/gpio-mxs.h

diff --git a/arch/arm/mach-mxs/include/mach/gpio-mxs.h b/arch/arm/mach-mxs/include/mach/gpio-mxs.h
deleted file mode 100644
index 005bb06..0000000
--- a/arch/arm/mach-mxs/include/mach/gpio-mxs.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * Copyright 2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA  02110-1301, USA.
- */
-
-#ifndef __MXS_GPIO_H__
-#define __MXS_GPIO_H__
-
-struct mxs_gpio_port {
-	void __iomem *base;
-	int id;
-	int irq;
-	int irq_high;
-	int virtual_irq_start;
-	struct gpio_chip chip;
-};
-
-int mxs_gpio_init(struct mxs_gpio_port*, int);
-
-#endif /* __MXS_GPIO_H__ */
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 6fd9f01..a287614 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -28,7 +28,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <mach/mxs.h>
-#include <mach/gpio-mxs.h>
 
 #define MXS_SET		0x4
 #define MXS_CLR		0x8
@@ -49,6 +48,15 @@
 #define GPIO_INT_LEV_MASK	(1 << 0)
 #define GPIO_INT_POL_MASK	(1 << 1)
 
+struct mxs_gpio_port {
+	void __iomem *base;
+	int id;
+	int irq;
+	int irq_high;
+	int virtual_irq_start;
+	struct gpio_chip chip;
+};
+
 /* Note: This driver assumes 32 GPIOs are handled in one register */
 
 static void clear_gpio_irqstatus(struct mxs_gpio_port *port, u32 index)
-- 
1.7.4.1
