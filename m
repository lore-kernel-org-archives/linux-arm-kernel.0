From: yankejian@huawei.com (Kejian Yan)
Date: Wed, 13 Jan 2016 15:09:58 +0800
Subject: [patch v3 net-next 1/2] dts: hisi: fixes no syscon fault when init
 mdio
In-Reply-To: <1452668999-443-1-git-send-email-yankejian@huawei.com>
References: <1452668999-443-1-git-send-email-yankejian@huawei.com>
Message-ID: <1452668999-443-2-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When linux start up, we get the log below:
"Hi-HNS_MDIO 803c0000.mdio: no syscon hisilicon,peri-c-subctrl
mdio_bus mdio at 803c0000: mdio sys ctl reg has not maped"

The source code about the subctrl is dealt syscon, but dts doesn't.
It cause such fault, so this patch adds the syscon info on dts files to
fixes it.

Signed-off-by: Kejian Yan <yankejian@huawei.com>
---
change log:
v3:
 1) uses capital letter at the beginning of sentences
 2) updates the right device node name

v2:
 1) updates the related documented in the binding as well
 2) uses the normal naming conventions using '-' instead of '_'

v1:
 first submit

v2 patch link: https://lkml.org/lkml/2015/12/7/80
v1 patch link: https://lkml.org/lkml/2015/11/28/3
---
 .../devicetree/bindings/arm/hisilicon/hisilicon.txt      | 16 ++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi                 |  5 +++++
 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi             |  4 ++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 6ac7c00..e3ccab1 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -187,6 +187,22 @@ Example:
 		reg = <0xb0000000 0x10000>;
 	};
 
+Hisilicon HiP05 PERISUB system controller
+
+Required properties:
+- compatible : "hisilicon,hip05-perisubc", "syscon";
+- reg : Register address and size
+
+The HiP05 PERISUB system controller is shared by peripheral controllers in
+HiP05 Soc to implement some basic configurations. The peripheral
+controllers include mdio, ddr, iic, uart, timer and so on.
+
+Example:
+	/* for HiP05 perisub-ctrl-c system */
+	peri_c_subctrl: syscon at 80000000 {
+		compatible = "hisilicon,hip05-perisubc", "syscon";
+		reg = <0x0 0x80000000 0x0 0x10000>;
+	};
 -----------------------------------------------------------------------
 Hisilicon CPU controller
 
diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index 4ff16d0..c1ea999 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -246,6 +246,11 @@
 			clock-frequency = <200000000>;
 		};
 
+		peri_c_subctrl: syscon at 80000000 {
+			compatible = "hisilicon,hip05-perisubc", "syscon";
+			reg = < 0x0 0x80000000 0x0 0x10000>;
+		};
+
 		uart0: uart at 80300000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x80300000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi b/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
index 606dd5a..da7b6e6 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
@@ -10,8 +10,8 @@ soc0: soc at 000000000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "hisilicon,hns-mdio";
-		reg = <0x0 0x803c0000 0x0 0x10000
-		       0x0 0x80000000 0x0 0x10000>;
+		reg = <0x0 0x803c0000 0x0 0x10000>;
+		subctrl-vbase = <&peri_c_subctrl>;
 
 		soc0_phy0: ethernet-phy at 0 {
 			reg = <0x0>;
-- 
2.4.1
