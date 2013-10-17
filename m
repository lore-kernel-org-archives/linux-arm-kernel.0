From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 16 Oct 2013 19:32:41 -0500
Subject: [PATCH 4/4] arm: dts: Add support for SD/MMC on SOCFPGA
In-Reply-To: <1381969961-12679-1-git-send-email-dinguyen@altera.com>
References: <1381969961-12679-1-git-send-email-dinguyen@altera.com>
Message-ID: <1381969961-12679-5-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Add new bindings that support SD/MMC on Altera's SOCFPGA platform.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Cc: Pavel Machek <pavel@denx.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: devicetree at vger.kernel.org
Cc: linux-mmc at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   38 ++++++++++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   11 ++++++
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   12 +++++++
 arch/arm/boot/dts/socfpga_vt.dts                   |   12 +++++++
 4 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
new file mode 100644
index 0000000..246f296
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
@@ -0,0 +1,38 @@
+* Altera SOCFPGA specific extensions to the Synopsys Designware Mobile
+  Storage Host Controller
+
+The Synopsys designware mobile storage host controller is used to interface
+a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+differences between the core Synopsys dw mshc controller properties described
+by synopsys-dw-mshc.txt and the properties used by the SOCFPGA specific
+extensions to the Synopsys Designware Mobile Storage Host Controller.
+
+Required Properties:
+
+* compatible: should be
+        - "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
+          specific extensions.
+
+* samsung,dw-mshc-sdr-timing: See exynos-dw-mshc.txt for more information about
+	this property.
+
+Example:
+        dwmmc0 at ff704000 {
+                compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
+                reg = <0xff704000 0x1000>;
+                interrupts = <0 139 4>;
+                fifo-depth = <0x400>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                clocks = <&l4_mp_clk>, <&sdmmc_clk>, <&sysmgr_sdr_mmc>;
+                clock-names = "biu", "ciu", "sysmgr-sdr-mmc";
+                num-slots = <1>;
+                supports-highspeed;
+                broken-cd;
+                samsung,dw-mshc-sdr-timing = <3 0>;
+
+                slot at 0 {
+                        reg = <0>;
+                        bus-width = <4>;
+                };
+        };
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 0662d04..cacec8d 100644
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
+			clocks = <&l4_mp_clk>, <&sdmmc_clk>, <&sysmgr_sdr_mmc>;
+			clock-names = "biu", "ciu", "sysmgr-sdr-mmc";
+		};
+
 		/* Local timer */
 		timer at fffec600 {
 			compatible = "arm,cortex-a9-twd-timer";
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index 809769e..44db0e6 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -48,6 +48,18 @@
 			};
 		};
 
+		dwmmc0 at ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			samsung,dw-mshc-sdr-timing = <3 0>;
+
+			slot at 0 {
+				reg = <0>;
+				bus-width = <4>;
+			};
+		};
+
 		ethernet at ff702000 {
 			phy-mode = "rgmii";
 			phy-addr = <0xffffffff>; /* probe for phy addr */
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index d1ec0ca..25b2653 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -41,6 +41,18 @@
 			};
 		};
 
+		dwmmc0 at ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			samsung,dw-mshc-sdr-timing = <3 0>;
+
+			slot at 0 {
+				reg = <0>;
+				bus-width = <4>;
+			};
+		};
+
 		ethernet at ff700000 {
 			phy-mode = "gmii";
 			status = "okay";
-- 
1.7.9.5
