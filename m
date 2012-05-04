From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri,  4 May 2012 20:30:23 +0800
Subject: [PATCH v2 6/9] ARM: mmp: support mmp2 with device tree
In-Reply-To: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1336134626-12262-7-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/Makefile  |    1 +
 arch/arm/mach-mmp/mmp2-dt.c |   60 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/mmp2-dt.c

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 77f63c1..b920b9b 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -19,5 +19,6 @@ obj-$(CONFIG_MACH_BROWNSTONE)	+= brownstone.o
 obj-$(CONFIG_MACH_FLINT)	+= flint.o
 obj-$(CONFIG_MACH_MARVELL_JASPER) += jasper.o
 obj-$(CONFIG_MACH_MMP_DT)	+= mmp-dt.o
+obj-$(CONFIG_MACH_MMP2_DT)	+= mmp2-dt.o
 obj-$(CONFIG_MACH_TETON_BGA)	+= teton_bga.o
 obj-$(CONFIG_MACH_GPLUGD)	+= gplugd.o
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
new file mode 100644
index 0000000..535a5ed
--- /dev/null
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -0,0 +1,60 @@
+/*
+ *  linux/arch/arm/mach-mmp/mmp2-dt.c
+ *
+ *  Copyright (C) 2012 Marvell Technology Group Ltd.
+ *  Author: Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <mach/irqs.h>
+#include <mach/regs-apbc.h>
+
+#include "common.h"
+
+extern void __init mmp_dt_irq_init(void);
+extern void __init mmp_dt_init_timer(void);
+
+static struct sys_timer mmp_dt_timer = {
+	.init	= mmp_dt_init_timer,
+};
+
+static const struct of_dev_auxdata mmp2_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4030000, "pxa2xx-uart.0", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4017000, "pxa2xx-uart.1", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4018000, "pxa2xx-uart.2", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4016000, "pxa2xx-uart.3", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4011000, "pxa2xx-i2c.0", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4025000, "pxa2xx-i2c.1", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "pxa-gpio", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-rtc", 0xd4010000, "sa1100-rtc", NULL),
+	{}
+};
+
+static void __init mmp2_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     mmp2_auxdata_lookup, NULL);
+}
+
+static const char *mmp2_dt_board_compat[] __initdata = {
+	"mrvl,mmp2-brownstone",
+	NULL,
+};
+
+DT_MACHINE_START(MMP2_DT, "Marvell MMP2 (Device Tree Support)")
+	.map_io		= mmp_map_io,
+	.init_irq	= mmp_dt_irq_init,
+	.timer		= &mmp_dt_timer,
+	.init_machine	= mmp2_dt_init,
+	.dt_compat	= mmp2_dt_board_compat,
+MACHINE_END
-- 
1.7.5.4
