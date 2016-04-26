From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Apr 2016 11:28:43 +1000
Subject: [PATCH 08/11] soc: renesas: rcar-sysc: Add support for R-Car M2-W
 power areas
In-Reply-To: <cover.1461632180.git.horms+renesas@verge.net.au>
References: <cover.1461632180.git.horms+renesas@verge.net.au>
Message-ID: <c5fbb3c08897c8941852e9096f8507785d8a18f2.1461632180.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/Makefile       |  2 +-
 drivers/soc/renesas/r8a7791-sysc.c | 33 +++++++++++++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c    |  3 +++
 drivers/soc/renesas/rcar-sysc.h    |  1 +
 4 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/renesas/r8a7791-sysc.c

diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 6588be3c6776..96463c05ee59 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
 obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o r8a7790-sysc.o
-obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
 obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o
 obj-$(CONFIG_ARCH_R8A7794)	+= rcar-sysc.o
diff --git a/drivers/soc/renesas/r8a7791-sysc.c b/drivers/soc/renesas/r8a7791-sysc.c
new file mode 100644
index 000000000000..03b9f41a34e6
--- /dev/null
+++ b/drivers/soc/renesas/r8a7791-sysc.c
@@ -0,0 +1,33 @@
+/*
+ * Renesas R-Car M2-W/N System Controller
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
+#include <dt-bindings/power/r8a7791-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a7791_areas[] __initconst = {
+	{ "always-on",	    0, 0, R8A7791_PD_ALWAYS_ON,	-1, PD_ALWAYS_ON },
+	{ "ca15-scu",	0x180, 0, R8A7791_PD_CA15_SCU,	R8A7791_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca15-cpu0",	 0x40, 0, R8A7791_PD_CA15_CPU0,	R8A7791_PD_CA15_SCU,
+	  PD_CPU_NOCR },
+	{ "ca15-cpu1",	 0x40, 1, R8A7791_PD_CA15_CPU1,	R8A7791_PD_CA15_SCU,
+	  PD_CPU_NOCR },
+	{ "sh-4a",	 0x80, 0, R8A7791_PD_SH_4A,	R8A7791_PD_ALWAYS_ON },
+	{ "sgx",	 0xc0, 0, R8A7791_PD_SGX,	R8A7791_PD_ALWAYS_ON },
+};
+
+const struct rcar_sysc_info r8a7791_sysc_info __initconst = {
+	.areas = r8a7791_areas,
+	.num_areas = ARRAY_SIZE(r8a7791_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 07ea25925e85..5b70b93a2aa7 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -290,6 +290,9 @@ static const struct of_device_id rcar_sysc_matches[] = {
 #ifdef CONFIG_ARCH_R8A7790
 	{ .compatible = "renesas,r8a7790-sysc", .data = &r8a7790_sysc_info },
 #endif
+#ifdef CONFIG_ARCH_R8A7791
+	{ .compatible = "renesas,r8a7791-sysc", .data = &r8a7791_sysc_info },
+#endif
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 33c8f2d00a01..d58b39400e79 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -52,4 +52,5 @@ struct rcar_sysc_info {
 
 extern const struct rcar_sysc_info r8a7779_sysc_info;
 extern const struct rcar_sysc_info r8a7790_sysc_info;
+extern const struct rcar_sysc_info r8a7791_sysc_info;
 #endif /* __SOC_RENESAS_RCAR_SYSC_H__ */
-- 
2.7.0.rc3.207.g0ac5344
