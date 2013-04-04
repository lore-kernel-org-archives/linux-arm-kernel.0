From: florian@openwrt.org (Florian Fainelli)
Date: Thu,  4 Apr 2013 12:27:15 +0200
Subject: [PATCH 5/5 v2] ARM: dove: add gigabit device tree nodes to dove.dtsi
In-Reply-To: <1365071235-11611-1-git-send-email-florian@openwrt.org>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
Message-ID: <1365071235-11611-6-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the gigabit ethernet device tree nodes to dove.dtsi in a
disabled state. The gigabit ethernet device tree node must be enabled on
a per-board basis. For completeness and easier testing the MDIO node is
also added in a disabled state.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- fixed off-by 0x2000 address of the ethernet-group node

 arch/arm/boot/dts/dove.dtsi |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index f7509ca..51de5f7 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -253,5 +253,30 @@
 				dmacap,xor;
 			};
 		};
+
+		mdio at 72004 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "marvell,orion-mdio";
+			reg = <0x72004 0x84>;
+			status = "disabled";
+		};
+
+		ethernet-group at 72000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "marvell,mv643xx-eth-block";
+			reg = <0x72000 0x4000>;
+			tx-csum-limit = <1600>;
+			status = "disabled";
+
+			egiga0: ethernet at 0 {
+				device_type = "network";
+				compatible = "marvell,mv643xx-eth";
+				reg = <0>;
+				interrupts = <29>;
+				clocks = <&gate_clk 2>;
+			};
+		};
 	};
 };
-- 
1.7.10.4
