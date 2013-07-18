From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Jul 2013 09:46:08 +0200
Subject: [PATCH 1/4] ARM: dts: i.MX6: split enet pins into smaller groups
In-Reply-To: <1374133571-7660-1-git-send-email-s.hauer@pengutronix.de>
References: <1374133571-7660-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1374133571-7660-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We used to have complete pinctrl groups for each device. This turns
out to be quite inflexible since we have to introduce a new pinctrl
group for each slight difference. This splits the enet pinctrl groups
into:

- a base group
- two mdio groups
- one enet ref clk group

This results in smaller devicetrees (both binary and source code) and
increased flexibility.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-wandboard.dts     |  2 +-
 arch/arm/boot/dts/imx6dl.dtsi              | 31 ++++++++++-----------
 arch/arm/boot/dts/imx6q-arm2.dts           |  2 +-
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |  2 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts      |  2 +-
 arch/arm/boot/dts/imx6q-sbc6x.dts          |  2 +-
 arch/arm/boot/dts/imx6q.dtsi               | 44 +++++++-----------------------
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi   |  2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi     |  2 +-
 9 files changed, 31 insertions(+), 58 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-wandboard.dts b/arch/arm/boot/dts/imx6dl-wandboard.dts
index bfc59c3..e3d3e11 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard.dts
@@ -22,7 +22,7 @@
 
 &fec {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet_1>;
+	pinctrl-0 = <&pinctrl_enet_1 &pinctrl_enet_mdio_1 &pinctrl_enet_ref_1>;
 	phy-mode = "rgmii";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 2b3ecd6..8a740f1 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -61,8 +61,6 @@
 				enet {
 					pinctrl_enet_1: enetgrp-1 {
 						fsl,pins = <
-							MX6DL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
-							MX6DL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
 							MX6DL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
 							MX6DL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
 							MX6DL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
@@ -76,27 +74,26 @@
 							MX6DL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
 							MX6DL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
 							MX6DL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
-							MX6DL_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8
 						>;
 					};
 
-					pinctrl_enet_2: enetgrp-2 {
+					pinctrl_enet_mdio_1: enet-mdiogrp-1 {
+						fsl,pins = <
+							MX6DL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
+							MX6DL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
+						>;
+					};
+
+					pinctrl_enet_mdio_2: enet-mdiogrp-2 {
 						fsl,pins = <
 							MX6DL_PAD_KEY_COL1__ENET_MDIO        0x1b0b0
 							MX6DL_PAD_KEY_COL2__ENET_MDC         0x1b0b0
-							MX6DL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
-							MX6DL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
-							MX6DL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
-							MX6DL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
-							MX6DL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
-							MX6DL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
-							MX6DL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
-							MX6DL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
-							MX6DL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
-							MX6DL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
-							MX6DL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
-							MX6DL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
-							MX6DL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
+						>;
+					};
+
+					pinctrl_enet_ref_1: enet-refgrp-1 {
+						fsl,pins = <
+							MX6DL_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8
 						>;
 					};
 				};
diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index 4e54fde..3425bc1 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -74,7 +74,7 @@
 
 &fec {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet_2>;
+	pinctrl-0 = <&pinctrl_enet_1 &pinctrl_enet_mdio_2>;
 	phy-mode = "rgmii";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
index f5e1981..c2ed29c 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -44,7 +44,7 @@
 
 &fec {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet_3>;
+	pinctrl-0 = <&pinctrl_enet_1 &pinctrl_enet_mdio_1>;
 	phy-mode = "rgmii";
 	phy-reset-gpios = <&gpio3 23 0>;
 	status = "disabled";
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 6a00066..48661a4 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -118,7 +118,7 @@
 
 &fec {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet_1>;
+	pinctrl-0 = <&pinctrl_enet_1 &pinctrl_enet_mdio_1 &pinctrl_enet_ref_1>;
 	phy-mode = "rgmii";
 	phy-reset-gpios = <&gpio3 23 0>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6q-sbc6x.dts b/arch/arm/boot/dts/imx6q-sbc6x.dts
index ee6addf..8d0e4ad 100644
--- a/arch/arm/boot/dts/imx6q-sbc6x.dts
+++ b/arch/arm/boot/dts/imx6q-sbc6x.dts
@@ -19,7 +19,7 @@
 
 &fec {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet_1>;
+	pinctrl-0 = <&pinctrl_enet_1 &pinctrl_enet_mdio_1 &pinctrl_enet_ref_1>;
 	phy-mode = "rgmii";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index ba09dc3..09797ca 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -123,8 +123,6 @@
 				enet {
 					pinctrl_enet_1: enetgrp-1 {
 						fsl,pins = <
-							MX6Q_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
-							MX6Q_PAD_ENET_MDC__ENET_MDC         0x1b0b0
 							MX6Q_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
 							MX6Q_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
 							MX6Q_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
@@ -138,48 +136,26 @@
 							MX6Q_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
 							MX6Q_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
 							MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
-							MX6Q_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8
 						>;
 					};
 
-					pinctrl_enet_2: enetgrp-2 {
+					pinctrl_enet_mdio_1: enet-mdiogrp-1 {
+						fsl,pins = <
+							MX6Q_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
+							MX6Q_PAD_ENET_MDC__ENET_MDC         0x1b0b0
+						>;
+					};
+
+					pinctrl_enet_mdio_2: enet-mdiogrp-2 {
 						fsl,pins = <
 							MX6Q_PAD_KEY_COL1__ENET_MDIO        0x1b0b0
 							MX6Q_PAD_KEY_COL2__ENET_MDC         0x1b0b0
-							MX6Q_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
-							MX6Q_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
-							MX6Q_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
-							MX6Q_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
-							MX6Q_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
-							MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
-							MX6Q_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
-							MX6Q_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
-							MX6Q_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
-							MX6Q_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
-							MX6Q_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
-							MX6Q_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
-							MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
 						>;
 					};
 
-					pinctrl_enet_3: enetgrp-3 {
+					pinctrl_enet_ref_1: enet-refgrp-1 {
 						fsl,pins = <
-							MX6Q_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
-							MX6Q_PAD_ENET_MDC__ENET_MDC         0x1b0b0
-							MX6Q_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
-							MX6Q_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
-							MX6Q_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
-							MX6Q_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
-							MX6Q_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
-							MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
-							MX6Q_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
-							MX6Q_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
-							MX6Q_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
-							MX6Q_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
-							MX6Q_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
-							MX6Q_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
-							MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
-							MX6Q_PAD_ENET_TX_EN__ENET_TX_EN     0x1b0b0
+							MX6Q_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8
 						>;
 					};
 				};
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index e994011..32a0f55 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -34,7 +34,7 @@
 
 &fec {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet_2>;
+	pinctrl-0 = <&pinctrl_enet_1 &pinctrl_enet_mdio_2>;
 	phy-mode = "rgmii";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 6e5dfdb..906d267 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -79,7 +79,7 @@
 
 &fec {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet_1>;
+	pinctrl-0 = <&pinctrl_enet_1 &pinctrl_enet_mdio_1 &pinctrl_enet_ref_1>;
 	phy-mode = "rgmii";
 	status = "okay";
 };
-- 
1.8.3.2
