From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 7 Jun 2012 16:22:07 -0500
Subject: [PATCH V2 05/10] ARM: OMAP2+: PMU: Add runtime PM support
In-Reply-To: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1339104132-26885-6-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original implementation of this patch was done by Ming Lei for PMU on OMAP4
[1]. Since then the PM runtime calls have been moved into the ARM PMU code and
this greatly simplifies the changes.

The another differnce since the original version, is that it is no longer
necessary to call pm_runtime_get/put during the PMU initialisation was we are no
longer accessing the hardware at this stage.

By adding runtime PM support, we can ensure that the appropriate power and clock
domains are kept on while PMU is being used.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074153.html

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/pmu.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index b3b9306..1b36eda 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -13,6 +13,8 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
+#include <linux/pm_runtime.h>
+
 #include <asm/pmu.h>
 
 #include <plat/omap_hwmod.h>
@@ -45,6 +47,9 @@ static int __init omap2_init_pmu(void)
 	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
 				dev_name);
 
+	if (omap_pmu_dev)
+		pm_runtime_enable(&omap_pmu_dev->dev);
+
 	return 0;
 }
 
@@ -88,6 +93,9 @@ static int __init omap4430_init_pmu(void)
 	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
 				dev_name);
 
+	if (omap_pmu_dev)
+		pm_runtime_enable(&omap_pmu_dev->dev);
+
 	return 0;
 }
 
-- 
1.7.9.5
