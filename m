From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  3 Dec 2016 00:08:48 +0100
Subject: [PATCH v2 1/2] ARM64: dts: meson-gx: move the SCPI and SRAM nodes to
 meson-gx
In-Reply-To: <20161202230849.11422-1-martin.blumenstingl@googlemail.com>
References: <20161123162040.24843-1-martin.blumenstingl@googlemail.com>
 <20161202230849.11422-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161202230849.11422-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCPI and SRAM are identical on GXBB and GXL. Moving the corresponding
nodes to meson-gx adds support for the thermal sensor on GXL based
devices.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 45 +++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 57 -----------------------------
 2 files changed, 45 insertions(+), 57 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index fc033c0..47ab306 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -65,6 +65,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&scpi_dvfs 0>;
 		};
 
 		cpu1: cpu at 1 {
@@ -73,6 +74,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&scpi_dvfs 0>;
 		};
 
 		cpu2: cpu at 2 {
@@ -81,6 +83,7 @@
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&scpi_dvfs 0>;
 		};
 
 		cpu3: cpu at 3 {
@@ -89,6 +92,7 @@
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&scpi_dvfs 0>;
 		};
 
 		l2: l2-cache0 {
@@ -153,6 +157,28 @@
 		};
 	};
 
+	scpi {
+		compatible = "amlogic,meson-gxbb-scpi", "arm,scpi-pre-1.0";
+		mboxes = <&mailbox 1 &mailbox 2>;
+		shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
+
+		clocks {
+			compatible = "arm,scpi-clocks";
+
+			scpi_dvfs: scpi_clocks at 0 {
+				compatible = "arm,scpi-dvfs-clocks";
+				#clock-cells = <1>;
+				clock-indices = <0>;
+				clock-output-names = "vcpu";
+			};
+		};
+
+		scpi_sensors: sensors {
+			compatible = "arm,scpi-sensors";
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -264,6 +290,25 @@
 			#address-cells = <0>;
 		};
 
+		sram: sram at c8000000 {
+			compatible = "amlogic,meson-gxbb-sram", "mmio-sram";
+			reg = <0x0 0xc8000000 0x0 0x14000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0xc8000000 0x14000>;
+
+			cpu_scp_lpri: scp-shmem at 0 {
+				compatible = "amlogic,meson-gxbb-scp-shmem";
+				reg = <0x13000 0x400>;
+			};
+
+			cpu_scp_hpri: scp-shmem at 200 {
+				compatible = "amlogic,meson-gxbb-scp-shmem";
+				reg = <0x13400 0x400>;
+			};
+		};
+
 		aobus: aobus at c8100000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc8100000 0x0 0x100000>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 51edd5b5..76465e7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -50,28 +50,6 @@
 / {
 	compatible = "amlogic,meson-gxbb";
 
-	scpi {
-		compatible = "amlogic,meson-gxbb-scpi", "arm,scpi-pre-1.0";
-		mboxes = <&mailbox 1 &mailbox 2>;
-		shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
-
-		clocks {
-			compatible = "arm,scpi-clocks";
-
-			scpi_dvfs: scpi_clocks at 0 {
-				compatible = "arm,scpi-dvfs-clocks";
-				#clock-cells = <1>;
-				clock-indices = <0>;
-				clock-output-names = "vcpu";
-			};
-		};
-
-		scpi_sensors: sensors {
-			compatible = "arm,scpi-sensors";
-			#thermal-sensor-cells = <1>;
-		};
-	};
-
 	soc {
 		usb0_phy: phy at c0000000 {
 			compatible = "amlogic,meson-gxbb-usb2-phy";
@@ -93,25 +71,6 @@
 			status = "disabled";
 		};
 
-		sram: sram at c8000000 {
-			compatible = "amlogic,meson-gxbb-sram", "mmio-sram";
-			reg = <0x0 0xc8000000 0x0 0x14000>;
-
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x0 0xc8000000 0x14000>;
-
-			cpu_scp_lpri: scp-shmem at 0 {
-				compatible = "amlogic,meson-gxbb-scp-shmem";
-				reg = <0x13000 0x400>;
-			};
-
-			cpu_scp_hpri: scp-shmem at 200 {
-				compatible = "amlogic,meson-gxbb-scp-shmem";
-				reg = <0x13400 0x400>;
-			};
-		};
-
 		usb0: usb at c9000000 {
 			compatible = "amlogic,meson-gxbb-usb", "snps,dwc2";
 			reg = <0x0 0xc9000000 0x0 0x40000>;
@@ -138,22 +97,6 @@
 	};
 };
 
-&cpu0 {
-	clocks = <&scpi_dvfs 0>;
-};
-
-&cpu1 {
-	clocks = <&scpi_dvfs 0>;
-};
-
-&cpu2 {
-	clocks = <&scpi_dvfs 0>;
-};
-
-&cpu3 {
-	clocks = <&scpi_dvfs 0>;
-};
-
 &cbus {
 	spifc: spi at 8c80 {
 		compatible = "amlogic,meson-gxbb-spifc";
-- 
2.10.2
