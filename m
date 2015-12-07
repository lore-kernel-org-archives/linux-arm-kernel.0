From: m.smarduch@samsung.com (Mario Smarduch)
Date: Sun, 06 Dec 2015 17:07:12 -0800
Subject: [PATCH v5 1/3] KVM/arm: add hooks for armv7 fp/simd lazy switch
 support
In-Reply-To: <1449450434-2929-1-git-send-email-m.smarduch@samsung.com>
References: <1449450434-2929-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1449450434-2929-2-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds vcpu fields to configure hcptr trap register which is also used 
to determine if fp/simd registers are dirty. Adds a field to save host FPEXC, 
and offsets associated offsets.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/include/asm/kvm_host.h | 6 ++++++
 arch/arm/kernel/asm-offsets.c   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 3df1e97..09bb1f2 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -104,6 +104,12 @@ struct kvm_vcpu_arch {
 	/* HYP trapping configuration */
 	u32 hcr;
 
+	/* HYP Co-processor fp/simd and trace trapping configuration */
+	u32 hcptr;
+
+	/* Save host FPEXC register to later restore on vcpu put */
+	u32 host_fpexc;
+
 	/* Interrupt related fields */
 	u32 irq_lines;		/* IRQ and FIQ levels */
 
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 871b826..28ebd4c 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -185,6 +185,8 @@ int main(void)
   DEFINE(VCPU_PC,		offsetof(struct kvm_vcpu, arch.regs.usr_regs.ARM_pc));
   DEFINE(VCPU_CPSR,		offsetof(struct kvm_vcpu, arch.regs.usr_regs.ARM_cpsr));
   DEFINE(VCPU_HCR,		offsetof(struct kvm_vcpu, arch.hcr));
+  DEFINE(VCPU_HCPTR,		offsetof(struct kvm_vcpu, arch.hcptr));
+  DEFINE(VCPU_VFP_HOST_FPEXC,	offsetof(struct kvm_vcpu, arch.host_fpexc));
   DEFINE(VCPU_IRQ_LINES,	offsetof(struct kvm_vcpu, arch.irq_lines));
   DEFINE(VCPU_HSR,		offsetof(struct kvm_vcpu, arch.fault.hsr));
   DEFINE(VCPU_HxFAR,		offsetof(struct kvm_vcpu, arch.fault.hxfar));
-- 
1.9.1
