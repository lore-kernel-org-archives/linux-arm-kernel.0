From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 10:00:13 +0900
Subject: [PATCH 3/3] soc: renesas: rcar-sysc: Add support for R-Car M3-W power
 areas
In-Reply-To: <cover.1465347345.git.horms+renesas@verge.net.au>
References: <cover.1465347345.git.horms+renesas@verge.net.au>
Message-ID: <e0c98b9171eecf1745eda08de86081db8ec41d51.1465347345.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/Makefile       |  1 +
 drivers/soc/renesas/r8a7796-sysc.c | 48 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c    |  3 +++
 drivers/soc/renesas/rcar-sysc.h    |  1 +
 4 files changed, 53 insertions(+)
 create mode 100644 drivers/soc/renesas/r8a7796-sysc.c

diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 151fcd3f025b..cd85cd5e6a01 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
 obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o r8a7791-sysc.o
 obj-$(CONFIG_ARCH_R8A7794)	+= rcar-sysc.o r8a7794-sysc.o
 obj-$(CONFIG_ARCH_R8A7795)	+= rcar-sysc.o r8a7795-sysc.o
+obj-$(CONFIG_ARCH_R8A7796)	+= rcar-sysc.o r8a7796-sysc.o
diff --git a/drivers/soc/renesas/r8a7796-sysc.c b/drivers/soc/renesas/r8a7796-sysc.c
new file mode 100644
index 000000000000..f700c842b9e1
--- /dev/null
+++ b/drivers/soc/renesas/r8a7796-sysc.c
@@ -0,0 +1,48 @@
+/*
+ * Renesas R-Car M3-W System Controller
+ *
+ * Copyright (C) 2016 Glider bvba
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/power/r8a7796-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a7796_areas[] __initconst = {
+	{ "always-on",	    0, 0, R8A7796_PD_ALWAYS_ON,	-1, PD_ALWAYS_ON },
+	{ "ca57-scu",	0x1c0, 0, R8A7796_PD_CA57_SCU,	R8A7796_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca57-cpu0",	 0x80, 0, R8A7796_PD_CA57_CPU0,	R8A7796_PD_CA57_SCU,
+	  PD_CPU_NOCR },
+	{ "ca57-cpu1",	 0x80, 1, R8A7796_PD_CA57_CPU1,	R8A7796_PD_CA57_SCU,
+	  PD_CPU_NOCR },
+	{ "ca53-scu",	0x140, 0, R8A7796_PD_CA53_SCU,	R8A7796_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca53-cpu0",	0x200, 0, R8A7796_PD_CA53_CPU0,	R8A7796_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "ca53-cpu1",	0x200, 1, R8A7796_PD_CA53_CPU1,	R8A7796_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "ca53-cpu2",	0x200, 2, R8A7796_PD_CA53_CPU2,	R8A7796_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "ca53-cpu3",	0x200, 3, R8A7796_PD_CA53_CPU3,	R8A7796_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "cr7",	0x240, 0, R8A7796_PD_CR7,	R8A7796_PD_ALWAYS_ON },
+	{ "a3vc",	0x380, 0, R8A7796_PD_A3VC,	R8A7796_PD_ALWAYS_ON },
+	{ "a2vc0",	0x3c0, 0, R8A7796_PD_A2VC0,	R8A7796_PD_A3VC },
+	{ "a2vc1",	0x3c0, 1, R8A7796_PD_A2VC1,	R8A7796_PD_A3VC },
+	{ "3dg-a",	0x100, 0, R8A7796_PD_3DG_A,	R8A7796_PD_ALWAYS_ON },
+	{ "3dg-b",	0x100, 1, R8A7796_PD_3DG_B,	R8A7796_PD_3DG_A },
+	{ "a3ir",	0x180, 0, R8A7796_PD_A3IR,	R8A7796_PD_ALWAYS_ON },
+};
+
+const struct rcar_sysc_info r8a7796_sysc_info __initconst = {
+	.areas = r8a7796_areas,
+	.num_areas = ARRAY_SIZE(r8a7796_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 79dbc770895f..fc997d4d2a4a 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -303,6 +303,9 @@ static const struct of_device_id rcar_sysc_matches[] = {
 #ifdef CONFIG_ARCH_R8A7795
 	{ .compatible = "renesas,r8a7795-sysc", .data = &r8a7795_sysc_info },
 #endif
+#ifdef CONFIG_ARCH_R8A7796
+	{ .compatible = "renesas,r8a7796-sysc", .data = &r8a7796_sysc_info },
+#endif
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 5e766174c2f4..4ac3d7bf7f38 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -55,4 +55,5 @@ extern const struct rcar_sysc_info r8a7790_sysc_info;
 extern const struct rcar_sysc_info r8a7791_sysc_info;
 extern const struct rcar_sysc_info r8a7794_sysc_info;
 extern const struct rcar_sysc_info r8a7795_sysc_info;
+extern const struct rcar_sysc_info r8a7796_sysc_info;
 #endif /* __SOC_RENESAS_RCAR_SYSC_H__ */
-- 
2.1.4
