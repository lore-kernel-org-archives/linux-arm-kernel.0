From: balbi@ti.com (Felipe Balbi)
Date: Mon, 10 Aug 2015 16:41:47 -0500
Subject: [RFC/PATCH-v4.2-rc6 1/5] Revert "ARM: 7655/1: smp_twd: make
 twd_local_timer_of_register() no-op for nosmp"
In-Reply-To: <1439242911-715-1-git-send-email-balbi@ti.com>
References: <1439242911-715-1-git-send-email-balbi@ti.com>
Message-ID: <1439242911-715-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 904464b91eca8c665acea033489225af02eeb75a.

The problem pointed out by commit 904464b91eca ("ARM: 7655/1:
smp_twd: make twd_local_timer_of_register() no-op for nosmp")
doesn't exist anymore.

We can safely boot with nosmp and the warning won't show up.

The other side benefit of this patch is that TWD has a chance
to probe on single-core A9 systems such as AM437x which sport
TWD.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/kernel/smp_twd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 172c6a05d27f..e8f6d241881f 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -23,7 +23,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 
-#include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
 
 /* set up by the platform code */
@@ -388,9 +387,6 @@ static void __init twd_local_timer_of_register(struct device_node *np)
 {
 	int err;
 
-	if (!is_smp() || !setup_max_cpus)
-		return;
-
 	twd_ppi = irq_of_parse_and_map(np, 0);
 	if (!twd_ppi) {
 		err = -EINVAL;
-- 
2.5.0
