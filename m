From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Aug 2015 20:03:11 +0200
Subject: [PATCH 6/7] ARM: shmobile: Remove obsolete earlytimer registration
In-Reply-To: <1438711392-23763-1-git-send-email-geert+renesas@glider.be>
References: <1438711392-23763-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1438711392-23763-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last caller of shmobile_earlytimer_init() was removed in commit
c99cd90d98a98aa1 ("ARM: shmobile: r8a7779: Remove legacy SoC code").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/common.h |  1 -
 arch/arm/mach-shmobile/timer.c  | 21 ---------------------
 2 files changed, 22 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index ee8fe9e473d72895..2a350b48b893a1b6 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -1,7 +1,6 @@
 #ifndef __ARCH_MACH_COMMON_H
 #define __ARCH_MACH_COMMON_H
 
-extern void shmobile_earlytimer_init(void);
 extern void shmobile_init_delay(void);
 struct twd_local_timer;
 extern void shmobile_boot_vector(void);
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index f1d027aa7a81ac33..c17d4d3881ffc45e 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -77,24 +77,3 @@ void __init shmobile_init_delay(void)
 			shmobile_setup_delay_hz(max_freq, 2, 4);
 	}
 }
-
-static void __init shmobile_late_time_init(void)
-{
-	/*
-	 * Make sure all compiled-in early timers register themselves.
-	 *
-	 * Run probe() for two "earlytimer" devices, these will be the
-	 * clockevents and clocksource devices respectively. In the event
-	 * that only a clockevents device is available, we -ENODEV on the
-	 * clocksource and the jiffies clocksource is used transparently
-	 * instead. No error handling is necessary here.
-	 */
-	early_platform_driver_register_all("earlytimer");
-	early_platform_driver_probe("earlytimer", 2, 0);
-}
-
-void __init shmobile_earlytimer_init(void)
-{
-	late_time_init = shmobile_late_time_init;
-}
-
-- 
1.9.1
