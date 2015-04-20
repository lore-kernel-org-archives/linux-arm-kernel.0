From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 20 Apr 2015 13:50:25 -0500
Subject: [PATCHv2 4/4] ARM: socfpga: rename socdk board file to socdk_sdmmc
In-Reply-To: <1429555825-23560-1-git-send-email-dinguyen@opensource.altera.com>
References: <1429555825-23560-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1429555825-23560-5-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Rename the socfpga_arria10_socdk board file to socfpga_arria10_socdk_sdmmc
as Arria 10 devkit cannot support SDMMC and QSPI at the same time. Thus
we will need to have 2 separate board files, one for SDMMC and one for
QSPI. We also add a new base board dtsi file, socfpga_arria10_socdk.dtsi
so that we use common peripherals for each flavor of the devkits.

Add the sdmmc node to the socfpga_arria10_socdk_sdmmc.dts board file.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/Makefile                        |  2 +-
 arch/arm/boot/dts/socfpga_arria10_socdk.dts       | 48 -----------------------
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi      | 46 ++++++++++++++++++++++
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts | 26 ++++++++++++
 4 files changed, 73 insertions(+), 49 deletions(-)
 delete mode 100755 arch/arm/boot/dts/socfpga_arria10_socdk.dts
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..e50441a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -485,7 +485,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7794-alt.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
-	socfpga_arria10_socdk.dtb \
+	socfpga_arria10_socdk_sdmmc.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_sockit.dtb \
 	socfpga_cyclone5_socrates.dtb \
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dts b/arch/arm/boot/dts/socfpga_arria10_socdk.dts
deleted file mode 100755
index 811a61c..0000000
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dts
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * Copyright (C) 2014 Altera Corporation <www.altera.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-/dts-v1/;
-#include "socfpga_arria10.dtsi"
-
-/ {
-	model = "Altera SOCFPGA Arria 10";
-	compatible = "altr,socfpga-arria10", "altr,socfpga";
-
-	chosen {
-		bootargs = "console=ttyS0,115200 rootwait";
-	};
-
-	memory {
-		name = "memory";
-		device_type = "memory";
-		reg = <0x0 0x40000000>; /* 1GB */
-	};
-
-	soc {
-		clkmgr at ffd04000 {
-			clocks {
-				osc1 {
-					clock-frequency = <25000000>;
-				};
-			};
-		};
-	};
-};
-
-&uart1 {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
new file mode 100644
index 0000000..347ca4e
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2015 Altera Corporation <www.altera.com>
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
+#include "socfpga_arria10.dtsi"
+
+/ {
+	model = "Altera SOCFPGA Arria 10";
+	compatible = "altr,socfpga-arria10", "altr,socfpga";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 rootwait";
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x40000000>; /* 1GB */
+	};
+
+	soc {
+		clkmgr at ffd04000 {
+			clocks {
+				osc1 {
+					clock-frequency = <25000000>;
+				};
+			};
+		};
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
new file mode 100644
index 0000000..dbbb751
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2014-2015 Altera Corporation <www.altera.com>
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
+/dts-v1/;
+#include "socfpga_arria10_socdk.dtsi"
+
+&mmc {
+	status = "okay";
+	num-slots = <1>;
+	broken-cd;
+	bus-width = <4>;
+};
-- 
2.2.1
