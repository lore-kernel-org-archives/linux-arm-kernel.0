From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 24 Jul 2018 14:24:06 +1000
Subject: [PATCH 5/5] arm: dts: aspeed: Add power9 CFAM dtsi and use it on
 OpenPower P9 machines
In-Reply-To: <20180724042406.15374-1-benh@kernel.crashing.org>
References: <20180724042406.15374-1-benh@kernel.crashing.org>
Message-ID: <20180724042406.15374-6-benh@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This provides proper chip IDs but also adds the various sub-devices
necessary for the future OCC driver among other. All the added nodes
comply with the existing upstream FSI bindings.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts  |   1 +
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |   2 +
 .../boot/dts/aspeed-bmc-opp-witherspoon.dts   |   2 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts    |   2 +
 arch/arm/boot/dts/ibm-power9-cfam.dtsi        | 104 ++++++++++++++++++
 arch/arm/boot/dts/ibm-power9-dual.dtsi        |  58 ++++++++++
 6 files changed, 169 insertions(+)
 create mode 100644 arch/arm/boot/dts/ibm-power9-cfam.dtsi
 create mode 100644 arch/arm/boot/dts/ibm-power9-dual.dtsi

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
index d598b6391362..e744d6532cbb 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
@@ -323,3 +323,4 @@
 	status = "okay";
 };
 
+#include "ibm-power9-dual.dtsi"
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index 852f264b9569..ead2a84f16bd 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -282,3 +282,5 @@
 &ibt {
 	status = "okay";
 };
+
+#include "ibm-power9-dual.dtsi"
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index 656036106001..33ea336f0c17 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -583,3 +583,5 @@
 &ibt {
 	status = "okay";
 };
+
+#include "ibm-power9-dual.dtsi"
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index 2c5aa90a546d..05df11cacb21 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -435,3 +435,5 @@
 &ibt {
 	status = "okay";
 };
+
+#include "ibm-power9-dual.dtsi"
diff --git a/arch/arm/boot/dts/ibm-power9-cfam.dtsi b/arch/arm/boot/dts/ibm-power9-cfam.dtsi
new file mode 100644
index 000000000000..5bda517f93cc
--- /dev/null
+++ b/arch/arm/boot/dts/ibm-power9-cfam.dtsi
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2018 IBM Corp
+
+#define __MAKE_LABEL(p,i)	p##i
+#define _MAKE_LABEL(p,i)	__MAKE_LABEL(p,i)
+#define HUB_LABEL		_MAKE_LABEL(fsi_hub,CFAM_CHIP_ID)
+#define I2C_LABEL(n)		_MAKE_LABEL(_MAKE_LABEL(cfam,CFAM_CHIP_ID),_i2c##n)
+
+#address-cells = <1>;
+#size-cells = <1>;
+chip-id = <CFAM_CHIP_ID>;
+
+scom at 1000 {
+	compatible = "ibm,fsi2pib";
+	reg = <0x1000 0x400>;
+};
+
+i2c at 1800 {
+	compatible = "ibm,fsi-i2c-master";
+	reg = <0x1800 0x400>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	I2C_LABEL(0): i2c-bus at 0 {
+		reg = <0>;
+	};
+
+	I2C_LABEL(1): i2c-bus at 1 {
+		reg = <1>;
+	};
+
+	I2C_LABEL(2): i2c-bus at 2 {
+		reg = <2>;
+	};
+
+	I2C_LABEL(3): i2c-bus at 3 {
+		reg = <3>;
+	};
+
+	I2C_LABEL(4): i2c-bus at 4 {
+		reg = <4>;
+	};
+
+	I2C_LABEL(5): i2c-bus at 5 {
+		reg = <5>;
+	};
+
+	I2C_LABEL(6): i2c-bus at 6 {
+		reg = <6>;
+	};
+
+	I2C_LABEL(7): i2c-bus at 7 {
+		reg = <7>;
+	};
+
+	I2C_LABEL(8): i2c-bus at 8 {
+		reg = <8>;
+	};
+
+	I2C_LABEL(9): i2c-bus at 9 {
+		reg = <9>;
+	};
+
+	I2C_LABEL(10): i2c-bus at 10 {
+		reg = <10>;
+	};
+
+	I2C_LABEL(11): i2c-bus at 11 {
+		reg = <11>;
+	};
+
+	I2C_LABEL(12): i2c-bus at 12 {
+		reg = <12>;
+	};
+
+	I2C_LABEL(13): i2c-bus at 13 {
+		reg = <13>;
+	};
+
+	I2C_LABEL(14): i2c-bus at 14 {
+		reg = <14>;
+	};
+};
+
+sbefifo at 2400 {
+	compatible = "ibm,p9-sbefifo";
+	reg = <0x2400 0x400>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
+
+HUB_LABEL: hub at 3400 {
+	compatible = "fsi-master-hub";
+	reg = <0x3400 0x400>;
+	#address-cells = <2>;
+	#size-cells = <0>;
+
+	no-scan-on-init;
+};
+
+#undef __MAKE_LABEL
+#undef _MAKE_LABEL
+#undef HUB_LABEL
+#undef I2C_LABEL
diff --git a/arch/arm/boot/dts/ibm-power9-dual.dtsi b/arch/arm/boot/dts/ibm-power9-dual.dtsi
new file mode 100644
index 000000000000..f6a82ad43ff8
--- /dev/null
+++ b/arch/arm/boot/dts/ibm-power9-dual.dtsi
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2018 IBM Corp
+
+/* Instantiate chip 0 */
+#define CFAM_CHIP_ID 0
+&fsi {
+	cfam at 0,0 {
+		reg = <0 0>;
+		#include "ibm-power9-cfam.dtsi"
+	};
+};
+#undef CFAM_CHIP_ID
+
+/* Instantiate chip 1 */
+#define CFAM_CHIP_ID 1
+&fsi_hub0 {
+	cfam at 1,0 {
+		reg = <1 0>;
+		#include "ibm-power9-cfam.dtsi"
+	};
+};
+#undef CFAM_CHIP_ID
+
+/ {
+	aliases {
+		i2c100 = &cfam0_i2c0;
+		i2c101 = &cfam0_i2c1;
+		i2c102 = &cfam0_i2c2;
+		i2c103 = &cfam0_i2c3;
+		i2c104 = &cfam0_i2c4;
+		i2c105 = &cfam0_i2c5;
+		i2c106 = &cfam0_i2c6;
+		i2c107 = &cfam0_i2c7;
+		i2c108 = &cfam0_i2c8;
+		i2c109 = &cfam0_i2c9;
+		i2c110 = &cfam0_i2c10;
+		i2c111 = &cfam0_i2c11;
+		i2c112 = &cfam0_i2c12;
+		i2c113 = &cfam0_i2c13;
+		i2c114 = &cfam0_i2c14;
+		i2c200 = &cfam1_i2c0;
+		i2c201 = &cfam1_i2c1;
+		i2c202 = &cfam1_i2c2;
+		i2c203 = &cfam1_i2c3;
+		i2c204 = &cfam1_i2c4;
+		i2c205 = &cfam1_i2c5;
+		i2c206 = &cfam1_i2c6;
+		i2c207 = &cfam1_i2c7;
+		i2c208 = &cfam1_i2c8;
+		i2c209 = &cfam1_i2c9;
+		i2c210 = &cfam1_i2c10;
+		i2c211 = &cfam1_i2c11;
+		i2c212 = &cfam1_i2c12;
+		i2c213 = &cfam1_i2c13;
+		i2c214 = &cfam1_i2c14;
+	};
+};
+
-- 
2.17.1
