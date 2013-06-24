From: lho@apm.com (Loc Ho)
Date: Mon, 24 Jun 2013 16:34:23 -0600
Subject: [PATCH v4 3/3] Documentation: Add documentation for APM X-Gene clock
 binding
In-Reply-To: <1372113263-18082-3-git-send-email-lho@apm.com>
References: <1372113263-18082-1-git-send-email-lho@apm.com>
 <1372113263-18082-2-git-send-email-lho@apm.com>
 <1372113263-18082-3-git-send-email-lho@apm.com>
Message-ID: <1372113263-18082-4-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation: Add documentation for APM X-Gene clock binding with PLL and
device clocks.

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
Signed-off-by: Vinayak Kale <vkale@apm.com>
Signed-off-by: Feng Kan <fkan@apm.com>
---
 Documentation/devicetree/bindings/clock/xgene.txt |  109 +++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/xgene.txt

diff --git a/Documentation/devicetree/bindings/clock/xgene.txt b/Documentation/devicetree/bindings/clock/xgene.txt
new file mode 100644
index 0000000..cda90f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/xgene.txt
@@ -0,0 +1,109 @@
+Device Tree Clock bindings for APM X-Gene
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be one of the following:
+	"apm,xgene-socpll-clock" - for a X-Gene SoC PLL clock
+	"apm,xgene-pcppll-clock" - for a X-Gene PCP PLL clock
+	"apm,xgene-device-clock" - for a X-Gene device clock
+
+Required properties for SoC or PCP PLL clocks:
+- reg : shall be the physical PLL register address for the pll clock.
+- clocks : shall be the input parent clock phandle for the clock. This should
+	be the reference clock.
+- #clock-cells : shall be set to 1.
+- clock-output-names : shall be the name of the PLL referenced by derive
+  clock.
+Optional properties for PLL clocks:
+- clock-names : shall be the name of the PLL. If missing, use the device name.
+
+Required properties for device clocks:
+- reg : shall be the physical CSR reset address base and/or physical CSR 
+        divider address base if one existed.
+- reg-names : shall be string describing the reg resource. Supported
+              register names are "csr-reg" and "div-reg" which default
+              to "csr-reg" if not specified.
+- clocks : shall be the input parent clock phandle for the clock.
+- #clock-cells : shall be set to 1.
+- clock-output-names : shall be the name of the device referenced.
+Optional properties for device clocks:
+- clock-names : shall be the name of the device clock. If missing, use the
+                device name.
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
+		compatible = "apm,xgene-pcppll-clock";
+		#clock-cells = <1>;
+		clocks = <&refclk 0>;
+		clock-names = "pcppll";
+		reg = <0x0 0x17000100 0x0 0x1000>;
+		clock-output-names = "pcppll";
+		type = <0>;
+	};
+
+	socpll: socpll at 17000120 {
+		compatible = "apm,xgene-socpll-clock";
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
+		reg = <0x0 0x1703C000 0x0 0x1000>;
+		reg-name = "csr-reg";
+		clock-output-names = "qmlclk";
+	};
+
+	ethclk: ethclk {
+		compatible = "apm,xgene-device-clock";
+		#clock-cells = <1>;
+		clocks = <&socplldiv2 0>;
+		clock-names = "ethclk";
+		reg = <0x0 0x17000000 0x0 0x1000>;
+		reg-names = "div-reg";
+		divider-offset = <0x238>;
+		divider-width = <0x9>;
+		divider-shift = <0x0>;
+		clock-output-names = "ethclk";
+	};
+
+	apbclk: apbclk {
+		compatible = "apm,xgene-device-clock";
+		#clock-cells = <1>;
+		clocks = <&ahbclk 0>;
+		clock-names = "apbclk";
+		reg = <0x0 0x1F2AC000 0x0 0x1000
+			0x0 0x1F2AC000 0x0 0x1000>;
+		reg-names = "csr-reg", "div-reg";
+		csr-offset = <0x0>;
+		csr-mask = <0x200>;
+		enable-offset = <0x8>;
+		enable-mask = <0x200>;
+		divider-offset = <0x10>;
+		divider-width = <0x2>;
+		divider-shift = <0x0>;
+		flags = <0x8>;
+		clock-output-names = "apbclk";
+	};
+
-- 
1.5.5
