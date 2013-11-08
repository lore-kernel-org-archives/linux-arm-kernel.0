From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  7 Nov 2013 17:31:59 -0800
Subject: [PATCH 1/4] ARM: KVM: Fix MPIDR computing to support virtual clusters
In-Reply-To: <1383874322-12328-1-git-send-email-christoffer.dall@linaro.org>
References: <1383874322-12328-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1383874322-12328-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

In order to be able to support more than 4 A7 or A15 CPUs,
we need to fix the MPIDR computing to reflect the fact that
both A15 and A7 can only exist in clusters of at most 4 CPUs.

Fix the MPIDR computing to allow virtual clusters to be exposed
to the guest.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/coproc.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index a629f2c..631e6bd 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -74,11 +74,13 @@ int kvm_handle_cp14_access(struct kvm_vcpu *vcpu, struct kvm_run *run)
 static void reset_mpidr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
 {
 	/*
-	 * Compute guest MPIDR. No need to mess around with different clusters
-	 * but we read the 'U' bit from the underlying hardware directly.
+	 * Compute guest MPIDR. We build a virtual cluster out of the
+	 * vcpu_id, but we read the 'U' bit from the underlying
+	 * hardware directly.
 	 */
-	vcpu->arch.cp15[c0_MPIDR] = (read_cpuid_mpidr() & MPIDR_SMP_BITMASK)
-					| vcpu->vcpu_id;
+	vcpu->arch.cp15[c0_MPIDR] = ((read_cpuid_mpidr() & MPIDR_SMP_BITMASK) |
+				     ((vcpu->vcpu_id >> 2) << MPIDR_LEVEL_BITS) |
+				     (vcpu->vcpu_id & 3));
 }
 
 /* TRM entries A7:4.3.31 A15:4.3.28 - RO WI */
-- 
1.7.10.4
