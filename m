From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 19 Feb 2018 09:38:07 -0600
Subject: [PATCH] KVM: arm/arm64: No need to zero CNTVOFF in
 kvm_timer_vcpu_put() for VHE
Message-ID: <1519054687-14405-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In AArch64/AArch32, the virtual counter uses a fixed virtual offset
of zero in the following situations as per ARMv8 specifications:

1) HCR_EL2.E2H is 1, and CNTVCT_EL0/CNTVCT are read from EL2.
2) HCR_EL2.{E2H, TGE} is {1, 1}, and either:
   ? CNTVCT_EL0 is read from Non-secure EL0 or EL2.
   ? CNTVCT is read from Non-secure EL0.

So, no need to zero CNTVOFF_EL2/CNTVOFF for VHE case.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 virt/kvm/arm/arch_timer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 70268c0..86eca324 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -541,9 +541,11 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
 	 * The kernel may decide to run userspace after calling vcpu_put, so
 	 * we reset cntvoff to 0 to ensure a consistent read between user
 	 * accesses to the virtual counter and kernel access to the physical
-	 * counter.
+	 * counter of non-VHE case. For VHE, the virtual counter uses a fixed
+	 * virtual offset of zero, so no need to zero CNTVOFF_EL2 register.
 	 */
-	set_cntvoff(0);
+	if (!has_vhe())
+		set_cntvoff(0);
 }
 
 /*
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
