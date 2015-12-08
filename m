From: robh@kernel.org (Rob Herring)
Date: Tue,  8 Dec 2015 14:44:15 -0600
Subject: [PATCH 1/4] ARM: versatile: add DT based PCI detection
In-Reply-To: <1449607458-16850-1-git-send-email-robh@kernel.org>
References: <1449607458-16850-1-git-send-email-robh@kernel.org>
Message-ID: <1449607458-16850-2-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the Versatile PCI DT node when no PCI backplane is detected. This
will prevent the Versatile PCI driver from probing when PCI is not
populated.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-versatile/versatile_dt.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index 7de3e92..a585758 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -22,15 +22,65 @@
  */
 
 #include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/slab.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
 #include "core.h"
 
+#define VERSATILE_SYS_PCICTL_OFFSET           0x44
+static void __iomem *versatile_sys_base;
+
+static void __init versatile_dt_pci_init(void)
+{
+	u32 val;
+	struct device_node *np;
+	struct property *newprop;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,versatile-pci");
+	if (!np)
+		return;
+
+	/* Check if PCI backplane is detected */
+	val = readl(versatile_sys_base + VERSATILE_SYS_PCICTL_OFFSET);
+	if (val & 1) {
+		/*
+		 * Enable PCI accesses. Note that the documentaton is
+		 * inconsistent whether or not this is needed, but the old
+		 * driver had it so we will keep it.
+		 */
+		writel(1, versatile_sys_base + VERSATILE_SYS_PCICTL_OFFSET);
+		return;
+	}
+
+	newprop = kzalloc(sizeof(*newprop), GFP_KERNEL);
+	if (!newprop)
+		return;
+
+	newprop->name = kstrdup("status", GFP_KERNEL);
+	newprop->value = kstrdup("disabled", GFP_KERNEL);
+	newprop->length = sizeof("disabled");
+	of_update_property(np, newprop);
+
+	pr_info("Not plugged into PCI backplane!\n");
+}
+
 static void __init versatile_dt_init(void)
 {
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,core-module-versatile");
+	if (np)
+		versatile_sys_base = of_iomap(np, 0);
+	WARN_ON(!versatile_sys_base);
+
+	versatile_dt_pci_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     versatile_auxdata_lookup, NULL);
 }
-- 
2.5.0
