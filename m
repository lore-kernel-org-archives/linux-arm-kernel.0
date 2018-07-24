From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 24 Jul 2018 14:24:05 +1000
Subject: [PATCH 4/5] arm: dts: Add power8 CFAM dtsi and use it on palmetto
In-Reply-To: <20180724042406.15374-1-benh@kernel.crashing.org>
References: <20180724042406.15374-1-benh@kernel.crashing.org>
Message-ID: <20180724042406.15374-5-benh@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So we get proper chip-id

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 10 ++++++
 arch/arm/boot/dts/ibm-power8-cfam.dtsi        | 31 +++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 arch/arm/boot/dts/ibm-power8-cfam.dtsi

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index e6cfdf3c1a67..e264d817978c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -331,3 +331,13 @@
 		line-name = "BMC_TPM_INT_N";
 	};
 };
+
+/* Instantiate chip 0 */
+#define CFAM_CHIP_ID 0
+&fsi {
+	cfam at 0,0 {
+		reg = <0 0>;
+		#include "ibm-power8-cfam.dtsi"
+	};
+};
+#undef CFAM_CHIP_ID
diff --git a/arch/arm/boot/dts/ibm-power8-cfam.dtsi b/arch/arm/boot/dts/ibm-power8-cfam.dtsi
new file mode 100644
index 000000000000..a07e9509d9bd
--- /dev/null
+++ b/arch/arm/boot/dts/ibm-power8-cfam.dtsi
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2018 IBM Corp
+
+#define __MAKE_LABEL(p,i)	p##i
+#define _MAKE_LABEL(p,i)	__MAKE_LABEL(p,i)
+#define HUB_LABEL		_MAKE_LABEL(fsi_hub,CFAM_CHIP_ID)
+#define OCC_LABEL		_MAKE_LABEL(fsi_occ,CFAM_CHIP_ID)
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
+HUB_LABEL: hub at 3400 {
+	compatible = "ibm,fsi-master-hub";
+	reg = <0x3400 0x400>;
+	#address-cells = <2>;
+	#size-cells = <0>;
+	no-scan-on-init;
+};
+
+#undef __MAKE_LABEL
+#undef _MAKE_LABEL
+#undef HUB_LABEL
+#undef OCC_LABEL
+#undef I2C_LABEL
-- 
2.17.1
