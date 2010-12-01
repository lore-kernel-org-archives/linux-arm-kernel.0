From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 1 Dec 2010 16:35:47 +0000
Subject: [PATCH] ARM: perf: use raw_spinlock_t for pmu_lock
In-Reply-To: <1291137443-13821-1-git-send-email-will.deacon@arm.com>
References: <1291137443-13821-1-git-send-email-will.deacon@arm.com>
Message-ID: <20101201163547.GE2898@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 05:17:23PM +0000, Will Deacon wrote:
> For kernels built with PREEMPT_RT, critical sections protected
> by standard spinlocks are preemptible. This is not acceptable
> on perf as (a) we may be scheduled onto a different CPU whilst
> reading/writing banked PMU registers and (b) the latency when
> reading the PMU registers becomes unpredictable.
> 
> This patch upgrades the pmu_lock spinlock to a raw_spinlock
> instead.
> 
> Reported-by: Jamie Iles <jamie@jamieiles.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
Hi Will, 

Looks fine to me and tested on my board (not with PREEMPT_RT at the moment 
though). Btw, it may be my mail reader (mutt) but trying to save your mail to 
an mbox gave lots of extra characters in the patch like:

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v=
6.c
index 3f427aa..c058bfc 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -426,12 +426,12 @@ armv6pmu_enable_event(struct hw_perf_event *hwc,
 =09 * Mask out the current event and set the counter to count the event
 =09 * that we're interested in.
 =09 */
-=09spin_lock_irqsave(&pmu_lock, flags);
+=09raw_spin_lock_irqsave(&pmu_lock, flags);

Possibly an Exchange thing? Saving the message body worked and your 
hw_breakpoint patches are fine.

Jamie
