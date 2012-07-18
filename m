From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 18 Jul 2012 19:15:24 +0530
Subject: [PATCH 4/8] ARM: EXYNOS5: Add EHCI device from device tree
In-Reply-To: <1342619128-25013-1-git-send-email-gautam.vivek@samsung.com>
References: <1342619128-25013-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1342619128-25013-5-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds EHCI device from device tree for exynos5
and adds platform data.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
index 63b80b9..45dadca 100644
--- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
+++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
@@ -17,3 +17,25 @@ ohci {
 	interrupts = <0 71 0>;
 };
 
+EHCI
+Required properties:
+ - compatible:	should be "samsung,exynos-ehci" for USB 2.0
+   EHCI controller in host mode.
+ - reg: physical base address of the controller and length
+   of memory mapped.
+ - interrupts: interrupt number to the cpu.
+
+Optional properties:
+ - samsung,vbus-gpio:  if present, specifies the GPIO
+   that needs to be pulled up for the bus to be powered.
+
+ehci {
+	compatible = "samsung,exynos-ehci";
+	reg = <0x12110000 0x100>;
+	interrupts = <0 71 0>;
+};
+
+ehci {
+	samsung,vbus-gpio = <&gpx2 6 1 3 3>;
+};
+
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 8a5e348..bf18286 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -109,4 +109,8 @@
 	spi_2: spi at 12d40000 {
 		status = "disabled";
 	};
+
+	ehci {
+		samsung,vbus-gpio = <&gpx2 6 1 3 3>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 3c73d15..988f52a 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -64,6 +64,12 @@
 		interrupts = <0 71 0>;
 	};
 
+	ehci {
+		compatible = "samsung,exynos-ehci";
+		reg = <0x12110000 0x100>;
+		interrupts = <0 71 0>;
+	};
+
 	rtc {
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x101E0000 0x100>;
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 39a4b34..0cc626e 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -20,6 +20,7 @@
 #include <plat/cpu.h>
 #include <plat/regs-serial.h>
 #include <plat/usb-phy.h>
+#include <plat/ehci.h>
 
 #include "common.h"
 
@@ -28,6 +29,11 @@ static struct exynos4_ohci_platdata smdk5250_ohci_pdata = {
 	.phy_exit = s5p_usb_phy_exit,
 };
 
+static struct s5p_ehci_platdata smdk5250_ehci_pdata = {
+	.phy_init = s5p_usb_phy_init,
+	.phy_exit = s5p_usb_phy_exit,
+};
+
 /*
  * The following lookup table is used to override device names when devices
  * are registered from device tree. This is temporarily added to enable
@@ -65,6 +71,8 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA1, "dma-pl330.2", NULL),
 	OF_DEV_AUXDATA("samsung,exynos-ohci", 0x12120000,
 				"exynos-ohci", &smdk5250_ohci_pdata),
+	OF_DEV_AUXDATA("samsung,exynos-ehci", 0x12110000,
+				"s5p-ehci", &smdk5250_ehci_pdata),
 	{},
 };
 
-- 
1.7.0.4
