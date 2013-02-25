From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 25 Feb 2013 17:30:16 +0100
Subject: [PATCH 1/4] ARM: imx: Add cpufreq support for i.MX27
In-Reply-To: <1361809819-24383-1-git-send-email-mpa@pengutronix.de>
References: <1361809819-24383-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1361809819-24383-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christian Hemp <c.hemp@phytec.de>

Adding cpu scaling support for the i.MX27. It supports 399MHz and 133MHz now.

[mpa: rebase to 3.8-rc, adaption for clock framework, cleanup]

Signed-off-by: Teresa G?mez <t.gamez@phytec.de>
Signed-off-by: Christian Hemp <c.hemp@phytec.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig       |  1 +
 arch/arm/mach-imx/Makefile      |  3 +++
 arch/arm/mach-imx/clk-imx27.c   |  5 +++++
 arch/arm/mach-imx/cpu_op-mx27.c | 37 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/cpu_op-mx27.h | 19 +++++++++++++++++++
 5 files changed, 65 insertions(+)
 create mode 100644 arch/arm/mach-imx/cpu_op-mx27.c
 create mode 100644 arch/arm/mach-imx/cpu_op-mx27.h

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0a2349d..5184f12 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -131,6 +131,7 @@ config SOC_IMX25
 
 config SOC_IMX27
 	bool
+	select ARCH_HAS_CPUFREQ
 	select COMMON_CLK
 	select CPU_ARM926T
 	select IMX_HAVE_IOMUX_V1
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 0634b31..3118ed4 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -7,6 +7,9 @@ obj-$(CONFIG_SOC_IMX25) += clk-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o
 
 obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_SOC_IMX27) += clk-imx27.o mm-imx27.o ehci-imx27.o
+ifdef CONFIG_SOC_IMX27
+obj-$(CONFIG_CPU_FREQ_IMX) += cpu_op-mx27.o
+endif
 
 obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clk-imx31.o iomux-imx31.o ehci-imx31.o pm-imx3.o
 obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clk-imx35.o ehci-imx35.o pm-imx3.o
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 1ffe3b534..d98bfb0 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -9,6 +9,7 @@
 #include "clk.h"
 #include "common.h"
 #include "hardware.h"
+#include "cpu_op-mx27.h"
 
 #define IO_ADDR_CCM(off)	(MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR + (off)))
 
@@ -91,6 +92,10 @@ int __init mx27_clocks_init(unsigned long fref)
 {
 	int i;
 
+#if defined(CONFIG_CPU_FREQ_IMX)
+	get_cpu_op = mx27_get_cpu_op;
+#endif
+
 	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[ckih] = imx_clk_fixed("ckih", fref);
 	clk[ckil] = imx_clk_fixed("ckil", 32768);
diff --git a/arch/arm/mach-imx/cpu_op-mx27.c b/arch/arm/mach-imx/cpu_op-mx27.c
new file mode 100644
index 0000000..fa2d743
--- /dev/null
+++ b/arch/arm/mach-imx/cpu_op-mx27.c
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2011 Teresa G?mez <t.gamez@phytec.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include <linux/bug.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+#include "hardware.h"
+
+static struct cpu_op mx27_cpu_op[] = {
+	{
+		.cpu_rate = 133000000,
+	}, {
+		.cpu_rate = 399000000,
+	},
+};
+
+struct cpu_op *mx27_get_cpu_op(int *op)
+{
+	*op = ARRAY_SIZE(mx27_cpu_op);
+	return mx27_cpu_op;
+}
diff --git a/arch/arm/mach-imx/cpu_op-mx27.h b/arch/arm/mach-imx/cpu_op-mx27.h
new file mode 100644
index 0000000..4e9162a
--- /dev/null
+++ b/arch/arm/mach-imx/cpu_op-mx27.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2011 Teresa G?mez <t.gamez@phytec.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+extern struct cpu_op *mx27_get_cpu_op(int *op);
-- 
1.8.1.2
