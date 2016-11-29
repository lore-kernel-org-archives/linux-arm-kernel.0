From: romain.perier@free-electrons.com (Romain Perier)
Date: Tue, 29 Nov 2016 15:39:39 +0100
Subject: [PATCH 5/5] arm64: dts: marvell: Enable spi0 on the board
 Armada-3720-db
In-Reply-To: <20161129143939.3191-1-romain.perier@free-electrons.com>
References: <20161129143939.3191-1-romain.perier@free-electrons.com>
Message-ID: <20161129143939.3191-6-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the device node spi0 on the official development
board for the Marvell Armada 3700. It also adds sub-node for the 128Mb
SPI-NOR present on the board.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 1372e9a6..0c4eb98 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -67,6 +67,36 @@
 	status = "okay";
 };
 
+&spi0 {
+	status = "okay";
+
+	m25p80 at 0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <108000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition at 0 {
+				label = "bootloader";
+				reg = <0x0 0x200000>;
+			};
+			partition at 200000 {
+				label = "U-boot Env";
+				reg = <0x200000 0x10000>;
+			};
+			partition at 210000 {
+				label = "Linux";
+				reg = <0x210000 0xDF0000>;
+			};
+		};
+	};
+};
+
 /* Exported on the micro USB connector CON32 through an FTDI */
 &uart0 {
 	status = "okay";
-- 
2.9.3
