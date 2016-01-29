From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 29 Jan 2016 12:04:33 -0800
Subject: [PATCH] clocksource/arm_arch_timer: Enable and verify MMIO access
In-Reply-To: <56ABC13B.9080500@arm.com>
References: <b4ccba950f8fe0433b8e258a1fc0b8977bbe82d5.1454079150.git.robin.murphy@arm.com>
 <20160129183051.GO12841@codeaurora.org> <56ABC13B.9080500@arm.com>
Message-ID: <20160129200433.GR12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29, Robin Murphy wrote:
> On 29/01/16 18:30, Stephen Boyd wrote:
> >On 01/29, Robin Murphy wrote:
> >Hm, that first sentence is sort of misleading. We've been blindly
> >assuming that the firmware has configured CNTACR to have the
> >correct bits set for virtual/physical access. We've always relied
> >on status = "disabled" to figure out if we can access an entire
> >frame or not.
> 
> Yeah, now that I read it back that sentence is nonsense for anything
> other than the very specific ideas of "frame" and "exists" that were
> passing through my head at some point last week - how about this
> instead?
> 
> "So far, we have been blindly assuming that having access to a
> memory-mapped timer frame implies that the individual elements of
> that frame are already enabled."

Sounds good.

> 
> >>
> >>Explicitly enable feature-level access per-frame, and verify that the
> >>access we want is really implemented before trying to make use of it.
> >>
> >>Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >>---
> >>  drivers/clocksource/arm_arch_timer.c | 39 ++++++++++++++++++++++++++++--------
> >>  1 file changed, 31 insertions(+), 8 deletions(-)
> >>
> >>diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> >>index c64d543..c88485d 100644
> >>--- a/drivers/clocksource/arm_arch_timer.c
> >>+++ b/drivers/clocksource/arm_arch_timer.c
> >>@@ -765,20 +772,34 @@ static void __init arch_timer_mem_init(struct device_node *np)
> >>  	 */
> >>  	for_each_available_child_of_node(np, frame) {
> >>  		int n;
> >>+		u32 cntacr;
> >>
> >>  		if (of_property_read_u32(frame, "frame-number", &n)) {
> >>  			pr_err("arch_timer: Missing frame-number\n");
> >>-			of_node_put(best_frame);
> >>  			of_node_put(frame);
> >>-			return;
> >>+			goto out;
> >>  		}
> >>
> >>-		if (cnttidr & CNTTIDR_VIRT(n)) {
> >>+		/* Try enabling everything, and see what sticks */
> >>+		cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
> >>+			 CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
> >>+		writel_relaxed(cntacr, cntctlbase + CNTACR(n));
> >>+		cntacr = readl_relaxed(cntctlbase + CNTACR(n));
> >>+
> >>+		if (~cntacr & CNTACR_RFRQ)
> >>+			continue;
> >
> >Do we need this check? If we can't read the frequency we fall
> >back to looking for the DT property, so it shouldn't matter if we
> >can't read the hardware there.
> 
> I was really just playing safe to start with. If we don't have cause
> to care about the difference between not having access vs. not
> having a frequency programmed then I'd agree it can probably go.
> 

Yeah I'm mostly worried that we'll break something somewhere
because that bit doesn't stick and it's the only frame we can
use. Or we can give it a shot and then remove clock-frequency
from the dts binding for mmio timers.

> 
> Great, thanks. The Trusted Firmware guys' warning shot has gone
> upstream already, if it helps:
> 
> https://github.com/ARM-software/arm-trusted-firmware/commit/01fc3f7300e86b0b672977133c3028d638d0c672

Ah I see. It would be nice if that bug gave a reason why it
should be done, instead of just saying it must be this way. O
well.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
