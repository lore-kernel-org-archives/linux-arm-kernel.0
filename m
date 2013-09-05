From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Sep 2013 15:23:31 +0900
Subject: [PATCH] ARM: shmobile: r8a7779: Update early timer initialisation
 order
In-Reply-To: <cover.1378362045.git.horms+renesas@verge.net.au>
References: <cover.1378362045.git.horms+renesas@verge.net.au>
Message-ID: <7658ea2fb57831c6836ffcfb20bcb84f3ff55dfb.1378362045.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

a894fcc2d01a89e6fe3da0845a4d80a5312e1124 ("ARM: smp_twd: Divorce smp_twd
from local timer API") altered twd_local_timer_common_register() so that it
may make use of late_timer_init.

This is problematic on marzen with Magnus's recent patch "ARM: shmobile:
marzen: Switch to DT_MACHINE_START" which switches marzen around to enable
USE_OF and thus shmobile_timer_init(), which is registered as
late_time_init by shmobile_earlytimer_init() stops being a no-op.

As a work-around I have updated r8a7779_earlytimer_init() so that
shmobile_earlytimer_init() is called after r8a7779_register_twd().
Or in other words, the shmobile_earlytimer_init() setting of
late_time_init overwrites that of twd_local_timer_common_register().

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Magnus Damm <damm@opensource.se>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 3986877..3c5fae5 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -616,8 +616,8 @@ void __init __weak r8a7779_register_twd(void) { }
 void __init r8a7779_earlytimer_init(void)
 {
 	r8a7779_clock_init();
-	shmobile_earlytimer_init();
 	r8a7779_register_twd();
+	shmobile_earlytimer_init();
 }
 
 void __init r8a7779_add_early_devices(void)
-- 
1.8.4
