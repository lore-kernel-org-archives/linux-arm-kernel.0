From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Nov 2016 09:39:25 +0000
Subject: [PATCH 1/2] arm64: KVM: pmu: Fix AArch32 cycle counter access
In-Reply-To: <1479461966-20136-1-git-send-email-marc.zyngier@arm.com>
References: <1479461966-20136-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1479461966-20136-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Huang <wei@redhat.com>

We're missing the handling code for the cycle counter accessed
from a 32bit guest, leading to unexpected results.

Cc: stable at vger.kernel.org # 4.6+
Signed-off-by: Wei Huang <wei@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f302fdb..87e7e66 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -597,8 +597,14 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 
 			idx = ARMV8_PMU_CYCLE_IDX;
 		} else {
-			BUG();
+			return false;
 		}
+	} else if (r->CRn == 0 && r->CRm == 9) {
+		/* PMCCNTR */
+		if (pmu_access_event_counter_el0_disabled(vcpu))
+			return false;
+
+		idx = ARMV8_PMU_CYCLE_IDX;
 	} else if (r->CRn == 14 && (r->CRm & 12) == 8) {
 		/* PMEVCNTRn_EL0 */
 		if (pmu_access_event_counter_el0_disabled(vcpu))
@@ -606,7 +612,7 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 
 		idx = ((r->CRm & 3) << 3) | (r->Op2 & 7);
 	} else {
-		BUG();
+		return false;
 	}
 
 	if (!pmu_counter_idx_valid(vcpu, idx))
-- 
2.1.4
