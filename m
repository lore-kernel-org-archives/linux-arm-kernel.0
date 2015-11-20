From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:24 -0800
Subject: [PATCH 17/29] ARM: shmobile: r8a7793: Add QSPI device to DT
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
Message-ID: <469352ad3c43e689c15cd396cbb750ee831ab63e.1447981420.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate the QSPI controller in the r8a7793 device tree.

Based on similar work for the r8a7794 by Hisashi Nakamura and
Sergei Shtylyov.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 187a82dc7d9f..aa9b64c14a09 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -18,6 +18,10 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		spi0 = &qspi;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -222,6 +226,20 @@
 		status = "disabled";
 	};
 
+	qspi: spi at e6b10000 {
+		compatible = "renesas,qspi-r8a7793", "renesas,qspi";
+		reg = <0 0xe6b10000 0 0x2c>;
+		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7793_CLK_QSPI_MOD>;
+		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -463,6 +481,14 @@
 				"ipmmu_sgx", "vin2", "vin1", "vin0", "ether",
 				"sata1", "sata0";
 		};
+		mstp9_clks: mstp9_clks at e6150994 {
+			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
+			clocks = <&cpg_clocks R8A7793_CLK_QSPI>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7793_CLK_QSPI_MOD>;
+			clock-output-names = "qspi_mod";
+		};
 	};
 
 	ipmmu_sy0: mmu at e6280000 {
-- 
2.1.4
