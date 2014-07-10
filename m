From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 10 Jul 2014 16:18:05 +0100
Subject: [PATCH 2/3] usb: host: st-hcd: Add st-hcd devicetree bindings
 documentation.
In-Reply-To: <1405005486-26355-1-git-send-email-peter.griffin@linaro.org>
References: <1405005486-26355-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1405005486-26355-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the device tree documentation required for
the ST HCD controller found in STMicroelectronics SoCs.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/usb/st-hcd.txt | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/st-hcd.txt

diff --git a/Documentation/devicetree/bindings/usb/st-hcd.txt b/Documentation/devicetree/bindings/usb/st-hcd.txt
new file mode 100644
index 0000000..f2500dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/st-hcd.txt
@@ -0,0 +1,51 @@
+ST HCD (Host Controller Driver) for USB 2.0 and 1.1
+
+The device node has the following properties.
+
+Required properties:
+ - compatible		: must be "st,usb-300x"
+ - reg			: physical base addresses of the controller and length of memory mapped
+			  region
+ - reg-names		: names associated to the reg defines above, should be "ehci" and "ohci"
+ - interrupts		: interrupt numbers to the cpu
+ - interrupt-names	: should be "ehci" and "ohci"
+
+ - pinctrl-names	: a pinctrl state named "default" must be defined
+-  pinctrl-0		: phandle referencing pin configuration of the USB controller
+See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
+
+ - clocks		: phandle list of usb clocks.
+ - clock-names		: should be "ic" for interconnect clock and "ohci" for the 48MHz clock
+See: Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+ - resets		: phandle to the powerdown and reset controller for the USB IP
+ - reset-names		: should be "power" and "softreset".
+See: Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
+See: Documentation/devicetree/bindings/reset/reset.txt
+
+Example:
+
+usb0: usb at fe100000 {
+	compatible	= "st,usb-300x";
+	reg		= <0xfe1ffc00 0x100>,
+			  <0xfe1ffe00 0x100>;
+	reg-names	= "ohci", "ehci";
+
+	interrupts	=  <GIC_SPI 148 IRQ_TYPE_NONE>,
+			   <GIC_SPI 149 IRQ_TYPE_NONE>;
+	interrupt-names	= "ehci","ohci";
+	pinctrl-names	= "default";
+	pinctrl-0	= <&pinctrl_usb0>;
+	clocks		= <&clk_s_a1_ls CLK_ICN_IF_2>,
+			  <&clockgen_b0 0>;
+	clock-names	= "ic", "ohci";
+
+	resets		= <&powerdown STIH416_USB0_POWERDOWN>,
+			  <&softreset STIH416_USB0_SOFTRESET>;
+	reset-names	= "power", "softreset";
+
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
+};
+
+
-- 
1.9.1
