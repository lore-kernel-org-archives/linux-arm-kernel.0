From: rob.lee@linaro.org (Robert Lee)
Date: Fri, 16 Sep 2011 12:27:50 -0500
Subject: [PATCH v2 3/3] ARM: imx: Add cpuidle for i.MX51
In-Reply-To: <1316194070-21889-1-git-send-email-rob.lee@linaro.org>
References: <1316194070-21889-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1316194070-21889-4-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the i.MX51 SoC specific cpuidle operating point data and other
necessary data.  Add init call to fill in imx cpuidle driver data
structures.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-mx5/Makefile      |    3 +--
 arch/arm/mach-mx5/cpu_op-mx51.c |   35 ++++++++++++++++++++++++++++++++++-
 arch/arm/mach-mx5/cpu_op-mx51.h |    1 +
 arch/arm/mach-mx5/mm.c          |    4 ++++
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 383e7cd..dc5413b 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -5,9 +5,8 @@
 # Object file lists.
 obj-y   := cpu.o mm.o clock-mx51-mx53.o devices.o ehci.o system.o
 obj-$(CONFIG_SOC_IMX50) += mm-mx50.o
-
+obj-$(CONFIG_SOC_IMX51)	+= cpu_op-mx51.o
 obj-$(CONFIG_PM) += pm-imx5.o
-obj-$(CONFIG_CPU_FREQ_IMX)    += cpu_op-mx51.o
 obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
 obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
 obj-$(CONFIG_MACH_MX53_EVK) += board-mx53_evk.o
diff --git a/arch/arm/mach-mx5/cpu_op-mx51.c b/arch/arm/mach-mx5/cpu_op-mx51.c
index 9d34c3d..d85ced3 100644
--- a/arch/arm/mach-mx5/cpu_op-mx51.c
+++ b/arch/arm/mach-mx5/cpu_op-mx51.c
@@ -12,9 +12,12 @@
  */
 
 #include <linux/types.h>
-#include <mach/hardware.h>
 #include <linux/kernel.h>
+#include <asm/proc-fns.h>
+#include <mach/cpuidle.h>
+#include <mach/system.h>
 
+#ifdef CONFIG_CPU_FREQ_IMX
 static struct cpu_op mx51_cpu_op[] = {
 	{
 	.cpu_rate = 160000000,},
@@ -27,3 +30,33 @@ struct cpu_op *mx51_get_cpu_op(int *op)
 	*op = ARRAY_SIZE(mx51_cpu_op);
 	return mx51_cpu_op;
 }
+#endif /* CONFIG_CPU_FREQ_IMX */
+
+#ifdef CONFIG_CPU_IDLE
+static struct imx_cpuidle_state_data mx51_cpuidle_state_data[] __initdata = {
+	{
+		.name = "powered_noclock",
+		.desc = "idle cpu powered, unclocked.",
+		.exit_latency = 12,
+		.mach_cpu_pwr_state = WAIT_UNCLOCKED,
+	}, {
+		.name = "nopower_noclock",
+		.desc = "idle cpu unpowered, unclocked.",
+		.exit_latency = 20,
+		.mach_cpu_pwr_state = WAIT_UNCLOCKED_POWER_OFF,
+	}
+};
+
+static struct cpuidle_driver imx51_cpuidle_driver = {
+	.name	= "imx51_cpuidle",
+	.owner	= THIS_MODULE,
+};
+
+struct imx_cpuidle_data mx51_cpuidle_data __initdata = {
+	.imx_cpuidle_driver = &imx51_cpuidle_driver,
+	.state_data = mx51_cpuidle_state_data,
+	.mach_cpuidle = mx5_cpuidle,
+	.mach_cpuidle_init = mx5_cpuidle_init,
+	.num_states = ARRAY_SIZE(mx51_cpuidle_state_data),
+};
+#endif /* CONFIG_CPU_IDLE */
diff --git a/arch/arm/mach-mx5/cpu_op-mx51.h b/arch/arm/mach-mx5/cpu_op-mx51.h
index 97477fe..60c60fd 100644
--- a/arch/arm/mach-mx5/cpu_op-mx51.h
+++ b/arch/arm/mach-mx5/cpu_op-mx51.h
@@ -12,3 +12,4 @@
  */
 
 extern struct cpu_op *mx51_get_cpu_op(int *op);
+extern struct imx_cpuidle_data mx51_cpuidle_data;
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index baea6e5..d20827e 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -20,6 +20,8 @@
 #include <mach/common.h>
 #include <mach/devices-common.h>
 #include <mach/iomux-v3.h>
+#include <mach/cpuidle.h>
+#include "cpu_op-mx51.h"
 
 /*
  * Define the MX51 memory map.
@@ -148,6 +150,8 @@ void __init imx51_soc_init(void)
 
 	/* i.mx51 has the i.mx35 type sdma */
 	imx_add_imx_sdma("imx35-sdma", MX51_SDMA_BASE_ADDR, MX51_INT_SDMA, &imx51_sdma_pdata);
+
+	imx_cpuidle_init(&mx51_cpuidle_data);
 }
 
 void __init imx53_soc_init(void)
-- 
1.7.1
