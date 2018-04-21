From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 15:55:35 +0200
Subject: [PATCH 15/17] arm64: dts: marvell: add AP806 SEI subnode
In-Reply-To: <20180421135537.24716-1-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
Message-ID: <20180421135537.24716-16-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the System Error Interrupt node, representing an IRQ chip which is
part of the GIC. The SEI node has two subnodes, one for each interrupt
domain: wired (from the AP) and not-wired (MSIs from the CPs).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 176e38d54872..ebda3edeceed 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -124,6 +124,25 @@
 				interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
+			sei: sei at 3f0200 {
+				compatible = "marvell,armada-8k-sei";
+				reg = <0x3f0200 0x40>;
+				interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				sei_wired_controller: sei-wired-controller at 0 {
+					reg = <0 21>;
+					#interrupt-cells = <1>;
+					interrupt-controller;
+				};
+
+				sei_msi_controller: sei-msi-controller at 21 {
+					reg = <21 43>;
+					msi-controller;
+				};
+			};
+
 			xor at 400000 {
 				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
 				reg = <0x400000 0x1000>,
-- 
2.14.1
