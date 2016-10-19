From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 19 Oct 2016 15:18:44 -0500
Subject: [PATCH 3/3] ARM: dts: socfpga: Enable QSPI on the Cyclone5 sockit
In-Reply-To: <1476908324-12313-1-git-send-email-dinguyen@opensource.altera.com>
References: <1476908324-12313-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1476908324-12313-3-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Enable the QSPI node and add the flash chip.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |   33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index 02e22f5..2f75e0f 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -175,6 +175,39 @@
 	status = "okay";
 };
 
+&qspi {
+	status = "okay";
+
+	flash: flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q256a";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
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
