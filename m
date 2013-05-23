From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 23 May 2013 16:36:37 -0500
Subject: [PATCHv3 1/6] ARM: socfpga: dts: Add ethernet bindings for SOCFPGA
Message-ID: <1369345002-20002-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Add entry for 2nd GMAC controller. Add the correct clocks for the GMAC.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Pavel Machek <pavel@denx.de>
CC: <linux@arm.linux.org.uk>

v2:
- Moved "disabled" status to dtsi file
---
 arch/arm/boot/dts/socfpga.dtsi         |   18 ++++++++++++++++--
 arch/arm/boot/dts/socfpga_cyclone5.dts |   13 +++++++++++++
 arch/arm/boot/dts/socfpga_vt.dts       |    5 +++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 16a6e13..02bb425 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -23,6 +23,7 @@
 
 	aliases {
 		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		timer0 = &timer0;
@@ -238,13 +239,26 @@
 				};
 			};
 
-		gmac0: stmmac at ff700000 {
+		gmac0: ethernet at ff700000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
 			reg = <0xff700000 0x2000>;
 			interrupts = <0 115 4>;
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-			phy-mode = "gmii";
+			clocks = <&emac0_clk>;
+			clock-names = "stmmaceth";
+			status = "disabled";
+		};
+
+		gmac1: ethernet at ff702000 {
+			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
+			reg = <0xff702000 0x2000>;
+			interrupts = <0 120 4>;
+			interrupt-names = "macirq";
+			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
+			clocks = <&emac1_clk>;
+			clock-names = "stmmaceth";
+			status = "disabled";
 		};
 
 		L2: l2-cache at fffef000 {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index 2495958..973999d 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -32,6 +32,13 @@
 		reg = <0x0 0x40000000>; /* 1GB */
 	};
 
+	aliases {
+		/* this allow the ethaddr uboot environmnet variable contents
+		 * to be added to the gmac1 device tree blob.
+		 */
+		ethernet0 = &gmac1;
+	};
+
 	soc {
 		clkmgr at ffd04000 {
 			clocks {
@@ -41,6 +48,12 @@
 			};
 		};
 
+		ethernet at ff702000 {
+			phy-mode = "rgmii";
+			phy-addr = <0xffffffff>; /* probe for phy addr */
+			status = "okay";
+		};
+
 		timer0 at ffc08000 {
 			clock-frequency = <100000000>;
 		};
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index 0bf035d..d1ec0ca 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -41,6 +41,11 @@
 			};
 		};
 
+		ethernet at ff700000 {
+			phy-mode = "gmii";
+			status = "okay";
+		};
+
 		timer0 at ffc08000 {
 			clock-frequency = <7000000>;
 		};
-- 
1.7.9.5
