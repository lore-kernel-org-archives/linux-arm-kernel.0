From: jintack.lim@linaro.org (Jintack Lim)
Date: Mon,  2 Oct 2017 22:11:04 -0500
Subject: [RFC PATCH v2 22/31] KVM: arm64: Emulate AT S1E2 instructions
In-Reply-To: <1507000273-3735-1-git-send-email-jintack.lim@linaro.org>
References: <1507000273-3735-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1507000273-3735-20-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Emulate AT S1E2 instructions by issuing the corresponding S1E1
instructions in EL2. We set the physical EL1 registers and the HCR_EL2
register as described in the AT instruction emulation overview.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a82274f..cb46db5 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1641,6 +1641,21 @@ static bool handle_s1e01(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return true;
 }
 
+static bool handle_s1e2(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			const struct sys_reg_desc *r)
+{
+	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
+	bool el2_format;
+	int sys_encoding = sys_insn(p->Op0, p->Op1, p->CRn, p->CRm, p->Op2);
+
+	/* See the '1. EL2 AT instructions: S1E2x' table */
+	ctxt->hw_sys_regs = ctxt->shadow_sys_regs;
+	el2_format = !vcpu_el2_e2h_is_set(vcpu);
+
+	kvm_call_hyp(__kvm_at_insn, vcpu, p->regval, el2_format, sys_encoding);
+	return true;
+}
+
 /*
  * AT instruction emulation
  *
@@ -1716,8 +1731,8 @@ static bool handle_s1e01(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	SYS_INSN_TO_DESC(AT_S1E0W, handle_s1e01, NULL),
 	SYS_INSN_TO_DESC(AT_S1E1RP, handle_s1e01, NULL),
 	SYS_INSN_TO_DESC(AT_S1E1WP, handle_s1e01, NULL),
-	SYS_INSN_TO_DESC(AT_S1E2R, NULL, NULL),
-	SYS_INSN_TO_DESC(AT_S1E2W, NULL, NULL),
+	SYS_INSN_TO_DESC(AT_S1E2R, handle_s1e2, NULL),
+	SYS_INSN_TO_DESC(AT_S1E2W, handle_s1e2, NULL),
 	SYS_INSN_TO_DESC(AT_S12E1R, NULL, NULL),
 	SYS_INSN_TO_DESC(AT_S12E1W, NULL, NULL),
 	SYS_INSN_TO_DESC(AT_S12E0R, NULL, NULL),
-- 
1.9.1
