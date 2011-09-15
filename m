From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 15 Sep 2011 16:35:12 +0900
Subject: [PATCH] arm: sched_clock: Enable HAVE_SCHED_CLOCK support without
	init_sched_clock
Message-ID: <20110915073511.GA31732@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

On Samsung Exynos4 series, EVT0 chip uses the s5p_timer with HAVE_SCHED_CLOCK and remains use the MCT timer without init_sched_clock.

The similar combination will be happend with other SOCs. some board use HAVE_SCHED_CLOCK or others are not.

To co-exist the these boards. check the sched_clock_update_fn when sched_clock_postinit is called and return if not defined.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 9a46370..12c6b6b 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -70,5 +70,8 @@ void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
 
 void __init sched_clock_postinit(void)
 {
+	/* If init_sched_clock is not called, just return */
+	if (!sched_clock_update_fn)
+		return;
 	sched_clock_poll(sched_clock_timer.data);
 }
