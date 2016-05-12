From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 12 May 2016 14:25:23 -0500
Subject: [PATCH] ARM: dts: socfpga: fix definitions of serial console for
 Arria10
Message-ID: <1463081123-3181-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthew Gerlach <mgerlach@opensource.altera.com>

The notion of which uart instance is serial0 or serial1
is board specific rather than generic to the chip. This
patch removes the serial aliases from generic chip dtsi
and adds an appropriate alias to the board specific dtsi.
By making the alias for serial0 point to uart1 for the arria10_socdk,
the linux boot command line supports specifying console=ttyS0,115200
for backwards compatibility, and it supports not specifying
the console at all.

Signed-off-by: Matthew Gerlach <mgerlach@opensource.altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi       | 5 -----
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 1c5e139..48658f9 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -22,11 +22,6 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index 567df98..b1a4293 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -20,9 +20,13 @@
 	model = "Altera SOCFPGA Arria 10";
 	compatible = "altr,socfpga-arria10", "altr,socfpga";
 
+	aliases {
+		serial0 = &uart1;
+	};
+
 	chosen {
 		bootargs = "earlyprintk";
-		stdout-path = "serial1:115200n8";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
2.6.2
