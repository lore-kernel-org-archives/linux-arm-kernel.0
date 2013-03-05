From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:18 +0000
Subject: [PATCH 24/29] ARM: KVM: move kvm_target_cpu to guest.c
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-25-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

guest.c already contains some target-specific checks. Let's move
kvm_target_cpu() over there so arm.c is mostly target agnostic.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c   | 17 -----------------
 arch/arm/kvm/guest.c | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index f053049..c10a45f 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -33,7 +33,6 @@
 #include <asm/uaccess.h>
 #include <asm/ptrace.h>
 #include <asm/mman.h>
-#include <asm/cputype.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/virt.h>
@@ -301,22 +300,6 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-int __attribute_const__ kvm_target_cpu(void)
-{
-	unsigned long implementor = read_cpuid_implementor();
-	unsigned long part_number = read_cpuid_part_number();
-
-	if (implementor != ARM_CPU_IMP_ARM)
-		return -EINVAL;
-
-	switch (part_number) {
-	case ARM_CPU_PART_CORTEX_A15:
-		return KVM_ARM_TARGET_CORTEX_A15;
-	default:
-		return -EINVAL;
-	}
-}
-
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	int ret;
diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index 2339d96..152d036 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
+#include <asm/cputype.h>
 #include <asm/uaccess.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
@@ -180,6 +181,22 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	return -EINVAL;
 }
 
+int __attribute_const__ kvm_target_cpu(void)
+{
+	unsigned long implementor = read_cpuid_implementor();
+	unsigned long part_number = read_cpuid_part_number();
+
+	if (implementor != ARM_CPU_IMP_ARM)
+		return -EINVAL;
+
+	switch (part_number) {
+	case ARM_CPU_PART_CORTEX_A15:
+		return KVM_ARM_TARGET_CORTEX_A15;
+	default:
+		return -EINVAL;
+	}
+}
+
 int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 			const struct kvm_vcpu_init *init)
 {
-- 
1.7.12.4
