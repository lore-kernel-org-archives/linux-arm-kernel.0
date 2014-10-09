From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 9 Oct 2014 15:44:29 -0700
Subject: [PATCH V4 5/7] ARM: dts: Enable Broadcom Cygnus SoC
In-Reply-To: <1412894671-5921-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1412894671-5921-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1412894671-5921-6-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Richardson <jonathar@broadcom.com>

DT files to enable cygnus consisting of the enterprise phone board
variant and cygnus core configuration.

Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Arun Parameswaran <aparames@broadcom.com>
Tested-by: Jonathan Richardson <jonathar@broadcom.com>
Reviewed-by: JD (Jiandong) Zheng <jdzheng@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/Makefile             |    1 +
 arch/arm/boot/dts/bcm-cygnus.dtsi      |  349 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm911360_entphn.dts |   22 ++
 3 files changed, 372 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm-cygnus.dtsi
 create mode 100644 arch/arm/boot/dts/bcm911360_entphn.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3..b95d41d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -52,6 +52,7 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d36ek.dtb
 dtb-$(CONFIG_ARCH_ATLAS6) += atlas6-evb.dtb
 dtb-$(CONFIG_ARCH_AXXIA) += axm5516-amarillo.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
+dtb-$(CONFIG_ARCH_BCM_CYGNUS) += bcm911360_entphn.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += bcm4708-netgear-r6250.dtb
 dtb-$(CONFIG_ARCH_BCM_MOBILE) += bcm28155-ap.dtb \
 	bcm21664-garnet.dtb
diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
new file mode 100644
index 0000000..81da0d8
--- /dev/null
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -0,0 +1,349 @@
+/*
+ * Copyright 2014 Broadcom Corporation.  All rights reserved.
+ *
+ * Unless you and Broadcom execute a separate written software license
+ * agreement governing use of this software, this software is licensed to you
+ * under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#include "skeleton.dtsi"
+
+/ {
+	compatible = "brcm,cygnus";
+	model = "Broadcom Cygnus SoC";
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &uart3;
+		serial1 = &uart0;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk debug";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0x0>;
+		};
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		osc: oscillator {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <25000000>;
+		};
+
+		lcpll: lcpll at 0301d02c {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-lcpll-clk";
+			reg = <0x0301d02c 0x1c>;
+			clocks = <&osc>;
+		};
+
+		genpll: genpll at 0301d000 {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-genpll-clk";
+			reg = <0x0301d000 0x2c>,
+				  <0x180AA024 0x4>,
+				  <0x0301C020 0x4>;
+			clocks = <&osc>;
+		};
+
+		axi21_clk: genpll_ch0 at 0301d000 {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-genpll-ch";
+			reg = <0x0301d000 0x2c>;
+			clocks = <&genpll>;
+			channel = <0>;
+		};
+
+		clk_25MHz: genpll_ch1 at 0301d000 {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-genpll-ch";
+			reg = <0x0301d000 0x2c>;
+			clocks = <&genpll>;
+			channel = <1>;
+		};
+
+		sys_clk: genpll_ch2 at 0301d000 {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-genpll-ch";
+			reg = <0x0301d000 0x2c>;
+			clocks = <&genpll>;
+			channel = <2>;
+		};
+
+		ethernet_clk: genpll_ch3 at 0301d000 {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-genpll-ch";
+			reg = <0x0301d000 0x2c>;
+			clocks = <&genpll>;
+			channel = <3>;
+		};
+
+		asiu_audio_clk: genpll_ch4 at 0301d000 {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-genpll-ch";
+			reg = <0x0301d000 0x2c>;
+			clocks = <&genpll>;
+			channel = <4>;
+		};
+
+		asiu_can_clk: genpll_ch5 at 0301d000 {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-genpll-ch";
+			reg = <0x0301d000 0x2c>;
+			clocks = <&genpll>;
+			channel = <5>;
+		};
+
+		pcie_clk: lcpll_ch0 at 0301d02c {
+			compatible = "brcm,cygnus-lcpll-ch";
+			reg = <0x0301d02c 0x1c>;
+			#clock-cells = <0>;
+			clocks = <&lcpll>;
+			channel = <0>;
+		};
+
+		ddr_clk: lcpll_ch1 at 0301d02c {
+			compatible = "brcm,cygnus-lcpll-ch";
+			reg = <0x0301d02c 0x1c>;
+			#clock-cells = <0>;
+			clocks = <&lcpll>;
+			channel = <1>;
+		};
+
+		sdio_clk: lcpll_ch2 at 0301d02c {
+			compatible = "brcm,cygnus-lcpll-ch";
+			reg = <0x0301d02c 0x1c>;
+			#clock-cells = <0>;
+			clocks = <&lcpll>;
+			channel = <2>;
+		};
+
+		usb_clk: lcpll_ch3 at 0301d02c {
+		    compatible = "brcm,cygnus-lcpll-ch";
+			reg = <0x0301d02c 0x1c>;
+			#clock-cells = <0>;
+			clocks = <&lcpll>;
+			channel = <3>;
+		};
+
+		smart_card_clk: lcpll_ch4 at 0301d02c {
+			compatible = "brcm,cygnus-lcpll-ch";
+			reg = <0x0301d02c 0x1c>;
+			#clock-cells = <0>;
+			clocks = <&lcpll>;
+			channel = <4>;
+		};
+
+		ch5_unknown_clk: lcpll_ch5 at 0301d02c {
+			compatible = "brcm,cygnus-lcpll-ch";
+			reg = <0x0301d02c 0x1c>;
+			#clock-cells = <0>;
+			clocks = <&lcpll>;
+			channel = <5>;
+		};
+
+		/*
+		 * There are 2 clocks derived from genpll ch0 (axi21) which are
+		 * divided internally by 2 and 4. If axi21 clock rate changes, these
+		 * derived clock rates scale accordingly.
+		 */
+
+		axi41_clk: axi41_clk {
+			reg = <0x0301d000 0x2c>;
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-pll-derived";
+			clocks = <&axi21_clk>;
+			div = <2>;
+		};
+
+		axi81_clk: axi81_clk {
+			reg = <0x0301d000 0x2c>;
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-pll-derived";
+			clocks = <&axi21_clk>;
+			div = <4>;
+		};
+
+		/*
+		 * The main output of the ARM PLL is arm_clk with several derived
+		 * child clocks:
+		 * 		periph_clk
+		 * 		apb_clk
+		 * 		arm_switch
+		 * 		apb0_free
+		 */
+		a9pll: arm_clk at 19000000 {
+			compatible = "brcm,iproc-arm-a9pll";
+			reg = <0x19000000 0x1000>;
+			#clock-cells = <0>;
+			clocks = <&osc>;
+		};
+
+		periph_clk: periph_clk at 19000000 {
+			compatible = "brcm,iproc-arm-ch";
+			reg = <0x19000000 0x1000>;
+			#clock-cells = <0>;
+			clocks = <&a9pll>;
+			channel = <3>;
+		};
+
+		apb0_free: apb0_free at 19000000 {
+			compatible = "brcm,iproc-arm-ch";
+			reg = <0x19000000 0x1000>;
+			#clock-cells = <0>;
+			clocks = <&a9pll>;
+			channel = <0>;
+		};
+
+		arm_switch: arm_switch at 19000000 {
+			compatible = "brcm,iproc-arm-ch";
+			reg = <0x19000000 0x1000>;
+			#clock-cells = <0>;
+			clocks = <&a9pll>;
+			channel = <1>;
+		};
+
+		apb_clk: apb_clk at 19000000 {
+			compatible = "brcm,iproc-arm-ch";
+			reg = <0x19000000 0x1000>;
+			#clock-cells = <0>;
+			clocks = <&a9pll>;
+			channel = <2>;
+		};
+
+		/*
+		 * Clocks derived from oscillator.
+		 */
+		keypad_clk: keypad_clk at 0301D048 {
+			compatible = "brcm,cygnus-osc-derived";
+			reg = <0x0301D048 0x4>,
+				  <0x180AA024 0x4>;
+			#clock-cells = <0>;
+			clocks = <&osc>;
+			channel = <0>;
+			div = <392>;
+		};
+
+		adc_clk: adc_clk at 0301D04C {
+			compatible = "brcm,cygnus-osc-derived";
+			reg = <0x0301D04C 0x4>,
+				  <0x180AA024 0x4>;
+			#clock-cells = <0>;
+			clocks = <&osc>;
+			channel = <1>;
+		};
+
+		pwm_clk: pwm_clk at 0301D050 {
+			compatible = "brcm,cygnus-osc-derived";
+			reg = <0x0301D050 0x4>,
+				  <0x180AA024 0x4>;
+			#clock-cells = <0>;
+			clocks = <&osc>;
+			channel = <2>;
+		};
+
+		mipipll: mipipll at 180a9800 {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-mipipll-clk";
+			reg = <0x180a9800 0x2c>,
+				  top_clk_gating_ctrl: <0x180AA024 0x4>,
+				  crmu_pll_aon_ctrl: <0x0301C020 0x4>;
+			clocks = <&osc>;
+		};
+
+		lcd_clk: mipipll_ch1 at 180a9800 {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-mipipll-ch";
+			reg = <0x180a9800 0x2c>,
+				  <0x180AA024 0x4>;
+			clocks = <&mipipll>;
+			channel = <1>;
+		};
+	};
+
+	amba {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,amba-bus", "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		wdt at 18009000 {
+			 compatible = "arm,sp805" , "arm,primecell";
+			 reg = <0x18009000 0x1000>;
+			 interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			 clocks = <&axi81_clk>;
+			 clock-names = "apb_pclk";
+		};
+	};
+
+	uart3: serial at 18023000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x18023000 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <100000000>;
+		clocks = <&axi81_clk>;
+		status = "okay";
+	};
+
+	uart0: serial at 18020000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x18020000 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&axi81_clk>;
+		clock-frequency = <100000000>;
+		status = "okay";
+	};
+
+	gic: interrupt-controller at 19021000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x19021000 0x1000>,
+		      <0x19020100 0x100>;
+	};
+
+	L2: l2-cache {
+		compatible = "arm,pl310-cache";
+		reg = <0x19022000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
+	timer at 19020200 {
+		compatible = "arm,cortex-a9-global-timer";
+		reg = <0x19020200 0x100>;
+		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&periph_clk>;
+	};
+
+};
diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/bcm911360_entphn.dts
new file mode 100644
index 0000000..c5188d7
--- /dev/null
+++ b/arch/arm/boot/dts/bcm911360_entphn.dts
@@ -0,0 +1,22 @@
+/*
+ * Copyright 2014 Broadcom Corporation.  All rights reserved.
+ *
+ * Unless you and Broadcom execute a separate written software license
+ * agreement governing use of this software, this software is licensed to you
+ * under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+
+#include "bcm-cygnus.dtsi"
+
+/ {
+	model = "Cygnus Enterprise Phone (BCM911360_ENTPHN)";
+	compatible = "brcm,bcm11360", "brcm,cygnus";
+};
-- 
1.7.9.5
