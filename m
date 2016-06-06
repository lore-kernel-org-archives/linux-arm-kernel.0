From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Mon,  6 Jun 2016 09:43:49 +0200
Subject: [PATCH 1/2] ARM: BCM5301X: Specify NAND chip select and ECC in
 separated files
Message-ID: <1465199036-24366-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using separated file with common chip select parameters will allow us
adding other ECC setups without code duplication.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi | 16 +++++-----------
 arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi      | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi

diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi
index d10781e..9a9630d 100644
--- a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi
+++ b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi
@@ -9,16 +9,10 @@
  * Licensed under the GNU/GPL. See COPYING for details.
  */
 
-/ {
-	nand at 18028000 {
-		nandcs at 0 {
-			compatible = "brcm,nandcs";
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+#include "bcm5301x-nand-cs0.dtsi"
 
-			nand-ecc-strength = <8>;
-			nand-ecc-step-size = <512>;
-		};
-	};
+&nandcs {
+	nand-ecc-algo = "bch";
+	nand-ecc-strength = <8>;
+	nand-ecc-step-size = <512>;
 };
diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi b/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
new file mode 100644
index 0000000..1684951
--- /dev/null
+++ b/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
@@ -0,0 +1,18 @@
+/*
+ * Broadcom Northstar NAND.
+ *
+ * Copyright (C) 2015 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+/ {
+	nand at 18028000 {
+		nandcs: nandcs at 0 {
+			compatible = "brcm,nandcs";
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
+};
-- 
1.8.4.5
