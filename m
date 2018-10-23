From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Tue, 23 Oct 2018 08:57:00 +0000
Subject: [PATCH RESEND v4 3/5] arm64: dts: lx2160a: add FlexSPI node property
In-Reply-To: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <1540284888-32307-4-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add fspi node property for LX2160A SoC for FlexSPI driver.
Property added for the FlexSPI controller and for the connected
slave device for the LX2160ARDB target.
This is having two SPI-NOR flash device, mt35xu512aba, connected
at CS0 and CS1.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- Incorporated Rob review comments.
Changes for v3:
- None.
Changes for v2:
- - Incorporated Shawn review comments.

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 12 ++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 70fad20..901ca346 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -32,6 +32,28 @@
 	status = "okay";
 };
 
+&fspi {
+	status = "okay";
+
+	mt35xu512aba0: flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,m25p80";
+		m25p,fast-read;
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+
+	mt35xu512aba1: flash at 1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,m25p80";
+		m25p,fast-read;
+		spi-max-frequency = <20000000>;
+		reg = <1>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 	pca9547 at 77 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index e35e494..ba2a247 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -568,5 +568,17 @@
 			timeout-sec = <30>;
 		};
 
+		fspi: spi at 20c0000 {
+			compatible = "nxp,lx2160a-fspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x20c0000 0x0 0x10000>,
+				<0x0 0x20000000 0x0 0x10000000>;
+			reg-names = "fspi_base", "fspi_mmap";
+			interrupts = <0 25 0x4>; /* Level high type */
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "fspi_en", "fspi";
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.4
