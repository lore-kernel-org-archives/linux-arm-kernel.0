From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 11 Mar 2014 09:40:01 +0800
Subject: [PATCH 2/3] clk: hip04: add clock driver
In-Reply-To: <1394502002-31058-1-git-send-email-haojian.zhuang@linaro.org>
References: <1394502002-31058-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1394502002-31058-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now only fixed rate clocks are appended into the clock driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/clk/Makefile                    |  1 +
 drivers/clk/hisilicon/Makefile          |  5 ++-
 drivers/clk/hisilicon/clk-hip04.c       | 54 +++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/hip04-clock.h | 35 +++++++++++++++++++++
 4 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/hisilicon/clk-hip04.c
 create mode 100644 include/dt-bindings/clock/hip04-clock.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 88af4a3..da39c62 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
 obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
 obj-$(CONFIG_ARCH_BCM_MOBILE)		+= bcm/
 obj-$(CONFIG_ARCH_HI3xxx)		+= hisilicon/
+obj-$(CONFIG_ARCH_HIP04)		+= hisilicon/
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
index f3f11c4..352269b 100644
--- a/drivers/clk/hisilicon/Makefile
+++ b/drivers/clk/hisilicon/Makefile
@@ -2,4 +2,7 @@
 # Hisilicon Clock specific Makefile
 #
 
-obj-y	+= clk.o clkgate-separated.o clk-hi3620.o clk-hi3716.o
+obj-y	+= clk.o clkgate-separated.o
+
+obj-$(CONFIG_ARCH_HI3xxx)	+= clk-hi3620.o clk-hi3716.o
+obj-$(CONFIG_ARCH_HIP04)	+= clk-hip04.o
diff --git a/drivers/clk/hisilicon/clk-hip04.c b/drivers/clk/hisilicon/clk-hip04.c
new file mode 100644
index 0000000..bdc6cd0
--- /dev/null
+++ b/drivers/clk/hisilicon/clk-hip04.c
@@ -0,0 +1,54 @@
+/*
+ * Hisilicon HiP04 clock driver
+ *
+ * Copyright (c) 2013-2014 Hisilicon Limited.
+ * Copyright (c) 2013-2014 Linaro Limited.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
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
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+
+#include <dt-bindings/clock/hip04-clock.h>
+
+#include "clk.h"
+
+/* fixed rate clocks */
+static struct hisi_fixed_rate_clock hip04_fixed_rate_clks[] __initdata = {
+	{ HIP04_OSC50M,   "osc50m",   NULL, CLK_IS_ROOT, 50000000, },
+	{ HIP04_CLK_50M,  "clk50m",   NULL, CLK_IS_ROOT, 50000000, },
+	{ HIP04_CLK_168M, "clk168m",  NULL, CLK_IS_ROOT, 168750000, },
+};
+
+static void __init hip04_clk_init(struct device_node *np)
+{
+	hisi_clk_init(np, HIP04_NR_CLKS);
+
+	hisi_clk_register_fixed_rate(hip04_fixed_rate_clks,
+				     ARRAY_SIZE(hip04_fixed_rate_clks),
+				     NULL);
+}
+CLK_OF_DECLARE(hip04_clk, "hisilicon,hip04-clock", hip04_clk_init);
diff --git a/include/dt-bindings/clock/hip04-clock.h b/include/dt-bindings/clock/hip04-clock.h
new file mode 100644
index 0000000..695e61c
--- /dev/null
+++ b/include/dt-bindings/clock/hip04-clock.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2013-2014 Hisilicon Limited.
+ * Copyright (c) 2013-2014 Linaro Limited.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
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
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#ifndef __DTS_HIP04_CLOCK_H
+#define __DTS_HIP04_CLOCK_H
+
+#define HIP04_NONE_CLOCK	0
+
+/* fixed rate & fixed factor clocks */
+#define HIP04_OSC50M		1
+#define HIP04_CLK_50M		2
+#define HIP04_CLK_168M		3
+
+#define HIP04_NR_CLKS		64
+
+#endif	/* __DTS_HIP04_CLOCK_H */
-- 
1.8.3.2
