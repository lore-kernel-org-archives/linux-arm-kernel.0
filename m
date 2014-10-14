From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Oct 2014 11:12:56 +0200
Subject: [PATCH 3/8] ARM: ux500: Initial support for PM domains
In-Reply-To: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
References: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413277981-27451-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ux500 SoC uses the generic PM domain and requires the domains to be
specified through DT.

Currently the genpd callbacks for handling power gating|ungating are
implemented as dummy functions. To be able to enable those to perform
PM domain gating/ungating, each device that resides in the VAPE domain
must be properly handled from a runtime PM perspective.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/Makefile     |  1 +
 arch/arm/mach-ux500/pm.c         |  4 ++
 arch/arm/mach-ux500/pm_domains.c | 79 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/pm_domains.h | 17 +++++++++
 4 files changed, 101 insertions(+)
 create mode 100644 arch/arm/mach-ux500/pm_domains.c
 create mode 100644 arch/arm/mach-ux500/pm_domains.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 9741de95..4418a50 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_MACH_MOP500)	+= board-mop500-regulators.o \
 				board-mop500-audio.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
+obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
 
 CFLAGS_hotplug.o		+= -march=armv7-a
diff --git a/arch/arm/mach-ux500/pm.c b/arch/arm/mach-ux500/pm.c
index b80a9a2..2cb587b 100644
--- a/arch/arm/mach-ux500/pm.c
+++ b/arch/arm/mach-ux500/pm.c
@@ -17,6 +17,7 @@
 #include <linux/platform_data/arm-ux500-pm.h>
 
 #include "db8500-regs.h"
+#include "pm_domains.h"
 
 /* ARM WFI Standby signal register */
 #define PRCM_ARM_WFI_STANDBY    (prcmu_base + 0x130)
@@ -191,4 +192,7 @@ void __init ux500_pm_init(u32 phy_base, u32 size)
 
 	/* Set up ux500 suspend callbacks. */
 	suspend_set_ops(UX500_SUSPEND_OPS);
+
+	/* Initialize ux500 power domains */
+	ux500_pm_domains_init();
 }
diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
new file mode 100644
index 0000000..0d4b5b4
--- /dev/null
+++ b/arch/arm/mach-ux500/pm_domains.c
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ * License terms: GNU General Public License (GPL) version 2
+ *
+ * Implements PM domains using the generic PM domain for ux500.
+ */
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/pm_domain.h>
+
+#include <dt-bindings/arm/ux500_pm_domains.h>
+#include "pm_domains.h"
+
+static int pd_power_off(struct generic_pm_domain *domain)
+{
+	/*
+	 * Handle the gating of the PM domain regulator here.
+	 *
+	 * Drivers/subsystems handling devices in the PM domain needs to perform
+	 * register context save/restore from their respective runtime PM
+	 * callbacks, to be able to enable PM domain gating/ungating.
+	 */
+	return 0;
+}
+
+static int pd_power_on(struct generic_pm_domain *domain)
+{
+	/*
+	 * Handle the ungating of the PM domain regulator here.
+	 *
+	 * Drivers/subsystems handling devices in the PM domain needs to perform
+	 * register context save/restore from their respective runtime PM
+	 * callbacks, to be able to enable PM domain gating/ungating.
+	 */
+	return 0;
+}
+
+static struct generic_pm_domain ux500_pm_domain_vape = {
+	.name = "VAPE",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain *ux500_pm_domains[NR_DOMAINS] = {
+	[DOMAIN_VAPE] = &ux500_pm_domain_vape,
+};
+
+static struct of_device_id ux500_pm_domain_matches[] = {
+	{ .compatible = "stericsson,ux500-pm-domains", },
+	{ },
+};
+
+int __init ux500_pm_domains_init(void)
+{
+	struct device_node *np;
+	struct genpd_onecell_data *genpd_data;
+	int i;
+
+	np = of_find_matching_node(NULL, ux500_pm_domain_matches);
+	if (!np)
+		return -ENODEV;
+
+	genpd_data = kzalloc(sizeof(*genpd_data), GFP_KERNEL);
+	if (!genpd_data)
+		return -ENOMEM;
+
+	genpd_data->domains = ux500_pm_domains;
+	genpd_data->num_domains = ARRAY_SIZE(ux500_pm_domains);
+
+	for (i = 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
+		pm_genpd_init(ux500_pm_domains[i], NULL, false);
+
+	of_genpd_add_provider_onecell(np, genpd_data);
+	return 0;
+}
diff --git a/arch/arm/mach-ux500/pm_domains.h b/arch/arm/mach-ux500/pm_domains.h
new file mode 100644
index 0000000..263d3ba
--- /dev/null
+++ b/arch/arm/mach-ux500/pm_domains.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __MACH_UX500_PM_DOMAINS_H
+#define __MACH_UX500_PM_DOMAINS_H
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS
+extern int __init ux500_pm_domains_init(void);
+#else
+static inline int ux500_pm_domains_init(void) { return 0; }
+#endif
+
+#endif
-- 
1.9.1
