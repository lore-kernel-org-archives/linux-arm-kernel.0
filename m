From: sangsu4u.park@samsung.com (Sangsu Park)
Date: Wed, 06 Feb 2013 14:50:59 +0900
Subject: [PATCH V2] ARM: EXYNOS: Add clocks for EXYNOS I2S and PCM I/F
Message-ID: <003701ce042d$f0dc9370$d295ba50$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Audio Subsystem has own clocks for I2S0 and PCM0 in all EXYNOS series.
This patch add clocks for I2S0 and PCM0 I/F.

Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
---
 arch/arm/mach-exynos/Makefile      |    1 +
 arch/arm/mach-exynos/clock-audss.c |   64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-exynos/clock-audss.c

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 7e53a3a..5b6c7c0 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -13,6 +13,7 @@ obj-				:=
 # Core
 
 obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
+obj-$(CONFIG_ARCH_EXYNOS)	+= clock-audss.o
 obj-$(CONFIG_ARCH_EXYNOS4)	+= clock-exynos4.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
 obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
diff --git a/arch/arm/mach-exynos/clock-audss.c
b/arch/arm/mach-exynos/clock-audss.c
new file mode 100644
index 0000000..e817655
--- /dev/null
+++ b/arch/arm/mach-exynos/clock-audss.c
@@ -0,0 +1,64 @@
+/*
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Clock support for EXYNOS Audio Subsystem
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <plat/clock.h>
+#include <plat/s5p-clock.h>
+
+#define EXYNOS_PA_AUDSS	(0x03810000)
+
+/* IP Clock Gate 0 Registers */
+#define EXYNOS_AUDSS_CLKGATE_I2SBUS	(1<<2)
+#define EXYNOS_AUDSS_CLKGATE_I2SSPECIAL	(1<<3)
+#define EXYNOS_AUDSS_CLKGATE_PCMBUS	(1<<4)
+#define EXYNOS_AUDSS_CLKGATE_PCMSPECIAL	(1<<5)
+#define EXYNOS_AUDSS_CLKGATE_GPIO	(1<<6)
+
+static void __iomem *clk_audss_base = 0;
+
+static int exynos_clk_audss_ctrl(struct clk *clk, int enable)
+{
+	if (!clk_audss_base)
+		return -ENOMEM;
+
+	return s5p_gatectrl(clk_audss_base, clk, enable);
+}
+
+static struct clk exynos_init_audss_clocks[] = {
+	{
+		.name		= "iis",
+		.devname	= "samsung-i2s.0",
+		.enable		= exynos_clk_audss_ctrl,
+		.ctrlbit	= EXYNOS_AUDSS_CLKGATE_I2SSPECIAL |
EXYNOS_AUDSS_CLKGATE_I2SBUS
+				| EXYNOS_AUDSS_CLKGATE_GPIO,
+	}, {
+		.name		= "pcm",
+		.devname	= "samsung-pcm.0",
+		.enable		= exynos_clk_audss_ctrl,
+		.ctrlbit	= EXYNOS_AUDSS_CLKGATE_PCMSPECIAL |
EXYNOS_AUDSS_CLKGATE_PCMBUS
+				| EXYNOS_AUDSS_CLKGATE_GPIO,
+	},
+};
+
+void __init exynos_register_audss_clocks(void)
+{
+	clk_audss_base = ioremap(EXYNOS_PA_AUDSS, SZ_4K);
+	if (clk_audss_base == NULL) {
+		pr_err("unable to ioremap for gpio_base1\n");
+		return;
+	}
+
+	s3c_register_clocks(exynos_init_audss_clocks,
ARRAY_SIZE(exynos_init_audss_clocks));
+	s3c_disable_clocks(exynos_init_audss_clocks,
ARRAY_SIZE(exynos_init_audss_clocks));
+}
-- 
1.7.4.1
