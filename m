From: andy.tang@nxp.com (Yuantian Tang)
Date: Mon, 5 Jun 2017 11:28:22 +0800
Subject: [PATCH v2] arm64: dts: ls1012a: Add coreclk
Message-ID: <1496633302-2795-1-git-send-email-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Scott Wood <oss@buserror.net>

ls1012a has separate input root clocks for core PLLs versus the platform
PLL, with the latter described as sysclk in the hw docs.
Accordingly, update the clock-frequency in sysclk to 125M as platform
input clock.

Signed-off-by: Scott Wood <oss@buserror.net>
Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
v2:
	- add explanation about frequency change
Note 1: Current versions of U-Boot are blindly updating the frequency
of all fixed-clock nodes.  That needs to be fixed for the split input
frequency to work properly, but until U-Boot is fixed this change doesn't
make anything worse than it already was.
Note 2: coreclk binding has been merged in mainline clock git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 9a2ccd8..b1554cb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -76,10 +76,17 @@
 	sysclk: sysclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <100000000>;
+		clock-frequency = <125000000>;
 		clock-output-names = "sysclk";
 	};
 
+	coreclk: coreclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "coreclk";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <1 13 IRQ_TYPE_LEVEL_LOW>,/* Physical Secure PPI */
@@ -248,7 +255,8 @@
 			compatible = "fsl,ls1012a-clockgen";
 			reg = <0x0 0x1ee1000 0x0 0x1000>;
 			#clock-cells = <2>;
-			clocks = <&sysclk>;
+			clocks = <&sysclk &coreclk>;
+			clock-names = "sysclk", "coreclk";
 		};
 
 		tmu: tmu at 1f00000 {
-- 
2.1.0.27.g96db324
