From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 Oct 2014 11:07:56 +0200
Subject: [PATCH v2 4/5] ARM: berlin: Add AHCI and SATA PHY nodes to BG2
In-Reply-To: <1413882477-27922-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413882477-27922-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1413882477-27922-5-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT nodes for the AHCI controller and SATA PHY found on Marvell
Berlin2 SoCs.

Acked-by: Antoine T?nart <antoine.tenart@free-electrons.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Changelog:
v1->v2:
- remove status = "disabled" from SATA controller node (Suggested by
  Antoine)

Cc: Kishon Vijay Abraham I <kishon@ti.com> 
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org 
---
 arch/arm/boot/dts/berlin2.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 9d7c810ebd0b..f39090491eb2 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -246,6 +246,45 @@
 			};
 		};
 
+		ahci: sata at e90000 {
+			compatible = "marvell,berlin2-ahci", "generic-ahci";
+			reg = <0xe90000 0x1000>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_SATA>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sata0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata_phy 0>;
+				status = "disabled";
+			};
+
+			sata1: sata-port at 1 {
+				reg = <1>;
+				phys = <&sata_phy 1>;
+				status = "disabled";
+			};
+		};
+
+		sata_phy: phy at e900a0 {
+			compatible = "marvell,berlin2-sata-phy";
+			reg = <0xe900a0 0x200>;
+			clocks = <&chip CLKID_SATA>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#phy-cells = <1>;
+			status = "disabled";
+
+			sata-phy at 0 {
+				reg = <0>;
+			};
+
+			sata-phy at 1 {
+				reg = <1>;
+			};
+		};
+
 		chip: chip-control at ea0000 {
 			compatible = "marvell,berlin2-chip-ctrl";
 			#clock-cells = <1>;
-- 
2.1.1
