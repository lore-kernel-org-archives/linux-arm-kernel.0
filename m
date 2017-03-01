From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Wed, 1 Mar 2017 17:35:05 +0200
Subject: [PATCH v2 2/2] dts: arm64: add LS1046A DPAA support
In-Reply-To: <1488382505-17554-1-git-send-email-madalin.bucur@nxp.com>
References: <1488382505-17554-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1488382505-17554-3-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi | 45 +++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  |  2 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 62 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 66 +++++++++++++++++++++-
 .../boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi    | 42 ++++++++++++++
 5 files changed, 216 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
new file mode 100644
index 0000000..1a29045
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
@@ -0,0 +1,45 @@
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
+/include/ "qoriq-fman3-0.dtsi"
+/include/ "qoriq-fman3-0-1g-0.dtsi"
+/include/ "qoriq-fman3-0-1g-1.dtsi"
+/include/ "qoriq-fman3-0-1g-2.dtsi"
+/include/ "qoriq-fman3-0-1g-3.dtsi"
+/include/ "qoriq-fman3-0-1g-4.dtsi"
+/include/ "qoriq-fman3-0-1g-5.dtsi"
+/include/ "qoriq-fman3-0-10g-0.dtsi"
+/include/ "qoriq-fman3-0-10g-1.dtsi"
+	fman at 1a00000 {
+		enet0: ethernet at e0000 {
+		};
+
+		enet1: ethernet at e2000 {
+		};
+
+		enet2: ethernet at e4000 {
+		};
+
+		enet3: ethernet at e6000 {
+		};
+
+		enet4: ethernet at e8000 {
+		};
+
+		enet5: ethernet at ea000 {
+		};
+
+		enet6: ethernet at f0000 {
+		};
+
+		enet7: ethernet at f2000 {
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index 290e5b0..ccd3948 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -210,3 +210,5 @@
 		reg = <0>;
 	};
 };
+
+/include/ "fsl-ls1046-post.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index d1ccc00..78d5609 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -148,3 +148,65 @@
 		reg = <1>;
 	};
 };
+
+/include/ "fsl-ls1046-post.dtsi"
+
+&soc {
+	fman at 1a00000 {
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
+		aqr106_phy: ethernet-phy at 1 {
+			compatible = "ethernet-phy-ieee802.3-c45";
+			interrupts = <0 131 4>;
+			reg = <0x0>;
+		};
+	};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 38806ca..7aef0d8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -54,6 +54,15 @@
 
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
@@ -172,7 +181,7 @@
 					 IRQ_TYPE_LEVEL_LOW)>;
 	};
 
-	soc {
+	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -266,6 +275,18 @@
 			};
 		};
 
+		qman: qman at 1880000 {
+			compatible = "fsl,qman";
+			reg = <0x00 0x1880000 0x0 0x10000>;
+			interrupts = <0 45 0x4>;
+		};
+
+		bman: bman at 1890000 {
+			compatible = "fsl,bman";
+			reg = <0x00 0x1890000 0x0 0x10000>;
+			interrupts = <0 45 0x4>;
+		};
+
 		dcfg: dcfg at 1ee0000 {
 			compatible = "fsl,ls1046a-dcfg", "syscon";
 			reg = <0x0 0x1ee0000 0x0 0x10000>;
@@ -512,4 +533,47 @@
 			clocks = <&clockgen 4 1>;
 		};
 	};
+
+	qportals: qman-portals at 500000000 {
+		ranges = <0x0 0x5 0x00000000 0x8000000>;
+	};
+	bportals: bman-portals at 508000000 {
+		ranges = <0x0 0x5 0x08000000 0x8000000>;
+	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+		qman_fqd: qman-fqd {
+			size = <0 0x800000>;
+			alignment = <0 0x800000>;
+		};
+		qman_pfdr: qman-pfdr {
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+		};
+	};
+};
+
+&bman_fbpr {
+	compatible = "fsl,bman-fbpr";
+	alloc-ranges = <0 0 0x10000 0>;
 };
+
+&qman_fqd {
+	compatible = "fsl,qman-fqd";
+	alloc-ranges = <0 0 0x10000 0>;
+};
+
+&qman_pfdr {
+	compatible = "fsl,qman-pfdr";
+	alloc-ranges = <0 0 0x10000 0>;
+};
+
+/include/ "qoriq-qman1-portals.dtsi"
+/include/ "qoriq-bman1-portals.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
new file mode 100644
index 0000000..2a36f18
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
@@ -0,0 +1,42 @@
+/*
+ * QorIQ FMan v3 10g port #1 device tree
+ *
+ * Copyright 2012-2015 Freescale Semiconductor Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+ */
+
+fman at 1a00000 {
+	fman0_rx_0x11: port at 91000 {
+		cell-index = <0x11>;
+		compatible = "fsl,fman-v3-port-rx";
+		reg = <0x91000 0x1000>;
+		fsl,fman-10g-port;
+	};
+
+	fman0_tx_0x31: port at b1000 {
+		cell-index = <0x31>;
+		compatible = "fsl,fman-v3-port-tx";
+		reg = <0xb1000 0x1000>;
+		fsl,fman-10g-port;
+	};
+
+	ethernet at f2000 {
+		cell-index = <0x8>;
+		compatible = "fsl,fman-memac";
+		reg = <0xf2000 0x1000>;
+		fsl,fman-ports = <&fman0_rx_0x11 &fman0_tx_0x31>;
+		pcsphy-handle = <&pcsphy7>;
+	};
+
+	mdio at f3000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		reg = <0xf3000 0x1000>;
+
+		pcsphy7: ethernet-phy at 0 {
+			reg = <0x0>;
+		};
+	};
+};
-- 
2.1.0
