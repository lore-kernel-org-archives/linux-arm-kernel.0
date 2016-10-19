From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 18 Oct 2016 23:11:04 -0500
Subject: [PATCH] ARM: dts: socfpga: enable qspi on the Cyclone5 devkit
Message-ID: <1476850264-25346-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Enable the qspi controller on the devkit and add the flash chip.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts |   32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index 15e43f4..a0868e9 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -87,6 +87,38 @@
 	status = "okay";
 };
 
+&qspi {
+	status = "okay";
+
+	flash0: n25q00 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q00";
+		reg = <0>;	/* chip select */
+		spi-max-frequency = <100000000>;
+
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <4>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partition at qspi-boot {
+			/* 8MB for raw data. */
+			label = "Flash 0 Raw Data";
+			reg = <0x0 0x800000>;
+		};
+
+		partition at qspi-rootfs {
+			/* 120MB for jffs2 data. */
+			label = "Flash 0 jffs2 Filesystem";
+			reg = <0x800000 0x7800000>;
+		};
+	};
+};
+
 &usb1 {
 	status = "okay";
 };
-- 
1.7.9.5
