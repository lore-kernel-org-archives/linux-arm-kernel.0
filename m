From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  5 Jun 2015 21:02:10 +0200
Subject: [PATCH 07/20] ARM: dts: sun8i: Add support for USB controllers on
 A23/A33
In-Reply-To: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433530943-12599-8-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>

A23/A33 has one pair of EHCI/OHCI USB controllers. There are 2 USB PHYs,
one for the USB OTG controller, one for the EHCI/OHCI pair. The latter
may also support HSIC, though none of the available boards utilize this,
so this is not supported yet.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 7abd0ae..b9e4d56 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -332,6 +332,28 @@
 			#size-cells = <0>;
 		};
 
+		ehci0: usb at 01c1a000 {
+			compatible = "allwinner,sun8i-a23-ehci", "generic-ehci";
+			reg = <0x01c1a000 0x100>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ahb1_gates 26>;
+			resets = <&ahb1_rst 26>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb at 01c1a400 {
+			compatible = "allwinner,sun8i-a23-ohci", "generic-ohci";
+			reg = <0x01c1a400 0x100>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ahb1_gates 29>, <&usb_clk 16>;
+			resets = <&ahb1_rst 29>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		pio: pinctrl at 01c20800 {
 			/* compatible gets set in SoC specific dtsi file */
 			reg = <0x01c20800 0x400>;
-- 
2.4.2
