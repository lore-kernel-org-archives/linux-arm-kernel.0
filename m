From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 26 Apr 2011 09:36:36 -0700
Subject: [patch 01/16] time: Provide clocksource based sched_clock()
In-Reply-To: <20110423205131.574884925@linutronix.de>
References: <20110423205036.795894921@linutronix.de>
	<20110423205131.574884925@linutronix.de>
Message-ID: <4DB6F494.3040804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2011 01:54 PM, Thomas Gleixner wrote:
> Many embedded platforms use the clocksource which is used for
> timekeeping as their sched_clock as well. Though they need to take
> care about the wraparounds as sched_clock() wants to be monotonic
> increasing nsescs. The timekeeping code and the NOHZ core take care of
> the timekeeping clocksource wraparound so we can simply use the
> timekeeping clocksource if possible.
>
> clocksources which can be used by the clksrc sched_clock must have the
> flag CLOCK_SOURCE_SCHED_CLOCK set. This works with the default (weak)
> sched_clock implementation but the clksrc based function is also
> provided for architectures where multi platform kernels might override
> it. If there is no CLOCK_SOURCE_SCHED_CLOCK available, then the
> function returns the jiffies based sched clock.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Stephen Boyd <sboyd@codeaurora.org>

MSM doesn't have a sched_clock(), so I applied this patch on top. Care
to pick it up?

8<-----

Subject: [PATCH] msm: timer: Support clocksource sched_clock()

With the clocksource sched_clock() implementation we can support
sched_clock on MSM with little effort.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/timer.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 38b95e9..c875f9a 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -96,7 +96,7 @@ static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
        return IRQ_HANDLED;
 }

-static cycle_t msm_read_timer_count(struct clocksource *cs)
+static cycle_t notrace msm_read_timer_count(struct clocksource *cs)
 {
        struct msm_clock *clk = container_of(cs, struct msm_clock, clocksource);

@@ -186,7 +186,8 @@ static struct msm_clock msm_clocks[] = {
                        .rating         = 300,
                        .read           = msm_read_timer_count,
                        .mask           = CLOCKSOURCE_MASK((32 - MSM_DGT_SHIFT)),
-                       .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
+                       .flags          = CLOCK_SOURCE_IS_CONTINUOUS |
+                                         CLOCK_SOURCE_SCHED_CLOCK,
                },
                .irq = {
                        .name    = "dg_timer",

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
