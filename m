From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 26 Feb 2018 16:42:22 +0100
Subject: [PATCH 1/2] arm64: dts: r8a77965: Add IIC-DVFS device node
In-Reply-To: <1519659743-27027-1-git-send-email-geert+renesas@glider.be>
References: <1519659743-27027-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1519659743-27027-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate the device node for the IIC Bus Interface for DVFS (IIC for
DVFS) on R-Car M3-N, and add an alias to fix its bus number.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index ebda00397d5310a1..7435297d2581c410 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -18,6 +18,10 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		i2c7 = &i2c_dvfs;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
@@ -700,9 +704,17 @@
 		i2c_dvfs: i2c at e60b0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-
+			compatible = "renesas,iic-r8a77965",
+				     "renesas,rcar-gen3-iic",
+				     "renesas,rmobile-iic";
 			reg = <0 0xe60b0000 0 0x425>;
-			/* placeholder */
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 926>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 926>;
+			dmas = <&dmac0 0x11>, <&dmac0 0x10>;
+			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		pwm0: pwm at e6e30000 {
-- 
2.7.4
