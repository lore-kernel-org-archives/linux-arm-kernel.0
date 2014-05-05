From: tthayer@altera.com (tthayer at altera.com)
Date: Mon, 5 May 2014 17:52:15 -0500
Subject: [PATCHv3 1/3] dts: socfpga: Add bindings for Altera SoC SDRAM
 controller
In-Reply-To: <1399330337-16748-1-git-send-email-tthayer@altera.com>
References: <1399330337-16748-1-git-send-email-tthayer@altera.com>
Message-ID: <1399330337-16748-2-git-send-email-tthayer@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@altera.com>

Addition of the Altera SDRAM controller bindings and device
tree changes to the Altera SoC project. The "syscon" parameter
is included here because the SDRAM EDAC bits are shared with the SDRAM
configuration bits.
---
v2: Changes to SoC SDRAM EDAC code.

V3: Implement code suggestions for SDRAM EDAC code.

Signed-off-by: Thor Thayer <tthayer@altera.com>
---
 .../bindings/arm/altera/socfpga-sdram.txt          |   14 ++++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |    5 +++++
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
new file mode 100644
index 0000000..525cb76
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
@@ -0,0 +1,14 @@
+Altera SOCFPGA SDRAM Controller
+
+Required properties:
+- compatible : "altr,sdr-ctl", "syscon";
+                Note that syscon is invoked for this device to support the FPGA
+		bridge driver, EDAC driver and other devices that share the
+		registers.
+- reg : Should contain 1 register ranges(address and length)
+
+Example:
+	sdrctl at ffc25000 {
+		compatible = "altr,sdr-ctl", "syscon";
+		reg = <0xffc25000 0x1000>;
+	};
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index df43702..6ce912e 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -676,6 +676,11 @@
 			clocks = <&l4_sp_clk>;
 		};
 
+		sdrctl at ffc25000 {
+			compatible = "altr,sdr-ctl", "syscon";
+			reg = <0xffc25000 0x1000>;
+		};
+
 		rstmgr at ffd05000 {
 			compatible = "altr,rst-mgr";
 			reg = <0xffd05000 0x1000>;
-- 
1.7.9.5
