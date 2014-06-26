From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 26 Jun 2014 12:13:34 +0200
Subject: [PATCH v2 1/2] ARM: at91/dt: describe rgmii ethernet phy connected to
 sama5d3xek boards
In-Reply-To: <1403777615-25685-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1403777615-25685-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1403777615-25685-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ethernet-phy node and specify phy interrupt (connected to pin PB25).

The PHY address is not specified here because atmel have 2 different
designs
for its CPU modules: one is connecting PHYAD[0-2] pins to pull up resistors
(Embest design) and the other one is connection PHYAD0 to a pull up
resistor and PHYAD[1-2] to pull down resistors (Ronetix design).
As a result, Ronetix design will have its PHY available at address 0x1 and
Embest design at 0x7.
Let the net PHY core automatically detect the PHY address by scanning the
MDIO bus.

Define board specific delays to apply to RGMII signals.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3xcm.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index b0b1331..fc68bae 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -34,6 +34,21 @@
 
 			macb0: ethernet at f0028000 {
 				phy-mode = "rgmii";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ethernet-phy {
+					interrupt-parent = <&pioB>;
+					interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+					txen-skew-ps = <800>;
+					txc-skew-ps = <3000>;
+					rxdv-skew-ps = <400>;
+					rxc-skew-ps = <3000>;
+					rxd0-skew-ps = <400>;
+					rxd1-skew-ps = <400>;
+					rxd2-skew-ps = <400>;
+					rxd3-skew-ps = <400>;
+				};
 			};
 
 			pmc: pmc at fffffc00 {
-- 
1.8.3.2
