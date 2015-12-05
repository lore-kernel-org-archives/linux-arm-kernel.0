From: yankejian@huawei.com (yankejian)
Date: Sat, 5 Dec 2015 15:54:47 +0800
Subject: [PATCH RESEND net-next 2/3] dts: hisi: fixes no syscon error when
 init mdio
In-Reply-To: <1449302088-53037-1-git-send-email-yankejian@huawei.com>
References: <1449302088-53037-1-git-send-email-yankejian@huawei.com>
Message-ID: <1449302088-53037-3-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when linux start up, we get the log below:
"Hi-HNS_MDIO 803c0000.mdio: no syscon hisilicon,peri-c-subctrl
 mdio_bus mdio at 803c0000: mdio sys ctl reg has not maped       "

the source code about the subctrl is dealled with syscon, but dts doesn't.
it cause such fault. so this patch adds the syscon info on dts files to
fixes it.

Signed-off-by: yankejian <yankejian@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05.dtsi     | 4 ++++
 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index 4ff16d0..daaca63 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -246,6 +246,10 @@
 			clock-frequency = <200000000>;
 		};
 
+		peri_c_subctrl: sub_ctrl_c at 80000000 {
+			compatible = "hisilicon,peri-c-subctrl", "syscon";
+			reg = < 0x0 0x80000000 0x0 0x10000>;
+		};
 		uart0: uart at 80300000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x80300000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi b/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
index 606dd5a..4d4815e 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
@@ -10,8 +10,8 @@ soc0: soc at 000000000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "hisilicon,hns-mdio";
-		reg = <0x0 0x803c0000 0x0 0x10000
-		       0x0 0x80000000 0x0 0x10000>;
+		reg = <0x0 0x803c0000 0x0 0x10000>;
+		subctrl_vbase = <&peri_c_subctrl>;
 
 		soc0_phy0: ethernet-phy at 0 {
 			reg = <0x0>;
-- 
1.9.1
