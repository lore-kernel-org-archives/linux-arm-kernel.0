From: lho@apm.com (Loc Ho)
Date: Fri, 21 Jun 2013 09:30:05 -0600
Subject: [PATCH 3/3] Documentation: Add documentation for APM X-Gene clock
 binding.
In-Reply-To: <1371828605-18053-3-git-send-email-lho@apm.com>
References: <1371828605-18053-1-git-send-email-lho@apm.com>
 <1371828605-18053-2-git-send-email-lho@apm.com>
 <1371828605-18053-3-git-send-email-lho@apm.com>
Message-ID: <1371828605-18053-4-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation: Add documentation for APM X-Gene clock binding with PLL and 
device clocks.

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
Signed-off-by: Vinayak Kale <vkale@apm.com>
Signed-off-by: Feng Kan <fkan@apm.com>
---
 Documentation/devicetree/bindings/clock/xgene.txt |   90 +++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/xgene.txt

diff --git a/Documentation/devicetree/bindings/clock/xgene.txt b/Documentation/devicetree/bindings/clock/xgene.txt
new file mode 100644
index 0000000..fcdee79
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/xgene.txt
@@ -0,0 +1,90 @@
+Device Tree Clock bindings for APM X-Gene
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be one of the following:
+	"apm,xgene-pll-clock" - for a X-Gene PLL clock
+	"apm,xgene-device-clock" - for a X-Gene device clock
+
+Required properties for PLL clocks:
+- reg : shall be the physical PLL register address for the pll clock.
+- clocks : shall be the input parent clock phandle for the clock. This should
+	be the reference clock.
+- #clock-cells : shall be set to 1.
+- clock-output-names : shall be the name of the PLL referenced by derive
+  clock.
+- type : shall be 1 for SoC PLL and 0 for PCP PLL.
+Optional properties for PLL clocks:
+- clock-names : shall be the name of the PLL. If missing, use the device name.
+
+Required properties for device clocks:
+- reg : shall be the physical CSR reset address base and physical CSR divider
+        address base. If one does not exist, specify 0 for address and 0 for 
+        size.
+- clocks : shall be the input parent clock phandle for the clock.
+- #clock-cells : shall be set to 1.
+- clock-output-names : shall be the name of the device referenced.
+Optional properties for device clocks:
+- clock-names : shall be the name of the device clock. If missing, use the
+                device name.
+- flags : Any clock flags. ie. use 0x8 to leave clock un-touch if not
+          referenced. Default is 0.
+- csr-offset : Offset to the CSR reset register from the reset address base.
+               Default is 0.
+- csr-mask : CSR reset mask bit. Default is 0xF.
+- enable-offset : Offset to the enable register from the reset address base.
+                  Default is 0x8.
+- enable-mask : CSR enable mask bit. Default is 0xF.
+- divider-offset : Offset to the divider CSR register from the divider base.
+                   Default is 0x0.
+- divider-width : Width of the divider register. Default is 0.
+- divider-shift : Bit shift of the divider register. Default is 0.
+
+For example:
+
+	pcppll: pcppll at 17000100 {
+		compatible = "apm,xgene-pll-clock";
+		#clock-cells = <1>;
+		clocks = <&refclk 0>;
+		clock-names = "pcppll";
+		reg = <0x0 0x17000100 0x0 0x1000>;
+		clock-output-names = "pcppll";
+		type = <0>;
+	};
+
+	socpll: socpll at 17000120 {
+		compatible = "apm,xgene-pll-clock";
+		#clock-cells = <1>;
+		clocks = <&refclk 0>;
+		clock-names = "socpll";
+		reg = <0x0 0x17000120 0x0 0x1000>;
+		clock-output-names = "socpll";
+		type = <1>;
+	};
+
+	qmlclk: qmlclk {
+		compatible = "apm,xgene-device-clock";
+		#clock-cells = <1>;
+		clocks = <&socplldiv2 0>;
+		clock-names = "qmlclk";
+		reg = <0x0 0x1703C000 0x0 0x1000
+			0x0 0x00000000 0x0 0x0000>;
+		clock-output-names = "qmlclk";
+	};
+
+	ethclk: ethclk {
+		compatible = "apm,xgene-device-clock";
+		#clock-cells = <1>;
+		clocks = <&socplldiv2 0>;
+		clock-names = "ethclk";
+		reg = <0x0 0x00000000 0x0 0x0000
+			0x0 0x17000000 0x0 0x1000>;
+			divider-offset = <0x238>;
+		divider-width = <0x9>;
+		divider-shift = <0x0>;
+		clock-output-names = "ethclk";
+	};
+
-- 
1.5.5
