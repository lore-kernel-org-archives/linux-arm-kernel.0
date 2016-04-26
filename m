From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Apr 2016 11:28:41 +1000
Subject: [PATCH 06/11] soc: renesas: rcar-sysc: Add support for R-Car H1 power
 areas
In-Reply-To: <cover.1461632180.git.horms+renesas@verge.net.au>
References: <cover.1461632180.git.horms+renesas@verge.net.au>
Message-ID: <9b83ea17b0d9b5461ee46a2f5a668e6b10743f1a.1461632180.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/Makefile       |  2 +-
 drivers/soc/renesas/r8a7779-sysc.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c    |  3 +++
 drivers/soc/renesas/rcar-sysc.h    |  1 +
 4 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/renesas/r8a7779-sysc.c

diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 2b64f6c94681..b8aa9db4fdd9 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
 obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o
 obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o
 obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o
diff --git a/drivers/soc/renesas/r8a7779-sysc.c b/drivers/soc/renesas/r8a7779-sysc.c
new file mode 100644
index 000000000000..9e8e6b7faa04
--- /dev/null
+++ b/drivers/soc/renesas/r8a7779-sysc.c
@@ -0,0 +1,34 @@
+/*
+ * Renesas R-Car H1 System Controller
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
+#include <dt-bindings/power/r8a7779-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a7779_areas[] __initconst = {
+	{ "always-on",	    0, 0, R8A7779_PD_ALWAYS_ON,	-1, PD_ALWAYS_ON },
+	{ "arm1",	 0x40, 1, R8A7779_PD_ARM1,	R8A7779_PD_ALWAYS_ON,
+	  PD_CPU_CR },
+	{ "arm2",	 0x40, 2, R8A7779_PD_ARM2,	R8A7779_PD_ALWAYS_ON,
+	  PD_CPU_CR },
+	{ "arm3",	 0x40, 3, R8A7779_PD_ARM3,	R8A7779_PD_ALWAYS_ON,
+	  PD_CPU_CR },
+	{ "sgx",	 0xc0, 0, R8A7779_PD_SGX,	R8A7779_PD_ALWAYS_ON },
+	{ "vdp",	0x100, 0, R8A7779_PD_VDP,	R8A7779_PD_ALWAYS_ON },
+	{ "imp",	0x140, 0, R8A7779_PD_IMP,	R8A7779_PD_ALWAYS_ON },
+};
+
+const struct rcar_sysc_info r8a7779_sysc_info __initconst = {
+	.areas = r8a7779_areas,
+	.num_areas = ARRAY_SIZE(r8a7779_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 0d49a25de740..858ad23ae03a 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -284,6 +284,9 @@ finalize:
 }
 
 static const struct of_device_id rcar_sysc_matches[] = {
+#ifdef CONFIG_ARCH_R8A7779
+	{ .compatible = "renesas,r8a7779-sysc", .data = &r8a7779_sysc_info },
+#endif
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 7bb48b4f7334..7cf58b9cd544 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -50,4 +50,5 @@ struct rcar_sysc_info {
 	unsigned int num_areas;
 };
 
+extern const struct rcar_sysc_info r8a7779_sysc_info;
 #endif /* __SOC_RENESAS_RCAR_SYSC_H__ */
-- 
2.7.0.rc3.207.g0ac5344
