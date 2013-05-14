From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 14 May 2013 17:52:34 -0500
Subject: [PATCH 4/5] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <1368571955-6652-1-git-send-email-dinguyen@altera.com>
References: <1368571955-6652-1-git-send-email-dinguyen@altera.com>
Message-ID: <1368571955-6652-4-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Add bindings for SD/MMC for SOCFPGA.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
CC: Pavel Machek <pavel@denx.de>
CC: <linux@arm.linux.org.uk>
---
 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   59 ++++++++++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   11 ++++
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   13 +++++
 arch/arm/boot/dts/socfpga_vt.dts                   |   13 +++++
 4 files changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
new file mode 100644
index 0000000..f4fda57
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
@@ -0,0 +1,59 @@
+* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
+  Storage Host Controller
+
+Required Properties:
+
+* compatible: should be
+	- "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
+	  specific extentions.
+
+* altr,dw-mshc-ciu-div: Specifies the divider value for the card interface
+  unit (ciu) clock. For Altera's SOCFPGA, the divider value is fixed at 4.
+
+* altr,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
+  in transmit mode and CIU clock phase shift value in receive mode for single
+  data rate mode operation. Refer notes below for the order of the cells and the
+  valid values.
+
+  Notes for the sdr-timing values:
+
+    The order of the cells should be
+      - First Cell: CIU clock phase shift value for RX mode, smplsel bits in
+	the system manager SDMMC control group.
+      - Second Cell: CIU clock phase shift value for TX mode, drvsel bits in
+	the system manager SDMMC control group.
+
+    Valid values for SDR CIU clock timing for SOCFPGA:
+      - valid value for tx phase shift and rx phase shift is 0 to 7.
+
+Required properties for a slot:
+
+* bus-width: Data width for card slot. 4-bit or 8-bit data.
+
+Example:
+
+  The MSHC controller node can be split into two portions, SoC specific and
+  board specific portions as listed below.
+
+	dwmmc0 at ff704000 {
+		compatible = "altr,socfpga-dw-mshc";
+		reg = <0xff704000 0x1000>;
+		interrupts = <0 139 4>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	dwmmc0 at ff704000 {
+		num-slots = <1>;
+		supports-highspeed;
+		broken-cd;
+		fifo-depth = <0x400>;
+		altr,dw-mshc-ciu-div = <4>;
+      		altr,dw-mshc-sdr-timing = <0 3>;
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <4>;
+		};
+	};
+
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index ee8d1f1..6138edf 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -466,6 +466,17 @@
 			cache-level = <2>;
 		};
 
+		mmc: dwmmc0 at ff704000 {
+			compatible = "altr,socfpga-dw-mshc";
+			reg = <0xff704000 0x1000>;
+			interrupts = <0 139 4>;
+			fifo-depth = <0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&l4_mp_clk>, <&sdmmc_clk>;
+			clock-names = "biu", "ciu";
+		};
+
 		/* Local timer */
 		timer at fffec600 {
 			compatible = "arm,cortex-a9-twd-timer";
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index ece1a87..dcb8c3a 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -57,6 +57,19 @@
 			phy-addr = <0xffffffff>; /* probe for phy addr */
 		};
 
+		dwmmc0 at ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			altr,dw-mshc-ciu-div = <4>;
+			altr,dw-mshc-sdr-timing = <0 3>;
+
+			slot at 0 {
+				reg = <0>;
+				bus-width = <4>;
+			};
+		};
+
 		timer0 at ffc08000 {
 			clock-frequency = <100000000>;
 		};
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index f728471..1aec566 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -49,6 +49,19 @@
 			status = "disabled";
 		};
 
+		dwmmc0 at ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			altr,dw-mshc-ciu-div = <4>;
+			pwr-en = <1>;
+
+			slot at 0 {
+				reg = <0>;
+				bus-width = <4>;
+			};
+		};
+
 		timer0 at ffc08000 {
 			clock-frequency = <7000000>;
 		};
-- 
1.7.9.5
