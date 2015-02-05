From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu,  5 Feb 2015 22:46:58 +0800
Subject: [PATCH 2/4] Documentation: dt-bindings: add dt binding info for hi6220
In-Reply-To: <1423147620-5760-1-git-send-email-zhangfei.gao@linaro.org>
References: <1423147620-5760-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1423147620-5760-3-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../devicetree/bindings/usb/hi6220-usb.txt         | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/hi6220-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/hi6220-usb.txt b/Documentation/devicetree/bindings/usb/hi6220-usb.txt
new file mode 100644
index 0000000..e926364
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/hi6220-usb.txt
@@ -0,0 +1,50 @@
+Hisilicon hi6220  SoC USB controlle
+-----------------------------
+
+usb controller is inherited from dwc2, refer dwc2.txt
+-----
+
+Required properties:
+- compatible: "hisilicon,hi6220-usb-phy"
+Refer to dwc2.txt for dwc2 usb properties
+
+
+phy:
+-----
+
+Required properties:
+- compatible: "hisilicon,hi6220-usb-phy"
+- vcc-supply: phandle to the regulator that provides power to the PHY.
+- clocks: phandle to the PHY clock. Use as per Documentation/devicetree
+  /bindings/clock/clock-bindings.txt
+- hisilicon,peripheral-syscon: phandle of syscon used to control peripheral.
+- hisilicon,gpio_vbus_det: gpio of detecting vbus.
+- hisilicon,gpio_id_det: gpio of detecting id.
+
+Example:
+
+	peripheral_ctrl: syscon at f7030000 {
+	        compatible = "syscon";
+	        reg = <0x0 0xf7030000 0x0 0x1000>;
+	};
+
+	usb2_phy: usbphy {
+		compatible = "hisilicon,hi6220-usb-phy";
+		vcc-supply = <&fixed_5v_hub>;
+		hisilicon,gpio_vbus_det = <&gpio2 6 0>;
+		hisilicon,gpio_id_det = <&gpio2 5 0>;
+		hisilicon,peripheral-syscon = <&peripheral_ctrl>;
+		clocks = <&clock_sys HI6220_USBOTG_HCLK>;
+	};
+
+	usb: usb at f72c0000 {
+		compatible = "hisilicon,hi6220-usb";
+		reg = <0x0 0xf72c0000 0x0 0x40000>;
+		phys = <&usb2_phy>;
+		dr_mode = "otg";
+		g-use-dma;
+		g-rx-fifo-size = <512>;
+		g-np-tx-fifo-size = <128>;
+		g-tx-fifo-size = <128>;
+		interrupts = <0 77 0x4>;
+	};
-- 
1.9.1
