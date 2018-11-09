From: taoren@fb.com (Tao Ren)
Date: Thu, 8 Nov 2018 16:50:34 -0800
Subject: [PATCH v3 1/2] ARM: dts: Add Facebook BMC flash layout
Message-ID: <20181109005034.210138-1-taoren@fb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the layout used by Facebook BMC systems. It describes the fixed
flash layout of a 32MB mtd device.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 Changes in v3:
   - adding comments explaining why "data0" and "flash0" partitions are
     needed.
 Changes in v2:
   - adding facebook copyright.

 .../boot/dts/facebook-bmc-flash-layout.dtsi   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 arch/arm/boot/dts/facebook-bmc-flash-layout.dtsi

diff --git a/arch/arm/boot/dts/facebook-bmc-flash-layout.dtsi b/arch/arm/boot/dts/facebook-bmc-flash-layout.dtsi
new file mode 100644
index 000000000000..87bb8b576250
--- /dev/null
+++ b/arch/arm/boot/dts/facebook-bmc-flash-layout.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018 Facebook Inc.
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	u-boot at 0 {
+		reg = <0x0 0x60000>;
+		label = "u-boot";
+	};
+
+	u-boot-env at 60000 {
+		reg = <0x60000 0x20000>;
+		label = "env";
+	};
+
+	fit at 80000 {
+		reg = <0x80000 0x1b80000>;
+		label = "fit";
+	};
+
+	/*
+	 * "data0" partition is used by several Facebook BMC platforms
+	 * as persistent data store.
+	 */
+	data0 at 1c00000 {
+		reg = <0x1c00000 0x400000>;
+		label = "data0";
+	};
+
+	/*
+	 * Although the master partition can be created by enabling
+	 * MTD_PARTITIONED_MASTER option, below "flash0" partition is
+	 * explicitly created to avoid breaking legacy applications.
+	 */
+	flash0 at 0 {
+		reg = <0x0 0x2000000>;
+		label = "flash0";
+	};
+};
-- 
2.17.1
