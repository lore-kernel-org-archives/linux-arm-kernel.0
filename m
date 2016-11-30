From: ping.bai@nxp.com (Bai Ping)
Date: Wed, 30 Nov 2016 11:04:58 +0800
Subject: [PATCH 2/2] ARM: imx: Add speed grading check for imx6ul
In-Reply-To: <1480475098-2037-1-git-send-email-ping.bai@nxp.com>
References: <1480475098-2037-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1480475098-2037-2-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6UL, it has two type of part, the difference
is the max ARM frequency that can run at(528MHz/700MHz).
The part can be identified by part marking for speed grading
fuse. This patch add speed grading check to disable the unsupported
OPP dynamically.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 arch/arm/mach-imx/mach-imx6ul.c | 78 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 6cb8a22..bf86530 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -9,14 +9,17 @@
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/micrel_phy.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/phy.h>
+#include <linux/pm_opp.h>
 #include <linux/regmap.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
 #include "common.h"
 #include "cpuidle.h"
+#include "hardware.h"
 
 static void __init imx6ul_enet_clk_init(void)
 {
@@ -57,6 +60,76 @@ static inline void imx6ul_enet_init(void)
 	imx6ul_enet_phy_init();
 }
 
+#define OCOTP_CFG3			0x440
+#define OCOTP_CFG3_SPEED_SHIFT		16
+#define OCOTP_CFG3_SPEED_696MHZ		0x2
+
+static void __init imx6ul_opp_check_speed_grading(struct device *cpu_dev)
+{
+	struct device_node *np;
+	void __iomem *base;
+	u32 val;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
+	if (!np) {
+		pr_warn("failed to find ocotp node\n");
+		return;
+	}
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_warn("failed to map ocotp\n");
+		goto put_node;
+	}
+
+	/*
+	 * Speed GRADING[1:0] defines the max speed of ARM:
+	 * 2b'00: Reserved;
+	 * 2b'01: 528000000Hz;
+	 * 2b'10: 700000000Hz;
+	 * 2b'11: Reserved;
+	 * We need to set the max speed of ARM according to fuse map.
+	 */
+	val = readl_relaxed(base + OCOTP_CFG3);
+	val >>= OCOTP_CFG3_SPEED_SHIFT;
+	val &= 0x3;
+
+	if (val != OCOTP_CFG3_SPEED_696MHZ) {
+		if (dev_pm_opp_disable(cpu_dev, 696000000))
+			pr_warn("Failed to disable 696MHz OPP\n");
+	}
+	iounmap(base);
+
+put_node:
+	of_node_put(np);
+}
+
+static void __init imx6ul_opp_init(void)
+{
+	struct device_node *np;
+	struct device *cpu_dev = get_cpu_device(0);
+
+	if (!cpu_dev) {
+		pr_warn("failed to get cpu0 device\n");
+		return;
+	}
+	np = of_node_get(cpu_dev->of_node);
+	if (!np) {
+		pr_warn("failed to find cpu0 node\n");
+		return;
+	}
+
+	if (dev_pm_opp_of_add_table(cpu_dev)) {
+		pr_warn("failed to init OPP table\n");
+		goto put_node;
+	}
+
+	imx6ul_opp_check_speed_grading(cpu_dev);
+
+put_node:
+	of_node_put(np);
+}
+
 static void __init imx6ul_init_machine(void)
 {
 	struct device *parent;
@@ -83,8 +156,11 @@ static void __init imx6ul_init_late(void)
 {
 	imx6sx_cpuidle_init();
 
-	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
+	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
+		if (cpu_is_imx6ul())
+			imx6ul_opp_init();
 		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
+	}
 }
 
 static const char * const imx6ul_dt_compat[] __initconst = {
-- 
1.9.1
