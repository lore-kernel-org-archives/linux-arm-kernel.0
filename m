From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 15 May 2012 21:58:22 +0800
Subject: [PATCH v1 6/7] ARM: imx6q: add anatop initialization for usb
 controllers
In-Reply-To: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337090303-16046-7-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-imx/mach-imx6q.c |   60 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 74e44d3..4530c45 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -22,6 +22,7 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/phy.h>
 #include <linux/micrel_phy.h>
+#include <linux/mfd/anatop.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
@@ -82,6 +83,63 @@ static void __init imx6q_sabrelite_init(void)
 				ksz9021rn_phy_fixup);
 }
 
+static void __init imx6q_post_populate(void)
+{
+	u32 val;
+
+#define HW_ANADIG_USB2_CHRG_DETECT	(0x00000210)
+#define BM_ANADIG_USB2_CHRG_DETECT_EN_B 0x00100000
+#define BM_ANADIG_USB2_CHRG_DETECT_CHK_CHRG_B 0x00080000
+
+#define HW_ANADIG_USB2_PLL_480_CTRL	(0x00000020)
+#define BM_ANADIG_USB2_PLL_480_CTRL_BYPASS 0x00010000
+#define BM_ANADIG_USB2_PLL_480_CTRL_ENABLE 0x00002000
+#define BM_ANADIG_USB2_PLL_480_CTRL_POWER 0x00001000
+#define BM_ANADIG_USB2_PLL_480_CTRL_EN_USB_CLKS 0x00000040
+
+	/* Some phy and power's special controls for host1
+	 * 1. The external charger detector needs to be disabled
+	 * or the signal at DP will be poor
+	 * 2. The PLL's power and output to usb for host 1
+	 * is totally controlled by IC, so the Software only needs
+	 * to enable them at initializtion.
+	 */
+
+	anatop_write_reg(NULL, HW_ANADIG_USB2_CHRG_DETECT,
+			BM_ANADIG_USB2_CHRG_DETECT_EN_B |
+			BM_ANADIG_USB2_CHRG_DETECT_CHK_CHRG_B,
+			~0);
+	anatop_write_reg(NULL, HW_ANADIG_USB2_PLL_480_CTRL, 0,
+			BM_ANADIG_USB2_PLL_480_CTRL_BYPASS);
+
+	val = BM_ANADIG_USB2_PLL_480_CTRL_ENABLE |
+	      BM_ANADIG_USB2_PLL_480_CTRL_POWER |
+	      BM_ANADIG_USB2_PLL_480_CTRL_EN_USB_CLKS;
+	anatop_write_reg(NULL, HW_ANADIG_USB2_PLL_480_CTRL, val, val);
+
+	/* Some phy and power's special controls for otg
+	 * 1. The external charger detector needs to be disabled
+	 * or the signal at DP will be poor
+	 * 2. The EN_USB_CLKS is always enabled.
+	 * The PLL's power is controlled by usb and others who
+	 * use pll3 too.
+	 */
+#define HW_ANADIG_USB1_CHRG_DETECT      (0x000001b0)
+#define BM_ANADIG_USB1_CHRG_DETECT_EN_B 0x00100000
+#define BM_ANADIG_USB1_CHRG_DETECT_CHK_CHRG_B 0x00080000
+
+#define HW_ANADIG_USB1_PLL_480_CTRL     (0x00000010)
+#define BM_ANADIG_USB1_PLL_480_CTRL_EN_USB_CLKS 0x00000040
+
+	anatop_write_reg(NULL, HW_ANADIG_USB1_CHRG_DETECT,
+			BM_ANADIG_USB1_CHRG_DETECT_EN_B
+			| BM_ANADIG_USB1_CHRG_DETECT_CHK_CHRG_B,
+			~0);
+	anatop_write_reg(NULL, HW_ANADIG_USB1_PLL_480_CTRL,
+			BM_ANADIG_USB1_PLL_480_CTRL_EN_USB_CLKS,
+			BM_ANADIG_USB1_PLL_480_CTRL_EN_USB_CLKS);
+}
+
 static void __init imx6q_init_machine(void)
 {
 	/*
@@ -95,6 +153,8 @@ static void __init imx6q_init_machine(void)
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
+	imx6q_post_populate();
+
 	imx6q_pm_init();
 }
 
-- 
1.7.5.4
