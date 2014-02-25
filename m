From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Feb 2014 16:50:33 -0500
Subject: [PATCH 2/4] ARM: dts: keystone: preparatory patch to support K2L and
 K2E SOCs
In-Reply-To: <1393365035-20083-1-git-send-email-santosh.shilimkar@ti.com>
References: <1393365035-20083-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1393365035-20083-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

Current keystone.dtsi includes SoC specific definitions for K2HK
SoCs. In order to support two addition keystone devices, k2 Edison
and K2 Lamarr and corresponding EVMs, This patch restructure the
dts files for the following:-

 - All clock nodes that are only available in k2hk SoC are moved
   from keystone-clocks.dtsi to a new k2hk-clocks.dtsi include file
 - The CPU nodes are now part of the soc specific k2hk.dtsi.
 - Change the compatibility string to ti,k2hk-evm and change
   the model name accordingly
 - Finally include k2hk-clocks.dtsi in k2hk.dtsi and that in
   k2hk-evm.dts

Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/k2hk-clocks.dtsi     |  426 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2hk-evm.dts         |    6 +-
 arch/arm/boot/dts/k2hk.dtsi            |   46 ++++
 arch/arm/boot/dts/keystone-clocks.dtsi |  405 ------------------------------
 arch/arm/boot/dts/keystone.dtsi        |   31 ---
 5 files changed, 476 insertions(+), 438 deletions(-)
 create mode 100644 arch/arm/boot/dts/k2hk-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/k2hk.dtsi

diff --git a/arch/arm/boot/dts/k2hk-clocks.dtsi b/arch/arm/boot/dts/k2hk-clocks.dtsi
new file mode 100644
index 0000000..4eed84f
--- /dev/null
+++ b/arch/arm/boot/dts/k2hk-clocks.dtsi
@@ -0,0 +1,426 @@
+/*
+ * Copyright 2013-2014 Texas Instruments, Inc.
+ *
+ * Keystone 2 Kepler/Hawking SoC clock nodes
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+clocks {
+	armpllclk: armpllclk at 2620370 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,pll-clock";
+		clocks = <&refclkarm>;
+		clock-output-names = "arm-pll-clk";
+		reg = <0x02620370 4>;
+		reg-names = "control";
+	};
+
+	mainpllclk: mainpllclk at 2310110 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,main-pll-clock";
+		clocks = <&refclksys>;
+		reg = <0x02620350 4>, <0x02310110 4>;
+		reg-names = "control", "multiplier";
+		fixed-postdiv = <2>;
+	};
+
+	papllclk: papllclk at 2620358 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,pll-clock";
+		clocks = <&refclkpass>;
+		clock-output-names = "pa-pll-clk";
+		reg = <0x02620358 4>;
+		reg-names = "control";
+	};
+
+	ddr3apllclk: ddr3apllclk at 2620360 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,pll-clock";
+		clocks = <&refclkddr3a>;
+		clock-output-names = "ddr-3a-pll-clk";
+		reg = <0x02620360 4>;
+		reg-names = "control";
+	};
+
+	ddr3bpllclk: ddr3bpllclk at 2620368 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,pll-clock";
+		clocks = <&refclkddr3b>;
+		clock-output-names = "ddr-3b-pll-clk";
+		reg = <0x02620368 4>;
+		reg-names = "control";
+	};
+
+	clktsip: clktsip {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk16>;
+		clock-output-names = "tsip";
+		reg = <0x0235000c 0xb00>, <0x02350000 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <0>;
+	};
+
+	clksrio: clksrio {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk1rstiso13>;
+		clock-output-names = "srio";
+		reg = <0x0235002c 0xb00>, <0x02350010 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <4>;
+	};
+
+	clkhyperlink0: clkhyperlink0 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk12>;
+		clock-output-names = "hyperlink-0";
+		reg = <0x02350030 0xb00>, <0x02350014 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <5>;
+	};
+
+	clkgem1: clkgem1 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem1";
+		reg = <0x02350040 0xb00>, <0x02350024 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <9>;
+	};
+
+	clkgem2: clkgem2 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem2";
+		reg = <0x02350044 0xb00>, <0x02350028 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <10>;
+	};
+
+	clkgem3: clkgem3 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem3";
+		reg = <0x02350048 0xb00>, <0x0235002c 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <11>;
+	};
+
+	clkgem4: clkgem4 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem4";
+		reg = <0x0235004c 0xb00>, <0x02350030 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <12>;
+	};
+
+	clkgem5: clkgem5 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem5";
+		reg = <0x02350050 0xb00>, <0x02350034 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <13>;
+	};
+
+	clkgem6: clkgem6 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem6";
+		reg = <0x02350054 0xb00>, <0x02350038 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <14>;
+	};
+
+	clkgem7: clkgem7 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem7";
+		reg = <0x02350058 0xb00>, <0x0235003c 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <15>;
+	};
+
+	clkddr31: clkddr31 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "ddr3-1";
+		reg = <0x02350060 0xb00>, <0x02350040 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <16>;
+	};
+
+	clktac: clktac {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "tac";
+		reg = <0x02350064 0xb00>, <0x02350044 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <17>;
+	};
+
+	clkrac01: clkrac01 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "rac-01";
+		reg = <0x02350068 0xb00>, <0x02350044 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <17>;
+	};
+
+	clkrac23: clkrac23 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "rac-23";
+		reg = <0x0235006c 0xb00>, <0x02350048 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <18>;
+	};
+
+	clkfftc0: clkfftc0 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "fftc-0";
+		reg = <0x02350070 0xb00>, <0x0235004c 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <19>;
+	};
+
+	clkfftc1: clkfftc1 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "fftc-1";
+		reg = <0x02350074 0xb00>, <0x023504c0 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <19>;
+	};
+
+	clkfftc2: clkfftc2 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "fftc-2";
+		reg = <0x02350078 0xb00>, <0x02350050 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <20>;
+	};
+
+	clkfftc3: clkfftc3 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "fftc-3";
+		reg = <0x0235007c 0xb00>, <0x02350050 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <20>;
+	};
+
+	clkfftc4: clkfftc4 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "fftc-4";
+		reg = <0x02350080 0xb00>, <0x02350050 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <20>;
+	};
+
+	clkfftc5: clkfftc5 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "fftc-5";
+		reg = <0x02350084 0xb00>, <0x02350050 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <20>;
+	};
+
+	clkaif: clkaif {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "aif";
+		reg = <0x02350088 0xb00>, <0x02350054 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <21>;
+	};
+
+	clktcp3d0: clktcp3d0 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "tcp3d-0";
+		reg = <0x0235008c 0xb00>, <0x02350058 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <22>;
+	};
+
+	clktcp3d1: clktcp3d1 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "tcp3d-1";
+		reg = <0x02350090 0xb00>, <0x02350058 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <22>;
+	};
+
+	clktcp3d2: clktcp3d2 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "tcp3d-2";
+		reg = <0x02350094 0xb00>, <0x0235005c 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <23>;
+	};
+
+	clktcp3d3: clktcp3d3 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "tcp3d-3";
+		reg = <0x02350098 0xb00>, <0x0235005c 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <23>;
+	};
+
+	clkvcp0: clkvcp0 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-0";
+		reg = <0x0235009c 0xb00>, <0x02350060 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <24>;
+	};
+
+	clkvcp1: clkvcp1 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-1";
+		reg = <0x023500a0 0xb00>, <0x02350060 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <24>;
+	};
+
+	clkvcp2: clkvcp2 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-2";
+		reg = <0x023500a4 0xb00>, <0x02350060 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <24>;
+	};
+
+	clkvcp3: clkvcp3 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-3";
+		reg = <0x0235000a8 0xb00>, <0x02350060 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <24>;
+	};
+
+	clkvcp4: clkvcp4 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-4";
+		reg = <0x023500ac 0xb00>, <0x02350064 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <25>;
+	};
+
+	clkvcp5: clkvcp5 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-5";
+		reg = <0x023500b0 0xb00>, <0x02350064 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <25>;
+	};
+
+	clkvcp6: clkvcp6 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-6";
+		reg = <0x023500b4 0xb00>, <0x02350064 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <25>;
+	};
+
+	clkvcp7: clkvcp7 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-7";
+		reg = <0x023500b8 0xb00>, <0x02350064 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <25>;
+	};
+
+	clkbcp: clkbcp {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "bcp";
+		reg = <0x023500bc 0xb00>, <0x02350068 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <26>;
+	};
+
+	clkdxb: clkdxb {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "dxb";
+		reg = <0x023500c0 0xb00>, <0x0235006c 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <27>;
+	};
+
+	clkhyperlink1: clkhyperlink1 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk12>;
+		clock-output-names = "hyperlink-1";
+		reg = <0x023500c4 0xb00>, <0x02350070 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <28>;
+	};
+
+	clkxge: clkxge {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "xge";
+		reg = <0x023500c8 0xb00>, <0x02350074 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <29>;
+	};
+};
diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index 1d8ea6e..d8cc99a 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2013 Texas Instruments, Inc.
+ * Copyright 2013-2014 Texas Instruments, Inc.
  *
  * Keystone 2 Kepler/Hawking EVM device tree
  *
@@ -10,9 +10,11 @@
 /dts-v1/;
 
 #include "keystone.dtsi"
+#include "k2hk.dtsi"
 
 / {
-	compatible =  "ti,keystone-evm";
+	compatible =  "ti,k2hk-evm";
+	model = "Texas Instruments Keystone 2 Kepler/Hawking EVM";
 
 	soc {
 		clocks {
diff --git a/arch/arm/boot/dts/k2hk.dtsi b/arch/arm/boot/dts/k2hk.dtsi
new file mode 100644
index 0000000..c73899c
--- /dev/null
+++ b/arch/arm/boot/dts/k2hk.dtsi
@@ -0,0 +1,46 @@
+/*
+ * Copyright 2013-2014 Texas Instruments, Inc.
+ *
+ * Keystone 2 Kepler/Hawking soc specific device tree
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		interrupt-parent = <&gic>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <1>;
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <2>;
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <3>;
+		};
+	};
+
+	soc {
+		/include/ "k2hk-clocks.dtsi"
+	};
+};
diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
index a3d1f3d..93f82c7 100644
--- a/arch/arm/boot/dts/keystone-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-clocks.dtsi
@@ -13,51 +13,6 @@ clocks {
 	#size-cells = <1>;
 	ranges;
 
-	mainpllclk: mainpllclk at 2310110 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,main-pll-clock";
-		clocks = <&refclksys>;
-		reg = <0x02620350 4>, <0x02310110 4>;
-		reg-names = "control", "multiplier";
-		fixed-postdiv = <2>;
-	};
-
-	papllclk: papllclk at 2620358 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkpass>;
-		clock-output-names = "pa-pll-clk";
-		reg = <0x02620358 4>;
-		reg-names = "control";
-	};
-
-	ddr3apllclk: ddr3apllclk at 2620360 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkddr3a>;
-		clock-output-names = "ddr-3a-pll-clk";
-		reg = <0x02620360 4>;
-		reg-names = "control";
-	};
-
-	ddr3bpllclk: ddr3bpllclk at 2620368 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkddr3b>;
-		clock-output-names = "ddr-3b-pll-clk";
-		reg = <0x02620368 4>;
-		reg-names = "control";
-	};
-
-	armpllclk: armpllclk at 2620370 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkarm>;
-		clock-output-names = "arm-pll-clk";
-		reg = <0x02620370 4>;
-		reg-names = "control";
-	};
-
 	mainmuxclk: mainmuxclk at 2310108 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-mux-clock";
@@ -297,26 +252,6 @@ clocks {
 		domain-id = <3>;
 	};
 
-	clksrio: clksrio {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1rstiso13>;
-		clock-output-names = "srio";
-		reg = <0x0235002c 0xb00>, <0x02350010 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <4>;
-	};
-
-	clkhyperlink0: clkhyperlink0 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk12>;
-		clock-output-names = "hyperlink-0";
-		reg = <0x02350030 0xb00>, <0x02350014 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <5>;
-	};
-
 	clksr: clksr {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
@@ -337,76 +272,6 @@ clocks {
 		domain-id = <8>;
 	};
 
-	clkgem1: clkgem1 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem1";
-		reg = <0x02350040 0xb00>, <0x02350024 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <9>;
-	};
-
-	clkgem2: clkgem2 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem2";
-		reg = <0x02350044 0xb00>, <0x02350028 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <10>;
-	};
-
-	clkgem3: clkgem3 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem3";
-		reg = <0x02350048 0xb00>, <0x0235002c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <11>;
-	};
-
-	clkgem4: clkgem4 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem4";
-		reg = <0x0235004c 0xb00>, <0x02350030 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <12>;
-	};
-
-	clkgem5: clkgem5 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem5";
-		reg = <0x02350050 0xb00>, <0x02350034 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <13>;
-	};
-
-	clkgem6: clkgem6 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem6";
-		reg = <0x02350054 0xb00>, <0x02350038 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <14>;
-	};
-
-	clkgem7: clkgem7 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem7";
-		reg = <0x02350058 0xb00>, <0x0235003c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <15>;
-	};
-
 	clkddr30: clkddr30 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
@@ -417,276 +282,6 @@ clocks {
 		domain-id = <16>;
 	};
 
-	clkddr31: clkddr31 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "ddr3-1";
-		reg = <0x02350060 0xb00>, <0x02350040 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <16>;
-	};
-
-	clktac: clktac {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tac";
-		reg = <0x02350064 0xb00>, <0x02350044 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <17>;
-	};
-
-	clkrac01: clktac01 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "rac-01";
-		reg = <0x02350068 0xb00>, <0x02350044 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <17>;
-	};
-
-	clkrac23: clktac23 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "rac-23";
-		reg = <0x0235006c 0xb00>, <0x02350048 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <18>;
-	};
-
-	clkfftc0: clkfftc0 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-0";
-		reg = <0x02350070 0xb00>, <0x0235004c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <19>;
-	};
-
-	clkfftc1: clkfftc1 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-1";
-		reg = <0x02350074 0xb00>, <0x023504c0 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <19>;
-	};
-
-	clkfftc2: clkfftc2 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-2";
-		reg = <0x02350078 0xb00>, <0x02350050 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <20>;
-	};
-
-	clkfftc3: clkfftc3 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-3";
-		reg = <0x0235007c 0xb00>, <0x02350050 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <20>;
-	};
-
-	clkfftc4: clkfftc4 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-4";
-		reg = <0x02350080 0xb00>, <0x02350050 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <20>;
-	};
-
-	clkfftc5: clkfftc5 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-5";
-		reg = <0x02350084 0xb00>, <0x02350050 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <20>;
-	};
-
-	clkaif: clkaif {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "aif";
-		reg = <0x02350088 0xb00>, <0x02350054 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <21>;
-	};
-
-	clktcp3d0: clktcp3d0 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tcp3d-0";
-		reg = <0x0235008c 0xb00>, <0x02350058 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <22>;
-	};
-
-	clktcp3d1: clktcp3d1 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tcp3d-1";
-		reg = <0x02350090 0xb00>, <0x02350058 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <22>;
-	};
-
-	clktcp3d2: clktcp3d2 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tcp3d-2";
-		reg = <0x02350094 0xb00>, <0x0235005c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <23>;
-	};
-
-	clktcp3d3: clktcp3d3 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tcp3d-3";
-		reg = <0x02350098 0xb00>, <0x0235005c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <23>;
-	};
-
-	clkvcp0: clkvcp0 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-0";
-		reg = <0x0235009c 0xb00>, <0x02350060 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <24>;
-	};
-
-	clkvcp1: clkvcp1 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-1";
-		reg = <0x023500a0 0xb00>, <0x02350060 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <24>;
-	};
-
-	clkvcp2: clkvcp2 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-2";
-		reg = <0x023500a4 0xb00>, <0x02350060 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <24>;
-	};
-
-	clkvcp3: clkvcp3 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-3";
-		reg = <0x0235000a8 0xb00>, <0x02350060 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <24>;
-	};
-
-	clkvcp4: clkvcp4 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-4";
-		reg = <0x023500ac 0xb00>, <0x02350064 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <25>;
-	};
-
-	clkvcp5: clkvcp5 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-5";
-		reg = <0x023500b0 0xb00>, <0x02350064 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <25>;
-	};
-
-	clkvcp6: clkvcp6 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-6";
-		reg = <0x023500b4 0xb00>, <0x02350064 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <25>;
-	};
-
-	clkvcp7: clkvcp7 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-7";
-		reg = <0x023500b8 0xb00>, <0x02350064 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <25>;
-	};
-
-	clkbcp: clkbcp {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "bcp";
-		reg = <0x023500bc 0xb00>, <0x02350068 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <26>;
-	};
-
-	clkdxb: clkdxb {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "dxb";
-		reg = <0x023500c0 0xb00>, <0x0235006c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <27>;
-	};
-
-	clkhyperlink1: clkhyperlink1 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk12>;
-		clock-output-names = "hyperlink-1";
-		reg = <0x023500c4 0xb00>, <0x02350070 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <28>;
-	};
-
-	clkxge: clkxge {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "xge";
-		reg = <0x023500c8 0xb00>, <0x02350074 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <29>;
-	};
-
 	clkwdtimer0: clkwdtimer0 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 4eceb46..1992351 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -25,37 +25,6 @@
 		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		interrupt-parent = <&gic>;
-
-		cpu at 0 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <0>;
-		};
-
-		cpu at 1 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <1>;
-		};
-
-		cpu at 2 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <2>;
-		};
-
-		cpu at 3 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <3>;
-		};
-	};
-
 	gic: interrupt-controller {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
-- 
1.7.9.5
