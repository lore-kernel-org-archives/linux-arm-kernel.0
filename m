From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:22 +0900
Subject: [PATCH 06/21] ARM: shmobile: Remove obsolete earlytimer registration
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
Message-ID: <93161cb4c3c27517f1b4516a880adaf7df4112e2.1442478814.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The last caller of shmobile_earlytimer_init() was removed in commit
c99cd90d98a98aa1 ("ARM: shmobile: r8a7779: Remove legacy SoC code").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/common.h |  1 -
 arch/arm/mach-shmobile/timer.c  | 21 ---------------------
 2 files changed, 22 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index ee8fe9e473d7..2a350b48b893 100644
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
index f1d027aa7a81..c17d4d3881ff 100644
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
2.1.4
