From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:16:08 +0200
Subject: [PATCH 1/5] soc: renesas: rcar-sysc: add R8A7792 support
In-Reply-To: <cover.1467292648.git.horms+renesas@verge.net.au>
References: <cover.1467292648.git.horms+renesas@verge.net.au>
Message-ID: <7e49c845983e9aae86c70464786aa2ee191929a6.1467292648.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add support for R-Car V2H (R8A7792) SoC power areas to the SYSC driver.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/Makefile       |  1 +
 drivers/soc/renesas/r8a7792-sysc.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c    |  3 +++
 drivers/soc/renesas/rcar-sysc.h    |  1 +
 4 files changed, 39 insertions(+)
 create mode 100644 drivers/soc/renesas/r8a7792-sysc.c

diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index cd85cd5e6a01..623039c3514c 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
 obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o r8a7790-sysc.o
 obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
+obj-$(CONFIG_ARCH_R8A7792)	+= rcar-sysc.o r8a7792-sysc.o
 # R-Car M2-N is identical to R-Car M2-W w.r.t. power domains.
 obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o r8a7791-sysc.o
 obj-$(CONFIG_ARCH_R8A7794)	+= rcar-sysc.o r8a7794-sysc.o
diff --git a/drivers/soc/renesas/r8a7792-sysc.c b/drivers/soc/renesas/r8a7792-sysc.c
new file mode 100644
index 000000000000..ca7467d7b7ec
--- /dev/null
+++ b/drivers/soc/renesas/r8a7792-sysc.c
@@ -0,0 +1,34 @@
+/*
+ * Renesas R-Car V2H (R8A7792) System Controller
+ *
+ * Copyright (C) 2016 Cogent Embedded Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/bug.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/power/r8a7792-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a7792_areas[] __initconst = {
+	{ "always-on",	    0, 0, R8A7792_PD_ALWAYS_ON,	-1, PD_ALWAYS_ON },
+	{ "ca15-scu",	0x180, 0, R8A7792_PD_CA15_SCU,	R8A7792_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca15-cpu0",	 0x40, 0, R8A7792_PD_CA15_CPU0,	R8A7792_PD_CA15_SCU,
+	  PD_CPU_NOCR },
+	{ "ca15-cpu1",	 0x40, 1, R8A7792_PD_CA15_CPU1,	R8A7792_PD_CA15_SCU,
+	  PD_CPU_NOCR },
+	{ "sgx",	 0xc0, 0, R8A7792_PD_SGX,	R8A7792_PD_ALWAYS_ON },
+	{ "imp",	0x140, 0, R8A7792_PD_IMP,	R8A7792_PD_ALWAYS_ON },
+};
+
+const struct rcar_sysc_info r8a7792_sysc_info __initconst = {
+	.areas = r8a7792_areas,
+	.num_areas = ARRAY_SIZE(r8a7792_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index fc997d4d2a4a..a43ca24699be 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -293,6 +293,9 @@ static const struct of_device_id rcar_sysc_matches[] = {
 #ifdef CONFIG_ARCH_R8A7791
 	{ .compatible = "renesas,r8a7791-sysc", .data = &r8a7791_sysc_info },
 #endif
+#ifdef CONFIG_ARCH_R8A7792
+	{ .compatible = "renesas,r8a7792-sysc", .data = &r8a7792_sysc_info },
+#endif
 #ifdef CONFIG_ARCH_R8A7793
 	/* R-Car M2-N is identical to R-Car M2-W w.r.t. power domains. */
 	{ .compatible = "renesas,r8a7793-sysc", .data = &r8a7791_sysc_info },
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 4ac3d7bf7f38..77dbe861473f 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -53,6 +53,7 @@ struct rcar_sysc_info {
 extern const struct rcar_sysc_info r8a7779_sysc_info;
 extern const struct rcar_sysc_info r8a7790_sysc_info;
 extern const struct rcar_sysc_info r8a7791_sysc_info;
+extern const struct rcar_sysc_info r8a7792_sysc_info;
 extern const struct rcar_sysc_info r8a7794_sysc_info;
 extern const struct rcar_sysc_info r8a7795_sysc_info;
 extern const struct rcar_sysc_info r8a7796_sysc_info;
-- 
2.7.0.rc3.207.g0ac5344
