From: pankaj.bansal@nxp.com (Pankaj Bansal)
Date: Thu, 15 Nov 2018 12:12:05 +0000
Subject: [PATCH] arm64: dts: lx2160aqds: Add mdio mux nodes
Message-ID: <20181115173752.22482-1-pankaj.bansal@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two external MDIO buses used to communicate with phy devices that
are external to SOC are muxed in LX2160AQDS board.

These buses can be routed to any one of the eight IO slots on
LX2160AQDS board depending on value in fpga register 0x54.

Additionally the external MDIO1 is used to communicate to the onboard
RGMII phy devices.

The mdio1 is controlled by bits 4-7 of fpga register and mdio2 is
controlled by bits 0-3 of fpga register.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---

Notes:
    This patch depends on following patches:
    [1]https://patchwork.kernel.org/cover/10658863/
    [2]https://patchwork.codeaurora.org/patch/637861/

 .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 116 +++++++++++++++++
 .../boot/dts/freescale/fsl-lx2160a.dtsi      |  23 ++++
 2 files changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 8a0305a2b778..39aa2731ddfa 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -54,6 +54,121 @@
 &i2c0 {
 	status = "okay";
 
+	fpga at 66 {
+		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
+		reg = <0x66>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mdio-mux-1 at 54 {
+			mdio-parent-bus = <&emdio1>;
+			reg = <0x54>;		 /* BRDCFG4 */
+			mux-mask = <0xf8>;      /* EMI1_MDIO */
+			#address-cells=<1>;
+			#size-cells = <0>;
+
+			mdio at 0 {
+				reg = <0x00>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at 40 {
+				reg = <0x40>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at c0 {
+				reg = <0xc0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at c8 {
+				reg = <0xc8>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at d0 {
+				reg = <0xd0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at d8 {
+				reg = <0xd8>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at e0 {
+				reg = <0xe0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at e8 {
+				reg = <0xe8>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at f0 {
+				reg = <0xf0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at f8 {
+				reg = <0xf8>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		mdio-mux-2 at 54 {
+			mdio-parent-bus = <&emdio2>;
+			reg = <0x54>;		 /* BRDCFG4 */
+			mux-mask = <0x07>;      /* EMI2_MDIO */
+			#address-cells=<1>;
+			#size-cells = <0>;
+
+			mdio at 0 {
+				reg = <0x00>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at 1 {
+				reg = <0x01>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at 2 {
+				reg = <0x02>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at 3 {
+				reg = <0x03>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at 4 {
+				reg = <0x04>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at 5 {
+				reg = <0x05>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at 6 {
+				reg = <0x06>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio at 7 {
+				reg = <0x07>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+
 	i2c-mux at 77 {
 		compatible = "nxp,pca9547";
 		reg = <0x77>;
@@ -118,3 +233,4 @@
 &usb1 {
 	status = "okay";
 };
+
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 6ce0677c3096..518882b05f03 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -780,5 +780,28 @@
 				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 			dma-coherent;
 		};
+		/* TODO: WRIOP (CCSR?) */
+		/* WRIOP0: 0x8B8_0000, E-MDIO1: 0x1_6000 */
+		emdio1: mdio at 0x8B96000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8B96000 0x0 0x1000>;
+			device_type = "mdio";	/* TODO: is this necessary? */
+			little-endian;	/* force the driver in LE mode */
+
+			/* Not necessary on the QDS, but needed on the RDB*/
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		/* WRIOP0: 0x8B8_0000, E-MDIO2: 0x1_7000 */
+		emdio2: mdio at 0x8B97000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8B97000 0x0 0x1000>;
+			device_type = "mdio";	/* TODO: is this necessary? */
+			little-endian;	/* force the driver in LE mode */
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 };
+
-- 
2.17.1
