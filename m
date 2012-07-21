From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Sat, 21 Jul 2012 16:02:08 +0530
Subject: [PATCH 7/8 v2] ARM: EXYNOS5: Add XHCI device from device tree
In-Reply-To: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
References: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1342866729-30460-8-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds EHCI device from device tree for exynos5
and adds platform data.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 .../devicetree/bindings/usb/exynos-usb.txt         |   19 +++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                  |    6 ++++++
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    9 +++++++++
 3 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
index 45dadca..b2349fe 100644
--- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
+++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
@@ -39,3 +39,22 @@ ehci {
 	samsung,vbus-gpio = <&gpx2 6 1 3 3>;
 };
 
+XHCI
+Required properties:
+ - compatible:	should be "samsung,exynos-xhci" for USB 3.0
+   DWC3 controller in host mode.
+ - reg: physical base address of the controller and length
+   of memory mapped.
+ - interrupts: interrupt number to the cpu.
+ - samsung,vbus-gpio:  if present, specifies the GPIO
+   that needs to be pulled up for the bus to be powered.
+
+Optional properties:
+ - samsung,vbus-gpio:  if present, specifies the GPIO
+   that needs to be pulled up for the bus to be powered.
+
+xhci {
+	compatible = "samsung,exynos-xhci";
+	reg = <0x12000000 0x10000>;
+	interrupts = <0 72 0>;
+};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 988f52a..bc36584 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -70,6 +70,12 @@
 		interrupts = <0 71 0>;
 	};
 
+	xhci {
+		compatible = "samsung,exynos-xhci";
+		reg = <0x12000000 0x10000>;
+		interrupts = <0 72 0>;
+	};
+
 	rtc {
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x101E0000 0x100>;
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 0cc626e..fc1ed3f 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -10,6 +10,7 @@
 */
 
 #include <linux/of_platform.h>
+#include <linux/platform_data/dwc3-exynos.h>
 #include <linux/serial_core.h>
 
 #include <asm/mach/arch.h>
@@ -34,6 +35,12 @@ static struct s5p_ehci_platdata smdk5250_ehci_pdata = {
 	.phy_exit = s5p_usb_phy_exit,
 };
 
+static struct dwc3_exynos_data smdk5250_xhci_pdata = {
+	.phy_type = S5P_USB_PHY_DRD,
+	.phy_init = s5p_usb_phy_init,
+	.phy_exit = s5p_usb_phy_exit,
+};
+
 /*
  * The following lookup table is used to override device names when devices
  * are registered from device tree. This is temporarily added to enable
@@ -73,6 +80,8 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 				"exynos-ohci", &smdk5250_ohci_pdata),
 	OF_DEV_AUXDATA("samsung,exynos-ehci", 0x12110000,
 				"s5p-ehci", &smdk5250_ehci_pdata),
+	OF_DEV_AUXDATA("samsung,exynos-xhci", 0x12000000,
+				"exynos-dwc3", &smdk5250_xhci_pdata),
 	{},
 };
 
-- 
1.7.0.4
