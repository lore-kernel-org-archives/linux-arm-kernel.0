From: taoren@fb.com (Tao Ren)
Date: Thu, 8 Nov 2018 16:50:46 -0800
Subject: [PATCH v3 2/2] ARM: dts: aspeed: Add Facebook Backpack-CMM BMC
Message-ID: <20181109005046.210657-1-taoren@fb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial version of device tree file for Facebook Backpack CMM
(Chasis Management Module) ast2500 BMC.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 Changes in v3:
   - including pin configurations in UARTs 1-4 device nodes explicitly.
   - including external pinctrl controller nodes gfx and lhc explicitly.
   - deleting misleading i2c-related statements from commit messages, and
     adding comments for i2c buses in the board device tree file.
 Changes in v2:
   - including "aspeed-bmc-facebook-cmm.dtb" in Makefile.

 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts | 368 ++++++++++++++++++
 2 files changed, 369 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a7c313bfe490..2239e6a30d7a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1200,6 +1200,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2500-evb.dtb \
 	aspeed-bmc-arm-centriq2400-rep.dtb \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
+	aspeed-bmc-facebook-cmm.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-intel-s2600wf.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
new file mode 100644
index 000000000000..9f194b5eeba4
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+
+/ {
+	model = "Facebook Backpack CMM BMC";
+	compatible = "facebook,cmm-bmc", "aspeed,ast2500";
+
+	aliases {
+		/*
+		 * Override the default uart aliases to avoid breaking
+		 * the legacy applications.
+		 */
+		serial0 = &uart5;
+		serial1 = &uart1;
+		serial2 = &uart3;
+		serial3 = &uart4;
+
+		/*
+		 * Hardcode the bus number of i2c switches' channels to
+		 * avoid breaking the legacy applications.
+		 */
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+		i2c32 = &imux32;
+		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
+		i2c38 = &imux38;
+		i2c39 = &imux39;
+	};
+
+	chosen {
+		stdout-path = &uart1;
+		bootargs = "console=ttyS1,9600n8 root=/dev/ram rw earlyprintk";
+	};
+
+	memory at 80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+};
+
+&pinctrl {
+	aspeed,external-nodes = <&gfx &lhc>;
+};
+
+/*
+ * Update reset type to "system" (full chip) to fix warm reboot hang issue
+ * when reset type is set to default ("soc", gated by reset mask registers).
+ */
+&wdt1 {
+	status = "okay";
+	aspeed,reset-type = "system";
+};
+
+/*
+ * wdt2 is not used by Backpack CMM.
+ */
+&wdt2 {
+	status = "disabled";
+};
+
+&fmc {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+#include "facebook-bmc-flash-layout.dtsi"
+	};
+};
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default
+		     &pinctrl_ncts1_default
+		     &pinctrl_ndcd1_default
+		     &pinctrl_ndsr1_default
+		     &pinctrl_ndtr1_default
+		     &pinctrl_nrts1_default>;
+};
+
+&uart3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd3_default
+		     &pinctrl_rxd3_default
+		     &pinctrl_ncts3_default
+		     &pinctrl_ndcd3_default
+		     &pinctrl_nri3_default>;
+};
+
+&uart4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd4_default
+		     &pinctrl_rxd4_default>;
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&mac1 {
+	status = "okay";
+	no-hw-checksum;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+};
+
+/*
+ * I2C bus reserved for communication with COM-E.
+ */
+&i2c0 {
+	status = "okay";
+};
+
+/*
+ * I2C bus to Line Cards and Fabric Cards.
+ */
+&i2c1 {
+	status = "okay";
+
+	i2c-switch at 77 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x77>;
+
+		imux16: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux17: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux18: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux19: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux20: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux21: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux22: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux23: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+/*
+ * I2C bus to Power Distribution Board.
+ */
+&i2c2 {
+	status = "okay";
+
+	i2c-switch at 71 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x71>;
+
+		imux24: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux25: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux26: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux27: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux28: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux29: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux30: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux31: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+/*
+ * I2c bus connected with temperature sensors on CMM.
+ */
+&i2c3 {
+	status = "okay";
+};
+
+/*
+ * I2C bus reserved for communication with COM-E.
+ */
+&i2c4 {
+	status = "okay";
+};
+
+/*
+ * I2c bus connected with ADM1278.
+ */
+&i2c5 {
+	status = "okay";
+};
+
+/*
+ * I2c bus connected with I/O Expander.
+ */
+&i2c6 {
+	status = "okay";
+};
+
+/*
+ * I2c bus connected with I/O Expander and EPROMs.
+ */
+&i2c7 {
+	status = "okay";
+};
+
+/*
+ * I2C bus to Fan Control Board.
+ */
+&i2c8 {
+	status = "okay";
+
+	i2c-switch at 77 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x77>;
+
+		imux32: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux33: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux34: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux35: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux36: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux37: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux38: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux39: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+/*
+ * I2C bus to CMM CPLD.
+ */
+&i2c13 {
+	status = "okay";
+};
+
+&adc {
+	status = "okay";
+};
-- 
2.17.1
