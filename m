From: frieder.schrempf@kontron.De (Schrempf Frieder)
Date: Tue, 13 Nov 2018 13:47:16 +0000
Subject: [PATCH v5 1/9] ARM: dts: Reflect change of FSL QSPI driver and remove
 unused properties
In-Reply-To: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
Message-ID: <1542116782-13118-2-git-send-email-frieder.schrempf@kontron.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FSL QSPI driver will be moved to the SPI framework and it then
acts as a SPI controller. Therefore the subnodes need to set
spi-[rx/tx]-bus-width = <4>, so quad mode is used just as before.

Also the properties 'bus-num', 'fsl,spi-num-chipselects' and
'fsl,spi-flash-chipselects' were never read by the driver and
can be removed.

The 'reg' properties are adjusted to reflect what bus and
chipselect the flash is connected to, as the new driver needs
this information.

The property 'fsl,qspi-has-second-chip' is not needed anymore
and will be removed after the old driver was disabled to avoid
breaking ls1021a-moxa-uc-8410a.dts.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/boot/dts/imx6sx-sdb-reva.dts       | 8 ++++++--
 arch/arm/boot/dts/imx6sx-sdb.dts            | 8 ++++++--
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi     | 2 ++
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts | 5 ++---
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
index 9cc6ff2..9997156 100644
--- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
@@ -132,13 +132,17 @@
 		#size-cells = <1>;
 		compatible = "spansion,s25fl128s", "jedec,spi-nor";
 		spi-max-frequency = <66000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 	};
 
-	flash1: s25fl128s at 1 {
-		reg = <1>;
+	flash1: s25fl128s at 2 {
+		reg = <2>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spansion,s25fl128s", "jedec,spi-nor";
 		spi-max-frequency = <66000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 6dd9beb..9acfda8 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -117,15 +117,19 @@
 		#size-cells = <1>;
 		compatible = "micron,n25q256a", "jedec,spi-nor";
 		spi-max-frequency = <29000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 
-	flash1: n25q256a at 1 {
+	flash1: n25q256a at 2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "micron,n25q256a", "jedec,spi-nor";
 		spi-max-frequency = <29000000>;
-		reg = <1>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		reg = <2>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
index 32a0723..c2c9a2a 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
@@ -176,6 +176,8 @@
 		#size-cells = <1>;
 		compatible = "micron,n25q256a";
 		spi-max-frequency = <29000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 };
diff --git a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
index d01f64b..6a83f30 100644
--- a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
+++ b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
@@ -203,9 +203,6 @@
 };
 
 &qspi {
-	bus-num = <0>;
-	fsl,spi-num-chipselects = <2>;
-	fsl,spi-flash-chipselects = <0>;
 	fsl,qspi-has-second-chip;
 	status = "okay";
 
@@ -214,6 +211,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 
 		partitions at 0 {
-- 
2.7.4
