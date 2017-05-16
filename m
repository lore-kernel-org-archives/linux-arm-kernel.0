From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Tue, 16 May 2017 15:07:22 +0300
Subject: [PATCH 2/3] arm64: dts: add LS1043A DPAA FMan support
In-Reply-To: <1494936443-14869-1-git-send-email-madalin.bucur@nxp.com>
References: <1494936443-14869-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1494936443-14869-3-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DPAA 1.x FMan device tree nodes for LS1043A boards.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi | 45 +++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |  2 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  | 73 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     | 13 +++-
 4 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
new file mode 100644
index 0000000..169e171
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
@@ -0,0 +1,45 @@
+/*
+ * QorIQ FMan v3 device tree nodes for ls1043
+ *
+ * Copyright 2015-2016 Freescale Semiconductor Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+ */
+
+&soc {
+
+/* include used FMan blocks */
+#include "qoriq-fman3-0.dtsi"
+#include "qoriq-fman3-0-1g-0.dtsi"
+#include "qoriq-fman3-0-1g-1.dtsi"
+#include "qoriq-fman3-0-1g-2.dtsi"
+#include "qoriq-fman3-0-1g-3.dtsi"
+#include "qoriq-fman3-0-1g-4.dtsi"
+#include "qoriq-fman3-0-1g-5.dtsi"
+#include "qoriq-fman3-0-10g-0.dtsi"
+
+};
+
+&fman0 {
+	/* these aliases provide the FMan ports mapping */
+	enet0: ethernet at e0000 {
+	};
+
+	enet1: ethernet at e2000 {
+	};
+
+	enet2: ethernet at e4000 {
+	};
+
+	enet3: ethernet at e6000 {
+	};
+
+	enet4: ethernet at e8000 {
+	};
+
+	enet5: ethernet at ea000 {
+	};
+
+	enet6: ethernet at f0000 {
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index 0989d63..c5b93ea 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -181,3 +181,5 @@
 		reg = <0>;
 	};
 };
+
+#include "fsl-ls1043-post.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index c37110b..67dbc94 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -139,3 +139,76 @@
 &duart1 {
 	status = "okay";
 };
+
+#include "fsl-ls1043-post.dtsi"
+
+&fman0 {
+	ethernet at e0000 {
+		phy-handle = <&qsgmii_phy1>;
+		phy-connection-type = "qsgmii";
+	};
+
+	ethernet at e2000 {
+		phy-handle = <&qsgmii_phy2>;
+		phy-connection-type = "qsgmii";
+	};
+
+	ethernet at e4000 {
+		phy-handle = <&rgmii_phy1>;
+		phy-connection-type = "rgmii-txid";
+	};
+
+	ethernet at e6000 {
+		phy-handle = <&rgmii_phy2>;
+		phy-connection-type = "rgmii-txid";
+	};
+
+	ethernet at e8000 {
+		phy-handle = <&qsgmii_phy3>;
+		phy-connection-type = "qsgmii";
+	};
+
+	ethernet at ea000 {
+		phy-handle = <&qsgmii_phy4>;
+		phy-connection-type = "qsgmii";
+	};
+
+	ethernet at f0000 { /* 10GEC1 */
+		phy-handle = <&aqr105_phy>;
+		phy-connection-type = "xgmii";
+	};
+
+	mdio at fc000 {
+		rgmii_phy1: ethernet-phy at 1 {
+			reg = <0x1>;
+		};
+
+		rgmii_phy2: ethernet-phy at 2 {
+			reg = <0x2>;
+		};
+
+		qsgmii_phy1: ethernet-phy at 4 {
+			reg = <0x4>;
+		};
+
+		qsgmii_phy2: ethernet-phy at 5 {
+			reg = <0x5>;
+		};
+
+		qsgmii_phy3: ethernet-phy at 6 {
+			reg = <0x6>;
+		};
+
+		qsgmii_phy4: ethernet-phy at 7 {
+			reg = <0x7>;
+		};
+	};
+
+	mdio at fd000 {
+		aqr105_phy: ethernet-phy at 1 {
+			compatible = "ethernet-phy-ieee802.3-c45";
+			interrupts = <0 132 4>;
+			reg = <0x1>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 2247615..5efc088 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -53,6 +53,17 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		fman0 = &fman0;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		ethernet4 = &enet4;
+		ethernet5 = &enet5;
+		ethernet6 = &enet6;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -180,7 +191,7 @@
 		interrupts = <1 9 0xf08>;
 	};
 
-	soc {
+	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.1.0
