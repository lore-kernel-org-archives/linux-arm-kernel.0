From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 10:25:24 +0800
Subject: [PATCH v7 3/6] ARM: imx6q: disable usb charger detector
In-Reply-To: <1342059927-25661-1-git-send-email-richard.zhao@freescale.com>
References: <1342059927-25661-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1342059927-25661-4-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The external charger detector needs to be disabled,
or the signal at DP will be poor

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-imx/mach-imx6q.c |   41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 1c18d3c..5ec0608 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -25,6 +25,7 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/phy.h>
 #include <linux/micrel_phy.h>
+#include <linux/mfd/anatop.h>
 #include <asm/cpuidle.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -117,6 +118,45 @@ static void __init imx6q_sabrelite_init(void)
 	imx6q_sabrelite_cko1_setup();
 }
 
+static void __init imx6q_usb_init(void)
+{
+	struct device_node *np;
+	struct platform_device *pdev = NULL;
+	struct anatop *adata = NULL;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
+	if (np)
+		pdev = of_find_device_by_node(np);
+	if (pdev)
+		adata = platform_get_drvdata(pdev);
+	if (!adata) {
+		if (np)
+			of_node_put(np);
+		return;
+	}
+
+#define HW_ANADIG_USB1_CHRG_DETECT		0x000001b0
+#define HW_ANADIG_USB2_CHRG_DETECT		0x00000210
+
+#define BM_ANADIG_USB_CHRG_DETECT_EN_B		0x00100000
+#define BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B	0x00080000
+
+	/*
+	 * The external charger detector needs to be disabled,
+	 * or the signal at DP will be poor
+	 */
+	anatop_write_reg(adata, HW_ANADIG_USB1_CHRG_DETECT,
+			BM_ANADIG_USB_CHRG_DETECT_EN_B
+			| BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B,
+			~0);
+	anatop_write_reg(adata, HW_ANADIG_USB2_CHRG_DETECT,
+			BM_ANADIG_USB_CHRG_DETECT_EN_B |
+			BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B,
+			~0);
+
+	of_node_put(np);
+}
+
 static void __init imx6q_init_machine(void)
 {
 	/*
@@ -131,6 +171,7 @@ static void __init imx6q_init_machine(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	imx6q_pm_init();
+	imx6q_usb_init();
 }
 
 static struct cpuidle_driver imx6q_cpuidle_driver = {
-- 
1.7.9.5
