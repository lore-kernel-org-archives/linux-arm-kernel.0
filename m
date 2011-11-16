From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 16 Nov 2011 11:47:37 +0100
Subject: [PATCH 1/3] drivers: base: add support for stmp-style devices
In-Reply-To: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
References: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1321440459-4527-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/base/Kconfig        |    3 ++
 drivers/base/Makefile       |    1 +
 drivers/base/stmp_device.c  |   80 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/stmp_device.h |   19 ++++++++++
 4 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100644 drivers/base/stmp_device.c
 create mode 100644 include/linux/stmp_device.h

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 21cf46f..331f78f 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -172,6 +172,9 @@ config SYS_HYPERVISOR
 	bool
 	default n
 
+config STMP_DEVICE
+	bool
+
 source "drivers/base/regmap/Kconfig"
 
 endmenu
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 99a375a..b865072 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -17,6 +17,7 @@ ifeq ($(CONFIG_SYSFS),y)
 obj-$(CONFIG_MODULES)	+= module.o
 endif
 obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
+obj-$(CONFIG_STMP_DEVICE) += stmp_device.o
 obj-$(CONFIG_REGMAP)	+= regmap/
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
diff --git a/drivers/base/stmp_device.c b/drivers/base/stmp_device.c
new file mode 100644
index 0000000..3e261e6
--- /dev/null
+++ b/drivers/base/stmp_device.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 1999 ARM Limited
+ * Copyright (C) 2000 Deep Blue Solutions Ltd
+ * Copyright 2006-2007,2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
+ * Copyright 2009 Ilya Yanok, Emcraft Systems Ltd, yanok at emcraft.com
+ * Copyright (C) 2011 Wolfram Sang, Pengutronix e.K.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/stmp_device.h>
+
+#define STMP_MODULE_CLKGATE	(1 << 30)
+#define STMP_MODULE_SFTRST	(1 << 31)
+
+/*
+ * Clear the bit and poll it cleared.  This is usually called with
+ * a reset address and mask being either SFTRST(bit 31) or CLKGATE
+ * (bit 30).
+ */
+static int stmp_clear_poll_bit(void __iomem *addr, u32 mask)
+{
+	int timeout = 0x400;
+
+	writel(mask, addr + STMP_CLR_ADDR);
+	udelay(1);
+	while ((readl(addr) & mask) && --timeout)
+		/* nothing */;
+
+	return !timeout;
+}
+
+int stmp_reset_block(void __iomem *reset_addr)
+{
+	int ret;
+	int timeout = 0x400;
+
+	/* clear and poll SFTRST */
+	ret = stmp_clear_poll_bit(reset_addr, STMP_MODULE_SFTRST);
+	if (unlikely(ret))
+		goto error;
+
+	/* clear CLKGATE */
+	writel(STMP_MODULE_CLKGATE, reset_addr + STMP_CLR_ADDR);
+
+	/* set SFTRST to reset the block */
+	writel(STMP_MODULE_SFTRST, reset_addr + STMP_SET_ADDR);
+	udelay(1);
+
+	/* poll CLKGATE becoming set */
+	while ((!(readl(reset_addr) & STMP_MODULE_CLKGATE)) && --timeout)
+		/* nothing */;
+	if (unlikely(!timeout))
+		goto error;
+
+	/* clear and poll SFTRST */
+	ret = stmp_clear_poll_bit(reset_addr, STMP_MODULE_SFTRST);
+	if (unlikely(ret))
+		goto error;
+
+	/* clear and poll CLKGATE */
+	ret = stmp_clear_poll_bit(reset_addr, STMP_MODULE_CLKGATE);
+	if (unlikely(ret))
+		goto error;
+
+	return 0;
+
+error:
+	pr_err("%s(%p): module reset timeout\n", __func__, reset_addr);
+	return -ETIMEDOUT;
+}
+EXPORT_SYMBOL(stmp_reset_block);
diff --git a/include/linux/stmp_device.h b/include/linux/stmp_device.h
new file mode 100644
index 0000000..330f8d8
--- /dev/null
+++ b/include/linux/stmp_device.h
@@ -0,0 +1,19 @@
+/*
+ * basic functions for devices following the "stmp" style register layout
+ *
+ * Copyright (C) 2011 Wolfram Sang, Pengutronix e.K.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#ifndef __STMP_DEVICE_H__
+#define __STMP_DEVICE_H__
+
+#define STMP_SET_ADDR		0x4
+#define STMP_CLR_ADDR		0x8
+#define STMP_TOG_ADDR		0xc
+
+extern int stmp_reset_block(void __iomem *);
+#endif /* __STMP_DEVICE_H__ */
-- 
1.7.7.1
