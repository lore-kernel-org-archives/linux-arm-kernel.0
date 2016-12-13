From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 13 Dec 2016 13:13:51 -0500
Subject: [PATCH 7/7] ARM: dts: NSP: Add SD/MMC support
In-Reply-To: <1481652831-2744-1-git-send-email-jon.mason@broadcom.com>
References: <1481652831-2744-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1481652831-2744-8-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SD/MMC support to the Broadcom NSP SVK and XMC.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi     |   9 +++
 arch/arm/boot/dts/bcm958525xmc.dts |   6 +-
 arch/arm/boot/dts/bcm958625k.dts   | 118 ++++++++++++++++++++++++-------------
 3 files changed, 90 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index ecffc16..6c58c78 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -209,6 +209,15 @@
 			#dma-cells = <1>;
 		};
 
+		sdio: sdhci at 21000 {
+			compatible = "brcm,sdhci-iproc-cygnus";
+			reg = <0x21000 0x100>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			sdhci,auto-cmd12;
+			clocks = <&lcpll0 BCM_NSP_LCPLL0_SDIO_CLK>;
+			status = "disabled";
+		};
+
 		amac0: ethernet at 22000 {
 			compatible = "brcm,nsp-amac";
 			reg = <0x022000 0x1000>,
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index 3912269..41e7fd3 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -59,7 +59,7 @@
 	};
 };
 
-/* XHCI and SD/MMC support needed to be complete */
+/* XHCI support needed to be complete */
 
 &amac0 {
 	status = "okay";
@@ -184,6 +184,10 @@
 	status = "okay";
 };
 
+&sdio {
+	status = "ok";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index 6e994f2..f8d47e5 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -117,58 +117,34 @@
 
 &pinctrl {
 	pinctrl-names = "default";
-	pinctrl-0 = <&nand_sel>;
+	pinctrl-0 = <&nand_sel>, <&gpiobs>, <&pwmc>;
+
 	nand_sel: nand_sel {
 		function = "nand";
 		groups = "nand_grp";
 	};
-};
-
-&srab {
-	compatible = "brcm,bcm58625-srab", "brcm,nsp-srab";
-	status = "okay";
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port at 0 {
-			label = "port0";
-			reg = <0>;
-		};
-
-		port at 1 {
-			label = "port1";
-			reg = <1>;
-		};
-
-		port at 2 {
-			label = "port2";
-			reg = <2>;
-		};
 
-		port at 3 {
-			label = "port3";
-			reg = <3>;
-		};
+	gpiobs: gpiobs {
+		function = "gpio_b";
+		groups = "gpio_b_0_grp", "gpio_b_1_grp", "gpio_b_2_grp",
+			 "gpio_b_3_grp";
+	};
 
-		port at 4 {
-			label = "port4";
-			reg = <4>;
-		};
+	pwmc: pwmc {
+		function = "pwm";
+		groups = "pwm0_grp", "pwm1_grp", "pwm2_grp", "pwm3_grp";
+	};
 
-		port at 5 {
-			ethernet = <&amac0>;
-			label = "cpu";
-			reg = <5>;
-			fixed-link {
-				speed = <1000>;
-				full-duplex;
-			};
-		};
+	emmc_sel: emmc_sel {
+		function = "emmc";
+		groups = "emmc_grp";
 	};
 };
 
+&pwm {
+	status = "okay";
+};
+
 &qspi {
 	bspi-sel = <0>;
 	flash: m25p80 at 0 {
@@ -215,6 +191,64 @@
 	status = "okay";
 };
 
+/*
+ * By default the sd slot is functional. For emmc to work add "<&emmc_sel>"
+ * and delete "<&nand_sel>" in "pinctrl-0" property of pinctrl node. Remove the
+ * bus-width property here and disable the nand node with status = "disabled";.
+ *
+ * Ex: pinctrl-0 = <&emmc_sel>, <&gpiobs>, <&pwmc>;
+ */
+&sdio {
+	bus-width = <4>;
+	no-1-8-v;
+	status = "ok";
+};
+
+&srab {
+	compatible = "brcm,bcm58625-srab", "brcm,nsp-srab";
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			label = "port0";
+			reg = <0>;
+		};
+
+		port at 1 {
+			label = "port1";
+			reg = <1>;
+		};
+
+		port at 2 {
+			label = "port2";
+			reg = <2>;
+		};
+
+		port at 3 {
+			label = "port3";
+			reg = <3>;
+		};
+
+		port at 4 {
+			label = "port4";
+			reg = <4>;
+		};
+
+		port at 5 {
+			ethernet = <&amac0>;
+			label = "cpu";
+			reg = <5>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.7.4
