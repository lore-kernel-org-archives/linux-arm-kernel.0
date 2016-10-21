From: octavian.purdila@nxp.com (Octavian Purdila)
Date: Fri, 21 Oct 2016 10:18:20 +0300
Subject: [PATCH 1/2] ARM: imx: add ocotp support in machine code
In-Reply-To: <1477034301-26579-1-git-send-email-octavian.purdila@nxp.com>
References: <1477034301-26579-1-git-send-email-octavian.purdila@nxp.com>
Message-ID: <1477034301-26579-2-git-send-email-octavian.purdila@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we will have the need to access OCOTP fuse registers from
multiple places move the ocotp initialization and register access code
to a new file and provide interfaces for it.

Signed-off-by: Octavian Purdila <octavian.purdila@nxp.com>
---
 arch/arm/mach-imx/Kconfig       |  5 +++++
 arch/arm/mach-imx/Makefile      |  1 +
 arch/arm/mach-imx/common.h      |  2 ++
 arch/arm/mach-imx/mach-imx6q.c  | 20 ++------------------
 arch/arm/mach-imx/mach-imx6sl.c |  1 +
 arch/arm/mach-imx/mach-imx6sx.c |  1 +
 arch/arm/mach-imx/mach-imx7d.c  |  1 +
 arch/arm/mach-imx/ocotp.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 53 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/mach-imx/ocotp.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0ac05a0..1fb36ee 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -58,6 +58,9 @@ config HAVE_IMX_SRC
 	def_bool y if SMP
 	select ARCH_HAS_RESET_CONTROLLER
 
+config HAVE_IMX_OCOTP
+	bool
+
 config IMX_HAVE_IOMUX_V1
 	bool
 
@@ -492,6 +495,7 @@ config SOC_IMX6
 	select HAVE_IMX_SRC
 	select MFD_SYSCON
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select HAVE_IMX_OCOTP
 
 config SOC_IMX6Q
 	bool "i.MX6 Quad/DualLite support"
@@ -537,6 +541,7 @@ config SOC_IMX7D
 	select HAVE_IMX_ANATOP
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
+	select HAVE_IMX_OCOTP
 	help
 		This enables support for Freescale i.MX7 Dual processor.
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index cab1289..feef1cf 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_HAVE_IMX_ANATOP) += anatop.o
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
 obj-$(CONFIG_HAVE_IMX_SRC) += src.o
+obj-$(CONFIG_HAVE_IMX_OCOTP) += ocotp.o
 ifneq ($(CONFIG_SOC_IMX6)$(CONFIG_SOC_LS1021A),)
 AFLAGS_headsmp.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index c4436d9..fc78d4d0 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -103,6 +103,8 @@ void imx_gpc_hwirq_unmask(unsigned int hwirq);
 void imx_anatop_init(void);
 void imx_anatop_pre_suspend(void);
 void imx_anatop_post_resume(void);
+void imx_ocotp_init(const char *ocotp_compat);
+u32 imx_ocotp_read(u32 offset);
 int imx6_set_lpm(enum mxc_cpu_pwr_mode mode);
 void imx6_set_int_mem_clk_lpm(bool enable);
 void imx6sl_set_wait_clk(bool enter);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 97fd251..51f6c19 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -280,6 +280,7 @@ static void __init imx6q_init_machine(void)
 
 	of_platform_default_populate(NULL, NULL, parent);
 
+	imx_ocotp_init("fsl,imx6q-ocotp");
 	imx_anatop_init();
 	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
 	imx6q_1588_init();
@@ -294,22 +295,8 @@ static void __init imx6q_init_machine(void)
 
 static void __init imx6q_opp_check_speed_grading(struct device *cpu_dev)
 {
-	struct device_node *np;
-	void __iomem *base;
 	u32 val;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ocotp");
-	if (!np) {
-		pr_warn("failed to find ocotp node\n");
-		return;
-	}
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		pr_warn("failed to map ocotp\n");
-		goto put_node;
-	}
-
 	/*
 	 * SPEED_GRADING[1:0] defines the max speed of ARM:
 	 * 2b'11: 1200000000Hz;
@@ -318,7 +305,7 @@ static void __init imx6q_opp_check_speed_grading(struct device *cpu_dev)
 	 * 2b'00: 792000000Hz;
 	 * We need to set the max speed of ARM according to fuse map.
 	 */
-	val = readl_relaxed(base + OCOTP_CFG3);
+	val = imx_ocotp_read(OCOTP_CFG3);
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
 	val &= 0x3;
 
@@ -333,9 +320,6 @@ static void __init imx6q_opp_check_speed_grading(struct device *cpu_dev)
 			if (dev_pm_opp_disable(cpu_dev, 852000000))
 				pr_warn("failed to disable 852 MHz OPP\n");
 	}
-	iounmap(base);
-put_node:
-	of_node_put(np);
 }
 
 static void __init imx6q_opp_init(void)
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 0408490..01558df 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -54,6 +54,7 @@ static void __init imx6sl_init_machine(void)
 
 	of_platform_default_populate(NULL, NULL, parent);
 
+	imx_ocotp_init("fsl,imx6sl-ocotp");
 	imx6sl_fec_init();
 	imx_anatop_init();
 	imx6sl_pm_init();
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index 7f52d9b..acb73c1 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -74,6 +74,7 @@ static void __init imx6sx_init_machine(void)
 
 	of_platform_default_populate(NULL, NULL, parent);
 
+	imx_ocotp_init("fsl,imx6sx-ocotp");
 	imx6sx_enet_init();
 	imx_anatop_init();
 	imx6sx_pm_init();
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index 26ca744..c29c771 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -93,6 +93,7 @@ static void __init imx7d_init_machine(void)
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
 
+	imx_ocotp_init("fsl,imx7d-ocotp");
 	imx_anatop_init();
 	imx7d_enet_init();
 }
diff --git a/arch/arm/mach-imx/ocotp.c b/arch/arm/mach-imx/ocotp.c
new file mode 100644
index 0000000..e73f0e8
--- /dev/null
+++ b/arch/arm/mach-imx/ocotp.c
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+static void __iomem *ocotp_base;
+
+void __init imx_ocotp_init(const char *compat)
+{
+	struct device_node *ocotp_np;
+
+	ocotp_np = of_find_compatible_node(NULL, NULL, compat);
+	if (!ocotp_np) {
+		pr_warn("failed to find ocotp node\n");
+		return;
+	}
+
+	ocotp_base = of_iomap(ocotp_np, 0);
+	if (!ocotp_base)
+		pr_warn("failed to map ocotp\n");
+
+	of_node_put(ocotp_np);
+}
+
+u32 imx_ocotp_read(u32 offset)
+{
+	if (WARN_ON(!ocotp_base))
+		return 0;
+
+	return readl_relaxed(ocotp_base + offset);
+}
-- 
2.7.4
