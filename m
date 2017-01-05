From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu,  5 Jan 2017 06:16:44 -0600
Subject: [PATCHv2] ARM: dts: socfpga: Add NAND device tree for Arria10
Message-ID: <1483618604-24994-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graham Moore <grmoore@opensource.altera.com>

Add socfpga_arria10_socdk_nand.dts board file for supporting NAND.

Signed-off-by: Graham Moore <grmoore@opensource.altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: move nand dts node to socfpga_arria10.dtsi
---
 arch/arm/boot/dts/Makefile                       |  1 +
 arch/arm/boot/dts/socfpga_arria10.dtsi           | 13 ++++++++++
 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts | 31 ++++++++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cccdbcb..380d9bb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -717,6 +717,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
+	socfpga_arria10_socdk_nand.dtb \
 	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
 	socfpga_cyclone5_mcvevk.dtb \
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 3ceb4e4..1139d3b2 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -614,6 +614,19 @@
 			status = "disabled";
 		};
 
+		nand: nand at ffb90000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "denali,denali-nand-dt", "altr,socfpga-denali-nand";
+			reg = <0xffb90000 0x72000>,
+			      <0xffb80000 0x10000>;
+			reg-names = "nand_data", "denali_reg";
+			interrupts = <0 99 4>;
+			dma-mask = <0xffffffff>;
+			clocks = <&nand_clk>;
+			status = "disabled";
+		};
+
 		ocram: sram at ffe00000 {
 			compatible = "mmio-sram";
 			reg = <0xffe00000 0x40000>;
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
new file mode 100644
index 0000000..d14f9cc
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2015 Altera Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/dts-v1/;
+#include "socfpga_arria10_socdk.dtsi"
+
+&nand {
+	status = "okay";
+
+	partition at nand-boot {
+		label = "Boot and fpga data";
+		reg = <0x0 0x1C00000>;
+	};
+	partition at nand-rootfs {
+		label = "Root Filesystem - JFFS2";
+		reg = <0x1C00000 0x6400000>;
+	};
+};
-- 
2.7.4
