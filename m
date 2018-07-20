From: jacopo@jmondi.org (Jacopo Mondi)
Date: Fri, 20 Jul 2018 12:16:04 +0200
Subject: [PATCH 1/2] ARM: dts: imx6qdl: Add Engicam i.Core 1.5 MX6
In-Reply-To: <1532081765-29910-1-git-send-email-jacopo@jmondi.org>
References: <1532081765-29910-1-git-send-email-jacopo@jmondi.org>
Message-ID: <1532081765-29910-2-git-send-email-jacopo@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 1.5 version of Engicam's i.Core MX6 CPU module features a different clock
provider for the ethernet's PHY interface. Adjust the FEC ptp clock to
reference CLK_ENET_REF clock source, and set SION bit of
MX6QDL_PAD_GPIO_16__ENET_REF_CLK to adjust the input path of that pin.

The newly introduced imx6ql-icore-1.5.dtsi allows to collect in a single
place differences between version '1.0' and '1.5' of the module.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi

diff --git a/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi b/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
new file mode 100644
index 0000000..d91d46b
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Jacopo Mondi <jacopo@jmondi.org>
+ */
+
+#include "imx6qdl-icore.dtsi"
+
+&iomuxc {
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0b0
+			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
+			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x1b0b0
+			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x1b0b0
+			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x1b0b0
+		>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+	clocks = <&clks IMX6QDL_CLK_ENET>,
+		 <&clks IMX6QDL_CLK_ENET>,
+		 <&clks IMX6QDL_CLK_ENET_REF>;
+	phy-mode = "rmii";
+	status = "okay";
+};
--
2.7.4
