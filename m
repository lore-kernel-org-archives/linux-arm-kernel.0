From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Feb 2012 13:59:34 +0000
Subject: [PATCH 1/2] ARM: perf: clear overflow flag when disabling counter on
 ARMv7 PMU
Message-ID: <1329832775-11203-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When disabling a counter on an ARMv7 PMU, we should also clear the
overflow flag in case an overflow occurred whilst stopping the counter.
This prevents a spurious overflow being picked up later and leading to
either false accounting or a NULL dereference.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 6f48861..050cc8b 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -809,6 +809,11 @@ static inline int armv7_pmnc_disable_intens(int idx)
 
 	counter = ARMV7_IDX_TO_COUNTER(idx);
 	asm volatile("mcr p15, 0, %0, c9, c14, 2" : : "r" (BIT(counter)));
+	isb();
+	/* Clear the overflow flag in case an interrupt is pending. */
+	asm volatile("mcr p15, 0, %0, c9, c12, 3" : : "r" (BIT(counter)));
+	isb();
+
 	return idx;
 }
 
-- 
1.7.4.1
