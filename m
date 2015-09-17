From: rjui@broadcom.com (Ray Jui)
Date: Thu, 17 Sep 2015 16:57:59 -0700
Subject: [PATCH 1/4] ARM: dts: clean up Cygnus DT files
In-Reply-To: <1442534282-21356-1-git-send-email-rjui@broadcom.com>
References: <1442534282-21356-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442534282-21356-2-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch cleans up Cygnus DT files and makes the format consistent
with the rest of Broadcom iProc based SoCs.

Changes include:
    - Put core components into "core" node of type "simple-bus"
    - Put all other peripherals into "soc" node of type "simple-bus"
    - Move aliases into bcm-cygnus.dtsi to avoid duplications in all dts
      files
    - Ordered all device nodes under buses based on their base register
      addresses
    - Remove unused PCI I/O resource
    - Use label instead of full path to reference device nodes in dts
      files

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi      | 328 +++++++++++++++++----------------
 arch/arm/boot/dts/bcm911360_entphn.dts |  12 +-
 arch/arm/boot/dts/bcm911360k.dts       |  10 +-
 arch/arm/boot/dts/bcm958300k.dts       |  44 ++---
 arch/arm/boot/dts/bcm958305k.dts       |  10 +-
 5 files changed, 199 insertions(+), 205 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index e1ac07a..1f56b18 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -32,6 +32,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/bcm-cygnus.h>
 
 #include "skeleton.dtsi"
 
@@ -40,6 +41,10 @@
 	model = "Broadcom Cygnus SoC";
 	interrupt-parent = <&gic>;
 
+	aliases {
+		serial0 = &uart3;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -54,197 +59,202 @@
 
 	/include/ "bcm-cygnus-clock.dtsi"
 
-	pinctrl: pinctrl at 0x0301d0c8 {
-		compatible = "brcm,cygnus-pinmux";
-		reg = <0x0301d0c8 0x30>,
-		      <0x0301d24c 0x2c>;
-	};
-
-	gpio_crmu: gpio at 03024800 {
-		compatible = "brcm,cygnus-crmu-gpio";
-		reg = <0x03024800 0x50>,
-		      <0x03024008 0x18>;
-		#gpio-cells = <2>;
-		gpio-controller;
-	};
-
-	gpio_ccm: gpio at 1800a000 {
-		compatible = "brcm,cygnus-ccm-gpio";
-		reg = <0x1800a000 0x50>,
-		      <0x0301d164 0x20>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-controller;
-	};
+	core {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-	gpio_asiu: gpio at 180a5000 {
-		compatible = "brcm,cygnus-asiu-gpio";
-		reg = <0x180a5000 0x668>;
-		#gpio-cells = <2>;
-		gpio-controller;
+		timer at 19020200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x19020200 0x100>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&periph_clk>;
+		};
 
-		pinmux = <&pinctrl>;
+		gic: interrupt-controller at 19021000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x19021000 0x1000>,
+			      <0x19020100 0x100>;
+		};
 
-		interrupt-controller;
-		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+		L2: l2-cache {
+			compatible = "arm,pl310-cache";
+			reg = <0x19022000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
 	};
 
-	amba {
+	soc {
+		compatible = "simple-bus";
+		ranges;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "arm,amba-bus", "simple-bus";
-		interrupt-parent = <&gic>;
-		ranges;
 
-		wdt at 18009000 {
-			 compatible = "arm,sp805" , "arm,primecell";
-			 reg = <0x18009000 0x1000>;
-			 interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-			 clocks = <&axi81_clk>;
-			 clock-names = "apb_pclk";
+		pinctrl: pinctrl at 0301d0c8 {
+			compatible = "brcm,cygnus-pinmux";
+			reg = <0x0301d0c8 0x30>,
+			      <0x0301d24c 0x2c>;
 		};
-	};
 
-	i2c0: i2c at 18008000 {
-		compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
-		reg = <0x18008000 0x100>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
-		clock-frequency = <100000>;
-		status = "disabled";
-	};
+		gpio_crmu: gpio at 03024800 {
+			compatible = "brcm,cygnus-crmu-gpio";
+			reg = <0x03024800 0x50>,
+			      <0x03024008 0x18>;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
 
-	i2c1: i2c at 1800b000 {
-		compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
-		reg = <0x1800b000 0x100>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
-		clock-frequency = <100000>;
-		status = "disabled";
-	};
+		i2c0: i2c at 18008000 {
+			compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
+			reg = <0x18008000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		wdt0: wdt at 18009000 {
+			compatible = "arm,sp805" , "arm,primecell";
+			reg = <0x18009000 0x1000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&axi81_clk>;
+			clock-names = "apb_pclk";
+		};
 
-	pcie0: pcie at 18012000 {
-		compatible = "brcm,iproc-pcie";
-		reg = <0x18012000 0x1000>;
+		gpio_ccm: gpio at 1800a000 {
+			compatible = "brcm,cygnus-ccm-gpio";
+			reg = <0x1800a000 0x50>,
+			      <0x0301d164 0x20>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+		};
 
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
+		i2c1: i2c at 1800b000 {
+			compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
+			reg = <0x1800b000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
 
-		linux,pci-domain = <0>;
+		pcie0: pcie at 18012000 {
+			compatible = "brcm,iproc-pcie";
+			reg = <0x18012000 0x1000>;
 
-		bus-range = <0x00 0xff>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
 
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x81000000 0 0	  0x28000000 0 0x00010000
-			  0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
+			linux,pci-domain = <0>;
 
-		status = "disabled";
-	};
+			bus-range = <0x00 0xff>;
 
-	pcie1: pcie at 18013000 {
-		compatible = "brcm,iproc-pcie";
-		reg = <0x18013000 0x1000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
 
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
+			status = "disabled";
+		};
 
-		linux,pci-domain = <1>;
+		pcie1: pcie at 18013000 {
+			compatible = "brcm,iproc-pcie";
+			reg = <0x18013000 0x1000>;
 
-		bus-range = <0x00 0xff>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
 
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x81000000 0 0	  0x48000000 0 0x00010000
-			  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
+			linux,pci-domain = <1>;
 
-		status = "disabled";
-	};
+			bus-range = <0x00 0xff>;
 
-	uart0: serial at 18020000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x18020000 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&axi81_clk>;
-		clock-frequency = <100000000>;
-		status = "disabled";
-	};
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
 
-	uart1: serial at 18021000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x18021000 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&axi81_clk>;
-		clock-frequency = <100000000>;
-		status = "disabled";
-	};
+			status = "disabled";
+		};
 
-	uart2: serial at 18022000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x18020000 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&axi81_clk>;
-		clock-frequency = <100000000>;
-		status = "disabled";
-	};
+		uart0: serial at 18020000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x18020000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&axi81_clk>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
 
-	uart3: serial at 18023000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x18023000 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&axi81_clk>;
-		clock-frequency = <100000000>;
-		status = "disabled";
-	};
+		uart1: serial at 18021000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x18021000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&axi81_clk>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
 
-	nand: nand at 18046000 {
-		compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1", "brcm,brcmnand";
-		reg = <0x18046000 0x600>, <0xf8105408 0x600>, <0x18046f00 0x20>;
-		reg-names = "nand", "iproc-idm", "iproc-ext";
-		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+		uart2: serial at 18022000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x18020000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&axi81_clk>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
 
-		#address-cells = <1>;
-		#size-cells = <0>;
+		uart3: serial at 18023000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x18023000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&axi81_clk>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
 
-		brcm,nand-has-wp;
-	};
+		nand: nand at 18046000 {
+			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1",
+				     "brcm,brcmnand";
+			reg = <0x18046000 0x600>, <0xf8105408 0x600>,
+			      <0x18046f00 0x20>;
+			reg-names = "nand", "iproc-idm", "iproc-ext";
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 
-	gic: interrupt-controller at 19021000 {
-		compatible = "arm,cortex-a9-gic";
-		#interrupt-cells = <3>;
-		#address-cells = <0>;
-		interrupt-controller;
-		reg = <0x19021000 0x1000>,
-		      <0x19020100 0x100>;
-	};
+			#address-cells = <1>;
+			#size-cells = <0>;
 
-	L2: l2-cache {
-		compatible = "arm,pl310-cache";
-		reg = <0x19022000 0x1000>;
-		cache-unified;
-		cache-level = <2>;
-	};
+			brcm,nand-has-wp;
+		};
 
-	timer at 19020200 {
-		compatible = "arm,cortex-a9-global-timer";
-		reg = <0x19020200 0x100>;
-		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&periph_clk>;
-	};
+		gpio_asiu: gpio at 180a5000 {
+			compatible = "brcm,cygnus-asiu-gpio";
+			reg = <0x180a5000 0x668>;
+			#gpio-cells = <2>;
+			gpio-controller;
 
+			pinmux = <&pinctrl>;
+
+			interrupt-controller;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/bcm911360_entphn.dts
index 7db4843..f791a3b 100644
--- a/arch/arm/boot/dts/bcm911360_entphn.dts
+++ b/arch/arm/boot/dts/bcm911360_entphn.dts
@@ -39,19 +39,11 @@
 	model = "Cygnus Enterprise Phone (BCM911360_ENTPHN)";
 	compatible = "brcm,bcm11360", "brcm,cygnus";
 
-	aliases {
-		serial0 = &uart3;
-	};
-
 	chosen {
 		stdout-path = &uart3;
 		bootargs = "console=ttyS0,115200";
 	};
 
-	uart3: serial at 18023000 {
-		status = "okay";
-	};
-
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
@@ -64,3 +56,7 @@
 		};
 	};
 };
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm911360k.dts b/arch/arm/boot/dts/bcm911360k.dts
index 9658d4f..814011c 100644
--- a/arch/arm/boot/dts/bcm911360k.dts
+++ b/arch/arm/boot/dts/bcm911360k.dts
@@ -38,16 +38,12 @@
 	model = "Cygnus SVK (BCM911360K)";
 	compatible = "brcm,bcm11360", "brcm,cygnus";
 
-	aliases {
-		serial0 = &uart3;
-	};
-
 	chosen {
 		stdout-path = &uart3;
 		bootargs = "console=ttyS0,115200";
 	};
+};
 
-	uart3: serial at 18023000 {
-		status = "okay";
-	};
+&uart3 {
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958300k.dts b/arch/arm/boot/dts/bcm958300k.dts
index 2f63052..d8dc9f0 100644
--- a/arch/arm/boot/dts/bcm958300k.dts
+++ b/arch/arm/boot/dts/bcm958300k.dts
@@ -38,40 +38,36 @@
 	model = "Cygnus SVK (BCM958300K)";
 	compatible = "brcm,bcm58300", "brcm,cygnus";
 
-	aliases {
-		serial0 = &uart3;
-	};
-
 	chosen {
 		stdout-path = &uart3;
 		bootargs = "console=ttyS0,115200";
 	};
+};
 
-	pcie0: pcie at 18012000 {
-		status = "okay";
-	};
+&pcie0 {
+	status = "okay";
+};
 
-	pcie1: pcie at 18013000 {
-		status = "okay";
-	};
+&pcie1 {
+	status = "okay";
+};
 
-	uart3: serial at 18023000 {
-		status = "okay";
-	};
+&uart3 {
+	status = "okay";
+};
 
-	nand: nand at 18046000 {
-		nandcs at 1 {
-			compatible = "brcm,nandcs";
-			reg = <0>;
-			nand-on-flash-bbt;
+&nand {
+	nandcs at 1 {
+		compatible = "brcm,nandcs";
+		reg = <0>;
+		nand-on-flash-bbt;
 
-			#address-cells = <1>;
-			#size-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-			nand-ecc-strength = <24>;
-			nand-ecc-step-size = <1024>;
+		nand-ecc-strength = <24>;
+		nand-ecc-step-size = <1024>;
 
-			brcm,nand-oob-sector-size = <27>;
-		};
+		brcm,nand-oob-sector-size = <27>;
 	};
 };
diff --git a/arch/arm/boot/dts/bcm958305k.dts b/arch/arm/boot/dts/bcm958305k.dts
index 56b429a..af11a8e 100644
--- a/arch/arm/boot/dts/bcm958305k.dts
+++ b/arch/arm/boot/dts/bcm958305k.dts
@@ -38,16 +38,12 @@
 	model = "Cygnus Wireless Audio (BCM958305K)";
 	compatible = "brcm,bcm58305", "brcm,cygnus";
 
-	aliases {
-		serial0 = &uart3;
-	};
-
 	chosen {
 		stdout-path = &uart3;
 		bootargs = "console=ttyS0,115200";
 	};
+};
 
-	uart3: serial at 18023000 {
-		status = "okay";
-	};
+&uart3 {
+	status = "okay";
 };
-- 
1.9.1
