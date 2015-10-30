From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 30 Oct 2015 11:48:58 +0530
Subject: [PATCH v4 3/3] arm64: dts: Add BRCM IPROC NAND DT node for NS2
In-Reply-To: <1446185938-17520-1-git-send-email-anup.patel@broadcom.com>
References: <1446185938-17520-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1446185938-17520-4-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND controller on NS2 SoC is compatible with existing
BRCM IPROC NAND driver so let's enable it in NS2 DT and
NS2 SVK DT.

This patch also fixes use of node labels in ns2-svk.dts.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Reviewed-by: Brian Norris <computersforpeace@gmail.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 30 ++++++++++++++++++++----------
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 14 ++++++++++++++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index e5950d5..6bb3d4d 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -50,18 +50,28 @@
 		device_type = "memory";
 		reg = <0x000000000 0x80000000 0x00000000 0x40000000>;
 	};
+};
 
-	soc: soc {
-		i2c0: i2c at 66080000 {
-			status = "ok";
-		};
+&i2c0 {
+	status = "ok";
+};
 
-		i2c1: i2c at 660b0000 {
-			status = "ok";
-		};
+&i2c1 {
+	status = "ok";
+};
+
+&uart3 {
+	status = "ok";
+};
 
-		uart3: serial at 66130000 {
-			status = "ok";
-		};
+&nand {
+	nandcs at 0 {
+		compatible = "brcm,nandcs";
+		reg = <0>;
+		nand-ecc-mode = "hw";
+		nand-ecc-strength = <8>;
+		nand-ecc-step-size = <512>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 	};
 };
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index f603277..9610822 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -212,5 +212,19 @@
 			compatible = "brcm,iproc-rng200";
 			reg = <0x66220000 0x28>;
 		};
+
+		nand: nand at 66460000 {
+			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
+			reg = <0x66460000 0x600>,
+			      <0x67015408 0x600>,
+			      <0x66460f00 0x20>;
+			reg-names = "nand", "iproc-idm", "iproc-ext";
+			interrupts = <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			brcm,nand-has-wp;
+		};
 	};
 };
-- 
1.9.1
