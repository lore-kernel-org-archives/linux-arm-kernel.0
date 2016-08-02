From: vigneshr@ti.com (Vignesh R)
Date: Tue, 2 Aug 2016 10:51:47 +0530
Subject: [PATCH] ARM: dts: am57xx-idk-common: Enable support for QSPI
Message-ID: <20160802052147.11085-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM572x IDK has a Spansion s25fl256s1 QSPI flash on the EVM connected to
TI QSPI IP over CS0. Hence, add QSPI and flash slave DT nodes.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 49 ++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 0e63b9dff6e7..03cec62260e1 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -304,3 +304,52 @@
 	ti,non-removable;
 	max-frequency = <96000000>;
 };
+
+&qspi {
+	status = "okay";
+
+	spi-max-frequency = <76800000>;
+	m25p80 at 0 {
+		compatible = "s25fl256s1", "jedec,spi-nor";
+		spi-max-frequency = <76800000>;
+		reg = <0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* MTD partition table.
+		 * The ROM checks the first four physical blocks
+		 * for a valid file to boot and the flash here is
+		 * 64KiB block size.
+		 */
+		partition at 0 {
+			label = "QSPI.SPL";
+			reg = <0x00000000 0x000040000>;
+		};
+		partition at 1 {
+			label = "QSPI.u-boot";
+			reg = <0x00040000 0x00100000>;
+		};
+		partition at 2 {
+			label = "QSPI.u-boot-spl-os";
+			reg = <0x00140000 0x00080000>;
+		};
+		partition at 3 {
+			label = "QSPI.u-boot-env";
+			reg = <0x001c0000 0x00010000>;
+		};
+		partition at 4 {
+			label = "QSPI.u-boot-env.backup1";
+			reg = <0x001d0000 0x0010000>;
+		};
+		partition at 5 {
+			label = "QSPI.kernel";
+			reg = <0x001e0000 0x0800000>;
+		};
+		partition at 6 {
+			label = "QSPI.file-system";
+			reg = <0x009e0000 0x01620000>;
+		};
+	};
+};
-- 
2.9.2
