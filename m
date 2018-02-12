From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Mon, 12 Feb 2018 13:35:28 +0100
Subject: [PATCH 1/2] dt-bindings: phy: add support for STM32 USB PHY
 Controller (USBPHYC)
In-Reply-To: <1518438929-5254-1-git-send-email-amelie.delaunay@st.com>
References: <1518438929-5254-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1518438929-5254-2-git-send-email-amelie.delaunay@st.com>
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
index 0000000..1e65e0a
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
+  |_ PLL
+  |
+  |_ PHY port#1 _________________ HOST controller
+  |                                      |
+  |_ PHY port#2_______                   |
+  |                   |_                 |
+  |_ UTMI switch_____/ 1|________________|
+                    |   |________________
+                     \_0|                |
+		                  OTG controller
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
+- st,port2-switch-to-host: select HOST controller on UTMI switch for port#2
+
+
+Example:
+		usbphyc: usbphyc at 5a006000 {
+			compatible = "st,stm32mp1-usbphyc";
+			reg = <0x5a006000 0x1000>;
+			clocks = <&rcc_clk USBPHY_K>;
+			resets = <&rcc_rst USBPHY_R>;
+			st,port2-switch-to-host;
+			phy-supply = <&vdd_usb>;
+			vdda1v1-supply = <&reg11>;
+			vdda1v8-supply = <&reg18>
+		};
-- 
2.7.4
