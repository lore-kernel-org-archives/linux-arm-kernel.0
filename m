From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  9 May 2016 14:06:37 +0100
Subject: [PATCH] clocksource/arm_arch_timer: Force per-CPU interrupt to
 trigger on level-high
Message-ID: <1462799197-31286-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM architected timer produces level-triggered interrupts (this
is mandated by the architecture). Unfortunately, most device-trees
get this wrong, and expose an edge-triggered interrupt.

Until now, this wasn't too much an issue, as the programming of the
trigger would fail (the corresponding PPI cannot be reconfigured),
and the kernel would be happy with this. But we're about to change
this, and trust DT a lot if the driver doesn't provide its own
trigger information. In that context, the timer breaks badly.

While we do need to fix the DTs, there is also some userspace out
there (kvmtool) that generates the same kind of broken DT on the
fly, and that will completely break with newer kernels.

As a safety measure, and to keep buggy software alive as well as
buying us some time to fix DTs all over the place, let's enforce
the interrupt trigger in the timer driver. This doesn't cost
us anything, and ensures that this will work in all situations,
broken DT or not.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5152b38..fdf367ae 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -366,7 +366,7 @@ static int arch_timer_setup(struct clock_event_device *clk)
 {
 	__arch_timer_setup(ARCH_CP15_TIMER, clk);
 
-	enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], 0);
+	enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], IRQF_TRIGGER_HIGH);
 
 	if (arch_timer_has_nonsecure_ppi())
 		enable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI], 0);
-- 
2.1.4
