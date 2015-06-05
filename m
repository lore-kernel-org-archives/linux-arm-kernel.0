From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  5 Jun 2015 21:02:08 +0200
Subject: [PATCH 05/20] ARM: dts: sun8i: Add A23 usb-phy and otg nodes
In-Reply-To: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433530943-12599-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note these are added to the sun8i-a23.dtsi file rather then to the shared
sun8i-a23-a33.dtsi file as both the phy and the otg controller on the a33
are slightly different.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 8698f7a..60fde9e 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -58,6 +58,38 @@
 			clock-output-names = "mbus";
 		};
 	};
+
+	soc at 01c00000 {
+		usb_otg: usb at 01c19000 {
+			compatible = "allwinner,sun6i-a31-musb";
+			reg = <0x01c19000 0x0400>;
+			clocks = <&ahb1_gates 24>;
+			resets = <&ahb1_rst 24>;
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		usbphy: phy at 01c19400 {
+			compatible = "allwinner,sun8i-a23-usb-phy";
+			reg = <0x01c19400 0x10>,
+			      <0x01c1a800 0x4>;
+			reg-names = "phy_ctrl",
+				    "pmu1";
+			clocks = <&usb_clk 8>,
+				 <&usb_clk 9>;
+			clock-names = "usb0_phy",
+				      "usb1_phy";
+			resets = <&usb_clk 0>,
+				 <&usb_clk 1>;
+			reset-names = "usb0_reset",
+				      "usb1_reset";
+			status = "disabled";
+			#phy-cells = <1>;
+		};
+	};
 };
 
 &pio {
-- 
2.4.2
