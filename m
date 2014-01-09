From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu,  9 Jan 2014 13:31:48 +0100
Subject: [PATCH v2 11/12] at91: dt: sam9261: moved the NAND under the smc node
In-Reply-To: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>
References: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1389270709-32662-12-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi  | 35 ++++++++++++++-------------
 arch/arm/boot/dts/at91sam9261ek.dts | 48 ++++++++++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 6c90790..c558918 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -525,23 +525,6 @@
 			status = "disabled";
 		};
 
-		nand0: nand at 40000000 {
-			compatible = "atmel,at91rm9200-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x40000000 0x10000000>;
-			atmel,nand-addr-offset = <22>;
-			atmel,nand-cmd-offset = <21>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_nand>;
-
-			gpios = <&pioC 15 GPIO_ACTIVE_HIGH
-				&pioC 14 GPIO_ACTIVE_HIGH
-				0
-				>;
-			status = "disabled";
-		};
-
 		smc: smc at ffffec00 {
 			#address-cells = <2>;
 			#size-cells = <1>;
@@ -588,6 +571,24 @@
 				ranges = <0 3 0x00000000 0x10000000>;
 				smc,cs = <3>;
 				status = "disabled";
+
+				nand0: nand at 3,0 {
+					compatible = "atmel,at91rm9200-nand";
+					#address-cells = <1>;
+					#size-cells = <1>;
+					reg = <0x0 0x10000000>;
+					atmel,nand-addr-offset = <22>;
+					atmel,nand-cmd-offset = <21>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_nand>, <&pinctrl_smc_nandoe>, <&pinctrl_smc_nandwe>;
+					smc,cs = <3>;
+
+					gpios = <&pioC 15 GPIO_ACTIVE_HIGH
+						&pioC 14 GPIO_ACTIVE_HIGH
+						0
+						>;
+					status = "disabled";
+				};
 			};
 			ebi_cs4 at 4,0 {
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 03c05fc..e92cb8e 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -42,17 +42,6 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt = <1>;
-			status = "okay";
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x20000>;
-			};
-		};
-
 		fb0: fb at 0x00600000 {
 			display = <&display0>;
 			status = "okay";
@@ -83,6 +72,43 @@
 				};
 			};
 		};
+
+		smc: smc at ffffec00 {
+			status = "okay";
+
+			ebi_cs3 at 3,0 {
+				status = "okay";
+				smc,ncs_read_setup = <0>;
+				smc,nrd_setup = <1>;
+				smc,ncs_write_setup = <0>;
+				smc,nwe_setup = <1>;
+				smc,ncs_read_pulse = <3>;
+				smc,nrd_pulse = <3>;
+				smc,ncs_write_pulse = <3>;
+				smc,nwe_pulse = <3>;
+				smc,read_cycle = <5>;
+				smc,write_cycle = <5>;
+				smc,tdf_cycles = <2>;
+				smc,tdf_optimized = <0>;
+				smc,page_size = <0>;
+				smc,byte_access_type = <0>;
+				smc,bus_width = <0>;
+				smc,nwait_mode = <0>;
+				smc,read_mode = <1>;
+				smc,write_mode = <1>;
+
+				nand0: nand at 3,0 {
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt = <1>;
+					status = "okay";
+					at91bootstrap at 0 {
+						label = "at91bootstrap";
+						reg = <0x0 0x20000>;
+					};
+				};
+			};
+		};
 	};
 
 	leds {
-- 
1.8.5.2
