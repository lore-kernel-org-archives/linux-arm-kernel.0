From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:20 +0200
Subject: [PATCH 05/21] soc: renesas: rcar-sysc: Add r8a774a1 support
In-Reply-To: <cover.1538128711.git.horms+renesas@verge.net.au>
References: <cover.1538128711.git.horms+renesas@verge.net.au>
Message-ID: <7f0e99cc916933ecd7fd407e2eb42448198e0404.1538128711.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add support for RZ/G2M (R8A774A1) SoC power areas to the R-Car SYSC
driver.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../bindings/power/renesas,rcar-sysc.txt           |  1 +
 drivers/soc/renesas/Kconfig                        |  5 +++
 drivers/soc/renesas/Makefile                       |  1 +
 drivers/soc/renesas/r8a774a1-sysc.c                | 45 ++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c                    |  3 ++
 drivers/soc/renesas/rcar-sysc.h                    |  1 +
 6 files changed, 56 insertions(+)
 create mode 100644 drivers/soc/renesas/r8a774a1-sysc.c

diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
index 180ae65be753..4e3ec6ac6345 100644
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
@@ -10,6 +10,7 @@ Required properties:
       - "renesas,r8a7743-sysc" (RZ/G1M)
       - "renesas,r8a7745-sysc" (RZ/G1E)
       - "renesas,r8a77470-sysc" (RZ/G1C)
+      - "renesas,r8a774a1-sysc" (RZ/G2M)
       - "renesas,r8a7779-sysc" (R-Car H1)
       - "renesas,r8a7790-sysc" (R-Car H2)
       - "renesas,r8a7791-sysc" (R-Car M2-W)
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 1d824cbd462d..d769330b640e 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -9,6 +9,7 @@ config SOC_RENESAS
 	select SYSC_R8A7743 if ARCH_R8A7743
 	select SYSC_R8A7745 if ARCH_R8A7745
 	select SYSC_R8A77470 if ARCH_R8A77470
+	select SYSC_R8A774A1 if ARCH_R8A774A1
 	select SYSC_R8A7779 if ARCH_R8A7779
 	select SYSC_R8A7790 if ARCH_R8A7790
 	select SYSC_R8A7791 if ARCH_R8A7791 || ARCH_R8A7793
@@ -37,6 +38,10 @@ config SYSC_R8A77470
 	bool "RZ/G1C System Controller support" if COMPILE_TEST
 	select SYSC_RCAR
 
+config SYSC_R8A774A1
+	bool "RZ/G2M System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
 config SYSC_R8A7779
 	bool "R-Car H1 System Controller support" if COMPILE_TEST
 	select SYSC_RCAR
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index c37b0803c1b6..6adb9d6964a0 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_SOC_RENESAS)	+= renesas-soc.o
 obj-$(CONFIG_SYSC_R8A7743)	+= r8a7743-sysc.o
 obj-$(CONFIG_SYSC_R8A7745)	+= r8a7745-sysc.o
 obj-$(CONFIG_SYSC_R8A77470)	+= r8a77470-sysc.o
+obj-$(CONFIG_SYSC_R8A774A1)	+= r8a774a1-sysc.o
 obj-$(CONFIG_SYSC_R8A7779)	+= r8a7779-sysc.o
 obj-$(CONFIG_SYSC_R8A7790)	+= r8a7790-sysc.o
 obj-$(CONFIG_SYSC_R8A7791)	+= r8a7791-sysc.o
diff --git a/drivers/soc/renesas/r8a774a1-sysc.c b/drivers/soc/renesas/r8a774a1-sysc.c
new file mode 100644
index 000000000000..9db51ff6f5ed
--- /dev/null
+++ b/drivers/soc/renesas/r8a774a1-sysc.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2M System Controller
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ *
+ * Based on Renesas R-Car M3-W System Controller
+ * Copyright (C) 2016 Glider bvba
+ */
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/power/r8a774a1-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a774a1_areas[] __initconst = {
+	{ "always-on",	    0, 0, R8A774A1_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
+	{ "ca57-scu",	0x1c0, 0, R8A774A1_PD_CA57_SCU,	R8A774A1_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca57-cpu0",	 0x80, 0, R8A774A1_PD_CA57_CPU0, R8A774A1_PD_CA57_SCU,
+	  PD_CPU_NOCR },
+	{ "ca57-cpu1",	 0x80, 1, R8A774A1_PD_CA57_CPU1, R8A774A1_PD_CA57_SCU,
+	  PD_CPU_NOCR },
+	{ "ca53-scu",	0x140, 0, R8A774A1_PD_CA53_SCU,	R8A774A1_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca53-cpu0",	0x200, 0, R8A774A1_PD_CA53_CPU0, R8A774A1_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "ca53-cpu1",	0x200, 1, R8A774A1_PD_CA53_CPU1, R8A774A1_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "ca53-cpu2",	0x200, 2, R8A774A1_PD_CA53_CPU2, R8A774A1_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "ca53-cpu3",	0x200, 3, R8A774A1_PD_CA53_CPU3, R8A774A1_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "a3vc",	0x380, 0, R8A774A1_PD_A3VC,	R8A774A1_PD_ALWAYS_ON },
+	{ "a2vc0",	0x3c0, 0, R8A774A1_PD_A2VC0,	R8A774A1_PD_A3VC },
+	{ "a2vc1",	0x3c0, 1, R8A774A1_PD_A2VC1,	R8A774A1_PD_A3VC },
+	{ "3dg-a",	0x100, 0, R8A774A1_PD_3DG_A,	R8A774A1_PD_ALWAYS_ON },
+	{ "3dg-b",	0x100, 1, R8A774A1_PD_3DG_B,	R8A774A1_PD_3DG_A },
+};
+
+const struct rcar_sysc_info r8a774a1_sysc_info __initconst = {
+	.areas = r8a774a1_areas,
+	.num_areas = ARRAY_SIZE(r8a774a1_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 029188e8be6e..fe32f7a3b215 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -275,6 +275,9 @@ static const struct of_device_id rcar_sysc_matches[] __initconst = {
 #ifdef CONFIG_SYSC_R8A77470
 	{ .compatible = "renesas,r8a77470-sysc", .data = &r8a77470_sysc_info },
 #endif
+#ifdef CONFIG_SYSC_R8A774A1
+	{ .compatible = "renesas,r8a774a1-sysc", .data = &r8a774a1_sysc_info },
+#endif
 #ifdef CONFIG_SYSC_R8A7779
 	{ .compatible = "renesas,r8a7779-sysc", .data = &r8a7779_sysc_info },
 #endif
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index a22e7cf25e30..33defe624a8c 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -52,6 +52,7 @@ struct rcar_sysc_info {
 extern const struct rcar_sysc_info r8a7743_sysc_info;
 extern const struct rcar_sysc_info r8a7745_sysc_info;
 extern const struct rcar_sysc_info r8a77470_sysc_info;
+extern const struct rcar_sysc_info r8a774a1_sysc_info;
 extern const struct rcar_sysc_info r8a7779_sysc_info;
 extern const struct rcar_sysc_info r8a7790_sysc_info;
 extern const struct rcar_sysc_info r8a7791_sysc_info;
-- 
2.11.0
