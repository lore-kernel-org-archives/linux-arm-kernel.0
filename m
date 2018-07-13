From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Jul 2018 23:19:34 +0200
Subject: [PATCH 1/3 v4] ARM: dts: Add WAN ethernet port to the SQ201
Message-ID: <20180713211936.31820-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This sets up the ethernet interface and PHY for the
WAN ethernet port which uses a Marvell PHY.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Revert the lost changes in v3 (sorrty for the mistakes).
ChangeLog v2->v3:
- No changes, just resending.
ChangeLog v1->v2:
- Rename wrongly named "ethernet-phy" to "mdio"
- Drop device_type from the ethernet phy
---
 arch/arm/boot/dts/gemini-sq201.dts | 86 +++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index 7658e212e6d2..a57a03e2953b 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -20,7 +20,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,115200n8 root=/dev/sdb1 rw rootwait";
+		bootargs = "console=ttyS0,115200n8";
 		stdout-path = &uart0;
 	};
 
@@ -55,6 +55,20 @@
 		};
 	};
 
+	mdio0: mdio {
+		compatible = "virtual,mdio-gpio";
+		/* Uses MDC and MDIO */
+		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
+			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* This is a Marvell 88E1111 ethernet transciever */
+		phy0: ethernet-phy at 1 {
+			reg = <1>;
+		};
+	};
+
 	soc {
 		flash at 30000000 {
 			/*
@@ -108,6 +122,7 @@
 				/*
 				 * gpio0fgrp cover line 18 used by reset button
 				 * gpio0ggrp cover line 20 used by info LED
+				 * gpio0hgrp cover line 21, 22 used by MDIO for Marvell PHY
 				 * gpio0kgrp cover line 31 used by USB LED
 				 */
 				gpio0_default_pins: pinctrl-gpio0 {
@@ -115,9 +130,66 @@
 						function = "gpio0";
 						groups = "gpio0fgrp",
 						"gpio0ggrp",
+						"gpio0hgrp",
 						"gpio0kgrp";
 					};
 				};
+				pinctrl-gmii {
+					mux {
+						function = "gmii";
+						groups = "gmii_gmac0_grp", "gmii_gmac1_grp";
+					};
+					/* Settings come from memory dump in PLATO */
+					conf0 {
+						pins = "V8 GMAC0 RXDV";
+						skew-delay = <0>;
+					};
+					conf1 {
+						pins = "Y7 GMAC0 RXC";
+						skew-delay = <15>;
+					};
+					conf2 {
+						pins = "T8 GMAC0 TXEN";
+						skew-delay = <7>;
+					};
+					conf3 {
+						pins = "U8 GMAC0 TXC";
+						skew-delay = <10>;
+					};
+					conf4 {
+						pins = "T10 GMAC1 RXDV";
+						skew-delay = <7>;
+					};
+					conf5 {
+						pins = "Y11 GMAC1 RXC";
+						skew-delay = <8>;
+					};
+					conf6 {
+						pins = "W11 GMAC1 TXEN";
+						skew-delay = <7>;
+					};
+					conf7 {
+						pins = "V11 GMAC1 TXC";
+						skew-delay = <5>;
+					};
+					conf8 {
+						/* The data lines all have default skew */
+						pins = "W8 GMAC0 RXD0", "V9 GMAC0 RXD1",
+						       "Y8 GMAC0 RXD2", "U9 GMAC0 RXD3",
+						       "T7 GMAC0 TXD0", "U6 GMAC0 TXD1",
+						       "V7 GMAC0 TXD2", "U7 GMAC0 TXD3",
+						       "Y12 GMAC1 RXD0", "V12 GMAC1 RXD1",
+						       "T11 GMAC1 RXD2", "W12 GMAC1 RXD3",
+						       "U10 GMAC1 TXD0", "Y10 GMAC1 TXD1",
+						       "W10 GMAC1 TXD2", "T9 GMAC1 TXD3";
+						skew-delay = <7>;
+					};
+					/* Set up drive strength on GMAC0 and GMAC1 to 16 mA */
+					conf9 {
+						groups = "gmii_gmac0_grp", "gmii_gmac1_grp";
+						drive-strength = <16>;
+					};
+				};
 			};
 		};
 
@@ -154,6 +226,18 @@
 				<0x6000 0 0 4 &pci_intc 2>;
 		};
 
+		ethernet at 60000000 {
+			status = "okay";
+
+			ethernet-port at 0 {
+				phy-mode = "rgmii";
+				phy-handle = <&phy0>;
+			};
+			ethernet-port at 1 {
+				/* Used for the Vitesse G5 chip, add later */
+			};
+		};
+
 		ata at 63000000 {
 			status = "okay";
 		};
-- 
2.17.1
