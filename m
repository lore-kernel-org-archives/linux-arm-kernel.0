From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:04:04 +0200
Subject: [PATCH 3/4] soc: renesas: rcar-sysc: Add support for R-Car D3 power
 areas
In-Reply-To: <cover.1501511923.git.horms+renesas@verge.net.au>
References: <cover.1501511923.git.horms+renesas@verge.net.au>
Message-ID: <eed17c427f8b16dc9ca68f80d6b0d39a62b8eee3.1501511923.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../bindings/power/renesas,rcar-sysc.txt           |  1 +
 drivers/soc/renesas/Kconfig                        |  5 ++++
 drivers/soc/renesas/Makefile                       |  1 +
 drivers/soc/renesas/r8a77995-sysc.c                | 31 ++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c                    |  3 +++
 drivers/soc/renesas/rcar-sysc.h                    |  1 +
 6 files changed, 42 insertions(+)
 create mode 100644 drivers/soc/renesas/r8a77995-sysc.c

diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
index d91715bc8d52..98cc8c09d02d 100644
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
@@ -17,6 +17,7 @@ Required properties:
       - "renesas,r8a7794-sysc" (R-Car E2)
       - "renesas,r8a7795-sysc" (R-Car H3)
       - "renesas,r8a7796-sysc" (R-Car M3-W)
+      - "renesas,r8a77995-sysc" (R-Car D3)
   - reg: Address start and address range for the device.
   - #power-domain-cells: Must be 1.
 
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 87a4be46bd98..680a5a29837b 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -13,6 +13,7 @@ config SOC_RENESAS
 	select SYSC_R8A7794 if ARCH_R8A7794
 	select SYSC_R8A7795 if ARCH_R8A7795
 	select SYSC_R8A7796 if ARCH_R8A7796
+	select SYSC_R8A77995 if ARCH_R8A77995
 
 if SOC_RENESAS
 
@@ -53,6 +54,10 @@ config SYSC_R8A7796
 	bool "R-Car M3-W System Controller support" if COMPILE_TEST
 	select SYSC_RCAR
 
+config SYSC_R8A77995
+	bool "R-Car D3 System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
 # Family
 config RST_RCAR
 	bool "R-Car Reset Controller support" if COMPILE_TEST
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 1a1a297b26a7..6b6e7f16104c 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SYSC_R8A7792)	+= r8a7792-sysc.o
 obj-$(CONFIG_SYSC_R8A7794)	+= r8a7794-sysc.o
 obj-$(CONFIG_SYSC_R8A7795)	+= r8a7795-sysc.o
 obj-$(CONFIG_SYSC_R8A7796)	+= r8a7796-sysc.o
+obj-$(CONFIG_SYSC_R8A77995)	+= r8a77995-sysc.o
 
 # Family
 obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
diff --git a/drivers/soc/renesas/r8a77995-sysc.c b/drivers/soc/renesas/r8a77995-sysc.c
new file mode 100644
index 000000000000..f718429cab02
--- /dev/null
+++ b/drivers/soc/renesas/r8a77995-sysc.c
@@ -0,0 +1,31 @@
+/*
+ * Renesas R-Car D3 System Controller
+ *
+ * Copyright (C) 2017 Glider bvba
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/sys_soc.h>
+
+#include <dt-bindings/power/r8a77995-sysc.h>
+
+#include "rcar-sysc.h"
+
+static struct rcar_sysc_area r8a77995_areas[] __initdata = {
+	{ "always-on",     0, 0, R8A77995_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
+	{ "ca53-scu",  0x140, 0, R8A77995_PD_CA53_SCU,  R8A77995_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca53-cpu0", 0x200, 0, R8A77995_PD_CA53_CPU0, R8A77995_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+};
+
+
+const struct rcar_sysc_info r8a77995_sysc_info __initconst = {
+	.areas = r8a77995_areas,
+	.num_areas = ARRAY_SIZE(r8a77995_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 7c8da3c90011..e4d3b0101dfb 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -284,6 +284,9 @@ static const struct of_device_id rcar_sysc_matches[] = {
 #ifdef CONFIG_SYSC_R8A7796
 	{ .compatible = "renesas,r8a7796-sysc", .data = &r8a7796_sysc_info },
 #endif
+#ifdef CONFIG_SYSC_R8A77995
+	{ .compatible = "renesas,r8a77995-sysc", .data = &r8a77995_sysc_info },
+#endif
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 1a5bebaf54ba..2f524922c4d2 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -58,6 +58,7 @@ extern const struct rcar_sysc_info r8a7792_sysc_info;
 extern const struct rcar_sysc_info r8a7794_sysc_info;
 extern const struct rcar_sysc_info r8a7795_sysc_info;
 extern const struct rcar_sysc_info r8a7796_sysc_info;
+extern const struct rcar_sysc_info r8a77995_sysc_info;
 
 
     /*
-- 
2.1.4
