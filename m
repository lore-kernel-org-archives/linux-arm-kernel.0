From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:57 +0100
Subject: [PATCH v4 29/32] arm64: KVM: enable initialization of a 32bit vcpu
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-30-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wire the init of a 32bit vcpu by allowing 32bit modes in pstate,
and providing sensible defaults out of reset state.

This feature is of course conditioned by the presence of 32bit
capability on the physical CPU, and is checked by the KVM_CAP_ARM_EL1_32BIT
capability.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/include/uapi/asm/kvm.h |  1 +
 arch/arm64/kvm/guest.c            |  6 ++++++
 arch/arm64/kvm/reset.c            | 25 ++++++++++++++++++++++++-
 include/uapi/linux/kvm.h          |  1 +
 5 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3f5830b..644d739 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -34,7 +34,7 @@
 #include <kvm/arm_vgic.h>
 #include <kvm/arm_arch_timer.h>
 
-#define KVM_VCPU_MAX_FEATURES 1
+#define KVM_VCPU_MAX_FEATURES 2
 
 /* We don't currently support large pages. */
 #define KVM_HPAGE_GFN_SHIFT(x)	0
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 5b1110c..5031f42 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -75,6 +75,7 @@ struct kvm_regs {
 #define KVM_VGIC_V2_CPU_SIZE		0x2000
 
 #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
+#define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
 
 struct kvm_vcpu_init {
 	__u32 target;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index c8d48b2..e0d6b2c 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -93,6 +93,12 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (off == KVM_REG_ARM_CORE_REG(regs.pstate)) {
 		u32 mode = (*(u32 *)valp) & COMPAT_PSR_MODE_MASK;
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
index 84112e0..c2cb9cc 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -36,11 +36,27 @@ static struct kvm_regs default_regs_reset = {
 			PSR_F_BIT | PSR_D_BIT),
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
 int kvm_arch_dev_ioctl_check_extension(long ext)
 {
 	int r;
 
 	switch (ext) {
+	case KVM_CAP_ARM_EL1_32BIT:
+		r = cpu_has_32bit_el1();
+		break;
 	default:
 		r = 0;
 	}
@@ -63,7 +79,14 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 
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
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2d1bcb8..aac2764 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -666,6 +666,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_IRQ_MPIC 90
 #define KVM_CAP_PPC_RTAS 91
 #define KVM_CAP_IRQ_XICS 92
+#define KVM_CAP_ARM_EL1_32BIT 93
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.8.2.3
