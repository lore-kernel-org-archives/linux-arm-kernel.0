From: tobetter@gmail.com (Dongjin Kim)
Date: Thu, 27 Dec 2012 03:42:20 +0900
Subject: [PATCH 1/2] ARM: dts: Add EHCI device tree node for Exynos4
In-Reply-To: <1356547341-23620-1-git-send-email-tobetter@gmail.com>
References: <1356547341-23620-1-git-send-email-tobetter@gmail.com>
Message-ID: <1356547341-23620-2-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds EHCI device node on device tree for Exynos4 and defines its
default platform data, s5p_usb_phy_init and s5p_usb_phy_exit, so that those
function can be called from the driver.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos4.dtsi         |    7 +++++++
 arch/arm/mach-exynos/mach-exynos4-dt.c |    9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 92bca86..df1a9f0 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -140,6 +140,13 @@
 		status = "disabled";
 	};
 
+	ehci at 12580000 {
+		compatible = "samsung,exynos-ehci";
+		reg = <0x12580000 0x100>;
+		interrupts = <0 70 0>;
+		status = "disabled";
+	};
+
 	serial at 13800000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13800000 0x100>;
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 92757ff..c8a23f0 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -13,6 +13,7 @@
 
 #include <linux/of_platform.h>
 #include <linux/serial_core.h>
+#include <linux/platform_data/usb-ehci-s5p.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
@@ -20,9 +21,15 @@
 
 #include <plat/cpu.h>
 #include <plat/regs-serial.h>
+#include <plat/usb-phy.h>
 
 #include "common.h"
 
+static struct s5p_ehci_platdata s5p_ehci_platdata = {
+	.phy_init = s5p_usb_phy_init,
+	.phy_exit = s5p_usb_phy_exit,
+};
+
 /*
  * The following lookup table is used to override device names when devices
  * are registered from device tree. This is temporarily added to enable
@@ -80,6 +87,8 @@ static const struct of_dev_auxdata exynos4_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_MDMA1, "dma-pl330.2", NULL),
 	OF_DEV_AUXDATA("samsung,exynos4210-tmu", EXYNOS4_PA_TMU,
 				"exynos-tmu", NULL),
+	OF_DEV_AUXDATA("samsung,exynos-ehci", EXYNOS4_PA_EHCI,
+				"s5p-ehci", &s5p_ehci_platdata),
 	{},
 };
 
-- 
1.7.10.4
