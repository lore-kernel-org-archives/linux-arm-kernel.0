From: anup.patel@broadcom.com (Anup Patel)
Date: Fri,  2 Jun 2017 12:04:35 +0530
Subject: [PATCH v6 11/11] arm64: dts: Add PWM and SDHCI DT nodes for Stingray
 SOC
In-Reply-To: <1496385275-6899-1-git-send-email-anup.patel@broadcom.com>
References: <1496385275-6899-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1496385275-6899-12-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinath Mannam <srinath.mannam@broadcom.com>

The Stingray SoC has two instances of SDHCI controller
and one instance of iProc PWM.

Let's enable above mentioned devices in Stingray DT.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 39 ++++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 28 ++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
index ff59a26..5dca7d1 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
@@ -43,6 +43,28 @@
 		serial2 = &uart2;
 		serial3 = &uart3;
 	};
+
+	sdio0_vddo_ctrl_reg: sdio0_vddo_ctrl {
+		compatible = "regulator-gpio";
+		regulator-name = "sdio0_vddo_ctrl_reg";
+		regulator-type = "voltage";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&pca9505 18 0>;
+		states = <3300000 0x0
+			  1800000 0x1>;
+	};
+
+	sdio1_vddo_ctrl_reg: sdio1_vddo_ctrl {
+		compatible = "regulator-gpio";
+		regulator-name = "sdio1_vddo_ctrl_reg";
+		regulator-type = "voltage";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&pca9505 19 0>;
+		states = <3300000 0x0
+			  1800000 0x1>;
+	};
 };
 
 &memory { /* Default DRAM banks */
@@ -54,6 +76,10 @@
 	status = "okay";
 };
 
+&pwm {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -90,3 +116,16 @@
 		#size-cells = <1>;
 	};
 };
+
+&sdio0 {
+	vqmmc-supply = <&sdio0_vddo_ctrl_reg>;
+	non-removable;
+	full-pwr-cycle;
+	status = "okay";
+};
+
+&sdio1 {
+	vqmmc-supply = <&sdio1_vddo_ctrl_reg>;
+	full-pwr-cycle;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 88a6176..49933cf 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -269,6 +269,14 @@
 
 		#include "stingray-pinctrl.dtsi"
 
+		pwm: pwm at 00010000 {
+			compatible = "brcm,iproc-pwm";
+			reg = <0x00010000 0x1000>;
+			clocks = <&crmu_ref25m>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		i2c0: i2c at 000b0000 {
 			compatible = "brcm,iproc-i2c";
 			reg = <0x000b0000 0x100>;
@@ -428,5 +436,25 @@
 			brcm,nand-has-wp;
 			status = "disabled";
 		};
+
+		sdio0: sdhci at 003f1000 {
+			compatible = "brcm,sdhci-iproc";
+			reg = <0x003f1000 0x100>;
+			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
+			bus-width = <8>;
+			clocks = <&sdio0_clk>;
+			iommus = <&smmu 0x6002 0x0000>;
+			status = "disabled";
+		};
+
+		sdio1: sdhci at 003f2000 {
+			compatible = "brcm,sdhci-iproc";
+			reg = <0x003f2000 0x100>;
+			interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
+			bus-width = <8>;
+			clocks = <&sdio1_clk>;
+			iommus = <&smmu 0x6003 0x0000>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.4
