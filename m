From: lyz@rock-chips.com (Yunzhi Li)
Date: Tue,  9 Dec 2014 10:52:34 +0800
Subject: [PATCH v4 4/5] ARM: dts: add rk3288 usb PHY
Message-ID: <1418093554-30671-1-git-send-email-lyz@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a device_node for RK3288 SoC usb phy. It also
defines the phy to be used by three usb controllers: usb_host0/1
and usb_otg.

Signed-off-by: Yunzhi Li <lyz@rock-chips.com>

---

Changes in v4:
- Add phy subnodes.

Changes in v3: None

 arch/arm/boot/dts/rk3288.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 874e66d..2db2d12 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -329,12 +329,35 @@
 		status = "disabled";
 	};
 
+	usbphy: phy {
+		#phy-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "rockchip,rk3288-usb-phy";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+
+		usb-phy at 0 {
+			reg = <0>;
+		};
+
+		usb-phy at 1 {
+			reg = <1>;
+		};
+
+		usb-phy at 2 {
+			reg = <2>;
+		};
+	};
+
 	usb_host0_ehci: usb at ff500000 {
 		compatible = "generic-ehci";
 		reg = <0xff500000 0x100>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST0>;
 		clock-names = "usbhost";
+		phys = <&usbphy 1>;
+		phy-names = "usb";
 		status = "disabled";
 	};
 
@@ -347,6 +370,8 @@
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST1>;
 		clock-names = "otg";
+		phys = <&usbphy 2>;
+		phy-names = "usb2-phy";
 		status = "disabled";
 	};
 
@@ -357,6 +382,8 @@
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_OTG0>;
 		clock-names = "otg";
+		phys = <&usbphy 0>;
+		phy-names = "usb2-phy";
 		status = "disabled";
 	};
 
-- 
2.0.0
