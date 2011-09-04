From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 4 Sep 2011 19:24:11 +0530
Subject: [PATCH 10/25] OMAP4: PM: Initialise all the clockdomains to supported
	states
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1315144466-9395-11-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise hardware supervised mode for all clockdomains if it's
supported. Initiate sleep transition for other clockdomains,
if they are not being used.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 0154363..44ce15c 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 
 #include "powerdomain.h"
+#include "clockdomain.h"
 #include <mach/omap4-common.h>
 
 struct power_state {
@@ -73,6 +74,22 @@ static const struct platform_suspend_ops omap_pm_ops = {
 };
 #endif /* CONFIG_SUSPEND */
 
+/*
+ * Enable hardware supervised mode for all clockdomains if it's
+ * supported. Initiate sleep transition for other clockdomains, if
+ * they are not used
+ */
+static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
+{
+	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
+		clkdm_allow_idle(clkdm);
+	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
+			atomic_read(&clkdm->usecount) == 0)
+		clkdm_sleep(clkdm);
+	return 0;
+}
+
+
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
@@ -161,6 +178,8 @@ static int __init omap4_pm_init(void)
 		goto err2;
 	}
 
+	(void) clkdm_for_each(clkdms_setup, NULL);
+
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
-- 
1.7.4.1
