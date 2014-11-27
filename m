From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 27 Nov 2014 19:40:57 +0100
Subject: [PATCH 2/5] arm/arm64: KVM: Reset the HCR on each vcpu when resetting
 the vcpu
In-Reply-To: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
References: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1417113660-23610-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When userspace resets the vcpu using KVM_ARM_VCPU_INIT, we should also
reset the HCR, because we now modify the HCR dynamically to
enable/disable trapping of guest accesses to the VM registers.

This is crucial for reboot of VMs working since otherwise we will not be
doing the necessary cache maintenance operations when faulting in pages
with the guest MMU off.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_emulate.h   | 5 +++++
 arch/arm/kvm/arm.c                   | 2 ++
 arch/arm/kvm/guest.c                 | 1 -
 arch/arm64/include/asm/kvm_emulate.h | 5 +++++
 arch/arm64/kvm/guest.c               | 1 -
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index b9db269..66ce176 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -33,6 +33,11 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
 
+static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hcr = HCR_GUEST_MASK;
+}
+
 static inline bool vcpu_mode_is_32bit(struct kvm_vcpu *vcpu)
 {
 	return 1;
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 4dcc8c2..a09a55b 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -658,6 +658,8 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	if (ret)
 		return ret;
 
+	vcpu_reset_hcr(vcpu);
+
 	/*
 	 * Handle the "start in power-off" case by marking the VCPU as paused.
 	 */
diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index cc0b787..8c97208 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -38,7 +38,6 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.hcr = HCR_GUEST_MASK;
 	return 0;
 }
 
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 5674a55..8127e45 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -38,6 +38,11 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
 
+static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
+}
+
 static inline unsigned long *vcpu_pc(const struct kvm_vcpu *vcpu)
 {
 	return (unsigned long *)&vcpu_gp_regs(vcpu)->regs.pc;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 7679469..84d5959 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -38,7 +38,6 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
 	return 0;
 }
 
-- 
2.1.2.330.g565301e.dirty
