From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Aug 2011 14:55:09 +0100
Subject: [RFC PATCH 08/15] ARM: perf: remove unnecessary armpmu->stop
In-Reply-To: <1313416516-8006-1-git-send-email-mark.rutland@arm.com>
References: <1313416516-8006-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1313416516-8006-9-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As armpmu_disable will call armpmu->stop when the last event has been
removed, this is pointless and simply adds to the noise when debugging.
Additionally, due to this call occurring in a preemptible context, this
is problematic for per-cpu locking of PMU registers (where we will
attempt to access per-cpu spinlock for use with raw_spin_lock_irqsave).

This patch removes the call to armpmu->stop.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 9d6ac99..5ce6c33 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -396,7 +396,6 @@ armpmu_release_hardware(void)
 			free_irq(irq, NULL);
 	}
 
-	armpmu->stop();
 	release_pmu(ARM_PMU_DEVICE_CPU);
 }
 
-- 
1.7.0.4
