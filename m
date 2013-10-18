From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Oct 2013 18:19:05 +0100
Subject: [PATCH 3/4] ARM: KVM: fix L2CTLR to be per-cluster
In-Reply-To: <1382116746-8757-1-git-send-email-marc.zyngier@arm.com>
References: <1382116746-8757-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1382116746-8757-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The L2CTLR register contains the number of CPUs in this cluster.

Make sure the register content is actually relevant to the vcpu
that is being configured by computing the number of cores that are
part of its cluster.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/coproc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 631e6bd..78c0885 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -124,6 +124,10 @@ static void reset_l2ctlr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
 	asm volatile("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
 	l2ctlr &= ~(3 << 24);
 	ncores = atomic_read(&vcpu->kvm->online_vcpus) - 1;
+	/* How many cores in the current cluster and the next ones */
+	ncores -= (vcpu->vcpu_id & ~3);
+	/* Cap it to the maximum number of cores in a single cluster */
+	ncores = min(ncores, 3U);
 	l2ctlr |= (ncores & 3) << 24;
 
 	vcpu->arch.cp15[c9_L2CTLR] = l2ctlr;
-- 
1.8.2.3
