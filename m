From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 21 May 2012 17:23:54 +0800
Subject: [PATCH v2 09/12] ARM: imx6q: disable usb charger detector
In-Reply-To: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337592237-5090-10-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The external charger detector needs to be disabled,
or the signal at DP will be poor

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-imx/mach-imx6q.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 577cf19..0bfd8c7 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -25,6 +25,7 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/phy.h>
 #include <linux/micrel_phy.h>
+#include <linux/mfd/anatop.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
@@ -141,9 +142,33 @@ static void __init imx6q_config_on_boot(void)
 	of_node_put(np);
 }
 
+static void __init imx6q_usb_init(void)
+{
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
+
+	anatop_write_reg(NULL, HW_ANADIG_USB1_CHRG_DETECT,
+			BM_ANADIG_USB_CHRG_DETECT_EN_B
+			| BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B,
+			~0);
+	anatop_write_reg(NULL, HW_ANADIG_USB2_CHRG_DETECT,
+			BM_ANADIG_USB_CHRG_DETECT_EN_B |
+			BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B,
+			~0);
+}
+
 static void __init imx6q_post_populate(void)
 {
 	imx6q_config_on_boot();
+	imx6q_usb_init();
 }
 
 static void __init imx6q_init_machine(void)
-- 
1.7.5.4
