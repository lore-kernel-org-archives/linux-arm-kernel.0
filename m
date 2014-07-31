From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Thu, 31 Jul 2014 18:28:05 -0300
Subject: [PATCH 2/9] ARM: sunxi: quirk support
In-Reply-To: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1406842092-25207-3-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, some hardware revisions of sunxi SoCs need special care on
some blocks because of hardware differences and/or bugs. Unfortunately,
it is unfeasible to account for these issues directly when writing the
device tree, as SoC revision can vary between different units of the
same device. This commit introduces a place to adjust DT compatibles
as needed to work around said issues before devices are probed. To
demonstrate usage, two quirks are added for the PLL2 and audio codec
on sun4i.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/mach-sunxi/Makefile |  2 +-
 arch/arm/mach-sunxi/quirks.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-sunxi/quirks.c

diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 589239b..7c13f99 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_ARCH_SUNXI) += sunxi.o sunxi-soc-id.o
+obj-$(CONFIG_ARCH_SUNXI) += sunxi.o sunxi-soc-id.o quirks.o
 obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-sunxi/quirks.c b/arch/arm/mach-sunxi/quirks.c
new file mode 100644
index 0000000..99cdaa0
--- /dev/null
+++ b/arch/arm/mach-sunxi/quirks.c
@@ -0,0 +1,82 @@
+/*
+ * Runtime quirk handling for sunxi SoCs
+ *
+ * Copyright 2014 Emilio L?pez
+ *
+ * Emilio L?pez <emilio@elopez.com.ar>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "sunxi-soc-id.h"
+
+static int __init update_compatible_string(const char *oldc, const char *newc)
+{
+	int count = 0;
+	struct property *newprop;
+	size_t newlen = strlen(newc);
+	struct device_node *np = NULL;
+
+	for_each_compatible_node(np, NULL, oldc) {
+		newprop = kzalloc(sizeof(*newprop), GFP_KERNEL);
+		if (!newprop)
+			return -ENOMEM;
+
+		newprop->name = kstrdup("compatible", GFP_KERNEL);
+		newprop->value = kstrdup(newc, GFP_KERNEL);
+		newprop->length = newlen;
+
+		if (!newprop->name || !newprop->value) {
+			kfree(newprop);
+			return -ENOMEM;
+		}
+
+		of_update_property(np, newprop);
+		count++;
+	}
+
+	return count;
+}
+
+static void __init sun4i_pll2_quirk(void)
+{
+	/* Only revision A is affected */
+	if (sunxi_soc_revision() != 'A')
+		return;
+
+	WARN_ON(!update_compatible_string("allwinner,sun4i-a10-b-pll2",
+					  "allwinner,sun4i-a10-a-pll2"));
+}
+
+static void __init sun4i_codec_quirk(void)
+{
+	/* Only revision A is affected */
+	if (sunxi_soc_revision() != 'A')
+		return;
+
+	WARN_ON(!update_compatible_string("allwinner,sun4i-a10-b-codec",
+					  "allwinner,sun4i-a10-a-codec"));
+}
+
+static int __init sunxi_apply_quirks(void)
+{
+	if (of_machine_is_compatible("allwinner,sun4i-a10")) {
+		sun4i_pll2_quirk();
+		sun4i_codec_quirk();
+	}
+
+	return 0;
+}
+postcore_initcall(sunxi_apply_quirks)
-- 
2.0.3
