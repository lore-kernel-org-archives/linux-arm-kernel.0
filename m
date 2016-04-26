From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Apr 2016 09:58:37 +0200
Subject: [PATCH v3 09/11] arm64: dts: marvell: enable several CP interfaces on
 Armada 7040-DB
In-Reply-To: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1461657519-11939-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables several interfaces of the CP side of the Armada
7040 for the Armada 7040 DB board:

 - one PCIe interface
 - one SPI controller with an attached SPI flash
 - one I2C controller
 - one SATA controller
 - two USB3 controllers

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 50 ++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 95dd7c7..070b589 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -96,3 +96,53 @@
 &uart0 {
 	status = "okay";
 };
+
+
+&cpm_pcie2 {
+	status = "okay";
+};
+
+&cpm_i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&cpm_spi1 {
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <20000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "U-Boot";
+				reg = <0x0 0x200000>;
+			};
+
+			partition at 400000 {
+				label = "Filesystem";
+				reg = <0x200000 0xe00000>;
+			};
+		};
+	};
+};
+
+&cpm_sata0 {
+	status = "okay";
+};
+
+&cpm_usb3_0 {
+	status = "okay";
+};
+
+&cpm_usb3_1 {
+	status = "okay";
+};
-- 
2.6.4
