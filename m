From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  6 Aug 2014 18:03:07 +0100
Subject: [PATCH v3 4/6] usb: host: ehci-st: Add ehci-st devicetree bindings
 documentation
In-Reply-To: <1407344589-24863-1-git-send-email-peter.griffin@linaro.org>
References: <1407344589-24863-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1407344589-24863-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the device tree bindings required for the
ehci on-chip controller found in ST consumer electronics SoC's.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/usb/ehci-st.txt | 41 +++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-st.txt

diff --git a/Documentation/devicetree/bindings/usb/ehci-st.txt b/Documentation/devicetree/bindings/usb/ehci-st.txt
new file mode 100644
index 0000000..abb862a
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ehci-st.txt
@@ -0,0 +1,41 @@
+ST USB EHCI controller
+
+Required properties:
+ - compatible		: must be "st,st-ehci-300x"
+ - reg			: physical base addresses of the controller and length of memory mapped
+			  region
+ - interrupts		: one EHCI interrupt should be described here
+ - pinctrl-names	: a pinctrl state named "default" must be defined
+ - pinctrl-0		: phandle referencing pin configuration of the USB controller
+See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
+
+Optional properties:
+ - clocks		: phandle list of usb clocks
+ - clock-names		: should be "ic" for interconnect clock and "clk48"
+See: Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+ - phys			: phandle for the PHY device
+ - phy-names		: should be "usb"
+ - resets		: phandle + reset specifier pairs to the powerdown and softreset lines
+			  of the USB IP
+ - reset-names		: should be "power" and "softreset"
+See: Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
+See: Documentation/devicetree/bindings/reset/reset.txt
+
+Example:
+
+	ehci1: usb at 0xfe203e00 {
+		compatible = "st,ehci-platform";
+		reg = <0xfe203e00 0x100>;
+		interrupts = <GIC_SPI 148 IRQ_TYPE_NONE>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb1>;
+		clocks = <&clk_s_a1_ls 0>;
+		phys = <&usb2_phy>;
+		phy-names = "usb";
+		status = "okay";
+
+		resets = <&powerdown STIH416_USB1_POWERDOWN>,
+			 <&softreset STIH416_USB1_SOFTRESET>;
+		reset-names = "power", "softreset";
+	};
-- 
1.9.1
