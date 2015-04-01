From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Wed, 1 Apr 2015 17:17:35 +0530
Subject: [RESEND PATCH 5/8] dts/ls2085a: Update DTSI to add support of various
 peripherals
In-Reply-To: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1427888858-29636-6-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the LS2085a DTSI (DTS Include) file to add
support for various peripherals supported by FSL LS2085a SoC, for e.g.:
	- USB 3.0 Host
	- PMU
	- Watchdog
	- SPI
	- etc.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
Signed-off-by: Alison Wang <alison.wang@freescale.com>
Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Haikun Wang <b53464@freescale.com>
Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi |  523 +++++++++++++++++++++++-
 1 file changed, 520 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
index e281ceb..2c2418f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
@@ -1,7 +1,7 @@
 /*
  * Device Tree Include file for Freescale Layerscape-2085A family SoC.
  *
- * Copyright (C) 2014, Freescale Semiconductor
+ * Copyright (C) 2014-15, Freescale Semiconductor
  *
  * Bhupesh Sharma <bhupesh.sharma@freescale.com>
  *
@@ -122,13 +122,129 @@
 		      /* DRAM space - 1, size : 2 GB DRAM */
 	};
 
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <1 7 0x8>; /* PMU PPI, Level low type */
+	};
+
 	gic: interrupt-controller at 6000000 {
 		compatible = "arm,gic-v3";
 		reg = <0x0 0x06000000 0 0x10000>, /* GIC Dist */
 		      <0x0 0x06100000 0 0x100000>; /* GICR (RD_base + SGI_base) */
 		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
 		interrupt-controller;
 		interrupts = <1 9 0x4>;
+
+		its: gic-its at 6020000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0x6020000 0 0x20000>;
+		};
+	};
+
+	clockgen: clocking at 1300000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x1300000 0xa0000>;
+
+		sysclk: sysclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <100000000>;
+			clock-output-names = "sysclk";
+		};
+
+		cga_pll1: pll at 80 {
+			compatible = "fsl,qoriq-core-pll-3.0";
+			#clock-cells = <1>;
+			reg = <0x80 0x10>;
+			clocks = <&sysclk>;
+			clock-output-names = "cga-pll1", "cga-pll1-div2",
+					     "cga-pll1-div3", "cga-pll1-div4";
+		};
+
+		cga_pll2: pll at a00 {
+			compatible = "fsl,qoriq-core-pll-3.0";
+			#clock-cells = <1>;
+			reg = <0xa0 0x10>;
+			clocks = <&sysclk>;
+			clock-output-names = "cga-pll2", "cga-pll2-div2",
+					     "cga-pll2-div3", "cga-pll2-div4";
+		};
+
+		cgb_pll1: pll at 10080 {
+			compatible = "fsl,qoriq-core-pll-3.0";
+			#clock-cells = <1>;
+			reg = <0x10080 0x10>;
+			clocks = <&sysclk>;
+			clock-output-names = "cgb-pll1", "cgb-pll1-div2",
+					     "cgb-pll1-div3", "cgb-pll1-div4";
+		};
+
+		cgb_pll2: pll at 100a0 {
+			compatible = "fsl,qoriq-core-pll-3.0";
+			#clock-cells = <1>;
+			reg = <0x100a0 0x10>;
+			clocks = <&sysclk>;
+			clock-output-names = "cgb-pll2", "cgb-pll2-div2",
+					     "cgb-pll2-div3", "cgb-pll2-div4";
+		};
+
+		platform_clk: pll at 60080 {
+			compatible = "fsl,qoriq-core-pll-3.0";
+			#clock-cells = <1>;
+			reg = <0x60080 0x10>;
+			clocks = <&sysclk>;
+			clock-output-names = "platform-clk",
+					     "platform-clk-div2";
+		};
+
+		cluster1_clk: clk0c0 at 70000 {
+			compatible = "fsl,qoriq-core-mux-3.0";
+			#clock-cells = <0>;
+			reg = <0x70000 0x10>;
+			clock-names = "pll1cga", "pll1cga-div2", "pll1cga-div4",
+				      "pll2cga", "pll2cga-div2", "pll2cga-div4";
+			clocks = <&cga_pll1 0>, <&cga_pll1 1>, <&cga_pll1 2>,
+				 <&cga_pll2 0>, <&cga_pll2 1>, <&cga_pll2 2>;
+			clock-output-names = "cluster1-clk";
+		};
+
+		cluster2_clk: clk0c0 at 70020 {
+			compatible = "fsl,qoriq-core-mux-3.0";
+			#clock-cells = <0>;
+			reg = <0x70020 0x10>;
+			clock-names = "pll1cga", "pll1cga-div2", "pll1cga-div4",
+				      "pll2cga", "pll2cga-div2", "pll2cga-div4";
+			clocks = <&cga_pll1 0>, <&cga_pll1 1>, <&cga_pll1 2>,
+				 <&cga_pll2 0>, <&cga_pll2 1>, <&cga_pll2 2>;
+			clock-output-names = "cluster2-clk";
+		};
+
+		cluster3_clk: clk0c0 at 70040 {
+			compatible = "fsl,qoriq-core-mux-3.0";
+			#clock-cells = <0>;
+			reg = <0x70040 0x10>;
+			clock-names = "pll1cgb", "pll1cgb-div2", "pll1cgb-div4",
+				      "pll2cgb", "pll2cgb-div2", "pll2cgb-div4";
+			clocks = <&cgb_pll1 0>, <&cgb_pll1 1>, <&cgb_pll1 2>,
+				 <&cgb_pll2 0>, <&cgb_pll2 1>, <&cgb_pll2 2>;
+			clock-output-names = "cluster3-clk";
+		};
+
+		cluster4_clk: clk0c0 at 70060 {
+			compatible = "fsl,qoriq-core-mux-3.0";
+			#clock-cells = <0>;
+			reg = <0x70060 0x10>;
+			clock-names = "pll1cgb", "pll1cgb-div2", "pll1cgb-div4",
+				      "pll2cgb", "pll2cgb-div2", "pll2cgb-div4";
+			clocks = <&cgb_pll1 0>, <&cgb_pll1 1>, <&cgb_pll1 2>,
+				 <&cgb_pll2 0>, <&cgb_pll2 1>, <&cgb_pll2 2>;
+			clock-output-names = "cluster4-clk";
+		};
 	};
 
 	timer {
@@ -139,12 +255,83 @@
 			     <1 10 0x8>; /* Hypervisor PPI, active-low */
 	};
 
+	amba {
+		compatible = "arm,amba-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cluster1_core0_watchdog: wdt at c000000 {
+			compatible = "arm,primecell";
+			reg = <0x0 0xc000000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&platform_clk 1>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster1_core1_watchdog: wdt at c010000 {
+			compatible = "arm,primecell";
+			reg = <0x0 0xc010000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&platform_clk 1>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster2_core0_watchdog: wdt at c100000 {
+			compatible = "arm,primecell";
+			reg = <0x0 0xc100000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&platform_clk 1>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster2_core1_watchdog: wdt at c110000 {
+			compatible = "arm,primecell";
+			reg = <0x0 0xc110000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&platform_clk 1>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster3_core0_watchdog: wdt at c200000 {
+			compatible = "arm,primecell";
+			reg = <0x0 0xc200000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&platform_clk 1>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster3_core1_watchdog: wdt at c210000 {
+			compatible = "arm,primecell";
+			reg = <0x0 0xc210000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&platform_clk 1>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster4_core0_watchdog: wdt at c300000 {
+			compatible = "arm,primecell";
+			reg = <0x0 0xc300000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&platform_clk 1>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster4_core1_watchdog: wdt at c310000 {
+			compatible = "arm,primecell";
+			reg = <0x0 0xc310000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&platform_clk 1>;
+			clock-names = "apb_pclk";
+		};
+	};
+
 	serial0: serial at 21c0500 {
 		device_type = "serial";
 		compatible = "fsl,ns16550", "ns16550a";
 		reg = <0x0 0x21c0500 0x0 0x100>;
 		clock-frequency = <0>;	/* Updated by bootloader */
-		interrupts = <0 32 0x1>; /* edge triggered */
+		interrupts = <0 32 0x4>; /* Level high type */
 	};
 
 	serial1: serial at 21c0600 {
@@ -152,12 +339,342 @@
 		compatible = "fsl,ns16550", "ns16550a";
 		reg = <0x0 0x21c0600 0x0 0x100>;
 		clock-frequency = <0>; 	/* Updated by bootloader */
-		interrupts = <0 32 0x1>; /* edge triggered */
+		interrupts = <0 32 0x4>; /* Level high type */
 	};
 
 	fsl_mc: fsl-mc at 80c000000 {
 		compatible = "fsl,qoriq-mc";
+		#stream-id-cells = <2>;
 		reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
 		      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
+		lpi-parent = <&its>;
+	};
+
+	smmu: iommu at 5000000 {
+		compatible = "arm,mmu-500";
+		reg = <0 0x5000000 0 0x800000>;
+		#global-interrupts = <12>;
+		interrupts = <0 13 4>, /* global secure fault */
+			     <0 14 4>, /* combined secure interrupt */
+			     <0 15 4>, /* global non-secure fault */
+			     <0 16 4>, /* combined non-secure interrupt */
+			/* performance counter interrupts 0-7 */
+			     <0 211 4>,
+			     <0 212 4>,
+			     <0 213 4>,
+			     <0 214 4>,
+			     <0 215 4>,
+			     <0 216 4>,
+			     <0 217 4>,
+			     <0 218 4>,
+			/* per context interrupt, 64 interrupts */
+			     <0 146 4>,
+			     <0 147 4>,
+			     <0 148 4>,
+			     <0 149 4>,
+			     <0 150 4>,
+			     <0 151 4>,
+			     <0 152 4>,
+			     <0 153 4>,
+			     <0 154 4>,
+			     <0 155 4>,
+			     <0 156 4>,
+			     <0 157 4>,
+			     <0 158 4>,
+			     <0 159 4>,
+			     <0 160 4>,
+			     <0 161 4>,
+			     <0 162 4>,
+			     <0 163 4>,
+			     <0 164 4>,
+			     <0 165 4>,
+			     <0 166 4>,
+			     <0 167 4>,
+			     <0 168 4>,
+			     <0 169 4>,
+			     <0 170 4>,
+			     <0 171 4>,
+			     <0 172 4>,
+			     <0 173 4>,
+			     <0 174 4>,
+			     <0 175 4>,
+			     <0 176 4>,
+			     <0 177 4>,
+			     <0 178 4>,
+			     <0 179 4>,
+			     <0 180 4>,
+			     <0 181 4>,
+			     <0 182 4>,
+			     <0 183 4>,
+			     <0 184 4>,
+			     <0 185 4>,
+			     <0 186 4>,
+			     <0 187 4>,
+			     <0 188 4>,
+			     <0 189 4>,
+			     <0 190 4>,
+			     <0 191 4>,
+			     <0 192 4>,
+			     <0 193 4>,
+			     <0 194 4>,
+			     <0 195 4>,
+			     <0 196 4>,
+			     <0 197 4>,
+			     <0 198 4>,
+			     <0 199 4>,
+			     <0 200 4>,
+			     <0 201 4>,
+			     <0 202 4>,
+			     <0 203 4>,
+			     <0 204 4>,
+			     <0 205 4>,
+			     <0 206 4>,
+			     <0 207 4>,
+			     <0 208 4>,
+			     <0 209 4>;
+		mmu-masters = <&fsl_mc 0x300 0>;
+	};
+
+	dspi: dspi at 2100000 {
+		compatible = "fsl,vf610-dspi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x0 0x2100000 0x0 0x10000>;
+		interrupts = <0 26 0x4>; /* Level high type */
+		tcfq-mode;
+		clocks = <&platform_clk 1>;
+		clock-names = "dspi";
+		spi-num-chipselects = <5>;
+		bus-num = <0>;
+		spi-cpol;
+		spi-cpha;
+	};
+
+	esdhc: esdhc at 2140000 {
+		compatible = "fsl,ls2085a-esdhc", "fsl,esdhc";
+		reg = <0x0 0x2140000 0x0 0x10000>;
+		interrupts = <0 28 0x4>; /* Level high type */
+		clock-frequency = <0>;
+		voltage-ranges = <1800 1800 3300 3300>;
+		sdhci,auto-cmd12;
+		little-endian;
+		bus-width = <4>;
+	};
+
+	ftm0: ftm0 at 2800000 {
+		compatible = "fsl,ftm-alarm";
+		reg = <0x0 0x2800000 0x0 0x10000>;
+		interrupts = <0 44 4>;
+	};
+
+	gpio0: gpio at 2300000 {
+		compatible = "fsl,ls2085a-gpio";
+		reg = <0x0 0x2300000 0x0 0x10000>;
+		interrupts = <0 36 0x4>; /* Level high type */
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpio1: gpio at 2310000 {
+		compatible = "fsl,ls2085a-gpio";
+		reg = <0x0 0x2310000 0x0 0x10000>;
+		interrupts = <0 36 0x4>; /* Level high type */
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpio2: gpio at 2320000 {
+		compatible = "fsl,ls2085a-gpio";
+		reg = <0x0 0x2320000 0x0 0x10000>;
+		interrupts = <0 37 0x4>; /* Level high type */
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpio3: gpio at 2330000 {
+		compatible = "fsl,ls2085a-gpio";
+		reg = <0x0 0x2330000 0x0 0x10000>;
+		interrupts = <0 37 0x4>; /* Level high type */
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	i2c0: i2c at 2000000 {
+		compatible = "fsl,vf610-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x0 0x2000000 0x0 0x10000>;
+		interrupts = <0 34 0x4>; /* Level high type */
+		clock-names = "i2c";
+		clocks = <&platform_clk 1>;
+	};
+
+	i2c1: i2c at 2010000 {
+		compatible = "fsl,vf610-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x0 0x2010000 0x0 0x10000>;
+		interrupts = <0 34 0x4>; /* Level high type */
+		clock-names = "i2c";
+		clocks = <&platform_clk 1>;
+	};
+
+	i2c2: i2c at 2020000 {
+		compatible = "fsl,vf610-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x0 0x2020000 0x0 0x10000>;
+		interrupts = <0 35 0x4>; /* Level high type */
+		clock-names = "i2c";
+		clocks = <&platform_clk 1>;
+	};
+
+	i2c3: i2c at 2030000 {
+		compatible = "fsl,vf610-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x0 0x2030000 0x0 0x10000>;
+		interrupts = <0 35 0x4>; /* Level high type */
+		clock-names = "i2c";
+		clocks = <&platform_clk 1>;
+	};
+
+	ifc: ifc at 2240000 {
+		compatible = "fsl,ifc", "simple-bus";
+		reg = <0x0 0x2240000 0x0 0x20000>;
+		interrupts = <0 21 0x4>; /* Level high type */
+		little-endian;
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		ranges = <0 0 0x5 0x80000000 0x08000000
+			  2 0 0x5 0x30000000 0x00010000
+			  3 0 0x5 0x20000000 0x00010000>;
+	};
+
+	qspi: quadspi at 20c0000 {
+		compatible = "fsl,vf610-qspi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x0 0x20c0000 0x0 0x10000>,
+		      <0x0 0x20000000 0x0 0x10000000>;
+		reg-names = "QuadSPI", "QuadSPI-memory";
+		interrupts = <0 25 0x4>; /* Level high type */
+		clocks = <&platform_clk 1>, <&platform_clk 1>;
+		clock-names = "qspi_en", "qspi";
+	};
+
+	pcie at 3400000 {
+		compatible = "fsl,ls2085a-pcie", "snps,dw-pcie";
+		reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+		       0x10 0x00000000 0x0 0x00002000>; /* configuration space */
+		reg-names = "regs", "config";
+		interrupts = <0 108 0x4>; /* Level high type */
+		interrupt-names = "intr";
+		num-atus = <6>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <4>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x81000000 0x0 0x00000000 0x10 0x00010000 0x0 0x00010000   /* downstream I/O */
+			  0x82000000 0x0 0x40000000 0x10 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0000 0 0 1 &gic 0 0 0 109 4>,
+				<0000 0 0 2 &gic 0 0 0 110 4>,
+				<0000 0 0 3 &gic 0 0 0 111 4>,
+				<0000 0 0 4 &gic 0 0 0 112 4>;
+	};
+
+	pcie at 3500000 {
+		compatible = "fsl,ls2085a-pcie", "snps,dw-pcie";
+		reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
+		       0x12 0x00000000 0x0 0x00002000>; /* configuration space */
+		reg-names = "regs", "config";
+		interrupts = <0 113 0x4>; /* Level high type */
+		interrupt-names = "intr";
+		num-atus = <6>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <2>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x81000000 0x0 0x00000000 0x12 0x00010000 0x0 0x00010000   /* downstream I/O */
+			  0x82000000 0x0 0x40000000 0x12 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0000 0 0 1 &gic 0 0 0 114 4>,
+				<0000 0 0 2 &gic 0 0 0 115 4>,
+				<0000 0 0 3 &gic 0 0 0 116 4>,
+				<0000 0 0 4 &gic 0 0 0 117 4>;
+	};
+
+	pcie at 3600000 {
+		compatible = "fsl,ls2085a-pcie", "snps,dw-pcie";
+		reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
+		       0x14 0x00000000 0x0 0x00002000>; /* configuration space */
+		reg-names = "regs", "config";
+		interrupts = <0 118 0x4>; /* Level high type */
+		interrupt-names = "intr";
+		num-atus = <6>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <4>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x81000000 0x0 0x00000000 0x14 0x00010000 0x0 0x00010000   /* downstream I/O */
+			  0x82000000 0x0 0x40000000 0x14 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0000 0 0 1 &gic 0 0 0 119 4>,
+				<0000 0 0 2 &gic 0 0 0 120 4>,
+				<0000 0 0 3 &gic 0 0 0 121 4>,
+				<0000 0 0 4 &gic 0 0 0 122 4>;
+	};
+
+	pcie at 3700000 {
+		compatible = "fsl,ls2085a-pcie", "snps,dw-pcie";
+		reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
+		       0x16 0x00000000 0x0 0x00002000>; /* configuration space */
+		reg-names = "regs", "config";
+		interrupts = <0 123 0x4>; /* Level high type */
+		interrupt-names = "intr";
+		num-atus = <6>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <2>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x81000000 0x0 0x00000000 0x16 0x00010000 0x0 0x00010000   /* downstream I/O */
+			  0x82000000 0x0 0x40000000 0x16 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0000 0 0 1 &gic 0 0 0 124 4>,
+				<0000 0 0 2 &gic 0 0 0 125 4>,
+				<0000 0 0 3 &gic 0 0 0 126 4>,
+				<0000 0 0 4 &gic 0 0 0 127 4>;
+	};
+
+	usb0: usb3 at 3100000 {
+		compatible = "snps,dwc3";
+		reg = <0x0 0x3100000 0x0 0x10000>;
+		interrupts = <0 80 0x4>; /* Level high type */
+		dr_mode = "host";
+	};
+
+	usb1: usb3 at 3110000 {
+		compatible = "snps,dwc3";
+		reg = <0x0 0x3110000 0x0 0x10000>;
+		interrupts = <0 81 0x4>; /* Level high type */
+		dr_mode = "host";
 	};
 };
-- 
1.7.9.5
