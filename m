From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 23 Aug 2013 10:44:45 -0500
Subject: [PATCHv5 2/3] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <1377272686-13253-1-git-send-email-dinguyen@altera.com>
References: <1377272686-13253-1-git-send-email-dinguyen@altera.com>
Message-ID: <1377272686-13253-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Add bindings for SD/MMC for SOCFPGA.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: devicetree at vger.kernel.org
Cc: linux-mmc at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org

v5:
- Add "altr,ciu-clk-offset" that represents the necessary offset
  and shift values in the sysmgr phandle. This is used to set
  the correct CIU clock values.

v4:
- Add a complete binding example in documentations
- Add a phandle entry for "altr,sysmgr" which links the system
  manager to the SD/MMC IP block that controls the SDR timings.
- Split up patches
        1/3 - Add syscon binding to sys-mgr node
        2/3 - DTS bindings and documentation for SD/MMC on SOCFPGA
        3/3 - Driver changes to use the bindings

v3:
- Explicitly reference synopsis-dw-mshc.txt for base bindings
- Remove "dw-mshc-ciu-div" as driver can get clock information dts "ciu" entry
- Fixed indentation issue

v2:
- Remove bus-width and extra line in documentation
- Merge bindings example into a single node in documentation
---
 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   63 ++++++++++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   11 ++++
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   14 +++++
 arch/arm/boot/dts/socfpga_vt.dts                   |   14 +++++
 4 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
new file mode 100644
index 0000000..70893a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
@@ -0,0 +1,63 @@
+* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
+  Storage Host Controller
+
+The Synopsis designware mobile storage host controller is used to interface
+a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+differences between the core Synopsis dw mshc controller properties described
+by synopsis-dw-mshc.txt and the properties used by the SOCFPGA specific
+extensions to the Synopsis Designware Mobile Storage Host Controller.
+
+Required Properties:
+
+* compatible: should be
+	- "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
+	  specific extensions.
+
+* altr,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
+  in transmit mode and CIU clock phase shift value in receive mode for single
+  data rate mode operation. Refer to notes below for the order of the cells and the
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
+* altr,sysmgr: Should be the phandle to the system_mgr node. As this is where
+		this where the register that controls the CIU clock phases
+		reside.
+
+* altr,ciu-clk-offset: The order of the cells should be:
+	- First Cell: Offset of the register in the system_mgr node that controls
+		the smpsel bits.
+	- Second Cell: Shift value of the drvsel bits.
+	- Third Cell: Shift value of the smpsel bits.
+
+Example:
+	dwmmc0 at ff704000 {
+		compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
+		reg = <0xff704000 0x1000>;
+		interrupts = <0 139 4>;
+		fifo-depth = <0x400>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&l4_mp_clk>, <&sdmmc_clk>;
+		clock-names = "biu", "ciu";
+		num-slots = <1>;
+		supports-highspeed;
+		broken-cd;
+		altr,sysmgr = <&system_mgr>;
+		altr,ciu-clk-offset = <0x108 0 3>;
+		altr,dw-mshc-sdr-timing = <0 3>;
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <4>;
+		};
+	};
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index c31c8e9..9706767 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -468,6 +468,17 @@
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
index 973999d..c5861b1 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -54,6 +54,20 @@
 			status = "okay";
 		};
 
+		dwmmc0 at ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			altr,sysmgr = <&system_mgr>;
+			altr,ciu-clk-offset = <0x108 0 3>;
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
index d1ec0ca..250991c 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -46,6 +46,20 @@
 			status = "okay";
 		};
 
+		dwmmc0 at ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			altr,sysmgr = <&system_mgr>;
+			altr,ciu-clk-offset = <0x108 0 3>;
+			altr,dw-mshc-sdr-timing = <0 3>;
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
