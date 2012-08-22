From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 22 Aug 2012 15:18:46 +0800
Subject: [PATCH 5/7] ARM: imx6q: convert to use imx-syscon to access anatop
 registers
In-Reply-To: <1345619928-15446-1-git-send-email-b29396@freescale.com>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
Message-ID: <1345619928-15446-6-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Using standard imx syscon API to access anatop registers.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/mach-imx/Kconfig      |    2 +-
 arch/arm/mach-imx/mach-imx6q.c |   25 ++++++-------------------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index afd542a..c7b2adb 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -839,7 +839,7 @@ config SOC_IMX6Q
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
 	select HAVE_SMP
-	select MFD_ANATOP
+	select MFD_IMX_SYSCON
 	select PINCTRL
 	select PINCTRL_IMX6Q
 
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 5ec0608..32a9c9e 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -24,8 +24,9 @@
 #include <linux/of_platform.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/phy.h>
+#include <linux/regmap.h>
 #include <linux/micrel_phy.h>
-#include <linux/mfd/anatop.h>
+#include <linux/mfd/imx-syscon.h>
 #include <asm/cpuidle.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -121,20 +122,8 @@ static void __init imx6q_sabrelite_init(void)
 static void __init imx6q_usb_init(void)
 {
 	struct device_node *np;
-	struct platform_device *pdev = NULL;
-	struct anatop *adata = NULL;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
-	if (np)
-		pdev = of_find_device_by_node(np);
-	if (pdev)
-		adata = platform_get_drvdata(pdev);
-	if (!adata) {
-		if (np)
-			of_node_put(np);
-		return;
-	}
-
 #define HW_ANADIG_USB1_CHRG_DETECT		0x000001b0
 #define HW_ANADIG_USB2_CHRG_DETECT		0x00000210
 
@@ -145,14 +134,12 @@ static void __init imx6q_usb_init(void)
 	 * The external charger detector needs to be disabled,
 	 * or the signal at DP will be poor
 	 */
-	anatop_write_reg(adata, HW_ANADIG_USB1_CHRG_DETECT,
+	imx_syscon_write(np, HW_ANADIG_USB1_CHRG_DETECT,
 			BM_ANADIG_USB_CHRG_DETECT_EN_B
-			| BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B,
-			~0);
-	anatop_write_reg(adata, HW_ANADIG_USB2_CHRG_DETECT,
+			| BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B);
+	imx_syscon_write(np, HW_ANADIG_USB2_CHRG_DETECT,
 			BM_ANADIG_USB_CHRG_DETECT_EN_B |
-			BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B,
-			~0);
+			BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B);
 
 	of_node_put(np);
 }
-- 
1.7.0.4
