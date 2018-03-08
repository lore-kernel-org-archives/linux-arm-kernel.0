From: ping.bai@nxp.com (Bai Ping)
Date: Thu,  8 Mar 2018 17:34:55 +0800
Subject: [PATCH v4 1/3] ARM: imx: Add basic msl support for imx6sll
Message-ID: <1520501697-22202-1-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic MSL support for i.MX6SLL.

The i.MX 6SoloLiteLite application processors are NXP's latest
additions to a growing family of multimedia-focused products
offering high-performance processing optimized for lowest power
consumption. The i.MX 6SoloLiteLite processors feature NXP's advanced
implementation of the ARM Cortex-A9 core, which can be interfaced
with LPDDR3 and LPDDR2 DRAM memory devices.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 change from v1->v2:
 - no
 change from v2->v3:
 - no
 change from v3->v4:
 - fix build warning
---
 arch/arm/mach-imx/Kconfig          |  7 +++++++
 arch/arm/mach-imx/Makefile         |  1 +
 arch/arm/mach-imx/cpu.c            |  3 +++
 arch/arm/mach-imx/cpuidle-imx6sl.c |  7 +++++--
 arch/arm/mach-imx/mach-imx6sl.c    | 10 ++++++++--
 arch/arm/mach-imx/mxc.h            |  6 ++++++
 6 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 782699e..8e3a618 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -512,6 +512,13 @@ config SOC_IMX6SL
 	help
 	  This enables support for Freescale i.MX6 SoloLite processor.
 
+config SOC_IMX6SLL
+	bool "i.MX6 SoloLiteLite support"
+	select SOC_IMX6
+
+	help
+	  This enables support for Freescale i.MX6 SoloLiteLite processor.
+
 config SOC_IMX6SX
 	bool "i.MX6 SoloX support"
 	select PINCTRL_IMX6SX
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 8ff7105..c5caecb 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 endif
 obj-$(CONFIG_SOC_IMX6Q) += mach-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += mach-imx6sl.o
+obj-$(CONFIG_SOC_IMX6SLL) += mach-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += mach-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += mach-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index d4e55f2..32969f3 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -135,6 +135,9 @@ struct device * __init imx_soc_device_init(void)
 	case MXC_CPU_IMX6ULL:
 		soc_id = "i.MX6ULL";
 		break;
+	case MXC_CPU_IMX6SLL:
+		soc_id = "i.MX6SLL";
+		break;
 	case MXC_CPU_IMX7D:
 		soc_id = "i.MX7D";
 		break;
diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/cpuidle-imx6sl.c
index 8d866fb..124f982 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sl.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
@@ -11,6 +11,7 @@
 #include <asm/cpuidle.h>
 
 #include "common.h"
+#include "hardware.h"
 #include "cpuidle.h"
 
 static int imx6sl_enter_wait(struct cpuidle_device *dev,
@@ -21,9 +22,11 @@ static int imx6sl_enter_wait(struct cpuidle_device *dev,
 	 * Software workaround for ERR005311, see function
 	 * description for details.
 	 */
-	imx6sl_set_wait_clk(true);
+	if (cpu_is_imx6sl())
+		imx6sl_set_wait_clk(true);
 	cpu_do_idle();
-	imx6sl_set_wait_clk(false);
+	if (cpu_is_imx6sl())
+		imx6sl_set_wait_clk(false);
 	imx6_set_lpm(WAIT_CLOCKED);
 
 	return index;
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 0408490..462ed9c 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -17,6 +17,7 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
+#include "hardware.h"
 #include "cpuidle.h"
 
 static void __init imx6sl_fec_init(void)
@@ -54,7 +55,8 @@ static void __init imx6sl_init_machine(void)
 
 	of_platform_default_populate(NULL, NULL, parent);
 
-	imx6sl_fec_init();
+	if (cpu_is_imx6sl())
+		imx6sl_fec_init();
 	imx_anatop_init();
 	imx6sl_pm_init();
 }
@@ -66,11 +68,15 @@ static void __init imx6sl_init_irq(void)
 	imx_init_l2cache();
 	imx_src_init();
 	irqchip_init();
-	imx6_pm_ccm_init("fsl,imx6sl-ccm");
+	if (cpu_is_imx6sl())
+		imx6_pm_ccm_init("fsl,imx6sl-ccm");
+	else
+		imx6_pm_ccm_init("fsl,imx6sll-ccm");
 }
 
 static const char * const imx6sl_dt_compat[] __initconst = {
 	"fsl,imx6sl",
+	"fsl,imx6sll",
 	NULL,
 };
 
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index e00d626..026e2ca 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -40,6 +40,7 @@
 #define MXC_CPU_IMX6Q		0x63
 #define MXC_CPU_IMX6UL		0x64
 #define MXC_CPU_IMX6ULL		0x65
+#define MXC_CPU_IMX6SLL		0x67
 #define MXC_CPU_IMX7D		0x72
 
 #define IMX_DDR_TYPE_LPDDR2		1
@@ -79,6 +80,11 @@ static inline bool cpu_is_imx6ull(void)
 	return __mxc_cpu_type == MXC_CPU_IMX6ULL;
 }
 
+static inline bool cpu_is_imx6sll(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX6SLL;
+}
+
 static inline bool cpu_is_imx6q(void)
 {
 	return __mxc_cpu_type == MXC_CPU_IMX6Q;
-- 
1.9.1
