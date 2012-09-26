From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 26 Sep 2012 16:59:11 -0300
Subject: DA9053 support on mx53qsb
Message-ID: <CAOMZO5BGGOJCVrF_NZP+gXg7wfKnKv7287Xqo=J_NfsMc=HeDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying to enable Dialog DA9053 on mx53qsb and did the following:

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 5bae4c7..f3c71e5 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -60,6 +60,7 @@
 							697  0x80000000	/* MX53_PAD_EIM_DA12__GPIO3_12 */
 							701  0x80000000	/* MX53_PAD_EIM_DA13__GPIO3_13 */
 							868  0x80000000	/* MX53_PAD_PATA_DA_0__GPIO7_6 */
+							1149 0x80000000 /* MX53_PAD_GPIO_16__GPIO7_11 */
 						>;
 					};

@@ -106,6 +107,8 @@
 				pmic: dialog at 48 {
 					compatible = "dlg,da9053-aa", "dlg,da9052";
 					reg = <0x48>;
+					interrupt-parent = <&gpio7>;
+					interrupts = <11 0x8>; /* low-level active IRQ at GPIO7_11 */

 					regulators {
 						buck0 {
--

and this is what I get:
...

da9052 1-0048: DA9052 ADC IRQ failed ret=-22  ----> fails here
BUCK1: 500 <--> 2075 mV at 1250 mV at 3000 mA
BUCK2: 925 <--> 2075 mV at 1350 mV at 1500 mA
BUCK3: 925 <--> 2500 mV at 1500 mV at 1500 mA
BUCK4: at 2475 mV at 1500 mA
LDO1: at 1300 mV
LDO2: at 1300 mV
LDO3: at 3300 mV
LDO4: 1725 <--> 1800 mV at 2775 mV
LDO5: 1200 <--> 1800 mV at 1300 mV
LDO6: 1750 <--> 3300 mV at 1300 mV
LDO7: 1750 <--> 3300 mV at 2750 mV
LDO8: 1200 <--> 3600 mV at 1800 mV
LDO9: 1250 <--> 3600 mV at 1500 mV
LDO10: 1200 <--> 3600 mV at 1300 mV
....

LDO10: disabling
LDO9: disabling
LDO8: disabling
?????????? (and then hangs here).

Any suggestions as to what I am missing?

Thanks,

Fabio Estevam
