From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 30 Sep 2016 01:21:54 +0300
Subject: [PATCH RFC v2 3/12] soc: renesas: rcar-sysc: add R8A7743 support
In-Reply-To: <1987532.PE2ex6PrJ5@wasted.cogentembedded.com>
References: <1987532.PE2ex6PrJ5@wasted.cogentembedded.com>
Message-ID: <1979633.oxsqSuXO5u@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for RZ/G1M (R8A7743) SoC power areas to the R-Car SYSC driver.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- documented the R8A7743 SYSC device tree binding;
- added "R-Car" to the patch description;
- added Geert's tag.

 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt |    7 +-
 drivers/soc/renesas/Makefile                                  |    1 
 drivers/soc/renesas/r8a7743-sysc.c                            |   32 ++++++++++
 drivers/soc/renesas/rcar-sysc.c                               |    3 
 drivers/soc/renesas/rcar-sysc.h                               |    1 
 5 files changed, 41 insertions(+), 3 deletions(-)

Index: renesas/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
===================================================================
--- renesas.orig/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
+++ renesas/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
@@ -1,12 +1,13 @@
-DT bindings for the Renesas R-Car System Controller
+DT bindings for the Renesas R-Car (RZ/G) System Controller
 
 == System Controller Node ==
 
-The R-Car System Controller provides power management for the CPU cores and
-various coprocessors.
+The R-Car (RZ/G) System Controller provides power management for the CPU cores
+and various coprocessors.
 
 Required properties:
   - compatible: Must contain exactly one of the following:
+      - "renesas,r8a7743-sysc" (RZ/G1M)
       - "renesas,r8a7779-sysc" (R-Car H1)
       - "renesas,r8a7790-sysc" (R-Car H2)
       - "renesas,r8a7791-sysc" (R-Car M2-W)
Index: renesas/drivers/soc/renesas/Makefile
===================================================================
--- renesas.orig/drivers/soc/renesas/Makefile
+++ renesas/drivers/soc/renesas/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_ARCH_R8A7743)	+= rcar-sysc.o r8a7743-sysc.o
 obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
 obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o r8a7790-sysc.o
 obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
Index: renesas/drivers/soc/renesas/r8a7743-sysc.c
===================================================================
--- /dev/null
+++ renesas/drivers/soc/renesas/r8a7743-sysc.c
@@ -0,0 +1,32 @@
+/*
+ * Renesas RZ/G1M System Controller
+ *
+ * Copyright (C) 2016 Cogent Embedded Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation; of the License.
+ */
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/power/r8a7743-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a7743_areas[] __initconst = {
+	{ "always-on",	    0, 0, R8A7743_PD_ALWAYS_ON,	-1, PD_ALWAYS_ON },
+	{ "ca15-scu",	0x180, 0, R8A7743_PD_CA15_SCU,	R8A7743_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca15-cpu0",	 0x40, 0, R8A7743_PD_CA15_CPU0,	R8A7743_PD_CA15_SCU,
+	  PD_CPU_NOCR },
+	{ "ca15-cpu1",	 0x40, 1, R8A7743_PD_CA15_CPU1,	R8A7743_PD_CA15_SCU,
+	  PD_CPU_NOCR },
+	{ "sgx",	 0xc0, 0, R8A7743_PD_SGX,	R8A7743_PD_ALWAYS_ON },
+};
+
+const struct rcar_sysc_info r8a7743_sysc_info __initconst = {
+	.areas = r8a7743_areas,
+	.num_areas = ARRAY_SIZE(r8a7743_areas),
+};
Index: renesas/drivers/soc/renesas/rcar-sysc.c
===================================================================
--- renesas.orig/drivers/soc/renesas/rcar-sysc.c
+++ renesas/drivers/soc/renesas/rcar-sysc.c
@@ -275,6 +275,9 @@ finalize:
 }
 
 static const struct of_device_id rcar_sysc_matches[] = {
+#ifdef CONFIG_ARCH_R8A7743
+	{ .compatible = "renesas,r8a7743-sysc", .data = &r8a7743_sysc_info },
+#endif
 #ifdef CONFIG_ARCH_R8A7779
 	{ .compatible = "renesas,r8a7779-sysc", .data = &r8a7779_sysc_info },
 #endif
Index: renesas/drivers/soc/renesas/rcar-sysc.h
===================================================================
--- renesas.orig/drivers/soc/renesas/rcar-sysc.h
+++ renesas/drivers/soc/renesas/rcar-sysc.h
@@ -50,6 +50,7 @@ struct rcar_sysc_info {
 	unsigned int num_areas;
 };
 
+extern const struct rcar_sysc_info r8a7743_sysc_info;
 extern const struct rcar_sysc_info r8a7779_sysc_info;
 extern const struct rcar_sysc_info r8a7790_sysc_info;
 extern const struct rcar_sysc_info r8a7791_sysc_info;
