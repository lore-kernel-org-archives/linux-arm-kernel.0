From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:04:35 +0100
Subject: [PATCH 2/4] soc: renesas: rcar-sysc: add R8A7745 support
In-Reply-To: <cover.1479389981.git.horms+renesas@verge.net.au>
References: <cover.1479389981.git.horms+renesas@verge.net.au>
Message-ID: <c1006fc763279138e963b5a182170b8633a3746e.1479389981.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add support for RZ/G1E (R8A7745) SoC power areas to the R-Car SYSC driver.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../bindings/power/renesas,rcar-sysc.txt           |  1 +
 drivers/soc/renesas/Makefile                       |  1 +
 drivers/soc/renesas/r8a7745-sysc.c                 | 32 ++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c                    |  3 ++
 drivers/soc/renesas/rcar-sysc.h                    |  1 +
 5 files changed, 38 insertions(+)
 create mode 100644 drivers/soc/renesas/r8a7745-sysc.c

diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
index c16ec1866ac4..d91715bc8d52 100644
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
@@ -8,6 +8,7 @@ and various coprocessors.
 Required properties:
   - compatible: Must contain exactly one of the following:
       - "renesas,r8a7743-sysc" (RZ/G1M)
+      - "renesas,r8a7745-sysc" (RZ/G1E)
       - "renesas,r8a7779-sysc" (R-Car H1)
       - "renesas,r8a7790-sysc" (R-Car H2)
       - "renesas,r8a7791-sysc" (R-Car M2-W)
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 9e0bb329594c..e2249f01b2de 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_ARCH_R8A7743)	+= rcar-sysc.o r8a7743-sysc.o
+obj-$(CONFIG_ARCH_R8A7745)	+= rcar-sysc.o r8a7745-sysc.o
 obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
 obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o r8a7790-sysc.o
 obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
diff --git a/drivers/soc/renesas/r8a7745-sysc.c b/drivers/soc/renesas/r8a7745-sysc.c
new file mode 100644
index 000000000000..d17887c08aa1
--- /dev/null
+++ b/drivers/soc/renesas/r8a7745-sysc.c
@@ -0,0 +1,32 @@
+/*
+ * Renesas RZ/G1E System Controller
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
+#include <dt-bindings/power/r8a7745-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a7745_areas[] __initconst = {
+	{ "always-on",	    0, 0, R8A7745_PD_ALWAYS_ON,	-1, PD_ALWAYS_ON },
+	{ "ca7-scu",	0x100, 0, R8A7745_PD_CA7_SCU,	R8A7745_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca7-cpu0",	0x1c0, 0, R8A7745_PD_CA7_CPU0,	R8A7745_PD_CA7_SCU,
+	  PD_CPU_NOCR },
+	{ "ca7-cpu1",	0x1c0, 1, R8A7745_PD_CA7_CPU1,	R8A7745_PD_CA7_SCU,
+	  PD_CPU_NOCR },
+	{ "sgx",	 0xc0, 0, R8A7745_PD_SGX,	R8A7745_PD_ALWAYS_ON },
+};
+
+const struct rcar_sysc_info r8a7745_sysc_info __initconst = {
+	.areas = r8a7745_areas,
+	.num_areas = ARRAY_SIZE(r8a7745_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 71acd45b13f0..225c35c79d9a 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -278,6 +278,9 @@ static const struct of_device_id rcar_sysc_matches[] = {
 #ifdef CONFIG_ARCH_R8A7743
 	{ .compatible = "renesas,r8a7743-sysc", .data = &r8a7743_sysc_info },
 #endif
+#ifdef CONFIG_ARCH_R8A7745
+	{ .compatible = "renesas,r8a7745-sysc", .data = &r8a7745_sysc_info },
+#endif
 #ifdef CONFIG_ARCH_R8A7779
 	{ .compatible = "renesas,r8a7779-sysc", .data = &r8a7779_sysc_info },
 #endif
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 8ab9ca8a825a..f6e842e2976e 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -51,6 +51,7 @@ struct rcar_sysc_info {
 };
 
 extern const struct rcar_sysc_info r8a7743_sysc_info;
+extern const struct rcar_sysc_info r8a7745_sysc_info;
 extern const struct rcar_sysc_info r8a7779_sysc_info;
 extern const struct rcar_sysc_info r8a7790_sysc_info;
 extern const struct rcar_sysc_info r8a7791_sysc_info;
-- 
2.7.0.rc3.207.g0ac5344
