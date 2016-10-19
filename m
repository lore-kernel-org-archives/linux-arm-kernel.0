From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 19 Oct 2016 15:18:43 -0500
Subject: [PATCH 2/3] ARM: dts: socfpga: Enable QSPI in Arria10 devkit
In-Reply-To: <1476908324-12313-1-git-send-email-dinguyen@opensource.altera.com>
References: <1476908324-12313-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1476908324-12313-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Enable the QSPI node and add the flash chip.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/Makefile                       |    1 +
 arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts |   49 ++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7c5f0c3..081fd94 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -690,6 +690,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
+	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
 	socfpga_cyclone5_mcvevk.dtb \
 	socfpga_cyclone5_socdk.dtb \
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts
new file mode 100644
index 0000000..beb2fc6
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2016 Intel. All rights reserved.
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
+&qspi {
+	status = "okay";
+
+	flash0: n25q00 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q00aa";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <4>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partition at qspi-boot {
+			label = "Boot and fpga data";
+			reg = <0x0 0x2720000>;
+		};
+
+		partition at qspi-rootfs {
+			label = "Root Filesystem - JFFS2";
+			reg = <0x2720000 0x58E0000>;
+		};
+	};
+};
-- 
1.7.9.5
