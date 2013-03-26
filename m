From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Mar 2013 17:01:25 +0000
Subject: [PATCH v2 30/30] arm64: KVM: enable initialization of a 32bit vcpu
In-Reply-To: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
References: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1364317285-20937-31-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wire the init of a 32bit vcpu by allowing 32bit modes in pstate,
and providing sensible defaults out of reset state.

This feature is of course conditioned by the presence of 32bit
capability on the physical CPU.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/include/uapi/asm/kvm.h |  1 +
 arch/arm64/kvm/guest.c            |  6 ++++++
 arch/arm64/kvm/reset.c            | 22 +++++++++++++++++++++-
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 544866a..67a1924 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -34,7 +34,7 @@
 #include <asm/kvm_vgic.h>
 #include <asm/kvm_arch_timer.h>
 
-#define KVM_VCPU_MAX_FEATURES 1
+#define KVM_VCPU_MAX_FEATURES 2
 
 /* We don't currently support large pages. */
 #define KVM_HPAGE_GFN_SHIFT(x)	0
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 4dee5c9..5bf9c28 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -75,6 +75,7 @@ struct kvm_regs {
 #define KVM_VGIC_V2_CPU_SIZE		0x2000
 
 #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
+#define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
 
 struct kvm_vcpu_init {
 	__u32 target;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index c54d40d..c444c8b 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -93,6 +93,12 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (off == KVM_REG_ARM_CORE_REG(regs.pstate)) {
 		unsigned long mode = (*(unsigned long *)valp) & COMPAT_PSR_MODE_MASK;
 		switch (mode) {
+		case COMPAT_PSR_MODE_USR:
+		case COMPAT_PSR_MODE_FIQ:
+		case COMPAT_PSR_MODE_IRQ:
+		case COMPAT_PSR_MODE_SVC:
+		case COMPAT_PSR_MODE_ABT:
+		case COMPAT_PSR_MODE_UND:
 		case PSR_MODE_EL0t:
 		case PSR_MODE_EL1t:
 		case PSR_MODE_EL1h:
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 8cb0244..c50aa89 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -35,6 +35,19 @@ static struct kvm_regs default_regs_reset = {
 	.regs.pstate = PSR_MODE_EL1h | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT,
 };
 
+static struct kvm_regs default_regs_reset32 = {
+	.regs.pstate = (COMPAT_PSR_MODE_SVC | COMPAT_PSR_A_BIT |
+			COMPAT_PSR_I_BIT | COMPAT_PSR_F_BIT),
+};
+
+static bool cpu_has_32bit_el1(void)
+{
+	u64 pfr0;
+
+	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
+	return !!(pfr0 & 0x20);
+}
+
 /**
  * kvm_reset_vcpu - sets core registers and sys_regs to reset value
  * @vcpu: The VCPU pointer
@@ -49,7 +62,14 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	switch (vcpu->arch.target) {
 	default:
-		cpu_reset = &default_regs_reset;
+		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
+			if (!cpu_has_32bit_el1())
+				return -EINVAL;
+			cpu_reset = &default_regs_reset32;
+			vcpu->arch.hcr_el2 &= ~HCR_RW;
+		} else {
+			cpu_reset = &default_regs_reset;
+		}
 		break;
 	}
 
-- 
1.8.1.4
