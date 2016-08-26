From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 26 Aug 2016 19:12:50 +0800
Subject: [PATCH 2/3] ARM: imx: add gpcv2 support
In-Reply-To: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
References: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1472209971-32469-3-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX7's GPC(general power controller) module is
different from i.MX6, name it as GPCV2 and add
its driver for SMP support, as secondary CPUs
boot up will need GPC to enable power.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/Kconfig  |  4 +++
 arch/arm/mach-imx/Makefile |  1 +
 arch/arm/mach-imx/common.h |  2 ++
 arch/arm/mach-imx/gpcv2.c  | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+)
 create mode 100644 arch/arm/mach-imx/gpcv2.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0ac05a0..13d5952 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -51,6 +51,9 @@ config HAVE_IMX_GPC
 	bool
 	select PM_GENERIC_DOMAINS if PM
 
+config HAVE_IMX_GPCV2
+	bool
+
 config HAVE_IMX_MMDC
 	bool
 
@@ -537,6 +540,7 @@ config SOC_IMX7D
 	select HAVE_IMX_ANATOP
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
+	select HAVE_IMX_GPCV2
 	help
 		This enables support for Freescale i.MX7 Dual processor.
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index edce8df..6d812f6 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_MACH_IMX35_DT) += imx35-dt.o
 
 obj-$(CONFIG_HAVE_IMX_ANATOP) += anatop.o
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
+obj-$(CONFIG_HAVE_IMX_GPCV2) += gpcv2.o
 obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
 obj-$(CONFIG_HAVE_IMX_SRC) += src.o
 ifneq ($(CONFIG_SOC_IMX6)$(CONFIG_SOC_LS1021A),)
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index b757811..732a19a 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -58,9 +58,11 @@ void imx_init_revision_from_anatop(void);
 struct device *imx_soc_device_init(void);
 void imx6_enable_rbc(bool enable);
 void imx_gpc_check_dt(void);
+void imx_gpcv2_check_dt(void);
 void imx_gpc_set_arm_power_in_lpm(bool power_off);
 void imx_gpc_set_arm_power_up_timing(u32 sw2iso, u32 sw);
 void imx_gpc_set_arm_power_down_timing(u32 sw2iso, u32 sw);
+void imx_gpcv2_set_core1_pdn_pup_by_software(bool pdn);
 void imx25_pm_init(void);
 void imx27_pm_init(void);
 
diff --git a/arch/arm/mach-imx/gpcv2.c b/arch/arm/mach-imx/gpcv2.c
new file mode 100644
index 0000000..98577c4
--- /dev/null
+++ b/arch/arm/mach-imx/gpcv2.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include "common.h"
+
+#define GPC_CPU_PGC_SW_PUP_REQ	0xf0
+#define GPC_CPU_PGC_SW_PDN_REQ	0xfc
+#define GPC_PGC_C1		0x840
+
+#define BM_CPU_PGC_SW_PDN_PUP_REQ_CORE1_A7	0x2
+#define BM_GPC_PGC_PCG				0x1
+
+static void __iomem *gpcv2_base;
+
+static void imx_gpcv2_set_m_core_pgc(bool enable, u32 offset)
+{
+	u32 val = readl_relaxed(gpcv2_base + offset) & (~BM_GPC_PGC_PCG);
+
+	if (enable)
+		val |= BM_GPC_PGC_PCG;
+
+	writel_relaxed(val, gpcv2_base + offset);
+}
+
+void imx_gpcv2_set_core1_pdn_pup_by_software(bool pdn)
+{
+	u32 val = readl_relaxed(gpcv2_base + (pdn ?
+		GPC_CPU_PGC_SW_PDN_REQ : GPC_CPU_PGC_SW_PUP_REQ));
+
+	imx_gpcv2_set_m_core_pgc(true, GPC_PGC_C1);
+	val |= BM_CPU_PGC_SW_PDN_PUP_REQ_CORE1_A7;
+	writel_relaxed(val, gpcv2_base + (pdn ?
+		GPC_CPU_PGC_SW_PDN_REQ : GPC_CPU_PGC_SW_PUP_REQ));
+
+	while ((readl_relaxed(gpcv2_base + (pdn ?
+		GPC_CPU_PGC_SW_PDN_REQ : GPC_CPU_PGC_SW_PUP_REQ)) &
+		BM_CPU_PGC_SW_PDN_PUP_REQ_CORE1_A7) != 0)
+		;
+	imx_gpcv2_set_m_core_pgc(false, GPC_PGC_C1);
+}
+
+void __init imx_gpcv2_check_dt(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx7d-gpc");
+	if (WARN_ON(!np))
+		return;
+
+	gpcv2_base = of_iomap(np, 0);
+	WARN_ON(!gpcv2_base);
+}
-- 
1.9.1
