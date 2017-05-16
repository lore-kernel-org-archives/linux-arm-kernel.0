From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Tue, 16 May 2017 15:07:23 +0300
Subject: [PATCH 3/3] arm64: dts: add LS1046A DPAA FMan nodes
In-Reply-To: <1494936443-14869-1-git-send-email-madalin.bucur@nxp.com>
References: <1494936443-14869-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1494936443-14869-4-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DPAA 1.x FMan device tree nodes for LS1046A boards.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi | 48 +++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  |  2 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 60 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 11 +++-
 4 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
new file mode 100644
index 0000000..f5017db
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
@@ -0,0 +1,48 @@
+/*
+ * QorIQ FMan v3 device tree nodes for ls1046
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
+#include "qoriq-fman3-0-10g-1.dtsi"
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
+
+	enet7: ethernet at f2000 {
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index 290e5b0..40357b1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -210,3 +210,5 @@
 		reg = <0>;
 	};
 };
+
+#include "fsl-ls1046-post.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index d1ccc00..af6e58d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -148,3 +148,63 @@
 		reg = <1>;
 	};
 };
+
+#include "fsl-ls1046-post.dtsi"
+
+&fman0 {
+	ethernet at e4000 {
+		phy-handle = <&rgmii_phy1>;
+		phy-connection-type = "rgmii";
+	};
+
+	ethernet at e6000 {
+		phy-handle = <&rgmii_phy2>;
+		phy-connection-type = "rgmii";
+	};
+
+	ethernet at e8000 {
+		phy-handle = <&sgmii_phy1>;
+		phy-connection-type = "sgmii";
+	};
+
+	ethernet at ea000 {
+		phy-handle = <&sgmii_phy2>;
+		phy-connection-type = "sgmii";
+	};
+
+	ethernet at f0000 { /* 10GEC1 */
+		phy-handle = <&aqr106_phy>;
+		phy-connection-type = "xgmii";
+	};
+
+	ethernet at f2000 { /* 10GEC2 */
+		fixed-link = <0 1 1000 0 0>;
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
+		sgmii_phy1: ethernet-phy at 3 {
+			reg = <0x3>;
+		};
+
+		sgmii_phy2: ethernet-phy at 4 {
+			reg = <0x4>;
+		};
+	};
+
+	mdio at fd000 {
+		aqr106_phy: ethernet-phy at 0 {
+			compatible = "ethernet-phy-ieee802.3-c45";
+			interrupts = <0 131 4>;
+			reg = <0x0>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 55f1e4f..318539a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -55,6 +55,15 @@
 
 	aliases {
 		crypto = &crypto;
+		fman0 = &fman0;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		ethernet4 = &enet4;
+		ethernet5 = &enet5;
+		ethernet6 = &enet6;
+		ethernet7 = &enet7;
 	};
 
 	cpus {
@@ -174,7 +183,7 @@
 					 IRQ_TYPE_LEVEL_LOW)>;
 	};
 
-	soc {
+	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.1.0
