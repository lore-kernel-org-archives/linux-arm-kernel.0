From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  4 Dec 2017 10:20:05 -0200
Subject: [PATCH v2 01/12] ARM: dts: imx51-ts4800: Fix syscon and touschscreen
 nodes
Message-ID: <1512390016-703-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The syscon node has an incorrect notation for its unit address and the
wdt node has an unneeded unit address.

Fix them so that the following build warnings with W=1 are gone:

arch/arm/boot/dts/imx51-ts4800.dtb: Warning (unit_address_vs_reg): Node /soc/aips at 80000000/weim at 83fda000/fpga at 0/syscon at b0010000/wdt at e has a unit name, but no reg property
arch/arm/boot/dts/imx51-ts4800.dtb: Warning (unit_address_vs_reg): Node /soc/aips at 80000000/weim at 83fda000/fpga at 0/touchscreen has a reg or ranges property, but no unit name
arch/arm/boot/dts/imx51-ts4800.dtb: Warning (simple_bus_reg): Node /soc/aips at 80000000/weim at 83fda000/fpga at 0/syscon at b0010000 simple-bus unit address format error, expected "10000"
arch/arm/boot/dts/imx51-ts4800.dtb: Warning (simple_bus_reg): Node /soc/aips at 80000000/weim at 83fda000/fpga at 0/touchscreen simple-bus unit address format error, expected "12000"

Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
Changes since v1:
- Removed 'Node /memory has a reg or ranges property, but no unit name' error

 arch/arm/boot/dts/imx51-ts4800.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index 564233e..f59b02b 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -149,18 +149,18 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0x1d000>;
 
-		syscon: syscon at b0010000 {
+		syscon: syscon at 10000 {
 			compatible = "syscon", "simple-mfd";
 			reg = <0x10000 0x3d>;
 			reg-io-width = <2>;
 
-			wdt at e {
+			wdt {
 				compatible = "technologic,ts4800-wdt";
 				syscon = <&syscon 0xe>;
 			};
 		};
 
-		touchscreen {
+		touchscreen at 12000 {
 			compatible = "technologic,ts4800-ts";
 			reg = <0x12000 0x1000>;
 			syscon = <&syscon 0x10 6>;
-- 
2.7.4
