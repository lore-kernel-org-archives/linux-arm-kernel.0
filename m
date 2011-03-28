From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 28 Mar 2011 14:52:22 +0530
Subject: [pm-core][PATCH v3 06/21] OMAP4: PM: Initialise all the clockdomains
	to supported states
In-Reply-To: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1301304157-2466-7-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise hardware supervised mode for all clockdomains if it's
supported. Initiate sleep transition for other clockdomains,
if they are not being used.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 5b631f5..4f932f3 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -16,9 +16,11 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
-#include "powerdomain.h"
 #include <mach/omap4-common.h>
 
+#include "powerdomain.h"
+#include "clockdomain.h"
+
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
@@ -73,6 +75,22 @@ static const struct platform_suspend_ops omap_pm_ops = {
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
@@ -111,6 +129,8 @@ static int __init omap4_pm_init(void)
 		goto err2;
 	}
 
+	(void) clkdm_for_each(clkdms_setup, NULL);
+
 	ret = omap4_mpuss_init();
 	if (ret) {
 		pr_err("Failed to initialise OMAP4 MPUSS\n");
-- 
1.6.0.4
