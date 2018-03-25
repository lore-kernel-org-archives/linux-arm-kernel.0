From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 25 Mar 2018 21:57:36 +0200
Subject: [PATCH] arm64: dts: armada-3720-espressobin: wire up spi flash
Message-ID: <20180325195736.19782-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ellie Reeves <ellierevves@gmail.com>

This is the storage the machine boots from by default. The partitioning
is taken from the U-Boot that is shipped with the board. There is some
more space on the flash that isn't used.

Signed-off-by: Ellie Reeves <ellierevves@gmail.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 .../boot/dts/marvell/armada-3720-espressobin.dts   | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 882d6e4a04e4..5f98c2fecca4 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -108,6 +108,33 @@
 	status = "okay";
 };
 
+&spi0 {
+	status = "okay";
+
+	flash at 0 {
+		reg = <0>;
+		compatible = "winbond,w25q32dw", "jedec,spi-flash";
+		spi-max-frequency = <104000000>;
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "uboot";
+				reg = <0 0x180000>;
+			};
+
+			partition at 180000 {
+				label = "ubootenv";
+				reg = <0x180000 0x10000>;
+			};
+		};
+	};
+};
+
 /* Exported on the micro USB connector J5 through an FTDI */
 &uart0 {
 	pinctrl-names = "default";
-- 
2.16.2
