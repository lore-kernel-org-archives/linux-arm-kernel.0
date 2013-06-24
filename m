From: lho@apm.com (Loc Ho)
Date: Mon, 24 Jun 2013 13:01:26 -0600
Subject: [PATCH v3 2/3] clk: arm64: Add DTS clock entry for APM X-Gene Storm
 SoC
In-Reply-To: <1372100487-9367-2-git-send-email-lho@apm.com>
References: <1372100487-9367-1-git-send-email-lho@apm.com>
 <1372100487-9367-2-git-send-email-lho@apm.com>
Message-ID: <1372100487-9367-3-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk: arm64: Add DTS clock entry for APM X-Gene Storm SoC with reference to
reference, PCP PLL, SoC PLL, and Ethernet clocks.

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
Signed-off-by: Vinayak Kale <vkale@apm.com>
Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |   75 ++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index bfdc578..3f2ef74 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -103,6 +103,81 @@
 		#size-cells = <2>;
 		ranges;
 
+		clocks {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			refclk: refclk {
+				compatible = "fixed-clock";
+				#clock-cells = <1>;
+				clock-frequency = <100000000>;
+				clock-output-names = "refclk";
+			};
+
+			pcppll: pcppll at 17000100 {
+				compatible = "apm,xgene-pcppll-clock";
+				#clock-cells = <1>;
+				clocks = <&refclk 0>;
+				clock-names = "pcppll";
+				reg = <0x0 0x17000100 0x0 0x1000>;
+				clock-output-names = "pcppll";
+				type = <0>;
+			};
+
+			socpll: socpll at 17000120 {
+				compatible = "apm,xgene-socpll-clock";
+				#clock-cells = <1>;
+				clocks = <&refclk 0>;
+				clock-names = "socpll";
+				reg = <0x0 0x17000120 0x0 0x1000>;
+				clock-output-names = "socpll";
+				type = <1>;
+			};
+
+			socplldiv2: socplldiv2  {
+				compatible = "fixed-factor-clock";
+				#clock-cells = <1>;
+				clocks = <&socpll 0>;
+				clock-names = "socplldiv2";
+				clock-mult = <1>;
+				clock-div = <2>;
+				clock-output-names = "socplldiv2";
+			};
+
+			qmlclk: qmlclk {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				clock-names = "qmlclk";
+				reg = <0x0 0x1703C000 0x0 0x1000
+				       0x0 0x00000000 0x0 0x0000>;
+				clock-output-names = "qmlclk";
+			};
+
+			ethclk: ethclk {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				clock-names = "ethclk";
+				reg = <0x0 0x00000000 0x0 0x0000
+				       0x0 0x17000000 0x0 0x1000>;
+				divider-offset = <0x238>;
+				divider-width = <0x9>;
+				divider-shift = <0x0>;
+				clock-output-names = "ethclk";
+			};
+
+			eth8clk: eth8clk {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&ethclk 0>;
+				clock-names = "eth8clk";
+				reg = <0x0 0x1702C000 0x0 0x1000
+				       0x0 0x00000000 0x0 0x0000>;
+				clock-output-names = "eth8clk";
+			};
+		};
+
 		serial0: serial at 1c020000 {
 			device_type = "serial";
 			compatible = "ns16550";
-- 
1.5.5
