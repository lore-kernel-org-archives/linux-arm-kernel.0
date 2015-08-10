From: balbi@ti.com (Felipe Balbi)
Date: Mon, 10 Aug 2015 16:41:50 -0500
Subject: [RFC/PATCH-v4.2-rc6 4/5] arm: omap2: timer: simplify
 omap4_local_timer_init()
In-Reply-To: <1439242911-715-1-git-send-email-balbi@ti.com>
References: <1439242911-715-1-git-send-email-balbi@ti.com>
Message-ID: <1439242911-715-5-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

all users of omap4_local_timer_init() are already
DT-only, so we can remove the check for having
DTB or not.

While at that, fix a typo in comment.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index cac46d852da1..88d39f98e7ff 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -649,23 +649,15 @@ static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
 
 #ifdef CONFIG_ARCH_OMAP4
 #ifdef CONFIG_HAVE_ARM_TWD
-static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, 29);
 void __init omap4_local_timer_init(void)
 {
 	omap4_sync32k_timer_init();
-	/* Local timers are not supprted on OMAP4430 ES1.0 */
-	if (omap_rev() != OMAP4430_REV_ES1_0) {
-		int err;
 
-		if (of_have_populated_dt()) {
-			clocksource_of_init();
-			return;
-		}
+	/* Local timers are not supported on OMAP4430 ES1.0 */
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		return;
 
-		err = twd_local_timer_register(&twd_local_timer);
-		if (err)
-			pr_err("twd_local_timer_register failed %d\n", err);
-	}
+	clocksource_of_init();
 }
 #else
 void __init omap4_local_timer_init(void)
-- 
2.5.0
