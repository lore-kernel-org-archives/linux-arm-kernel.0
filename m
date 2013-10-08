From: takasi-y@ops.dti.ne.jp (takasi-y at ops.dti.ne.jp)
Date: Tue, 8 Oct 2013 14:33:07 +0900
Subject: [PATCH v2 2/3] ARM: shmobile: emev2: Add clock tree description in DT
In-Reply-To: <20131008143040.52f36df8edb7ab63224d8433@ops.dti.ne.jp>
References: <20131008143040.52f36df8edb7ab63224d8433@ops.dti.ne.jp>
Message-ID: <20131008143307.9270bd3307a0524d89088c2a@ops.dti.ne.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add minimum clock tree description to .dts file.
This provides same set of clocks as current sh-clkfwk version .c
code does.

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
---
 arch/arm/boot/dts/emev2.dtsi | 84 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index 9063a44..df1d4cd 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -52,34 +52,118 @@
 			     <0 121 4>;
 	};
 
+	smu at e0110000 {
+		compatible = "renesas,emev2-smu";
+		reg = <0xe0110000 0x10000>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		c32ki: c32ki {
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			#clock-cells = <0>;
+		};
+		pll3_fo: pll3_fo {
+			compatible = "fixed-factor-clock";
+			clocks = <&c32ki>;
+			clock-div = <1>;
+			clock-mult = <7000>;
+			#clock-cells = <0>;
+		};
+		usia_u0_sclkdiv: usia_u0_sclkdiv {
+			compatible = "renesas,emev2-smu-clkdiv";
+			reg = <0x610 0>;
+			clocks = <&pll3_fo>;
+			#clock-cells = <0>;
+		};
+		usib_u1_sclkdiv: usib_u1_sclkdiv {
+			compatible = "renesas,emev2-smu-clkdiv";
+			reg = <0x65c 0>;
+			clocks = <&pll3_fo>;
+			#clock-cells = <0>;
+		};
+		usib_u2_sclkdiv: usib_u2_sclkdiv {
+			compatible = "renesas,emev2-smu-clkdiv";
+			reg = <0x65c 16>;
+			clocks = <&pll3_fo>;
+			#clock-cells = <0>;
+		};
+		usib_u3_sclkdiv: usib_u3_sclkdiv {
+			compatible = "renesas,emev2-smu-clkdiv";
+			reg = <0x660 0>;
+			clocks = <&pll3_fo>;
+			#clock-cells = <0>;
+		};
+		usia_u0_sclk: usia_u0_sclk {
+			compatible = "renesas,emev2-smu-gclk";
+			reg = <0x4a0 1>;
+			clocks = <&usia_u0_sclkdiv>;
+			#clock-cells = <0>;
+		};
+		usib_u1_sclk: usib_u1_sclk {
+			compatible = "renesas,emev2-smu-gclk";
+			reg = <0x4b8 1>;
+			clocks = <&usib_u1_sclkdiv>;
+			#clock-cells = <0>;
+		};
+		usib_u2_sclk: usib_u2_sclk {
+			compatible = "renesas,emev2-smu-gclk";
+			reg = <0x4bc 1>;
+			clocks = <&usib_u2_sclkdiv>;
+			#clock-cells = <0>;
+		};
+		usib_u3_sclk: usib_u3_sclk {
+			compatible = "renesas,emev2-smu-gclk";
+			reg = <0x4c0 1>;
+			clocks = <&usib_u3_sclkdiv>;
+			#clock-cells = <0>;
+		};
+		sti_sclk: sti_sclk {
+			compatible = "renesas,emev2-smu-gclk";
+			reg = <0x528 1>;
+			clocks = <&c32ki>;
+			#clock-cells = <0>;
+		};
+	};
+
 	sti at e0180000 {
 		compatible = "renesas,em-sti";
 		reg = <0xe0180000 0x54>;
 		interrupts = <0 125 0>;
+		clocks = <&sti_sclk>;
+		clock-names = "sclk";
 	};
 
 	uart at e1020000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1020000 0x38>;
 		interrupts = <0 8 0>;
+		clocks = <&usia_u0_sclk>;
+		clock-names = "sclk";
 	};
 
 	uart at e1030000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1030000 0x38>;
 		interrupts = <0 9 0>;
+		clocks = <&usib_u1_sclk>;
+		clock-names = "sclk";
 	};
 
 	uart at e1040000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1040000 0x38>;
 		interrupts = <0 10 0>;
+		clocks = <&usib_u2_sclk>;
+		clock-names = "sclk";
 	};
 
 	uart at e1050000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1050000 0x38>;
 		interrupts = <0 11 0>;
+		clocks = <&usib_u3_sclk>;
+		clock-names = "sclk";
 	};
 
 	gpio0: gpio at e0050000 {
-- 
1.8.1.5
