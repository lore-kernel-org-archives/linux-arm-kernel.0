From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Tue,  2 Jun 2015 21:31:00 -0500
Subject: [PATCH] ARM: socfpga: dts: enable ethernet for Arria10 devkit
Message-ID: <1433298660-4204-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Update the arria10 gmac nodes with all the necessary properties for ethernet
to function on the Arria10 devkit.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
Hi Arnd, Kevin, Olof:

Please apply this patch for v4.2. I couldn't add this patch to the pull
request as this patch will cause a merge conflict if it was based on
v4.1-rcX.

Thanks,
Dinh
---
 arch/arm/boot/dts/socfpga_arria10.dtsi       | 11 +++++++++++
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 28 ++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index abf9763..37a68e0 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -396,6 +396,7 @@
 
 		gmac0: ethernet at ff800000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.72a", "snps,dwmac";
+			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
 			reg = <0xff800000 0x2000>;
 			interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -403,11 +404,16 @@
 			mac-address = [00 00 00 00 00 00];
 			snps,multicast-filter-bins = <256>;
 			snps,perfect-filter-entries = <128>;
+			tx-fifo-depth = <4096>;
+			rx-fifo-depth = <16384>;
+			clocks = <&l4_mp_clk>;
+			clock-names = "stmmaceth";
 			status = "disabled";
 		};
 
 		gmac1: ethernet at ff802000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.72a", "snps,dwmac";
+			altr,sysmgr-syscon = <&sysmgr 0x48 0>;
 		        reg = <0xff802000 0x2000>;
 			interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -417,11 +423,14 @@
 			snps,perfect-filter-entries = <128>;
 			tx-fifo-depth = <4096>;
 			rx-fifo-depth = <16384>;
+			clocks = <&l4_mp_clk>;
+			clock-names = "stmmaceth";
 			status = "disabled";
 		};
 
 		gmac2: ethernet at ff804000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.72a", "snps,dwmac";
+			altr,sysmgr-syscon = <&sysmgr 0x4C 0>;
 			reg = <0xff804000 0x2000>;
 			interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -431,6 +440,8 @@
 			snps,perfect-filter-entries = <128>;
 			tx-fifo-depth = <4096>;
 			rx-fifo-depth = <16384>;
+			clocks = <&l4_mp_clk>;
+			clock-names = "stmmaceth";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index 347ca4e..94a0709 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -41,6 +41,34 @@
 	};
 };
 
+&gmac0 {
+	phy-mode = "rgmii";
+	phy-addr = <0xffffffff>; /* probe for phy addr */
+
+	/*
+	 * These skews assume the user's FPGA design is adding 600ps of delay
+	 * for TX_CLK on Arria 10.
+	 *
+	 * All skews are offset since hardware skew values for the ksz9031
+	 * range from a negative skew to a positive skew.
+	 * See the micrel-ksz90x1.txt Documentation file for details.
+	 */
+	txd0-skew-ps = <0>; /* -420ps */
+	txd1-skew-ps = <0>; /* -420ps */
+	txd2-skew-ps = <0>; /* -420ps */
+	txd3-skew-ps = <0>; /* -420ps */
+	rxd0-skew-ps = <420>; /* 0ps */
+	rxd1-skew-ps = <420>; /* 0ps */
+	rxd2-skew-ps = <420>; /* 0ps */
+	rxd3-skew-ps = <420>; /* 0ps */
+	txen-skew-ps = <0>; /* -420ps */
+	txc-skew-ps = <1860>; /* 960ps */
+	rxdv-skew-ps = <420>; /* 0ps */
+	rxc-skew-ps = <1680>; /* 780ps */
+	max-frame-size = <3800>;
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 };
-- 
1.9.1.315.g3f09db0
