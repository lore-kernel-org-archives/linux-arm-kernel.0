From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Mon, 27 May 2013 17:40:32 +0200
Subject: [PATCH v2] ARM: kirkwood: refactor dtsi to largest common nodes
Message-ID: <1369669232-24041-1-git-send-email-valentin.longchamp@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some kirkwood variants (for instance present in the prestera SoCs) do
not have all the peripherals whose nodes are declared in
kirkwood.dtsi. These missing peripherals are SATA, SDIO, and RTC.

As discussed in [1], to avoid that these missing peripherals get
initialized which could result in system hangs when accessing
undocumented/not present HW registers, their corresponding OF nodes
should not get declared at all for some kirkwood variants.

The corresponding OF nodes of these peripherals thus are moved from
kirkwood.dtsi to the kirkwood-628x.dtsi files so that they still are
initialized for these variants where they are present.

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/167154.html

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---

Changes in v2:
	- include kirkwood-6281.dtsi in kirkwood-nsa310.dts

 arch/arm/boot/dts/kirkwood-6281.dtsi  | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-6282.dtsi  | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-nsa310.dts |  1 +
 arch/arm/boot/dts/kirkwood.dtsi       | 24 ------------------------
 4 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
index d6c9d65..29f831e 100644
--- a/arch/arm/boot/dts/kirkwood-6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
@@ -40,5 +40,29 @@
 				marvell,function = "sdio";
 			};
 		};
+
+		rtc at 10300 {
+			compatible = "marvell,kirkwood-rtc", "marvell,orion-rtc";
+			reg = <0x10300 0x20>;
+			interrupts = <53>;
+			clocks = <&gate_clk 7>;
+		};
+
+		sata at 80000 {
+			compatible = "marvell,orion-sata";
+			reg = <0x80000 0x5000>;
+			interrupts = <21>;
+			clocks = <&gate_clk 14>, <&gate_clk 15>;
+			clock-names = "0", "1";
+			status = "disabled";
+		};
+
+		mvsdio at 90000 {
+			compatible = "marvell,orion-sdio";
+			reg = <0x90000 0x200>;
+			interrupts = <28>;
+			clocks = <&gate_clk 4>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 23991e4..a1c2c05 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -49,6 +49,30 @@
 			};
 		};
 
+		rtc at 10300 {
+			compatible = "marvell,kirkwood-rtc", "marvell,orion-rtc";
+			reg = <0x10300 0x20>;
+			interrupts = <53>;
+			clocks = <&gate_clk 7>;
+		};
+
+		sata at 80000 {
+			compatible = "marvell,orion-sata";
+			reg = <0x80000 0x5000>;
+			interrupts = <21>;
+			clocks = <&gate_clk 14>, <&gate_clk 15>;
+			clock-names = "0", "1";
+			status = "disabled";
+		};
+
+		mvsdio at 90000 {
+			compatible = "marvell,orion-sdio";
+			reg = <0x90000 0x200>;
+			interrupts = <28>;
+			clocks = <&gate_clk 4>;
+			status = "disabled";
+		};
+
 		thermal at 10078 {
 			compatible = "marvell,kirkwood-thermal";
 			reg = <0x10078 0x4>;
diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index a7412b9..4197fa0 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
 
 / {
 	model = "ZyXEL NSA310";
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index fada7e6..39f497e 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -71,13 +71,6 @@
 			status = "disabled";
 		};
 
-		rtc at 10300 {
-			compatible = "marvell,kirkwood-rtc", "marvell,orion-rtc";
-			reg = <0x10300 0x20>;
-			interrupts = <53>;
-			clocks = <&gate_clk 7>;
-		};
-
 		spi at 10600 {
 			compatible = "marvell,orion-spi";
 			#address-cells = <1>;
@@ -151,15 +144,6 @@
 			status = "okay";
 		};
 
-		sata at 80000 {
-			compatible = "marvell,orion-sata";
-			reg = <0x80000 0x5000>;
-			interrupts = <21>;
-			clocks = <&gate_clk 14>, <&gate_clk 15>;
-			clock-names = "0", "1";
-			status = "disabled";
-		};
-
 		nand at 3000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -194,13 +178,5 @@
 			clocks = <&gate_clk 17>;
 			status = "okay";
 		};
-
-		mvsdio at 90000 {
-			compatible = "marvell,orion-sdio";
-			reg = <0x90000 0x200>;
-			interrupts = <28>;
-			clocks = <&gate_clk 4>;
-			status = "disabled";
-		};
 	};
 };
-- 
1.8.0.1
