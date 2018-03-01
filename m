From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 1 Mar 2018 16:30:44 +0100
Subject: [PATCH v2 1/2] dt-bindings: phy: add support for STM32 USB PHY
 Controller (USBPHYC)
In-Reply-To: <1519918245-17333-1-git-send-email-amelie.delaunay@st.com>
References: <1519918245-17333-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1519918245-17333-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree bindings description for STM32 USBPHYC
(USB PHY Controller).

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 .../devicetree/bindings/phy/phy-stm32-usbphyc.txt  | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
new file mode 100644
index 0000000..1ad3893
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
@@ -0,0 +1,46 @@
+STMicroelectronics STM32 USB HS PHY controller
+
+The STM32 USBPHYC block contains a dual port High Speed UTMI+ PHY and a UTMI
+switch. It controls PHY configuration and status, and the UTMI+ switch that
+selects either OTG or HOST controller for the second PHY port. It also sets
+PLL configuration.
+
+USBPHYC
+      |_ PLL
+      |
+      |_ PHY port#1 _________________ HOST controller
+      |                    _                 |
+      |                  / 1|________________|
+      |_ PHY port#2 ----|   |________________
+      |                  \_0|                |
+      |_ UTMI switch_______|          OTG controller
+
+
+Required properties:
+- compatible: must be "st,stm32mp1-usbphyc"
+- reg: address and length of the usb phy control register set
+- clocks: phandle + clock specifier for the PLL phy clock
+- phy-supply: from the generic phy bindings, phandle to the regulator
+  providing 3V3 power to the PHY, see phy-bindings.txt
+- vdda1v1-supply: phandle to the regulator providing 1V1 power to the PHY
+- vdda1v8-supply: phandle to the regulator providing 1V8 power to the PHY
+
+Optional properties:
+- assigned-clocks: phandle + clock specifier for the PLL phy clock
+- assigned-clock-parents: the PLL phy clock parent
+- resets: phandle + reset specifier
+- st,utmi-switch: should be <0> or <1>, to select USB controller for PHY
+  port#2. If not specified, 0 is the default selection.
+
+
+Example:
+		usbphyc: usb-phy at 5a006000 {
+			compatible = "st,stm32mp1-usbphyc";
+			reg = <0x5a006000 0x1000>;
+			clocks = <&rcc_clk USBPHY_K>;
+			resets = <&rcc_rst USBPHY_R>;
+			st,utmi-switch = <1>;
+			phy-supply = <&vdd_usb>;
+			vdda1v1-supply = <&reg11>;
+			vdda1v8-supply = <&reg18>
+		};
-- 
2.7.4
