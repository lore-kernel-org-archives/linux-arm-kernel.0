From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 09:33:34 +0200
Subject: [PATCH v4 8/8] ARM64: dts: meson-gxbb: Add SCPI with cpufreq &
 sensors Nodes
In-Reply-To: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
References: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1475652814-30619-9-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 48 +++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 88f98f5..3fdb2d7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -74,6 +74,28 @@
 		};
 	};
 
+	scpi {
+		compatible = "amlogic,meson-gxbb-scpi";
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
 		usb0_phy: phy at c0000000 {
 			compatible = "amlogic,meson-gxbb-usb2-phy";
@@ -101,6 +123,16 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x0 0xc8000000 0x14000>;
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
 		};
 
 		usb0: usb at c9000000 {
@@ -143,6 +175,22 @@
 	};
 };
 
+&cpu0 {
+	clocks = <&scpi_dvfs 0>;
+};
+
+&cpu1 {
+	clocks = <&scpi_dvfs 0>;
+};
+
+&cpu2 {
+	clocks = <&scpi_dvfs 0>;
+};
+
+&cpu3 {
+	clocks = <&scpi_dvfs 0>;
+};
+
 &cbus {
 	reset: reset-controller at 4404 {
 		compatible = "amlogic,meson-gxbb-reset";
-- 
1.9.1
