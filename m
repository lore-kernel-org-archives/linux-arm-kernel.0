From: rogerq@ti.com (Roger Quadros)
Date: Fri, 7 Mar 2014 12:15:08 +0200
Subject: [PATCH v3 8/8] ARM: dts: dra7: add OCP2SCP3 and SATA nodes
In-Reply-To: <1394187308-19622-1-git-send-email-rogerq@ti.com>
References: <1394187308-19622-1-git-send-email-rogerq@ti.com>
Message-ID: <1394187308-19622-9-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Balaji T K <balajitk@ti.com>

Add nodes for OCP2SCP3 bus, SATA controller and SATA PHY.

[Roger Q] Clean up.

CC: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 9e3caf3..597979b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -772,6 +772,45 @@
 			dma-names = "tx0", "rx0";
 			status = "disabled";
 		};
+
+		omap_control_sata: control-phy at 4a002374 {
+			compatible = "ti,control-phy-pipe3";
+			reg = <0x4a002374 0x4>;
+			reg-names = "power";
+			clocks = <&sys_clkin1>;
+			clock-names = "sysclk";
+		};
+
+		/* OCP2SCP3 */
+		ocp2scp at 4a090000 {
+			compatible = "ti,omap-ocp2scp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			reg = <0x4a090000 0x20>;
+			ti,hwmods = "ocp2scp3";
+			sata_phy: phy at 4A096000 {
+				compatible = "ti,phy-pipe3-sata";
+				reg = <0x4A096000 0x80>, /* phy_rx */
+				      <0x4A096400 0x64>, /* phy_tx */
+				      <0x4A096800 0x40>; /* pll_ctrl */
+				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
+				ctrl-module = <&omap_control_sata>;
+				clocks = <&sys_clkin1>;
+				clock-names = "sysclk";
+				#phy-cells = <0>;
+			};
+		};
+
+		sata: sata at 4a141100 {
+			compatible = "snps,dwc-ahci";
+			reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&sata_phy>;
+			phy-names = "sata-phy";
+			clocks = <&sata_ref_clk>;
+			ti,hwmods = "sata";
+		};
 	};
 };
 
-- 
1.8.3.2
