From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 31 Jul 2015 00:24:23 +0200
Subject: [PATCH 5/9] ARM: dts: lpc4357-ea4357: add emc pins and static memory
 devices
In-Reply-To: <1438295067-24407-1-git-send-email-manabian@gmail.com>
References: <1438295067-24407-1-git-send-email-manabian@gmail.com>
Message-ID: <1438295067-24407-6-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup the emc pins used by external memory devices and add
configuration for the devices found on the EA4357 devkit.

The EA4357 devkit has a NOR Flash attached to chip select 0
and a D-type flip-flop used for LEDs on chip select 2.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 164 ++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index 9ac096746360..7768d724c379 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -88,6 +88,110 @@
 };
 
 &pinctrl {
+	emc_pins: emc-pins {
+		emc_addr0_23_cfg {
+			pins =	"p2_9",  "p2_10", "p2_11", "p2_12",
+				"p2_13", "p1_0",  "p1_1",  "p1_2",
+				"p2_8",  "p2_7",  "p2_6",  "p2_2",
+				"p2_1",  "p2_0",  "p6_8",  "p6_7",
+				"pd_16", "pd_15", "pe_0",  "pe_1",
+				"pe_2",  "pe_3",  "pe_4",  "pa_4";
+			function = "emc";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		emc_data0_31_cfg {
+			pins =	"p1_7",  "p1_8",  "p1_9",  "p1_10",
+				"p1_11", "p1_12", "p1_13", "p1_14",
+				"p5_4",  "p5_5",  "p5_6",  "p5_7",
+				"p5_0",  "p5_1",  "p5_2",  "p5_3",
+				"pd_2",  "pd_3",  "pd_4",  "pd_5",
+				"pd_6",  "pd_7",  "pd_8",  "pd_9",
+				"pe_5",  "pe_6",  "pe_7",  "pe_8",
+				"pe_9",  "pe_10", "pe_11", "pe_12";
+			function = "emc";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		emc_we_oe_cfg {
+			pins = "p1_6", "p1_3";
+			function = "emc";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		emc_bls0_3_cfg {
+			pins = "p1_4", "p6_6", "pd_13", "pd_10";
+			function = "emc";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		emc_cs0_3_cfg {
+			pins = "p1_5", "p6_3", "pd_12", "pd_11";
+			function = "emc";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		emc_sdram_dqm0_3_cfg {
+			pins = "p6_12", "p6_10", "pd_0", "pe_13";
+			function = "emc";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		emc_sdram_ras_cas_cfg {
+			pins = "p6_5", "p6_4";
+			function = "emc";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		emc_sdram_dycs0_cfg {
+			pins = "p6_9";
+			function = "emc";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		emc_sdram_cke_cfg {
+			pins = "p6_11";
+			function = "emc";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		emc_sdram_clock_cfg {
+			pins = "clk0", "clk1", "clk2", "clk3";
+			function = "emc";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+	};
+
 	enet_rmii_pins: enet-rmii-pins {
 		enet_rmii_rxd_cfg {
 			pins = "p1_15", "p0_0";
@@ -237,6 +341,66 @@
 	};
 };
 
+&emc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&emc_pins>;
+
+	cs0 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		mpmc,cs = <0>;
+		mpmc,memory-width = <16>;
+		mpmc,byte-lane-low;
+		mpmc,write-enable-delay = <0>;
+		mpmc,output-enable-delay = <0>;
+		mpmc,read-access-delay = <70>;
+		mpmc,page-mode-read-delay = <70>;
+
+		flash at 0,0 {
+			compatible = "sst,sst39vf320", "cfi-flash";
+			reg = <0 0 0x400000>;
+			bank-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "bootloader";
+				reg = <0x000000 0x040000>; /* 256 KiB */
+			};
+
+			partition at 1 {
+				label = "kernel";
+				reg = <0x040000 0x2c0000>; /* 2.75 MiB */
+			};
+
+			partition at 2 {
+				label = "rootfs";
+				reg = <0x300000 0x100000>; /* 1 MiB */
+			};
+		};
+	};
+
+	cs2 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		mpmc,cs = <2>;
+		mpmc,memory-width = <16>;
+
+		mmio_leds: gpio at 2,0 {
+			compatible = "ti,7416374";
+			reg = <2 0 0x2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+	};
+};
+
 &enet_tx_clk {
 	clock-frequency = <50000000>;
 };
-- 
1.8.0
