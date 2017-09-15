From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 15 Sep 2017 22:43:19 +0300
Subject: [PATCH v2 1/8] soc: renesas: rcar-sysc: add R8A77970 support
Message-ID: <20170915194421.403764714@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for R-Car V3M (R8A77970) SoC power areas to the R-Car SYSC
driver.

Based on the original (and large) patch by Daisuke Matsushita
<daisuke.matsushita.ns@hitachi.com>.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- removed #include <linux/bug.h>;
- fixed the parents for the A2IR[0123] and A2SC[01] power domains;
- added Geert's tag.

 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt |    1 
 drivers/soc/renesas/Kconfig                                   |    5 +
 drivers/soc/renesas/Makefile                                  |    1 
 drivers/soc/renesas/r8a77970-sysc.c                           |   38 ++++++++++
 drivers/soc/renesas/rcar-sysc.c                               |    3 
 drivers/soc/renesas/rcar-sysc.h                               |    1 
 6 files changed, 49 insertions(+)

Index: renesas/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
===================================================================
--- renesas.orig/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
+++ renesas/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
@@ -17,6 +17,7 @@ Required properties:
       - "renesas,r8a7794-sysc" (R-Car E2)
       - "renesas,r8a7795-sysc" (R-Car H3)
       - "renesas,r8a7796-sysc" (R-Car M3-W)
+      - "renesas,r8a77970-sysc" (R-Car V3M)
       - "renesas,r8a77995-sysc" (R-Car D3)
   - reg: Address start and address range for the device.
   - #power-domain-cells: Must be 1.
Index: renesas/drivers/soc/renesas/Kconfig
===================================================================
--- renesas.orig/drivers/soc/renesas/Kconfig
+++ renesas/drivers/soc/renesas/Kconfig
@@ -14,6 +14,7 @@ config SOC_RENESAS
 	select SYSC_R8A7794 if ARCH_R8A7794
 	select SYSC_R8A7795 if ARCH_R8A7795
 	select SYSC_R8A7796 if ARCH_R8A7796
+	select SYSC_R8A77970 if ARCH_R8A77970
 	select SYSC_R8A77995 if ARCH_R8A77995
 
 if SOC_RENESAS
@@ -55,6 +56,10 @@ config SYSC_R8A7796
 	bool "R-Car M3-W System Controller support" if COMPILE_TEST
 	select SYSC_RCAR
 
+config SYSC_R8A77970
+	bool "R-Car V3M System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
 config SYSC_R8A77995
 	bool "R-Car D3 System Controller support" if COMPILE_TEST
 	select SYSC_RCAR
Index: renesas/drivers/soc/renesas/Makefile
===================================================================
--- renesas.orig/drivers/soc/renesas/Makefile
+++ renesas/drivers/soc/renesas/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SYSC_R8A7792)	+= r8a7792-sy
 obj-$(CONFIG_SYSC_R8A7794)	+= r8a7794-sysc.o
 obj-$(CONFIG_SYSC_R8A7795)	+= r8a7795-sysc.o
 obj-$(CONFIG_SYSC_R8A7796)	+= r8a7796-sysc.o
+obj-$(CONFIG_SYSC_R8A77970)	+= r8a77970-sysc.o
 obj-$(CONFIG_SYSC_R8A77995)	+= r8a77995-sysc.o
 
 # Family
Index: renesas/drivers/soc/renesas/r8a77970-sysc.c
===================================================================
--- /dev/null
+++ renesas/drivers/soc/renesas/r8a77970-sysc.c
@@ -0,0 +1,38 @@
+/*
+ * Renesas R-Car V3M System Controller
+ *
+ * Copyright (C) 2017 Cogent Embedded Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+
+#include <dt-bindings/power/r8a77970-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a77970_areas[] __initconst = {
+	{ "always-on",	    0, 0, R8A77970_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
+	{ "ca53-scu",	0x140, 0, R8A77970_PD_CA53_SCU,	R8A77970_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca53-cpu0",	0x200, 0, R8A77970_PD_CA53_CPU0, R8A77970_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "ca53-cpu1",	0x200, 1, R8A77970_PD_CA53_CPU1, R8A77970_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "cr7",	0x240, 0, R8A77970_PD_CR7,	R8A77970_PD_ALWAYS_ON },
+	{ "a3ir",	0x180, 0, R8A77970_PD_A3IR,	R8A77970_PD_ALWAYS_ON },
+	{ "a2ir0",	0x400, 0, R8A77970_PD_A2IR0,	R8A77970_PD_A3IR },
+	{ "a2ir1",	0x400, 1, R8A77970_PD_A2IR1,	R8A77970_PD_A3IR },
+	{ "a2ir2",	0x400, 2, R8A77970_PD_A2IR2,	R8A77970_PD_A3IR },
+	{ "a2ir3",	0x400, 3, R8A77970_PD_A2IR3,	R8A77970_PD_A3IR },
+	{ "a2sc0",	0x400, 4, R8A77970_PD_A2SC0,	R8A77970_PD_A3IR },
+	{ "a2sc1",	0x400, 5, R8A77970_PD_A2SC1,	R8A77970_PD_A3IR },
+};
+
+const struct rcar_sysc_info r8a77970_sysc_info __initconst = {
+	.areas = r8a77970_areas,
+	.num_areas = ARRAY_SIZE(r8a77970_areas),
+};
Index: renesas/drivers/soc/renesas/rcar-sysc.c
===================================================================
--- renesas.orig/drivers/soc/renesas/rcar-sysc.c
+++ renesas/drivers/soc/renesas/rcar-sysc.c
@@ -284,6 +284,9 @@ static const struct of_device_id rcar_sy
 #ifdef CONFIG_SYSC_R8A7796
 	{ .compatible = "renesas,r8a7796-sysc", .data = &r8a7796_sysc_info },
 #endif
+#ifdef CONFIG_SYSC_R8A77970
+	{ .compatible = "renesas,r8a77970-sysc", .data = &r8a77970_sysc_info },
+#endif
 #ifdef CONFIG_SYSC_R8A77995
 	{ .compatible = "renesas,r8a77995-sysc", .data = &r8a77995_sysc_info },
 #endif
Index: renesas/drivers/soc/renesas/rcar-sysc.h
===================================================================
--- renesas.orig/drivers/soc/renesas/rcar-sysc.h
+++ renesas/drivers/soc/renesas/rcar-sysc.h
@@ -58,6 +58,7 @@ extern const struct rcar_sysc_info r8a77
 extern const struct rcar_sysc_info r8a7794_sysc_info;
 extern const struct rcar_sysc_info r8a7795_sysc_info;
 extern const struct rcar_sysc_info r8a7796_sysc_info;
+extern const struct rcar_sysc_info r8a77970_sysc_info;
 extern const struct rcar_sysc_info r8a77995_sysc_info;
 
 
