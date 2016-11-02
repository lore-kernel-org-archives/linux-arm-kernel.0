From: wei@redhat.com (Wei Huang)
Date: Wed,  2 Nov 2016 15:55:32 -0500
Subject: [PATCH 1/1] KVM: ARM64: Fix the issues when PMCCFILTR is configured
Message-ID: <1478120132-9928-1-git-send-email-wei@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KVM calls kvm_pmu_set_counter_event_type() when PMCCFILTR is configured.
But this function can't deals with PMCCFILTR correctly because the evtCount
bit of PMCCFILTR, which is reserved 0, conflits with the SW_INCR event
type of other PMXEVTYPER<n> registers. To fix it, when eventsel == 0, KVM
shouldn't return immediately, but instead it needs to check further if
select_idx is ARMV8_PMU_CYCLE_IDX.

Another issue is that KVM shouldn't copy the eventsel bits of PMCCFILTER
directly to attr.config. Istead it shoudl convert the request to
perf_event of type 0x11 (i.e. the "cpu cycle" event type).

Signed-off-by: Wei Huang <wei@redhat.com>
---
 virt/kvm/arm/pmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 6e9c40e..13cc812 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -379,7 +379,8 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
 	eventsel = data & ARMV8_PMU_EVTYPE_EVENT;
 
 	/* Software increment event does't need to be backed by a perf event */
-	if (eventsel == ARMV8_PMU_EVTYPE_EVENT_SW_INCR)
+	if (eventsel == ARMV8_PMU_EVTYPE_EVENT_SW_INCR &&
+	    select_idx != ARMV8_PMU_CYCLE_IDX)
 		return;
 
 	memset(&attr, 0, sizeof(struct perf_event_attr));
@@ -391,7 +392,7 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
 	attr.exclude_kernel = data & ARMV8_PMU_EXCLUDE_EL1 ? 1 : 0;
 	attr.exclude_hv = 1; /* Don't count EL2 events */
 	attr.exclude_host = 1; /* Don't count host events */
-	attr.config = eventsel;
+	attr.config = (select_idx == ARMV8_PMU_CYCLE_IDX) ? 0x011 : eventsel;
 
 	counter = kvm_pmu_get_counter_value(vcpu, select_idx);
 	/* The initial sample period (overflow count) of an event. */
-- 
2.7.4
