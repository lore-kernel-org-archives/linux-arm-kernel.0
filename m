From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Nov 2015 14:51:57 +0100
Subject: [PATCH v2] clocksource/drivers/dw_apb_timer: Use
 {readl|writel}_relaxed
In-Reply-To: <20151113205727.24354052@xhacker>
References: <1447417883-7881-1-git-send-email-jszhang@marvell.com>
 <3713227.4t0cg6qNF9@wuerfel> <20151113205727.24354052@xhacker>
Message-ID: <5804676.futR40KtNg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 November 2015 20:57:27 Jisheng Zhang wrote:
> 
> > that the conversion is correct. You could introduce apbt_readl_releaxed()
> > etc functions and call them from __apbt_read_clocksource()
> > and apbt_next_event().
> 
> I'm not sure whether such changes would make the code a bit complex. From
> another side, it's safe to always use relaxed version in this driver, so
> is it better to switch to relaxed version no matter the code path benefit from
> it or not?

We've had problems in the past when people blindly converted whole drivers,
so I try to discourage that in general, if only to get people to pay more
attention when copying from one driver to another.

> PS: for the global timer related patch, I just hack code a bit to make it works
> as clockevent on my platform, and I still try to think about a test case to
> measure the improvement, cyclictest? Any idea is appreciated.

Measuring performance of timers is tricky by definition, but you could try
to sample the amount of time you spend setting up timers like this

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index a2cb6fae9295..da88347718ae 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -95,6 +95,8 @@ static u64 gt_counter_read(void)
 static void gt_compare_set(unsigned long delta, int periodic)
 {
 	u64 counter = gt_counter_read();
+	static u64 total_time;
+	static u32 count;
 	unsigned long ctrl;
 
 	counter += delta;
@@ -110,6 +112,12 @@ static void gt_compare_set(unsigned long delta, int periodic)
 
 	ctrl |= GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE;
 	writel(ctrl, gt_base + GT_CONTROL);
+
+	total_time += gt_counter_read() - counter;
+	count++;
+
+	if (((count - 1) & 0xfff) == 0xfff)
+		printk(KERN_INFO "gt_compare_set time %lld\n", total_time / (count >> 12));
 }
 
 static int gt_clockevent_shutdown(struct clock_event_device *evt)

	Arnd
