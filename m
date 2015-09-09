From: tushar.jagad@linaro.org (Tushar Jagad)
Date: Wed,  9 Sep 2015 14:08:33 +0530
Subject: [PATCH RFC 3/4] arm64: kvm: Setup MIDR as per target vcpu
In-Reply-To: <1441787914-3191-1-git-send-email-tushar.jagad@linaro.org>
References: <1441787914-3191-1-git-send-email-tushar.jagad@linaro.org>
Message-ID: <1441787914-3191-4-git-send-email-tushar.jagad@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For Cross CPU targets guest kernel should see MIDR value as per the
target specified.

This patch adds support to construct the value for MIDR register
based on the target vcpu.

Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
---
 arch/arm64/kvm/sys_regs.c |   43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 273eecd..cb12783 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -172,10 +172,45 @@ static bool trap_dbgauthstatus_el1(struct kvm_vcpu *vcpu,
 
 static void reset_midr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
-	/*
-	 * We only export the host's MPIDR_EL1 for now.
-	 */
-	vcpu_sys_reg(vcpu, MIDR_EL1) = read_cpuid_id();
+	__u32 target;
+	unsigned long implementor;
+	unsigned long part_num;
+	__u32 midr_el1;
+
+	target = vcpu->arch.target;
+	switch (target) {
+	case KVM_ARM_TARGET_AEM_V8:
+		part_num = ARM_CPU_PART_AEM_V8;
+		implementor = ARM_CPU_IMP_ARM;
+		break;
+	case KVM_ARM_TARGET_FOUNDATION_V8:
+		part_num = ARM_CPU_PART_FOUNDATION;
+		implementor = ARM_CPU_IMP_ARM;
+		break;
+	case KVM_ARM_TARGET_CORTEX_A53:
+		part_num = ARM_CPU_PART_CORTEX_A53;
+		implementor = ARM_CPU_IMP_ARM;
+		break;
+	case KVM_ARM_TARGET_CORTEX_A57:
+		part_num = ARM_CPU_PART_CORTEX_A57;
+		implementor = ARM_CPU_IMP_ARM;
+		break;
+	case KVM_ARM_TARGET_XGENE_POTENZA:
+		part_num = APM_CPU_PART_POTENZA;
+		implementor = ARM_CPU_IMP_APM;
+		break;
+
+	default:
+		implementor = 0;
+		part_num = 0;
+	}
+
+	if (implementor && part_num)
+		midr_el1 = MIDR_CPU_PART(implementor, part_num);
+	else
+		midr_el1 = read_cpuid_id();
+
+	vcpu_sys_reg(vcpu, MIDR_EL1) = midr_el1;
 }
 
 /*
-- 
1.7.9.5
