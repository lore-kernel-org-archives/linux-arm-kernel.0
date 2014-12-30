From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Dec 2014 13:28:32 -0600
Subject: [PATCH 3/9] ARM: versatile: add DT based PCI detection
In-Reply-To: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
Message-ID: <1419967718-26909-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Disable the Versatile PCI DT node when no PCI backplane is detected. This
will prevent the Versatile PCI driver from probing when PCI is not
populated.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-versatile/versatile_dt.c | 46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index 9f9bc61..5053810 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -22,15 +22,61 @@
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
+
+static void __init versatile_dt_pci_init(void)
+{
+	u32 val;
+	void __iomem *base;
+	struct device_node *np;
+	struct property *newprop;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,core-module-versatile");
+	if (!np)
+		return;
+
+	base = of_iomap(np, 0);
+	if (!base)
+		return;
+
+	/* Check if PCI backplane is detected */
+	val = __raw_readl(base + VERSATILE_SYS_PCICTL_OFFSET);
+	if (val & 1)
+		goto err;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,versatile-pci");
+	if (!np)
+		goto err;
+
+	newprop = kzalloc(sizeof(*newprop), GFP_KERNEL);
+	if (!newprop)
+		goto err;
+
+	newprop->name = kstrdup("status", GFP_KERNEL);
+	newprop->value = kstrdup("disabled", GFP_KERNEL);
+	newprop->length = sizeof("disabled");
+	of_update_property(np, newprop);
+
+	pr_info("Not plugged into PCI backplane!\n");
+err:
+	iounmap(base);
+}
+
 static void __init versatile_dt_init(void)
 {
+	versatile_dt_pci_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     versatile_auxdata_lookup, NULL);
 }
-- 
2.1.0
