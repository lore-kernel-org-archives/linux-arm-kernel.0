From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Nov 2012 15:56:40 +0100
Subject: [PATCH 2/4] ARM: at91: dt: add mmc pinctrl for Atmel reference boards
In-Reply-To: <1353509802-20445-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121121145552.GW4398@game.jcrosoft.org>
 <1353509802-20445-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1353509802-20445-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/at91sam9263ek.dts         |   15 +++++++++++++++
 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts    |   14 ++++++++++++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |   14 ++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |   25 +++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |   13 +++++++++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |   24 ++++++++++++++++++++++++
 6 files changed, 105 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 8e319bb..1eb0872 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -56,6 +56,11 @@
 			};
 
 			mmc0: mmc at fff80000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc0
+					&pinctrl_mmc0_clk
+					&pinctrl_mmc0_slot0_cmd_dat0
+					&pinctrl_mmc0_slot0_dat1_3>;
 				status = "okay";
 				slot at 0 {
 					reg = <0>;
@@ -64,6 +69,16 @@
 					wp-gpios = <&pioE 19 0>;
 				};
 			};
+
+			pinctrl at fffff200 {
+				mmc0 {
+					pinctrl_board_mmc0: mmc0-board {
+						atmel,pins =
+							<5 18 0x0 0x5	/* PE18 gpio CD pin pull up and deglitch */
+							 5 19 0x0 0x1>;	/* PE19 gpio WP pin pull up */
+					};
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts b/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
index 684b229..66467b1 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
+++ b/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
@@ -15,12 +15,26 @@
 	ahb {
 		apb{
 			mmc0: mmc at fffa8000 {
+				/* clk already mux wuth slot0 */
+				pinctrl-0 = <
+					&pinctrl_board_mmc0_slot0
+					&pinctrl_mmc0_slot0_cmd_dat0
+					&pinctrl_mmc0_slot0_dat1_3>;
 				slot at 0 {
 					reg = <0>;
 					bus-width = <4>;
 					cd-gpios = <&pioC 2 0>;
 				};
 			};
+
+			pinctrl at fffff400 {
+				mmc0_slot0 {
+					pinctrl_board_mmc0_slot0: mmc0_slot0-board {
+						atmel,pins =
+							<2 2 0x0 0x5>;	/* PC2 gpio CD pin pull up and deglitch */
+					};
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 0090015..32a500a 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -60,6 +60,11 @@
 			};
 
 			mmc0: mmc at fffa8000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc0_slot1
+					&pinctrl_mmc0_clk
+					&pinctrl_mmc0_slot1_cmd_dat0
+					&pinctrl_mmc0_slot1_dat1_3>;
 				status = "okay";
 				slot at 1 {
 					reg = <1>;
@@ -67,6 +72,15 @@
 					cd-gpios = <&pioC 9 0>;
 				};
 			};
+
+			pinctrl at fffff400 {
+				mmc0_slot1 {
+					pinctrl_board_mmc0_slot1: mmc0_slot1-board {
+						atmel,pins =
+							<2 9 0x0 0x5>;	/* PC9 gpio CD pin pull up and deglitch */
+					};
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 1fc299f..20c3191 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -60,6 +60,10 @@
 			};
 
 			mmc0: mmc at fff80000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc0
+					&pinctrl_mmc0_slot0_clk_cmd_dat0
+					&pinctrl_mmc0_slot0_dat1_3>;
 				status = "okay";
 				slot at 0 {
 					reg = <0>;
@@ -69,6 +73,10 @@
 			};
 
 			mmc1: mmc at fffd0000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc1
+					&pinctrl_mmc1_slot0_clk_cmd_dat0
+					&pinctrl_mmc1_slot0_dat1_3>;
 				status = "okay";
 				slot at 0 {
 					reg = <0>;
@@ -77,6 +85,23 @@
 					wp-gpios = <&pioD 29 0>;
 				};
 			};
+
+			pinctrl at fffff200 {
+				mmc0 {
+					pinctrl_board_mmc0: mmc0-board {
+						atmel,pins =
+							<3 10 0x0 0x5>;	/* PD10 gpio CD pin pull up and deglitch */
+					};
+				};
+
+				mmc1 {
+					pinctrl_board_mmc1: mmc1-board {
+						atmel,pins =
+							<3 11 0x0 0x5	/* PD11 gpio CD pin pull up and deglitch */
+							 3 29 0x0 0x1>;	/* PD29 gpio WP pin pull up */
+					};
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 3d165bc..0376bf4 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -47,6 +47,10 @@
 			};
 
 			mmc0: mmc at f0008000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc0
+					&pinctrl_mmc0_slot0_clk_cmd_dat0
+					&pinctrl_mmc0_slot0_dat1_3>;
 				status = "okay";
 				slot at 0 {
 					reg = <0>;
@@ -54,6 +58,15 @@
 					cd-gpios = <&pioA 7 0>;
 				};
 			};
+
+			pinctrl at fffff400 {
+				mmc0 {
+					pinctrl_board_mmc0: mmc0-board {
+						atmel,pins =
+							<0 7 0x0 0x5>;	/* PA7 gpio CD pin pull up and deglitch */
+					};
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index e042b5e..8a7cf1d 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -19,6 +19,10 @@
 	ahb {
 		apb {
 			mmc0: mmc at f0008000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc0
+					&pinctrl_mmc0_slot0_clk_cmd_dat0
+					&pinctrl_mmc0_slot0_dat1_3>;
 				status = "okay";
 				slot at 0 {
 					reg = <0>;
@@ -28,6 +32,10 @@
 			};
 
 			mmc1: mmc at f000c000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc1
+					&pinctrl_mmc1_slot0_clk_cmd_dat0
+					&pinctrl_mmc1_slot0_dat1_3>;
 				status = "okay";
 				slot at 0 {
 					reg = <0>;
@@ -60,6 +68,22 @@
 			i2c2: i2c at f8018000 {
 				status = "okay";
 			};
+
+			pinctrl at fffff400 {
+				mmc0 {
+					pinctrl_board_mmc0: mmc0-board {
+						atmel,pins =
+							<3 15 0x0 0x5>;	/* PD15 gpio CD pin pull up and deglitch */
+					};
+				};
+
+				mmc1 {
+					pinctrl_board_mmc1: mmc1-board {
+						atmel,pins =
+							<3 14 0x0 0x5>;	/* PD14 gpio CD pin pull up and deglitch */
+					};
+				};
+			};
 		};
 
 		usb0: ohci at 00600000 {
-- 
1.7.10.4
