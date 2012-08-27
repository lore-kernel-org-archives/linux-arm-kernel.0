From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 28 Aug 2012 01:26:14 +0300
Subject: [PATCH] ARM: OMAP: timer: obey the !CONFIG_OMAP_32K_TIMER
Message-ID: <1346106374-3283-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, omap2_sync32k_clocksource_init() function initializes the 32K
timer as the system clock source regardless of the CONFIG_OMAP_32K_TIMER
setting.
Fix this by providing a default implementation for
!CONFIG_OMAP_32K_TIMER case.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Reviewed-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/timer.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 840929b..2cdbcc7 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -263,6 +263,7 @@ static u32 notrace dmtimer_read_sched_clock(void)
 	return 0;
 }
 
+#ifdef CONFIG_OMAP_32K_TIMER
 /* Setup free-running counter for clocksource */
 static int __init omap2_sync32k_clocksource_init(void)
 {
@@ -302,6 +303,12 @@ static int __init omap2_sync32k_clocksource_init(void)
 
 	return ret;
 }
+#else
+static inline int omap2_sync32k_clocksource_init(void)
+{
+	return -ENODEV;
+}
+#endif
 
 static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 						const char *fck_source)
-- 
1.7.3.4
