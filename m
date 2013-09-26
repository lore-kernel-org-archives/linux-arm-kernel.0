From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 26 Sep 2013 16:49:27 +0100
Subject: [PATCH 2/3] KVM: ARM: Fix calculation of virtual CPU ID
In-Reply-To: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
References: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1380210568-23175-3-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KVM does not have a notion of multiple clusters for CPUs, just a linear
array of CPUs. When using a system with cores in more than one cluster, the
current method for calculating the virtual MPIDR will leak the (physical)
cluster information into the virtual MPIDR. One effect of this is that
Linux under KVM fails to boot multiple CPUs that aren't in the 0th cluster.

This patch does away with exposing the real MPIDR fields in favour of simply
using the virtual CPU number (but preserving the U bit, as before).

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/coproc_a15.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kvm/coproc_a15.c b/arch/arm/kvm/coproc_a15.c
index cf93472..bbd4b88 100644
--- a/arch/arm/kvm/coproc_a15.c
+++ b/arch/arm/kvm/coproc_a15.c
@@ -27,14 +27,11 @@
 static void reset_mpidr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
 {
 	/*
-	 * Compute guest MPIDR:
-	 * (Even if we present only one VCPU to the guest on an SMP
-	 * host we don't set the U bit in the MPIDR, or vice versa, as
-	 * revealing the underlying hardware properties is likely to
-	 * be the best choice).
+	 * Compute guest MPIDR. No need to mess around with different clusters
+	 * but we read the 'U' bit from the underlying hardware directly.
 	 */
-	vcpu->arch.cp15[c0_MPIDR] = (read_cpuid_mpidr() & ~MPIDR_LEVEL_MASK)
-		| (vcpu->vcpu_id & MPIDR_LEVEL_MASK);
+	vcpu->arch.cp15[c0_MPIDR] = (read_cpuid_mpidr() & MPIDR_SMP_BITMASK)
+					| vcpu->vcpu_id;
 }
 
 #include "coproc.h"
-- 
1.7.9.5
