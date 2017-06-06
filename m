From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:25 +0200
Subject: [PATCH v4 27/28] soc: actions: owl-sps: Factor out owl_sps_set_pg()
 for power-gating
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-28-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the SMP code to reuse PM domain code for CPU2/CPU3 wakeup.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v4: new
 
 drivers/soc/actions/Kconfig          |  4 +++
 drivers/soc/actions/Makefile         |  1 +
 drivers/soc/actions/owl-sps-helper.c | 51 ++++++++++++++++++++++++++++++++++++
 drivers/soc/actions/owl-sps.c        | 34 +++---------------------
 include/linux/soc/actions/owl-sps.h  | 11 ++++++++
 5 files changed, 70 insertions(+), 31 deletions(-)
 create mode 100644 drivers/soc/actions/owl-sps-helper.c
 create mode 100644 include/linux/soc/actions/owl-sps.h

diff --git a/drivers/soc/actions/Kconfig b/drivers/soc/actions/Kconfig
index bdf827d5ce78..9d68b5a771c3 100644
--- a/drivers/soc/actions/Kconfig
+++ b/drivers/soc/actions/Kconfig
@@ -1,8 +1,12 @@
 if ARCH_ACTIONS || COMPILE_TEST
 
+config OWL_PM_DOMAINS_HELPER
+	bool
+
 config OWL_PM_DOMAINS
 	bool "Actions Semi SPS power domains"
 	depends on PM
+	select OWL_PM_DOMAINS_HELPER
 	select PM_GENERIC_DOMAINS
 	help
 	  Say 'y' here to enable support for Smart Power System (SPS)
diff --git a/drivers/soc/actions/Makefile b/drivers/soc/actions/Makefile
index 720c34ed16e4..1e101b06bab1 100644
--- a/drivers/soc/actions/Makefile
+++ b/drivers/soc/actions/Makefile
@@ -1 +1,2 @@
+obj-$(CONFIG_OWL_PM_DOMAINS_HELPER) += owl-sps-helper.o
 obj-$(CONFIG_OWL_PM_DOMAINS) += owl-sps.o
diff --git a/drivers/soc/actions/owl-sps-helper.c b/drivers/soc/actions/owl-sps-helper.c
new file mode 100644
index 000000000000..9d7a2c2b44ec
--- /dev/null
+++ b/drivers/soc/actions/owl-sps-helper.c
@@ -0,0 +1,51 @@
+/*
+ * Actions Semi Owl Smart Power System (SPS) shared helpers
+ *
+ * Copyright 2012 Actions Semi Inc.
+ * Author: Actions Semi, Inc.
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#define OWL_SPS_PG_CTL	0x0
+
+int owl_sps_set_pg(void __iomem *base, u32 pwr_mask, u32 ack_mask, bool enable)
+{
+	u32 val;
+	bool ack;
+	int timeout;
+
+	val = readl(base + OWL_SPS_PG_CTL);
+	ack = val & ack_mask;
+	if (ack == enable)
+		return 0;
+
+	if (enable)
+		val |= pwr_mask;
+	else
+		val &= ~pwr_mask;
+
+	writel(val, base + OWL_SPS_PG_CTL);
+
+	for (timeout = 5000; timeout > 0; timeout -= 50) {
+		val = readl(base + OWL_SPS_PG_CTL);
+		if ((val & ack_mask) == (enable ? ack_mask : 0))
+			break;
+		udelay(50);
+	}
+	if (timeout <= 0)
+		return -ETIMEDOUT;
+
+	udelay(10);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(owl_sps_set_pg);
diff --git a/drivers/soc/actions/owl-sps.c b/drivers/soc/actions/owl-sps.c
index d9160579b542..41991c5217a0 100644
--- a/drivers/soc/actions/owl-sps.c
+++ b/drivers/soc/actions/owl-sps.c
@@ -12,15 +12,12 @@
  * option) any later version.
  */
 
-#include <linux/delay.h>
-#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_domain.h>
+#include <linux/soc/actions/owl-sps.h>
 #include <dt-bindings/power/s500-powergate.h>
 
-#define OWL_SPS_PG_CTL	0x0
-
 struct owl_sps_domain_info {
 	const char *name;
 	int pwr_bit;
@@ -51,37 +48,12 @@ struct owl_sps_domain {
 
 static int owl_sps_set_power(struct owl_sps_domain *pd, bool enable)
 {
-	u32 val, pwr_mask, ack_mask;
-	int timeout;
-	bool ack;
+	u32 pwr_mask, ack_mask;
 
 	ack_mask = BIT(pd->info->ack_bit);
 	pwr_mask = BIT(pd->info->pwr_bit);
-	val = readl(pd->sps->base + OWL_SPS_PG_CTL);
-	ack = val & ack_mask;
-
-	if (ack == enable)
-		return 0;
-
-	if (enable)
-		val |= pwr_mask;
-	else
-		val &= ~pwr_mask;
-
-	writel(val, pd->sps->base + OWL_SPS_PG_CTL);
 
-	for (timeout = 5000; timeout > 0; timeout -= 50) {
-		val = readl(pd->sps->base + OWL_SPS_PG_CTL);
-		if ((val & ack_mask) == (enable ? ack_mask : 0))
-			break;
-		udelay(50);
-	}
-	if (timeout <= 0)
-		return -ETIMEDOUT;
-
-	udelay(10);
-
-	return 0;
+	return owl_sps_set_pg(pd->sps->base, pwr_mask, ack_mask, enable);
 }
 
 static int owl_sps_power_on(struct generic_pm_domain *domain)
diff --git a/include/linux/soc/actions/owl-sps.h b/include/linux/soc/actions/owl-sps.h
new file mode 100644
index 000000000000..33d0dbeceb55
--- /dev/null
+++ b/include/linux/soc/actions/owl-sps.h
@@ -0,0 +1,11 @@
+/*
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: GPL-2.0+
+ */
+#ifndef SOC_ACTIONS_OWL_SPS_H
+#define SOC_ACTIONS_OWL_SPS_H
+
+int owl_sps_set_pg(void __iomem *base, u32 pwr_mask, u32 ack_mask, bool enable);
+
+#endif
-- 
2.12.3
