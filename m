From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 2 Nov 2018 09:13:07 +0000
Subject: [PATCH V4 07/10] ARM: imx: add initial support for imx7ulp
In-Reply-To: <1541149669-10857-1-git-send-email-aisheng.dong@nxp.com>
References: <1541149669-10857-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1541149669-10857-8-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX 7ULP family of processors features NXP's advanced implementation
of the Arm Cortex-A7 core, the Arm Cortex-M4 core, as well as a 3D and 2D
Graphics Processing Units (GPUs).

This patch aims to add an initial support for imx7ulp. Note that we need
configure power mode to Partial Stop mode 3 with system/bus clock enabled
first as the default enabled STOP mode will gate off system/bus clock when
execute WFI in MX7ULP SoC.

And there's still no MXC_CPU_IMX7ULP IDs read from register as ULP has no
anatop as before. So we encode one with 0xff in reverse order in case new
ones will be in the future.

Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v3->v4:
 * add iounmap(smc1_base)
 * add comments about fixed SoC version
v2->v3:
 * no changes
v1->v2:
 * switch to SPDX license
 * more description of new SOC in commit message
---
 arch/arm/mach-imx/Kconfig        |  9 +++++++++
 arch/arm/mach-imx/Makefile       |  1 +
 arch/arm/mach-imx/common.h       |  1 +
 arch/arm/mach-imx/cpu.c          |  3 +++
 arch/arm/mach-imx/mach-imx7ulp.c | 33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mxc.h          |  1 +
 arch/arm/mach-imx/pm-imx7ulp.c   | 29 +++++++++++++++++++++++++++++
 7 files changed, 77 insertions(+)
 create mode 100644 arch/arm/mach-imx/mach-imx7ulp.c
 create mode 100644 arch/arm/mach-imx/pm-imx7ulp.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index abc3371..c12a05c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -558,6 +558,15 @@ config SOC_IMX7D
 	help
 		This enables support for Freescale i.MX7 Dual processor.
 
+config SOC_IMX7ULP
+	bool "i.MX7ULP support"
+	select ARM_GIC
+	select CLKSRC_IMX_TPM
+	select HAVE_ARM_ARCH_TIMER
+	select PINCTRL_IMX7ULP
+	help
+	  This enables support for Freescale i.MX7 Ultra Low Power processor.
+
 config SOC_VF610
 	bool "Vybrid Family VF610 support"
 	select ARM_GIC if ARCH_MULTI_V7
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index bae179a..8af2f7e 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_SOC_IMX6SX) += mach-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += mach-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D_CA7) += mach-imx7d.o
 obj-$(CONFIG_SOC_IMX7D_CM4) += mach-imx7d-cm4.o
+obj-$(CONFIG_SOC_IMX7ULP) += mach-imx7ulp.o pm-imx7ulp.o
 
 ifeq ($(CONFIG_SUSPEND),y)
 AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 423dd76..bc915e5 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -120,6 +120,7 @@ void imx6dl_pm_init(void);
 void imx6sl_pm_init(void);
 void imx6sx_pm_init(void);
 void imx6ul_pm_init(void);
+void imx7ulp_pm_init(void);
 
 #ifdef CONFIG_PM
 void imx51_pm_init(void);
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index c73593e..0b137ee 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -145,6 +145,9 @@ struct device * __init imx_soc_device_init(void)
 	case MXC_CPU_IMX7D:
 		soc_id = "i.MX7D";
 		break;
+	case MXC_CPU_IMX7ULP:
+		soc_id = "i.MX7ULP";
+		break;
 	default:
 		soc_id = "Unknown";
 	}
diff --git a/arch/arm/mach-imx/mach-imx7ulp.c b/arch/arm/mach-imx/mach-imx7ulp.c
new file mode 100644
index 0000000..979ad02
--- /dev/null
+++ b/arch/arm/mach-imx/mach-imx7ulp.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2018 NXP
+ *   Author: Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <linux/irqchip.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+
+#include "common.h"
+#include "hardware.h"
+
+static void __init imx7ulp_init_machine(void)
+{
+	imx7ulp_pm_init();
+
+	mxc_set_cpu_type(MXC_CPU_IMX7ULP);
+	/* FIXME: so far there is still no way to retrieve SoC version */
+	imx_print_silicon_rev("i.MX7ULP", IMX_CHIP_REVISION_UNKNOWN);
+	of_platform_default_populate(NULL, NULL, imx_soc_device_init());
+}
+
+static const char *const imx7ulp_dt_compat[] __initconst = {
+	"fsl,imx7ulp",
+	NULL,
+};
+
+DT_MACHINE_START(IMX7ulp, "Freescale i.MX7ULP (Device Tree)")
+	.init_machine	= imx7ulp_init_machine,
+	.dt_compat	= imx7ulp_dt_compat,
+MACHINE_END
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index b130a53..8e72d4e 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -44,6 +44,7 @@
 #define MXC_CPU_IMX6ULZ		0x6b
 #define MXC_CPU_IMX6SLL		0x67
 #define MXC_CPU_IMX7D		0x72
+#define MXC_CPU_IMX7ULP		0xff
 
 #define IMX_DDR_TYPE_LPDDR2		1
 
diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
new file mode 100644
index 0000000..cf6a380
--- /dev/null
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2018 NXP
+ *   Author: Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#define SMC_PMCTRL		0x10
+#define BP_PMCTRL_PSTOPO        16
+#define PSTOPO_PSTOP3		0x3
+
+void __init imx7ulp_pm_init(void)
+{
+	struct device_node *np;
+	void __iomem *smc1_base;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-smc1");
+	smc1_base = of_iomap(np, 0);
+	WARN_ON(!smc1_base);
+
+	/* Partial Stop mode 3 with system/bus clock enabled */
+	writel_relaxed(PSTOPO_PSTOP3 << BP_PMCTRL_PSTOPO,
+		       smc1_base + SMC_PMCTRL);
+	iounmap(smc1_base);
+}
-- 
2.7.4
