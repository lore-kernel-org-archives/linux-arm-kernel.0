From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 4 Nov 2013 14:36:03 -0600
Subject: [PATCHv2 2/4] arm: dts: Add a system manager compatible property
In-Reply-To: <1383597364-25613-1-git-send-email-dinguyen@altera.com>
References: <1383597364-25613-1-git-send-email-dinguyen@altera.com>
Message-ID: <1383597364-25613-3-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The "altr,sysmgr-sdmmc-sdr" compatible property is used for the SOCFPGA
clk-sysmgr driver. This property represents the register inside the
system manager that controls the clock phase of the SD/MMC driver.

Also add "syscon" to the system manager node.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
CC: Arnd Bergmann <arnd@arndb.de>
Cc: Mike Turquette <mturquette@linaro.org>
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
 .../bindings/arm/altera/socfpga-system.txt         |   10 ++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   12 ++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
index f4d04a0..7a6c7ed 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
@@ -5,9 +5,19 @@ Required properties:
 - reg : Should contain 1 register ranges(address and length)
 - cpu1-start-addr : CPU1 start address in hex.
 
+Optional properties:
+- compatible = "altr,sysmgr-sdmmc-sdr". This compatible property is used
+to represent the clock phase settings for the SD/MMC IP.
+
 Example:
 	 sysmgr at ffd08000 {
 		compatible = "altr,sys-mgr";
 		reg = <0xffd08000 0x1000>;
 		cpu1-start-addr = <0xffd080c4>;
+
+		sysmgr_sdr_mmc: sysmgr_sdr_mmc {
+			#clock-cells = <0>;
+			compatible = "altr,sysmgr-sdmmc-sdr";
+			reg = <0x108 1>;
+		};
 	};
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index e273fa9..eb990d2 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -521,8 +521,16 @@
 			};
 
 		sysmgr at ffd08000 {
-				compatible = "altr,sys-mgr";
-				reg = <0xffd08000 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "altr,sys-mgr", "syscon";
+			reg = <0xffd08000 0x4000>;
+
+			sysmgr_sdr_mmc: sysmgr_sdr_mmc {
+				#clock-cells = <0>;
+				compatible = "altr,sysmgr-sdmmc-sdr";
+				reg = <0x108 1>;
 			};
+		};
 	};
 };
-- 
1.7.9.5
