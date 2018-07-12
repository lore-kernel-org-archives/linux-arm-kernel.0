From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 12 Jul 2018 21:12:43 +0000
Subject: [PATCH v3 1/2] clk: meson: add DT documentation for emmc clock
 controller
In-Reply-To: <20180712211244.11428-1-yixun.lan@amlogic.com>
References: <20180712211244.11428-1-yixun.lan@amlogic.com>
Message-ID: <20180712211244.11428-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the MMC sub clock controller driver, the potential consumer
of this driver is MMC or NAND. Also add three clock bindings IDs which
provided by this driver.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 .../bindings/clock/amlogic,mmc-clkc.txt       | 31 +++++++++++++++++++
 .../clock/amlogic,meson-mmc-clkc.h            | 16 ++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
 create mode 100644 include/dt-bindings/clock/amlogic,meson-mmc-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
new file mode 100644
index 000000000000..91018221df1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
@@ -0,0 +1,31 @@
+* Amlogic MMC Sub Clock Controller Driver
+
+The Amlogic MMC clock controller generates and supplies clock to support
+MMC and NAND controller
+
+Required Properties:
+
+- compatible: should be:
+		"amlogic,meson-gx-mmc-clkc"
+		"amlogic,meson-axg-mmc-clkc"
+
+- #clock-cells: should be 1.
+- clocks: phandles to clocks corresponding to the clock-names property
+- clock-names: list of parent clock names
+	- "clkin0", "clkin1"
+
+Parent node should have the following properties :
+- compatible: "amlogic,meson-axg-mmc-clkc", "syscon".
+- reg: base address and size of the MMC control register space.
+
+Example: Clock controller node:
+
+sd_mmc_c_clkc: clock-controller at 7000 {
+	compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
+	reg = <0x0 0x7000 0x0 0x4>;
+	#clock-cells = <1>;
+
+	clock-names = "clkin0", "clkin1";
+	clocks = <&clkc CLKID_SD_MMC_C_CLK0>,
+		 <&clkc CLKID_FCLK_DIV2>;
+};
diff --git a/include/dt-bindings/clock/amlogic,meson-mmc-clkc.h b/include/dt-bindings/clock/amlogic,meson-mmc-clkc.h
new file mode 100644
index 000000000000..2ae988ebc3ae
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,meson-mmc-clkc.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Meson MMC sub clock tree IDs
+ *
+ * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
+ * Author: Yixun Lan <yixun.lan@amlogic.com>
+ */
+
+#ifndef __MMC_CLKC_H
+#define __MMC_CLKC_H
+
+#define CLKID_MMC_DIV				1
+#define CLKID_MMC_PHASE_TX			3
+#define CLKID_MMC_PHASE_RX			4
+
+#endif
-- 
2.18.0
