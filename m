From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat,  3 Mar 2012 23:19:44 +0800
Subject: [PATCH 03/20] ARM: imx: merge audmux-v1 and audmux-v2
In-Reply-To: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330788001-10158-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It merges audmux-v1 and audmux-v2 under arch/arm/plat-mxc into one.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig                   |   12 +++---
 arch/arm/plat-mxc/Kconfig                   |    5 +--
 arch/arm/plat-mxc/Makefile                  |    3 +-
 arch/arm/plat-mxc/audmux-v1.c               |   64 ---------------------------
 arch/arm/plat-mxc/{audmux-v2.c => audmux.c} |   29 +++++++++++-
 5 files changed, 34 insertions(+), 79 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/audmux-v1.c
 rename arch/arm/plat-mxc/{audmux-v2.c => audmux.c} (89%)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4defb97..495a854 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -46,7 +46,7 @@ config SOC_IMX21
 	bool
 	select MACH_MX21
 	select CPU_ARM926T
-	select ARCH_MXC_AUDMUX_V1
+	select ARCH_MXC_AUDMUX
 	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
@@ -55,7 +55,7 @@ config SOC_IMX25
 	bool
 	select ARCH_MX25
 	select CPU_ARM926T
-	select ARCH_MXC_AUDMUX_V2
+	select ARCH_MXC_AUDMUX
 	select ARCH_MXC_IOMUX_V3
 	select MXC_AVIC
 
@@ -63,7 +63,7 @@ config SOC_IMX27
 	bool
 	select MACH_MX27
 	select CPU_ARM926T
-	select ARCH_MXC_AUDMUX_V1
+	select ARCH_MXC_AUDMUX
 	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
@@ -72,7 +72,7 @@ config SOC_IMX31
 	bool
 	select CPU_V6
 	select IMX_HAVE_PLATFORM_MXC_RNGA
-	select ARCH_MXC_AUDMUX_V2
+	select ARCH_MXC_AUDMUX
 	select MXC_AVIC
 	select SMP_ON_UP if SMP
 
@@ -80,7 +80,7 @@ config SOC_IMX35
 	bool
 	select CPU_V6
 	select ARCH_MXC_IOMUX_V3
-	select ARCH_MXC_AUDMUX_V2
+	select ARCH_MXC_AUDMUX
 	select HAVE_EPIT
 	select MXC_AVIC
 	select SMP_ON_UP if SMP
@@ -89,7 +89,7 @@ config SOC_IMX5
 	select CPU_V7
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
-	select ARCH_MXC_AUDMUX_V2
+	select ARCH_MXC_AUDMUX
 	select ARCH_HAS_CPUFREQ
 	select ARCH_MX5
 	bool
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index dcebb12..0461d16 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -88,10 +88,7 @@ config IMX_HAVE_IOMUX_V1
 config ARCH_MXC_IOMUX_V3
 	bool
 
-config ARCH_MXC_AUDMUX_V1
-	bool
-
-config ARCH_MXC_AUDMUX_V2
+config ARCH_MXC_AUDMUX
 	bool
 
 config IRAM_ALLOC
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 076db84f..530c81d 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -14,8 +14,7 @@ obj-$(CONFIG_IRAM_ALLOC) += iram_alloc.o
 obj-$(CONFIG_MXC_PWM)  += pwm.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
-obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
-obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
+obj-$(CONFIG_ARCH_MXC_AUDMUX) += audmux.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
 ifdef CONFIG_SND_IMX_SOC
diff --git a/arch/arm/plat-mxc/audmux-v1.c b/arch/arm/plat-mxc/audmux-v1.c
deleted file mode 100644
index 1180bef..0000000
--- a/arch/arm/plat-mxc/audmux-v1.c
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
- *
- * Initial development of this code was funded by
- * Phytec Messtechnik GmbH, http://www.phytec.de
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
-#include <linux/module.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <mach/audmux.h>
-#include <mach/hardware.h>
-
-static void __iomem *audmux_base;
-
-static unsigned char port_mapping[] = {
-	0x0, 0x4, 0x8, 0x10, 0x14, 0x1c,
-};
-
-int mxc_audmux_v1_configure_port(unsigned int port, unsigned int pcr)
-{
-	if (!audmux_base) {
-		printk("%s: not configured\n", __func__);
-		return -ENOSYS;
-	}
-
-	if (port >= ARRAY_SIZE(port_mapping))
-		return -EINVAL;
-
-	writel(pcr, audmux_base + port_mapping[port]);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mxc_audmux_v1_configure_port);
-
-static int mxc_audmux_v1_init(void)
-{
-#ifdef CONFIG_MACH_MX21
-	if (cpu_is_mx21())
-		audmux_base = MX21_IO_ADDRESS(MX21_AUDMUX_BASE_ADDR);
-	else
-#endif
-#ifdef CONFIG_MACH_MX27
-	if (cpu_is_mx27())
-		audmux_base = MX27_IO_ADDRESS(MX27_AUDMUX_BASE_ADDR);
-	else
-#endif
-		(void)0;
-	
-	return 0;
-}
-
-postcore_initcall(mxc_audmux_v1_init);
diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux.c
similarity index 89%
rename from arch/arm/plat-mxc/audmux-v2.c
rename to arch/arm/plat-mxc/audmux.c
index 8cced35..f6dc536 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux.c
@@ -165,6 +165,24 @@ static inline void audmux_debugfs_init(void)
 }
 #endif
 
+static unsigned char port_mapping[] = {
+	0x0, 0x4, 0x8, 0x10, 0x14, 0x1c,
+};
+
+int mxc_audmux_v1_configure_port(unsigned int port, unsigned int pcr)
+{
+	if (!audmux_base)
+		return -ENOSYS;
+
+	if (port >= ARRAY_SIZE(port_mapping))
+		return -EINVAL;
+
+	writel(pcr, audmux_base + port_mapping[port]);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mxc_audmux_v1_configure_port);
+
 int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 		unsigned int pdcr)
 {
@@ -184,7 +202,7 @@ int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 }
 EXPORT_SYMBOL_GPL(mxc_audmux_v2_configure_port);
 
-static int mxc_audmux_v2_init(void)
+static int mxc_audmux_init(void)
 {
 	int ret;
 	if (cpu_is_mx51()) {
@@ -209,11 +227,16 @@ static int mxc_audmux_v2_init(void)
 			return ret;
 		}
 		audmux_base = MX25_IO_ADDRESS(MX25_AUDMUX_BASE_ADDR);
+	} else if (cpu_is_mx27()) {
+		audmux_base = MX27_IO_ADDRESS(MX27_AUDMUX_BASE_ADDR);
+	} else if (cpu_is_mx21()) {
+		audmux_base = MX21_IO_ADDRESS(MX21_AUDMUX_BASE_ADDR);
 	}
 
-	audmux_debugfs_init();
+	if (!cpu_is_mx2())
+		audmux_debugfs_init();
 
 	return 0;
 }
 
-postcore_initcall(mxc_audmux_v2_init);
+postcore_initcall(mxc_audmux_init);
-- 
1.7.5.4
