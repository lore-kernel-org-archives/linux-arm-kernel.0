From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed,  9 Dec 2009 23:59:09 +0530
Subject: [PATCH 5/6] OMAP4: Remove the secondary wait loop.
In-Reply-To: <1260383350-32681-4-git-send-email-santosh.shilimkar@ti.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-2-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-3-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-4-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1260383350-32681-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The secondary cores wakes up in time so the wait loop is not
necessary anymore.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-smp.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 59e8478..38153e5 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -17,7 +17,6 @@
  */
 #include <linux/init.h>
 #include <linux/device.h>
-#include <linux/jiffies.h>
 #include <linux/smp.h>
 #include <linux/io.h>
 
@@ -62,8 +61,6 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 
 int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	unsigned long timeout;
-
 	/*
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
@@ -80,10 +77,6 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	flush_cache_all();
 	smp_wmb();
 
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout))
-		;
-
 	/*
 	 * Now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
-- 
1.6.0.4
