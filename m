From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 15 Apr 2014 09:56:32 +0200
Subject: [PATCH v3 4/4] ARM: socfpga: dts: add reset-controller
In-Reply-To: <1397548592-6384-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1397548592-6384-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1397548592-6384-4-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary #reset-cells property to the rst-mgr node and
provide a header-file with all possible resets specified.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi           |  8 ++-
 include/dt-bindings/reset/altr,rst-mgr.h | 90 ++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr.h

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 1f71e96..027d2c6 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -16,6 +16,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/reset/altr,rst-mgr.h>
 
 / {
 	#address-cells = <1>;
@@ -456,6 +457,8 @@
 			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
 			clocks = <&emac0_clk>;
 			clock-names = "stmmaceth";
+			resets = <&rst EMAC0_RESET>;
+			reset-names = "stmmaceth";
 			status = "disabled";
 		};
 
@@ -467,6 +470,8 @@
 			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
 			clocks = <&emac1_clk>;
 			clock-names = "stmmaceth";
+			resets = <&rst EMAC1_RESET>;
+			reset-names = "stmmaceth";
 			status = "disabled";
 		};
 
@@ -584,7 +589,8 @@
 			reg-io-width = <4>;
 		};
 
-		rstmgr at ffd05000 {
+		rst: rstmgr at ffd05000 {
+			#reset-cells = <1>;
 			compatible = "altr,rst-mgr";
 			reg = <0xffd05000 0x1000>;
 		};
diff --git a/include/dt-bindings/reset/altr,rst-mgr.h b/include/dt-bindings/reset/altr,rst-mgr.h
new file mode 100644
index 0000000..3f04908
--- /dev/null
+++ b/include/dt-bindings/reset/altr,rst-mgr.h
@@ -0,0 +1,90 @@
+/*
+ * Copyright (c) 2014, Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_RESET_ALTR_RST_MGR_H
+#define _DT_BINDINGS_RESET_ALTR_RST_MGR_H
+
+/* MPUMODRST */
+#define CPU0_RESET		0
+#define CPU1_RESET		1
+#define WDS_RESET		2
+#define SCUPER_RESET		3
+#define L2_RESET		4
+
+/* PERMODRST */
+#define EMAC0_RESET		32
+#define EMAC1_RESET		33
+#define USB0_RESET		34
+#define USB1_RESET		35
+#define NAND_RESET		36
+#define QSPI_RESET		37
+#define L4WD0_RESET		38
+#define L4WD1_RESET		39
+#define OSC1TIMER0_RESET	40
+#define OSC1TIMER1_RESET	41
+#define SPTIMER0_RESET		42
+#define SPTIMER1_RESET		43
+#define I2C0_RESET		44
+#define I2C1_RESET		45
+#define I2C2_RESET		46
+#define I2C3_RESET		47
+#define UART0_RESET		48
+#define UART1_RESET		49
+#define SPIM0_RESET		50
+#define SPIM1_RESET		51
+#define SPIS0_RESET		52
+#define SPIS1_RESET		53
+#define SDMMC_RESET		54
+#define CAN0_RESET		55
+#define CAN1_RESET		56
+#define GPIO0_RESET		57
+#define GPIO1_RESET		58
+#define GPIO2_RESET		59
+#define DMA_RESET		60
+#define SDR_RESET		61
+
+/* PER2MODRST */
+#define DMAIF0_RESET		64
+#define DMAIF1_RESET		65
+#define DMAIF2_RESET		66
+#define DMAIF3_RESET		67
+#define DMAIF4_RESET		68
+#define DMAIF5_RESET		69
+#define DMAIF6_RESET		70
+#define DMAIF7_RESET		71
+
+/* BRGMODRST */
+#define HPS2FPGA_RESET		96
+#define LWHPS2FPGA_RESET	97
+#define FPGA2HPS_RESET		98
+
+/* MISCMODRST*/
+#define ROM_RESET		128
+#define OCRAM_RESET		129
+#define SYSMGR_RESET		130
+#define SYSMGRCOLD_RESET	131
+#define FPGAMGR_RESET		132
+#define ACPIDMAP_RESET		133
+#define S2F_RESET		134
+#define S2FCOLD_RESET		135
+#define NRSTPIN_RESET		136
+#define TIMESTAMPCOLD_RESET	137
+#define CLKMGRCOLD_RESET	138
+#define SCANMGR_RESET		139
+#define FRZCTRLCOLD_RESET	140
+#define SYSDBG_RESET		141
+#define DBG_RESET		142
+#define TAPCOLD_RESET		143
+#define SDRCOLD_RESET		144
+
+#endif
-- 
1.9.1
