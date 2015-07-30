From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 31 Jul 2015 00:24:27 +0200
Subject: [PATCH 9/9] ARM: dts: lpc4350-hitex-eval: add emc pins and static
 memory devices
In-Reply-To: <1438295067-24407-1-git-send-email-manabian@gmail.com>
References: <1438295067-24407-1-git-send-email-manabian@gmail.com>
Message-ID: <1438295067-24407-10-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup the emc pins used by external memory devices and add
configuration for the devices found on the Hitex eval board.

The Hitex eval board has a NOR Flash attached to chip select 0
and 512 kB of SRAM on chip select 2.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4350-hitex-eval.dts | 164 +++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4350-hitex-eval.dts b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
index 1150052731af..32bc7ff4eb2a 100644
--- a/arch/arm/boot/dts/lpc4350-hitex-eval.dts
+++ b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
@@ -37,6 +37,106 @@
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
+		emc_data0_15_cfg {
+			pins =	"p1_7",  "p1_8",  "p1_9",  "p1_10",
+				"p1_11", "p1_12", "p1_13", "p1_14",
+				"p5_4",  "p5_5",  "p5_6",  "p5_7",
+				"p5_0",  "p5_1",  "p5_2",  "p5_3";
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
+		emc_cs0_cs2_cfg {
+			pins = "p1_5", "pd_12";
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
 	enet_mii_pins: enet-mii-pins {
 		enet_mii_rxd0_3_cfg {
 			pins = "p1_15", "p0_0", "p9_3", "p9_2";
@@ -103,6 +203,70 @@
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
+				reg = <0x040000 0x2C0000>; /* 2.75 MiB */
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
+		mpmc,byte-lane-low;
+		mpmc,write-enable-delay = <0>;
+		mpmc,output-enable-delay = <30>;
+		mpmc,read-access-delay = <90>;
+		mpmc,page-mode-read-delay = <55>;
+		mpmc,write-access-delay = <55>;
+		mpmc,turn-round-delay = <55>;
+
+		ext_sram: sram at 2,0 {
+			compatible = "mmio-sram";
+			reg = <2 0 0x80000>; /* 512 KiB SRAM on IS62WV25616 */
+		};
+	};
+};
+
 &enet_tx_clk {
 	clock-frequency = <25000000>;
 };
-- 
1.8.0
