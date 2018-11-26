From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:17 +0100
Subject: [PATCH 15/16] ARM: dts: iwg23s-sbc: Add QSPI flash support
In-Reply-To: <cover.1543236456.git.horms+renesas@verge.net.au>
References: <cover.1543236456.git.horms+renesas@verge.net.au>
Message-ID: <8923e9a2667f7e62174f382b6cd3e1e9c62aa017.1543236456.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This commit adds QSPI flash support to the iwg23s board specific
device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
index 52f23b858885..40b7f98d6013 100644
--- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -96,6 +96,11 @@
 		power-source = <1800>;
 	};
 
+	qspi0_pins: qspi0 {
+		groups = "qspi0_ctrl", "qspi0_data2";
+		function = "qspi0";
+	};
+
 	scif1_pins: scif1 {
 		groups = "scif1_data_b";
 		function = "scif1";
@@ -114,6 +119,27 @@
 	};
 };
 
+&qspi0 {
+	pinctrl-0 = <&qspi0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	/* WARNING - This device contains the bootloader. Handle with care. */
+	flash: flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "issi,is25lp016d", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <133000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+	};
+};
+
 &rwdt {
 	timeout-sec = <60>;
 	status = "okay";
-- 
2.11.0
