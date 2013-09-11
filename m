From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 11 Sep 2013 10:34:09 +0200
Subject: [PATCH 1/3] ARM: socfpga: dts: Move common nodes to cyclone5 dtsi
In-Reply-To: <1378888451-28096-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1378888451-28096-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1378888451-28096-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current socfpga_cyclone5.dts describes the Altera Cyclone5 SoC Development
Kit. The Cyclone5 includes a SoCFPGA, which itself can be included in other
SoC+FPGA combinations.

Instead of having to describe all Cyclone5 common nodes in every board specific
dts, move socfpga_cyclone5.dts to a dtsi and include this in a new dts for the
Development Kit.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/Makefile                         |  2 +-
 ...{socfpga_cyclone5.dts => socfpga_cyclone5.dtsi} | 20 -----------
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       | 40 ++++++++++++++++++++++
 3 files changed, 41 insertions(+), 21 deletions(-)
 rename arch/arm/boot/dts/{socfpga_cyclone5.dts => socfpga_cyclone5.dtsi} (78%)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 69193be..79a1fa1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -211,7 +211,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a73a4-ape6evm-reference.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d-reference.dtb
-dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
+dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5_socdk.dtb \
 	socfpga_vt.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
 	spear1340-evb.dtb
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
similarity index 78%
rename from arch/arm/boot/dts/socfpga_cyclone5.dts
rename to arch/arm/boot/dts/socfpga_cyclone5.dtsi
index 973999d..a8716f6 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -19,26 +19,6 @@
 /include/ "socfpga.dtsi"
 
 / {
-	model = "Altera SOCFPGA Cyclone V";
-	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
-
-	chosen {
-		bootargs = "console=ttyS0,57600";
-	};
-
-	memory {
-		name = "memory";
-		device_type = "memory";
-		reg = <0x0 0x40000000>; /* 1GB */
-	};
-
-	aliases {
-		/* this allow the ethaddr uboot environmnet variable contents
-		 * to be added to the gmac1 device tree blob.
-		 */
-		ethernet0 = &gmac1;
-	};
-
 	soc {
 		clkmgr at ffd04000 {
 			clocks {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
new file mode 100644
index 0000000..0ea6399
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -0,0 +1,40 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation <www.altera.com>
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/include/ "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "Altera SOCFPGA Cyclone V SoC Development Kit";
+	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+
+	chosen {
+		bootargs = "console=ttyS0,57600";
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x40000000>; /* 1GB */
+	};
+
+	aliases {
+		/* this allow the ethaddr uboot environmnet variable contents
+		 * to be added to the gmac1 device tree blob.
+		 */
+		ethernet0 = &gmac1;
+	};
+};
-- 
1.8.4.rc3
