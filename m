From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  2 Feb 2012 20:02:32 -0200
Subject: [PATCH v2 2/2] ARM: mx3: Let mx31 and mx35 enter in LPM mode in WFI
In-Reply-To: <1328220152-3037-1-git-send-email-festevam@gmail.com>
References: <1328220152-3037-1-git-send-email-festevam@gmail.com>
Message-ID: <1328220152-3037-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LPM field of register CCMR is used to select the mode that the processor will run
when it goes to WFI.

When mx31 enters in WFI mode the LPM field is at its reset value of 0,
which configures the mx31 to enter in "wait mode".

On mx35, the LPM field on mx35 is also at 0 after reset, which corresponds 
to "run mode" instead of "wait mode".

Instead of relying on the reset value of LPM to set the low power mode for
WFI, configure mx31 and mx35 to run in "wait mode"

Reported-by: Benoit Thebaudeau <benoit.thebaudeau@advansee.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Make MXC_CCM_CCMR_LPM_WAIT a constant and then check in run-time
the CPU type inside function mx3_cpu_lp_set to decide to apply or not the LPM bit.
- Rebased against linux-next

 arch/arm/mach-imx/Makefile              |    4 +-
 arch/arm/mach-imx/crmregs-imx3.h        |    1 +
 arch/arm/mach-imx/mm-imx3.c             |    1 +
 arch/arm/mach-imx/pm-imx3.c             |   37 +++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |    8 ++++++
 5 files changed, 49 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-imx/pm-imx3.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 55db9c4..f4b6fb0 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -8,8 +8,8 @@ obj-$(CONFIG_SOC_IMX25) += clock-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o
 obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_SOC_IMX27) += clock-imx27.o mm-imx27.o ehci-imx27.o
 
-obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clock-imx31.o iomux-imx31.o ehci-imx31.o
-obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o
+obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clock-imx31.o iomux-imx31.o ehci-imx31.o pm-imx3.o
+obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o pm-imx3.o
 
 obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clock-mx51-mx53.o ehci-imx5.o pm-imx5.o cpu_op-mx51.o
 
diff --git a/arch/arm/mach-imx/crmregs-imx3.h b/arch/arm/mach-imx/crmregs-imx3.h
index d7691e2..5314127 100644
--- a/arch/arm/mach-imx/crmregs-imx3.h
+++ b/arch/arm/mach-imx/crmregs-imx3.h
@@ -77,6 +77,7 @@ MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR) : MX35_IO_ADDRESS(MX35_CCM_BASE_ADDR))
 #define MXC_CCM_CCMR_SSI2S_MASK                 (0x3 << 21)
 #define MXC_CCM_CCMR_LPM_OFFSET                 14
 #define MXC_CCM_CCMR_LPM_MASK                   (0x3 << 14)
+#define MXC_CCM_CCMR_LPM_WAIT_MX35		(0x1 << 14)
 #define MXC_CCM_CCMR_FIRS_OFFSET                11
 #define MXC_CCM_CCMR_FIRS_MASK                  (0x3 << 11)
 #define MXC_CCM_CCMR_UPE                        (1 << 9)
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 8404ee7..5f66791 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -34,6 +34,7 @@ static void imx3_idle(void)
 {
 	unsigned long reg = 0;
 
+	mx3_cpu_lp_set(MX3_WAIT);
 	__asm__ __volatile__(
 		/* disable I and D cache */
 		"mrc p15, 0, %0, c1, c0, 0\n"
diff --git a/arch/arm/mach-imx/pm-imx3.c b/arch/arm/mach-imx/pm-imx3.c
new file mode 100644
index 0000000..b375243
--- /dev/null
+++ b/arch/arm/mach-imx/pm-imx3.c
@@ -0,0 +1,37 @@
+/*
+ *  Copyright (C) 2012 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later@the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#include <linux/io.h>
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+#include "crmregs-imx3.h"
+
+/*
+ * Set cpu low power mode before WFI instruction. This function is called
+ * mx3 because it can be used for mx31 and mx35.
+ * Currently only WAIT_MODE is supported.
+ */
+void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode)
+{
+	int reg = __raw_readl(MXC_CCM_CCMR);
+	reg &= ~MXC_CCM_CCMR_LPM_MASK;
+
+	switch (mode) {
+	case MX3_WAIT:
+		if (cpu_is_mx35())
+			reg |= MXC_CCM_CCMR_LPM_WAIT_MX35;
+		__raw_writel(reg, MXC_CCM_CCMR);
+		break;
+	default:
+		pr_err("Unknown cpu power mode: %d\n", mode);
+		return;
+	}
+}
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 1bf0df8..06595a3 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -84,6 +84,14 @@ enum mxc_cpu_pwr_mode {
 	STOP_POWER_OFF,		/* STOP + SRPG */
 };
 
+enum mx3_cpu_pwr_mode {
+	MX3_RUN,
+	MX3_WAIT,
+	MX3_DOZE,
+	MX3_SLEEP,
+};
+
+extern void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode);
 extern void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode);
 extern void imx_print_silicon_rev(const char *cpu, int srev);
 
-- 
1.7.1
