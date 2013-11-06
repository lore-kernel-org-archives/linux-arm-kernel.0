From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  6 Nov 2013 10:05:48 +0000
Subject: [PATCH 7/7] ARM: ux500: Remove checking for DT during timer init as
 we are now DT only
In-Reply-To: <1383732348-18576-1-git-send-email-lee.jones@linaro.org>
References: <1383732348-18576-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1383732348-18576-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/timer.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index 05a4ff7..ca60bbd 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -27,18 +27,11 @@ static DEFINE_TWD_LOCAL_TIMER(u8500_twd_local_timer,
 static void __init ux500_twd_init(void)
 {
 	struct twd_local_timer *twd_local_timer;
-	int err;
 
 	/* Use this to switch local timer base if changed in new ASICs */
 	twd_local_timer = &u8500_twd_local_timer;
 
-	if (of_have_populated_dt())
-		clocksource_of_init();
-	else {
-		err = twd_local_timer_register(twd_local_timer);
-		if (err)
-			pr_err("twd_local_timer_register failed %d\n", err);
-	}
+	clocksource_of_init();
 }
 #else
 #define ux500_twd_init()	do { } while(0)
@@ -63,20 +56,15 @@ void __init ux500_timer_init(void)
 		ux500_unknown_soc();
 	}
 
-	/* TODO: Once MTU has been DT:ed place code above into else. */
-	if (of_have_populated_dt()) {
-#ifdef CONFIG_OF
-		np = of_find_matching_node(NULL, prcmu_timer_of_match);
-		if (!np)
-#endif
-			goto dt_fail;
+	np = of_find_matching_node(NULL, prcmu_timer_of_match);
+	if (!np)
+		goto dt_fail;
 
-		tmp_base = of_iomap(np, 0);
-		if (!tmp_base)
-			goto dt_fail;
+	tmp_base = of_iomap(np, 0);
+	if (!tmp_base)
+		goto dt_fail;
 
-		prcmu_timer_base = tmp_base;
-	}
+	prcmu_timer_base = tmp_base;
 
 dt_fail:
 	/* Doing it the old fashioned way. */
-- 
1.8.1.2
