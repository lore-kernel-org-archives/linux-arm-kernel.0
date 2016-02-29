From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 29 Feb 2016 15:43:55 +0000
Subject: [PATCH 1/8] clk: bcm2835: documenentation: add graphiz bcm2835 clock
 tree
In-Reply-To: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
References: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456760642-2412-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add a graphviz description of the bcm2835 clock tree
(at least as far as it is known right now).

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 Documentation/clk/bcrm,bcm2835-clock-tree.dot |  350 +++++++++++++++++++++++++
 1 file changed, 350 insertions(+)
 create mode 100644 Documentation/clk/bcrm,bcm2835-clock-tree.dot

diff --git a/Documentation/clk/bcrm,bcm2835-clock-tree.dot b/Documentation/clk/bcrm,bcm2835-clock-tree.dot
new file mode 100644
index 0000000..2a3282e
--- /dev/null
+++ b/Documentation/clk/bcrm,bcm2835-clock-tree.dot
@@ -0,0 +1,350 @@
+/*
+ * Copyright (C) 2016 Martin Sperl
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+digraph clocks {
+	rankdir=LR;
+
+	/* the basic clocks */
+	subgraph cluster_osc {
+		label = "Parent clocks";
+
+                "GND"
+                "OSC"
+	}
+
+	/* the generated test clocks */
+	subgraph cluster_clock_gen {
+		label = "generated clocks";
+
+                "testdebug0"
+                "testdebug1"
+	}
+
+	/* the PLLs and their divider */
+	subgraph cluster_pll {
+		label = "PLLs";
+
+		subgraph cluster_plla {
+			label = "PLLA";
+
+			OSC -> PLLA
+
+			PLLA -> PLLA_core
+			PLLA -> PLLA_per
+			PLLA -> PLLA_dsi0
+			PLLA -> PLLA_ccp2
+		}
+
+		subgraph cluster_pllb {
+			label = "PLLB";
+
+			OSC -> PLLB
+
+			PLLB -> PLLB_ARM
+			PLLB -> PLLB_SP0
+			PLLB -> PLLB_SP1
+			PLLB -> PLLB_SP2
+		}
+
+		subgraph cluster_pllc {
+			label = "PLLC";
+
+			OSC -> PLLC
+
+			PLLC -> PLLC_core0
+			PLLC -> PLLC_core1
+			PLLC -> PLLC_core2
+			PLLC -> PLLC_per
+		}
+
+		subgraph cluster_plld {
+			label = "PLLD";
+
+			OSC -> PLLD
+
+			PLLD -> PLLD_core
+			PLLD -> PLLD_per
+			PLLD -> PLLD_dsi0
+			PLLD -> PLLD_dsi1
+		}
+
+		subgraph cluster_pllh {
+			label = "PLLH";
+
+			OSC -> PLLH
+
+			PLLH -> PLLH_aux
+			PLLH -> PLLH_pix
+			PLLH -> PLLH_rcal
+		}
+	}
+
+	/* all the clock mux groups and the clocks that use them */
+	subgraph cluster_mux {
+		label = "clocks";
+
+		/* the vpu clocks and the common mux */
+		subgraph cluster_vpu_clocks {
+			label = "VPU-clocks";
+
+			/* the common mux for all vpu clocks */
+			subgraph cluster_vpu_mux {
+				label = "VPU-mux";
+
+				/* the mux name/id */
+				vGND        [label="0: GND"]
+				vOSC        [label="1: OSC"]
+				vtestdebug0 [label="2: testdebug0"]
+				vtestdebug1 [label="3: testdebug1"]
+				vPLLA_core  [label="4: PLLA_core"]
+				vPLLC_core0 [label="5: PLLC_core0"]
+				vPLLD_core  [label="6: PLLD_core"]
+				vPLLH_aux   [label="7: PLLH_aux"]
+				vPLLC_core1 [label="8: PLLC_core1"]
+				vPLLC_core2 [label="9: PLLC_core2"]
+
+				GND        -> vGND        -> vpu_mux
+				OSC        -> vOSC        -> vpu_mux
+				testdebug0 -> vtestdebug0 -> vpu_mux
+				testdebug1 -> vtestdebug1 -> vpu_mux
+				PLLA_core  -> vPLLA_core  -> vpu_mux
+				PLLC_core0 -> vPLLC_core0 -> vpu_mux
+				PLLD_core  -> vPLLD_core  -> vpu_mux
+				PLLH_aux   -> vPLLH_aux   -> vpu_mux
+				PLLC_core1 -> vPLLC_core1 -> vpu_mux
+				PLLC_core2 -> vPLLC_core2 -> vpu_mux
+			}
+
+			/* the clocks that use the vpu clock domain */
+			vpu_mux -> vpu
+			vpu_mux -> v3d
+			vpu_mux -> isp
+			vpu_mux -> h264
+			vpu_mux -> sdram
+		}
+
+		/* the peripherial clocks */
+		subgraph cluster_per_clocks {
+			label = "Periperial-clocks";
+
+			/* the common mux for all periperal clocks */
+			subgraph cluster_per_mux {
+				label = "Periperal-mux";
+				pGND        [label="0: GND"]
+				pOSC        [label="1: OSC"]
+				ptestdebug0 [label="2: testdebug0"]
+				ptestdebug1 [label="3: testdebug1"]
+				pPLLA_per   [label="4: PLLA_per"]
+				pPLLC_per   [label="5: PLLC_per"]
+				pPLLD_per   [label="6: PLLD_per"]
+				pPLLH_aux   [label="7: PLLH_aux"]
+
+				GND        -> pGND        -> per_mux
+				OSC        -> pOSC        -> per_mux
+				testdebug0 -> ptestdebug0 -> per_mux
+				testdebug1 -> ptestdebug1 -> per_mux
+				PLLA_per   -> pPLLA_per   -> per_mux
+				PLLC_per   -> pPLLC_per   -> per_mux
+				PLLD_per   -> pPLLD_per   -> per_mux
+				PLLH_aux   -> pPLLH_aux   -> per_mux
+			}
+
+			/* the clocks that use the per clock domain */
+			per_mux -> vec
+			per_mux -> uart
+			per_mux -> hsm
+			per_mux -> emmc
+			per_mux -> pwm
+			per_mux -> pcm
+			per_mux -> aveo
+			per_mux -> cam0
+			per_mux -> cam1
+			per_mux -> dft
+			per_mux -> dpi
+			per_mux -> gp0
+			per_mux -> gp1
+			per_mux -> gp2
+			per_mux -> slim
+			per_mux -> smi
+		}
+
+		/* the osc clocks */
+		subgraph cluster_osc_clocks {
+			label = "osc-clocks";
+
+			/* the common mux for all osc clocks */
+			subgraph cluster_osc_mux {
+				label = "oscillator-mux";
+				oGND        [label="0: GND"]
+				oOSC        [label="1: OSC"]
+				otestdebug0 [label="2: testdebug0"]
+				otestdebug1 [label="3: testdebug1"]
+
+				GND        -> oGND        -> osc_mux
+				OSC        -> oOSC        -> osc_mux
+				testdebug0 -> otestdebug0 -> osc_mux
+				testdebug1 -> otestdebug1 -> osc_mux
+			}
+
+			/* the clocks that use the osc clock domain */
+			osc_mux -> tsens
+			osc_mux -> tec
+			osc_mux -> otp
+			osc_mux -> pulse
+			osc_mux -> timer
+		}
+
+		/* dsi0 related clocks */
+		subgraph cluster_dsi0_mux_clocks {
+			label = "dsi0 clocks";
+
+			/* the common mux for all dsi0 clocks */
+			subgraph cluster_dsi0_mux {
+				label = "dsi0-mux";
+
+				/* 16 possible parent clocks */
+				d0GND        [label="0: GND"]
+				d0OSC        [label="1: OSC"]
+				d0testdebug0 [label="2: testdebug0"]
+				d0testdebug1 [label="3: testdebug1"]
+				d0PLLA_dsi0  [label="x: PLLA_dsi0 - CM_DSI0HSCK_SELPLLD==0"]
+				d0PLLD_dsi0  [label="x: PLLD_dsi0 - CM_DSI0HSCK_SELPLLD==1"]
+				d0missing    [label="more parents"]
+
+				GND        -> d0GND        -> dsi0_mux
+				OSC        -> d0OSC        -> dsi0_mux
+				testdebug0 -> d0testdebug0 -> dsi0_mux
+				testdebug1 -> d0testdebug1 -> dsi0_mux
+				PLLA_dsi0  -> d0PLLA_dsi0  -> dsi0_mux
+				PLLD_dsi0  -> d0PLLD_dsi0  -> dsi0_mux
+				d0missing  -> dsi0_mux
+			}
+
+			dsi0_mux -> dsi0e
+			dsi0_mux -> dsi0pix
+		}
+
+		/* dsi1 related clocks */
+		subgraph cluster_dsi1_mux_clocks {
+			label = "dsi1 clocks";
+
+			/* the common mux for all dsi1 clocks */
+			subgraph cluster_dsi1_mux {
+				label = "dsi1-mux";
+
+				/* 16 possible parent clocks */
+				d1GND        [label="0: GND"]
+				d1OSC        [label="1: OSC"]
+				d1testdebug0 [label="2: testdebug0"]
+				d1testdebug1 [label="3: testdebug1"]
+				d1PLLD_dsi1  [label="x: PLLD_dsi1"]
+				d1missing    [label="more parents"]
+
+				GND        -> d1GND        -> dsi1_mux
+				OSC        -> d1OSC        -> dsi1_mux
+				testdebug0 -> d1testdebug0 -> dsi1_mux
+				testdebug1 -> d1testdebug1 -> dsi1_mux
+				PLLD_dsi1  -> d1PLLD_dsi1  -> dsi1_mux
+				d1missing  -> dsi1_mux
+			}
+
+			dsi1_mux -> dsi1e
+			dsi1_mux -> dsi1pix
+		}
+
+		/* ccp2 related clocks */
+		subgraph cluster_ccp2_mux_clocks {
+			label = "ccp2 clocks";
+
+			/* the common mux for all ccp2 clocks */
+			subgraph cluster_ccp2_mux {
+				label = "ccp2-mux";
+
+				/* 8 possible parent clocks */
+				cGND        [label="0: GND"]
+				cOSC        [label="1: OSC"]
+				ctestdebug0 [label="2: testdebug0"]
+				ctestdebug1 [label="3: testdebug1"]
+				cPLLA_ccp2  [label="x: PLLA_ccp2"]
+				cmissing    [label="more parents"]
+
+				GND        -> cGND        -> ccp2_mux
+				OSC        -> cOSC        -> ccp2_mux
+				testdebug0 -> ctestdebug0 -> ccp2_mux
+				testdebug1 -> ctestdebug1 -> ccp2_mux
+				PLLA_ccp2  -> cPLLA_ccp2  -> ccp2_mux
+				cmissing   -> ccp2_mux
+			}
+
+			ccp2_mux -> ccp2
+		}
+
+		/* clocks where we do not know the parents */
+		subgraph cluster_unknown_parent_mux_clocks {
+			label = "unknown parent mux clocks";
+
+			/* the common mux for all unknown clocks */
+			subgraph cluster_ukn_mux {
+				label = "unknown-mux";
+				uGND        [label="0: GND"]
+				uOSC        [label="1: OSC"]
+				utestdebug0 [label="2: testdebug0"]
+				utestdebug1 [label="3: testdebug1"]
+				umissing    [label="more parents"]
+
+				GND        -> uGND        -> ukn_mux
+				OSC        -> uOSC        -> ukn_mux
+				testdebug0 -> utestdebug0 -> ukn_mux
+				testdebug1 -> utestdebug1 -> ukn_mux
+				umissing   -> ukn_mux
+			}
+
+			/*
+			 * mux-clocks with 16 possible parent clocks
+			 * possibly related to testdebug0/1?
+			 */
+			ukn_mux -> td0 -> testdebug0
+			ukn_mux -> td1 -> testdebug1
+			ukn_mux -> tcnt
+			ukn_mux -> gnric /* dummy? - but it is marked RW */
+
+			/* mux-clock with 8 possible parent clocks */
+			ukn_parent -> pllt /* no enable - missing divider,
+					    * but with CM_PLLTCNT0-3
+					    * counters?
+					    */
+		}
+	}
+
+	/* auxiliar periperial clock gates */
+	subgraph cluster_aux_clocks {
+		label = "auxiliar-clock gates off the vpu";
+
+		vpu -> spi1
+		vpu -> spi2
+		vpu -> uart1
+	}
+
+	/* clock gates that require debug bit set in the power manager */
+	subgraph cluster_vpu_debug_clocks {
+		label = "vpu debug gate clocks";
+
+		vpu -> PM_DEBUG
+		/* no ENABLE bits */
+		PM_DEBUG -> peria
+		PM_DEBUG -> perii
+		PM_DEBUG -> sys
+	}
+
+}
-- 
1.7.10.4
