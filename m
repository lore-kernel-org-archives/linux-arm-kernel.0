From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Aug 2012 18:36:31 +0100
Subject: [PATCH 5/9] ARM: perf: remove mysterious compiler barrier
In-Reply-To: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
Message-ID: <1344620195-22372-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a rather strange compiler barrier in the PMU disabling code
which was presumably placed there by aliens. There's no valid reason for
the barrier and one can only suspect that it's up to no good.

This patch removes it before it has a chance to spread.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 1ac1531..22ed512 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -223,7 +223,6 @@ armpmu_stop(struct perf_event *event, int flags)
 	 */
 	if (!(hwc->state & PERF_HES_STOPPED)) {
 		armpmu->disable(hwc, hwc->idx);
-		barrier(); /* why? */
 		armpmu_event_update(event, hwc, hwc->idx);
 		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
 	}
-- 
1.7.4.1
