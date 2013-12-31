From: jjhiblot@traphandler.com (jjhiblot at traphandler.com)
Date: Tue, 31 Dec 2013 17:32:13 +0100
Subject: [PATCH 5/6] at91: dt: sam9261: Add an entry in the DT for the SMC/EBI
 bus driver.
In-Reply-To: <1388507534-10570-1-git-send-email-jjhiblot@traphandler.com>
References: <1388507534-10570-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1388507534-10570-6-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: jean-jacques hiblot <jean-jacques.hiblot@jdsu.com>

This patch creates a new entry in the device tree for the 9261 under which
should be the devices attached to the EBI.
It also moves the NAND DT entries under this new bus.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi  | 32 +++++++++++++++++---------
 arch/arm/boot/dts/at91sam9261ek.dts | 46 ++++++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 925f9ad..acd19b4 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -525,21 +525,31 @@
 			status = "disabled";
 		};
 
-		nand0: nand at 40000000 {
-			compatible = "atmel,at91rm9200-nand";
+		smc: smc at ffffec00 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			reg = <0x40000000 0x10000000>;
-			atmel,nand-addr-offset = <22>;
-			atmel,nand-cmd-offset = <21>;
+			compatible = "atmel,at91sam9261-smc";
+			reg = <0xffffec00 0x80>;
 			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_nand>;
-
-			gpios = <&pioC 15 GPIO_ACTIVE_HIGH
-				&pioC 14 GPIO_ACTIVE_HIGH
-				0
-				>;
 			status = "disabled";
+			ranges = < >;
+			nand0: nand at 40000000 {
+				compatible = "atmel,at91rm9200-nand";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x40000000 0x10000000>;
+				atmel,nand-addr-offset = <22>;
+				atmel,nand-cmd-offset = <21>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_nand>, <&pinctrl_smc_nandoe>, <&pinctrl_smc_nandwe>;
+				smc,cs = <3>;
+
+				gpios = <&pioC 15 GPIO_ACTIVE_HIGH
+					&pioC 14 GPIO_ACTIVE_HIGH
+					0
+					>;
+				status = "disabled";
+			};
 		};
 
 		usb0: ohci at 00500000 {
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 03c05fc..11cf619 100644
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
@@ -83,6 +72,41 @@
 				};
 			};
 		};
+
+		smc: smc at ffffec00 {
+			status = "okay";
+
+			nand0: nand at 40000000 {
+				nand-bus-width = <8>;
+				nand-ecc-mode = "soft";
+				nand-on-flash-bbt = <1>;
+				status = "okay";
+
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
+				at91bootstrap at 0 {
+					label = "at91bootstrap";
+					reg = <0x0 0x20000>;
+				};
+			};
+		};
 	};
 
 	leds {
-- 
1.8.4.2
