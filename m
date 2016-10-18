From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Oct 2016 09:25:42 +0200
Subject: [PATCH 2/2] ARM: dts: add SMSC ethernet on the APQ8060 Dragonboard
Message-ID: <1476775542-4540-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMSC9112 ethernet controller is connected to chip select 2
on the EBI2 bus on the APQ8060 Dragonboard. We set this up by
activating EBI2, creating a chipselect entry as a subnode, and then
putting the ethernet controller in a subnode of the chipselect.

After the chipselect is configured, the SMSC device will be
instantiated.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Rebase on kernel v4.9-rc1
- Bindings and driver are merged so should be clear to apply.
ChangeLog v2->v3:
- Name chipselected device to ethernet-ebi2 at 2,0
- Update to the latest (v5) version of the bindings and what
  the EBI2 driver expects.
- The SMSC911x bindings were ACKed by Arnd Bergmann and are merged
  to the netdev tree by David Miller.
- The EBI2 bindings were ACKed by Rob Herring and a pull request
  for both bindings and driver is pending for ARM SoC.
- This should be safe to merge for v4.9.
ChangeLog v1->v2:
- Use the new bindings with the first address cell indicating
  the chipselect
- Use offset zero into the range in the EBI2 node (the range
  defines the base address of the chipselect)
- Move all the XMEM setup to arrays in the EBI2 node
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 124 +++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 6c0038398ef2..7848e4c8bdb9 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -51,6 +51,29 @@
 			regulator-boot-on;
 		};
 
+		/* GPIO controlled ethernet power regulator */
+		dragon_veth: xc622a331mrg {
+			compatible = "regulator-fixed";
+			regulator-name = "XC6222A331MR-G";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			vin-supply = <&vph>;
+			gpio = <&pm8058_gpio 40 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			pinctrl-names = "default";
+			pinctrl-0 = <&dragon_veth_gpios>;
+			regulator-always-on;
+		};
+
+		/* VDDvario fixed regulator */
+		dragon_vario: nds332p {
+			compatible = "regulator-fixed";
+			regulator-name = "NDS332P";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			vin-supply = <&pm8058_s3>;
+		};
+
 		/* This is a levelshifter for SDCC5 */
 		dragon_vio_txb: txb0104rgyr {
 			compatible = "regulator-fixed";
@@ -167,6 +190,41 @@
 					bias-pull-up;
 				};
 			};
+
+			dragon_ebi2_pins: ebi2 {
+				/*
+				 * Pins used by EBI2 on the Dragonboard, actually only
+				 * only CS2 is used by a real peripheral. CS0 is just
+				 * routed to a test point.
+				 */
+				mux0 {
+					/*
+					 * Pins used by EBI2 on the Dragonboard, actually only
+					 * only CS2 is used by a real peripheral. CS0 is just
+					 * routed to a test point.
+					 */
+					pins =
+					    /* "gpio39", CS1A_N this is not good to mux */
+					    "gpio40", /* CS2A_N */
+					    "gpio134"; /* CS0_N testpoint TP29 */
+					function = "ebi2cs";
+				};
+				mux1 {
+					pins =
+					    /* EBI2_ADDR_7 downto EBI2_ADDR_0 address bus */
+					    "gpio123", "gpio124", "gpio125", "gpio126",
+					    "gpio127", "gpio128", "gpio129", "gpio130",
+					    /* EBI2_DATA_15 downto EBI2_DATA_0 data bus */
+					    "gpio135", "gpio136", "gpio137", "gpio138",
+					    "gpio139", "gpio140", "gpio141", "gpio142",
+					    "gpio143", "gpio144", "gpio145", "gpio146",
+					    "gpio147", "gpio148", "gpio149", "gpio150",
+					    "gpio151", /* EBI2_OE_N */
+					    "gpio153", /* EBI2_ADV */
+					    "gpio157"; /* EBI2_WE_N */
+					function = "ebi2";
+				};
+			};
 		};
 
 		qcom,ssbi at 500000 {
@@ -201,6 +259,15 @@
 				};
 
 				gpio at 150 {
+					dragon_ethernet_gpios: ethernet-gpios {
+						pinconf {
+							pins = "gpio7";
+							function = "normal";
+							input-enable;
+							bias-disable;
+							power-source = <PM8058_GPIO_S3>;
+						};
+					};
 					dragon_bmp085_gpios: bmp085-gpios {
 						pinconf {
 							pins = "gpio16";
@@ -238,6 +305,14 @@
 							power-source = <PM8058_GPIO_S3>;
 						};
 					};
+					dragon_veth_gpios: veth-gpios {
+						pinconf {
+							pins = "gpio40";
+							function = "normal";
+							bias-disable;
+							drive-push-pull;
+						};
+					};
 				};
 
 				led at 48 {
@@ -322,6 +397,55 @@
 			};
 		};
 
+		ebi2 at 1a100000 {
+			/* The EBI2 will instantiate first, then populate its children */
+			status = "ok";
+			pinctrl-names = "default";
+			pinctrl-0 = <&dragon_ebi2_pins>;
+
+			/*
+			 * An on-board SMSC LAN9221 chip for "debug ethernet",
+			 * which is actually just an ordinary ethernet on the
+			 * EBI2. This has a 25MHz chrystal next to it, so no
+			 * clocking is needed.
+			 */
+			ethernet-ebi2 at 2,0 {
+				compatible = "smsc,lan9221", "smsc,lan9115";
+				reg = <2 0x0 0x100>;
+				/*
+				 * GPIO7 has interrupt 198 on the PM8058
+				 * The second interrupt is the PME interrupt
+				 * for network wakeup, connected to the TLMM.
+				 */
+				interrupts-extended = <&pmicintc 198 IRQ_TYPE_EDGE_FALLING>,
+						    <&tlmm 29 IRQ_TYPE_EDGE_RISING>;
+				reset-gpios = <&tlmm 30 GPIO_ACTIVE_LOW>;
+				vdd33a-supply = <&dragon_veth>;
+				vddvario-supply = <&dragon_vario>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&dragon_ethernet_gpios>;
+				phy-mode = "mii";
+				reg-io-width = <2>;
+				smsc,force-external-phy;
+				/* IRQ on edge falling = active low */
+				smsc,irq-active-low;
+				smsc,irq-push-pull;
+
+				/*
+				 * SLOW chipselect config
+				 * Delay 9 cycles (140ns at 64MHz) between SMSC
+				 * LAN9221 Ethernet controller reads and writes
+				 * on CS2.
+				 */
+				qcom,xmem-recovery-cycles = <0>;
+				qcom,xmem-write-hold-cycles = <3>;
+				qcom,xmem-write-delta-cycles = <31>;
+				qcom,xmem-read-delta-cycles = <28>;
+				qcom,xmem-write-wait-cycles = <9>;
+				qcom,xmem-read-wait-cycles = <9>;
+			};
+		};
+
 		rpm at 104000 {
 			/*
 			 * Set up of the PMIC RPM regulators for this board
-- 
2.7.4
