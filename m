From: vigneshr@ti.com (Vignesh R)
Date: Tue, 1 Aug 2017 10:24:33 +0530
Subject: [PATCH 6/7] ARM: dts: keystone-k2g-ice: Add QSPI node
In-Reply-To: <20170801045434.8733-1-vigneshr@ti.com>
References: <20170801045434.8733-1-vigneshr@ti.com>
Message-ID: <20170801045434.8733-7-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

66AK2G ICE board has a s25fl256s1 flash connected to QSPI CS0. Add
pinmux and DT entries for the same.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-ice.dts | 69 ++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-ice.dts b/arch/arm/boot/dts/keystone-k2g-ice.dts
index d820d37b5148..075c3a605c8b 100644
--- a/arch/arm/boot/dts/keystone-k2g-ice.dts
+++ b/arch/arm/boot/dts/keystone-k2g-ice.dts
@@ -26,6 +26,18 @@
 			K2G_CORE_IOPAD(0x11d0) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
+
+	qspi_pins: pinmux_qspi_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x1204) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* qspi_clk.qspi_clk */
+			K2G_CORE_IOPAD(0x1208) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* qspi_rclk.qspi_rclk */
+			K2G_CORE_IOPAD(0x120c) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* qspi_d0.qspi_d0 */
+			K2G_CORE_IOPAD(0x1210) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* qspi_d1.qspi_d1 */
+			K2G_CORE_IOPAD(0x1214) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* qspi_d2.qspi_d2 */
+			K2G_CORE_IOPAD(0x1218) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* qspi_d3.qspi_d3 */
+			K2G_CORE_IOPAD(0x121c) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* qspi_csn0.qspi_csn0 */
+		>;
+	};
 };
 
 &uart0 {
@@ -33,3 +45,60 @@
 	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
+
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_pins>;
+	cdns,rclk-en;
+	status = "okay";
+
+	flash0: m25p80 at 0 {
+		compatible = "s25fl256s1", "jedec,spi-nor";
+		reg = <0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <96000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		cdns,read-delay = <5>;
+		cdns,tshsl-ns = <500>;
+		cdns,tsd2d-ns = <500>;
+		cdns,tchsh-ns = <119>;
+		cdns,tslch-ns = <119>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "QSPI.u-boot";
+				reg = <0x00000000 0x00100000>;
+			};
+			partition at 100000 {
+				label = "QSPI.u-boot-env";
+				reg = <0x00100000 0x00040000>;
+			};
+			partition at 140000 {
+				label = "QSPI.skern";
+				reg = <0x00140000 0x0040000>;
+			};
+			partition at 180000 {
+				label = "QSPI.sci-firmware";
+				reg = <0x00180000 0x0040000>;
+			};
+			partition at 1c0000 {
+				label = "QSPI.kernel";
+				reg = <0x001c0000 0x0800000>;
+			};
+			partition at 9c0000 {
+				label = "QSPI.u-boot-spl-os";
+				reg = <0x009c0000 0x0040000>;
+			};
+			partition at a00000 {
+				label = "QSPI.file-system";
+				reg = <0x00a00000 0x1600000>;
+			};
+		};
+	};
+};
-- 
2.13.3
