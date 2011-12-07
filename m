From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Dec 2011 17:44:55 +0900
Subject: [PATCH] ARM: EXYNOS: Fix build error without CONFIG_LOCAL_TIMERS
Message-ID: <03f201ccb4bc$7e55b820$7b012860$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-exynos/mct.c: In function 'exynos4_timer_resources':
arch/arm/mach-exynos/mct.c:450: error: 'exynos4_mct_tick_isr' undeclared (first use in this function)
arch/arm/mach-exynos/mct.c:450: error: (Each undeclared identifier is reported only once
arch/arm/mach-exynos/mct.c:450: error: for each function it appears in.)
make[1]: *** [arch/arm/mach-exynos/mct.o] Error 1

Reported-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos/mct.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index 97343df..586c819 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -44,8 +44,6 @@ struct mct_clock_event_device {
 	char name[10];
 };
 
-static DEFINE_PER_CPU(struct mct_clock_event_device, percpu_mct_tick);
-
 static void exynos4_mct_write(unsigned int value, void *addr)
 {
 	void __iomem *stat_addr;
@@ -264,6 +262,9 @@ static void exynos4_clockevent_init(void)
 }
 
 #ifdef CONFIG_LOCAL_TIMERS
+
+static DEFINE_PER_CPU(struct mct_clock_event_device, percpu_mct_tick);
+
 /* Clock event handling */
 static void exynos4_mct_tick_stop(struct mct_clock_event_device *mevt)
 {
@@ -443,6 +444,7 @@ static void __init exynos4_timer_resources(void)
 
 	clk_rate = clk_get_rate(mct_clk);
 
+#ifdef CONFIG_LOCAL_TIMERS
 	if (mct_int_type == MCT_INT_PPI) {
 		int err;
 
@@ -452,6 +454,7 @@ static void __init exynos4_timer_resources(void)
 		WARN(err, "MCT: can't request IRQ %d (%d)\n",
 		     IRQ_MCT_LOCALTIMER, err);
 	}
+#endif /* CONFIG_LOCAL_TIMERS */
 }
 
 static void __init exynos4_timer_init(void)
-- 
1.7.1
