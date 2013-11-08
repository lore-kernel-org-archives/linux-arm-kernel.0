From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  7 Nov 2013 17:32:00 -0800
Subject: [PATCH 2/4] ARM: KVM: fix L2CTLR to be per-cluster
In-Reply-To: <1383874322-12328-1-git-send-email-christoffer.dall@linaro.org>
References: <1383874322-12328-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1383874322-12328-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The L2CTLR register contains the number of CPUs in this cluster.

Make sure the register content is actually relevant to the vcpu
that is being configured by computing the number of cores that are
part of its cluster.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/coproc.c |    4 ++++
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
1.7.10.4
