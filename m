From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  7 Mar 2016 12:12:14 +0000
Subject: [PATCH 1/2] arm64: dts: juno/vexpress: fix node name unit-address
 presence warnings
Message-ID: <1457352735-24453-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit fa38a82096a1 ("scripts/dtc: Update to upstream version
53bf130b1cdd") added warnings on node name unit-address presence/absence
mismatch in device trees.

This patch fixes those warning on all the juno/vexpress platforms where
unit-address is present in node name while the reg/ranges property is
not present.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/foundation-v8.dtsi         |  2 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi             | 14 +++++-----
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi      | 30 +++++++++++-----------
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         |  2 +-
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi   | 14 +++++-----
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      | 10 ++++----
 6 files changed, 36 insertions(+), 36 deletions(-)

Hi Rob,

I am not sure if the intention of commit fa38a82096a1 is to fix even
existing warnings or not. I saw warning with today's -next branch.
Let me know.

Regards,
Sudeep

diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
index 9314f3943269..ba03c934a861 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
@@ -89,7 +89,7 @@
 			     <0 63 4>;
 	};
 
-	smb {
+	smb at 0,08000000 {
 		compatible = "arm,vexpress,v2m-p1", "simple-bus";
 		arm,v2m-memory-map = "rs1";
 		#address-cells = <2>; /* SMB chipselect number and offset */
diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 4b6172b0f2cb..3841e82fa6f8 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -105,13 +105,13 @@
 		clocks {
 			compatible = "arm,scpi-clocks";
 
-			scpi_dvfs: scpi_clocks at 0 {
+			scpi_dvfs: scpi-clocks-0 {
 				compatible = "arm,scpi-dvfs-clocks";
 				#clock-cells = <1>;
 				clock-indices = <0>, <1>, <2>;
 				clock-output-names = "atlclk", "aplclk","gpuclk";
 			};
-			scpi_clk: scpi_clocks at 3 {
+			scpi_clk: scpi-clocks-1 {
 				compatible = "arm,scpi-variable-clocks";
 				#clock-cells = <1>;
 				clock-indices = <3>;
@@ -154,7 +154,7 @@
 		clock-names = "pxlclk";
 
 		port {
-			hdlcd1_output: endpoint at 0 {
+			hdlcd1_output: endpoint0 {
 				remote-endpoint = <&tda998x_1_input>;
 			};
 		};
@@ -168,7 +168,7 @@
 		clock-names = "pxlclk";
 
 		port {
-			hdlcd0_output: endpoint at 0 {
+			hdlcd0_output: endpoint0 {
 				remote-endpoint = <&tda998x_0_input>;
 			};
 		};
@@ -196,7 +196,7 @@
 			compatible = "nxp,tda998x";
 			reg = <0x70>;
 			port {
-				tda998x_0_input: endpoint at 0 {
+				tda998x_0_input: endpoint0 {
 					remote-endpoint = <&hdlcd0_output>;
 				};
 			};
@@ -206,7 +206,7 @@
 			compatible = "nxp,tda998x";
 			reg = <0x71>;
 			port {
-				tda998x_1_input: endpoint at 0 {
+				tda998x_1_input: endpoint0 {
 					remote-endpoint = <&hdlcd1_output>;
 				};
 			};
@@ -243,7 +243,7 @@
 		      <0x00000008 0x80000000 0x1 0x80000000>;
 	};
 
-	smb {
+	smb at 0,08000000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
index 413f1b9ebcd4..3d4af126df6e 100644
--- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
@@ -46,7 +46,7 @@
 			arm,vexpress,site = <0>;
 			arm,v2m-memory-map = "rs1";
 
-			mb_fixed_3v3: fixedregulator at 0 {
+			mb_fixed_3v3: fixedregulator0 {
 				compatible = "regulator-fixed";
 				regulator-name = "MCC_SB_3V3";
 				regulator-min-microvolt = <3300000>;
@@ -59,42 +59,42 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				button at 1 {
+				button1 {
 					debounce_interval = <50>;
 					wakeup-source;
 					linux,code = <116>;
 					label = "POWER";
 					gpios = <&iofpga_gpio0 0 0x4>;
 				};
-				button at 2 {
+				button2 {
 					debounce_interval = <50>;
 					wakeup-source;
 					linux,code = <102>;
 					label = "HOME";
 					gpios = <&iofpga_gpio0 1 0x4>;
 				};
-				button at 3 {
+				button3 {
 					debounce_interval = <50>;
 					wakeup-source;
 					linux,code = <152>;
 					label = "RLOCK";
 					gpios = <&iofpga_gpio0 2 0x4>;
 				};
-				button at 4 {
+				button4 {
 					debounce_interval = <50>;
 					wakeup-source;
 					linux,code = <115>;
 					label = "VOL+";
 					gpios = <&iofpga_gpio0 3 0x4>;
 				};
-				button at 5 {
+				button5 {
 					debounce_interval = <50>;
 					wakeup-source;
 					linux,code = <114>;
 					label = "VOL-";
 					gpios = <&iofpga_gpio0 4 0x4>;
 				};
-				button at 6 {
+				button6 {
 					debounce_interval = <50>;
 					wakeup-source;
 					linux,code = <99>;
@@ -159,7 +159,7 @@
 					compatible = "syscon", "simple-mfd";
 					reg = <0x010000 0x1000>;
 
-					led at 08.0 {
+					led0 {
 						compatible = "register-bit-led";
 						offset = <0x08>;
 						mask = <0x01>;
@@ -167,7 +167,7 @@
 						linux,default-trigger = "heartbeat";
 						default-state = "on";
 					};
-					led at 08.1 {
+					led1 {
 						compatible = "register-bit-led";
 						offset = <0x08>;
 						mask = <0x02>;
@@ -175,7 +175,7 @@
 						linux,default-trigger = "mmc0";
 						default-state = "off";
 					};
-					led at 08.2 {
+					led2 {
 						compatible = "register-bit-led";
 						offset = <0x08>;
 						mask = <0x04>;
@@ -183,7 +183,7 @@
 						linux,default-trigger = "cpu0";
 						default-state = "off";
 					};
-					led at 08.3 {
+					led3 {
 						compatible = "register-bit-led";
 						offset = <0x08>;
 						mask = <0x08>;
@@ -191,7 +191,7 @@
 						linux,default-trigger = "cpu1";
 						default-state = "off";
 					};
-					led at 08.4 {
+					led4 {
 						compatible = "register-bit-led";
 						offset = <0x08>;
 						mask = <0x10>;
@@ -199,7 +199,7 @@
 						linux,default-trigger = "cpu2";
 						default-state = "off";
 					};
-					led at 08.5 {
+					led5 {
 						compatible = "register-bit-led";
 						offset = <0x08>;
 						mask = <0x20>;
@@ -207,14 +207,14 @@
 						linux,default-trigger = "cpu3";
 						default-state = "off";
 					};
-					led at 08.6 {
+					led6 {
 						compatible = "register-bit-led";
 						offset = <0x08>;
 						mask = <0x40>;
 						label = "vexpress:6";
 						default-state = "off";
 					};
-					led at 08.7 {
+					led7 {
 						compatible = "register-bit-led";
 						offset = <0x08>;
 						mask = <0x80>;
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
index 20addabbd127..0d0df795809c 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
@@ -104,7 +104,7 @@
 			     <0 63 4>;
 	};
 
-	smb {
+	smb at 0,08000000 {
 		compatible = "simple-bus";
 
 		#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
index 88a7583ed7a7..09d97e1a8948 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
@@ -226,7 +226,7 @@
 			};
 		};
 
-		v2m_fixed_3v3: fixedregulator at 0 {
+		v2m_fixed_3v3: fixedregulator {
 			compatible = "regulator-fixed";
 			regulator-name = "3V3";
 			regulator-min-microvolt = <3300000>;
@@ -238,7 +238,7 @@
 			compatible = "arm,vexpress,config-bus";
 			arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-			v2m_oscclk1: osc at 1 {
+			v2m_oscclk1: osc {
 				/* CLCD clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 1>;
@@ -247,27 +247,27 @@
 				clock-output-names = "v2m:oscclk1";
 			};
 
-			reset at 0 {
+			reset {
 				compatible = "arm,vexpress-reset";
 				arm,vexpress-sysreg,func = <5 0>;
 			};
 
-			muxfpga at 0 {
+			muxfpga {
 				compatible = "arm,vexpress-muxfpga";
 				arm,vexpress-sysreg,func = <7 0>;
 			};
 
-			shutdown at 0 {
+			shutdown {
 				compatible = "arm,vexpress-shutdown";
 				arm,vexpress-sysreg,func = <8 0>;
 			};
 
-			reboot at 0 {
+			reboot {
 				compatible = "arm,vexpress-reboot";
 				arm,vexpress-sysreg,func = <9 0>;
 			};
 
-			dvimode at 0 {
+			dvimode {
 				compatible = "arm,vexpress-dvimode";
 				arm,vexpress-sysreg,func = <11 0>;
 			};
diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
index bb3c26d1154d..00024be0c9b0 100644
--- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
+++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
@@ -93,7 +93,7 @@
 		compatible = "arm,vexpress,config-bus";
 		arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-		smbclk: osc at 4 {
+		smbclk: osc4 {
 			/* SMC clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 4>;
@@ -102,7 +102,7 @@
 			clock-output-names = "smclk";
 		};
 
-		volt at 0 {
+		volt0 {
 			/* VIO to expansion board above */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 0>;
@@ -112,7 +112,7 @@
 			regulator-always-on;
 		};
 
-		volt at 1 {
+		volt1 {
 			/* 12V from power connector J6 */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 1>;
@@ -120,7 +120,7 @@
 			regulator-always-on;
 		};
 
-		temp at 0 {
+		temp0 {
 			/* FPGA temperature */
 			compatible = "arm,vexpress-temp";
 			arm,vexpress-sysreg,func = <4 0>;
@@ -128,7 +128,7 @@
 		};
 	};
 
-	smb {
+	smb at 0,08000000 {
 		compatible = "simple-bus";
 
 		#address-cells = <2>;
-- 
1.9.1
