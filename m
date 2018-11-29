From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 29 Nov 2018 12:09:30 +0100
Subject: [PATCH 1/2] ARM: shmobile: R-Mobile: Clean up struct rmobile_pm_domain
In-Reply-To: <20181129110931.11783-1-geert+renesas@glider.be>
References: <20181129110931.11783-1-geert+renesas@glider.be>
Message-ID: <20181129110931.11783-2-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 59b89af1d5551c12 ("ARM: shmobile: sh7372: Remove Legacy C
SoC code") removed the last user of the rmobile_pm_domain.resume()
callback.

Commit 44d88c754e57a6d9 ("ARM: shmobile: Remove legacy SoC code
for R-Mobile A1") removed the last user of the rmobile_pm_domain.no_debug
flag and of the "pm-rmobile.h" header file (outside the actual driver).

Hence remove no longer used rmobile_pm_domain members, and absorb the
header file into the driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 37 ++++++++++++++---------------
 arch/arm/mach-shmobile/pm-rmobile.h | 22 -----------------
 2 files changed, 18 insertions(+), 41 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/pm-rmobile.h

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index c6a11b5ec6dbc704..421ae1c887d824d0 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -18,12 +18,11 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_clock.h>
+#include <linux/pm_domain.h>
 #include <linux/slab.h>
 
 #include <asm/io.h>
 
-#include "pm-rmobile.h"
-
 /* SYSC */
 #define SPDCR		0x08	/* SYS Power Down Control Register */
 #define SWUCR		0x14	/* SYS Wakeup Control Register */
@@ -32,6 +31,14 @@
 #define PSTR_RETRIES	100
 #define PSTR_DELAY_US	10
 
+struct rmobile_pm_domain {
+	struct generic_pm_domain genpd;
+	struct dev_power_governor *gov;
+	int (*suspend)(void);
+	void __iomem *base;
+	unsigned int bit_shift;
+};
+
 static inline
 struct rmobile_pm_domain *to_rmobile_pd(struct generic_pm_domain *d)
 {
@@ -65,16 +72,13 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 		}
 	}
 
-	if (!rmobile_pd->no_debug)
-		pr_debug("%s: Power off, 0x%08x -> PSTR = 0x%08x\n",
-			 genpd->name, mask,
-			 __raw_readl(rmobile_pd->base + PSTR));
+	pr_debug("%s: Power off, 0x%08x -> PSTR = 0x%08x\n", genpd->name, mask,
+		 __raw_readl(rmobile_pd->base + PSTR));
 
 	return 0;
 }
 
-static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd,
-				 bool do_resume)
+static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd)
 {
 	unsigned int mask;
 	unsigned int retry_count;
@@ -85,7 +89,7 @@ static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd,
 
 	mask = BIT(rmobile_pd->bit_shift);
 	if (__raw_readl(rmobile_pd->base + PSTR) & mask)
-		goto out;
+		return ret;
 
 	__raw_writel(mask, rmobile_pd->base + SWUCR);
 
@@ -100,21 +104,16 @@ static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd,
 	if (!retry_count)
 		ret = -EIO;
 
-	if (!rmobile_pd->no_debug)
-		pr_debug("%s: Power on, 0x%08x -> PSTR = 0x%08x\n",
-			 rmobile_pd->genpd.name, mask,
-			 __raw_readl(rmobile_pd->base + PSTR));
-
-out:
-	if (ret == 0 && rmobile_pd->resume && do_resume)
-		rmobile_pd->resume();
+	pr_debug("%s: Power on, 0x%08x -> PSTR = 0x%08x\n",
+		 rmobile_pd->genpd.name, mask,
+		 __raw_readl(rmobile_pd->base + PSTR));
 
 	return ret;
 }
 
 static int rmobile_pd_power_up(struct generic_pm_domain *genpd)
 {
-	return __rmobile_pd_power_up(to_rmobile_pd(genpd), true);
+	return __rmobile_pd_power_up(to_rmobile_pd(genpd));
 }
 
 static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
@@ -127,7 +126,7 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	genpd->power_on			= rmobile_pd_power_up;
 	genpd->attach_dev		= cpg_mstp_attach_dev;
 	genpd->detach_dev		= cpg_mstp_detach_dev;
-	__rmobile_pd_power_up(rmobile_pd, false);
+	__rmobile_pd_power_up(rmobile_pd);
 	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
 }
 
diff --git a/arch/arm/mach-shmobile/pm-rmobile.h b/arch/arm/mach-shmobile/pm-rmobile.h
deleted file mode 100644
index 69f839259b092002..0000000000000000
--- a/arch/arm/mach-shmobile/pm-rmobile.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2012 Renesas Solutions Corp.
- *
- * Kuninori Morimoto <morimoto.kuninori@renesas.com>
- */
-#ifndef PM_RMOBILE_H
-#define PM_RMOBILE_H
-
-#include <linux/pm_domain.h>
-
-struct rmobile_pm_domain {
-	struct generic_pm_domain genpd;
-	struct dev_power_governor *gov;
-	int (*suspend)(void);
-	void (*resume)(void);
-	void __iomem *base;
-	unsigned int bit_shift;
-	bool no_debug;
-};
-
-#endif /* PM_RMOBILE_H */
-- 
2.17.1
