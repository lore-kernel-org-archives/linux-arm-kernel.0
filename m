From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Oct 2013 18:38:13 +0100
Subject: [PATCH v2 1/2] ARM: KVM: Yield CPU when vcpu executes a WFE
In-Reply-To: <1381253894-18114-1-git-send-email-marc.zyngier@arm.com>
References: <1381253894-18114-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1381253894-18114-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On an (even slightly) oversubscribed system, spinlocks are quickly
becoming a bottleneck, as some vcpus are spinning, waiting for a
lock to be released, while the vcpu holding the lock may not be
running at all.

This creates contention, and the observed slowdown is 40x for
hackbench. No, this isn't a typo.

The solution is to trap blocking WFEs and tell KVM that we're
now spinning. This ensures that other vpus will get a scheduling
boost, allowing the lock to be released more quickly. Also, using
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT slightly improves the performance
when the VM is severely overcommited.

Quick test to estimate the performance: hackbench 1 process 1000

2xA15 host (baseline):	1.843s

2xA15 guest w/o patch:	2.083s
4xA15 guest w/o patch:	80.212s
8xA15 guest w/o patch:	Could not be bothered to find out

2xA15 guest w/ patch:	2.102s
4xA15 guest w/ patch:	3.205s
8xA15 guest w/ patch:	6.887s

So we go from a 40x degradation to 1.5x in the 2x overcommit case,
which is vaguely more acceptable.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_arm.h | 4 +++-
 arch/arm/kvm/Kconfig           | 1 +
 arch/arm/kvm/handle_exit.c     | 6 +++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
index 64e9696..693d5b2 100644
--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -67,7 +67,7 @@
  */
 #define HCR_GUEST_MASK (HCR_TSC | HCR_TSW | HCR_TWI | HCR_VM | HCR_BSU_IS | \
 			HCR_FB | HCR_TAC | HCR_AMO | HCR_IMO | HCR_FMO | \
-			HCR_SWIO | HCR_TIDCP)
+			HCR_TWE | HCR_SWIO | HCR_TIDCP)
 #define HCR_VIRT_EXCP_MASK (HCR_VA | HCR_VI | HCR_VF)
 
 /* System Control Register (SCTLR) bits */
@@ -208,6 +208,8 @@
 #define HSR_EC_DABT	(0x24)
 #define HSR_EC_DABT_HYP	(0x25)
 
+#define HSR_WFI_IS_WFE		(1U << 0)
+
 #define HSR_HVC_IMM_MASK	((1UL << 16) - 1)
 
 #define HSR_DABT_S1PTW		(1U << 7)
diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index ebf5015..466bd29 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -20,6 +20,7 @@ config KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
+	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_MMIO
 	select KVM_ARM_HOST
 	depends on ARM_VIRT_EXT && ARM_LPAE
diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
index df4c82d..c4c496f 100644
--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -84,7 +84,11 @@ static int handle_dabt_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
 static int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	trace_kvm_wfi(*vcpu_pc(vcpu));
-	kvm_vcpu_block(vcpu);
+	if (kvm_vcpu_get_hsr(vcpu) & HSR_WFI_IS_WFE)
+		kvm_vcpu_on_spin(vcpu);
+	else
+		kvm_vcpu_block(vcpu);
+
 	return 1;
 }
 
-- 
1.8.2.3
