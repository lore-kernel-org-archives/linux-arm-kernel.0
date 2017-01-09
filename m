From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:19 -0500
Subject: [RFC 23/55] KVM: arm64: Forward WFX to the guest hypervisor
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-24-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forward exceptions due to WFI or WFE to the guest hypervisor if the
guest hypervisor has set corresponding virtual HCR_EL2.TWX bits.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/include/asm/kvm_nested.h |  1 +
 arch/arm64/kvm/handle_exit.c        | 11 ++++++++++-
 arch/arm64/kvm/handle_exit_nested.c | 18 ++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 620b4d3..8d36935 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -2,4 +2,5 @@
 #define __ARM64_KVM_NESTED_H__
 
 int handle_hvc_nested(struct kvm_vcpu *vcpu);
+int handle_wfx_nested(struct kvm_vcpu *vcpu, bool is_wfe);
 #endif
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index ce6d2ef..046fdf8 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -101,7 +101,16 @@ static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
  */
 static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	if (kvm_vcpu_get_hsr(vcpu) & ESR_ELx_WFx_ISS_WFE) {
+	bool is_wfe = !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_WFx_ISS_WFE);
+#ifdef CONFIG_KVM_ARM_NESTED_HYP
+	int ret = handle_wfx_nested(vcpu, is_wfe);
+
+	if (ret < 0 && ret != -EINVAL)
+		return ret;
+	else if (ret >= 0)
+		return ret;
+#endif
+	if (is_wfe) {
 		trace_kvm_wfx_arm64(*vcpu_pc(vcpu), true);
 		vcpu->stat.wfe_exit_stat++;
 		kvm_vcpu_on_spin(vcpu);
diff --git a/arch/arm64/kvm/handle_exit_nested.c b/arch/arm64/kvm/handle_exit_nested.c
index a6ce23b..871ecfc 100644
--- a/arch/arm64/kvm/handle_exit_nested.c
+++ b/arch/arm64/kvm/handle_exit_nested.c
@@ -25,3 +25,21 @@ int handle_hvc_nested(struct kvm_vcpu *vcpu)
 {
 	return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
 }
+
+/*
+ * Inject wfx to the nested hypervisor if this is from the nested VM and
+ * the virtual HCR_EL2.TWX is set. Otherwise, let the host hypervisor
+ * handle this.
+ */
+int handle_wfx_nested(struct kvm_vcpu *vcpu, bool is_wfe)
+{
+	u64 hcr_el2 = vcpu_el2_reg(vcpu, HCR_EL2);
+
+	if (vcpu_mode_el2(vcpu))
+		return -EINVAL;
+
+	if ((is_wfe && (hcr_el2 & HCR_TWE)) || (!is_wfe && (hcr_el2 & HCR_TWI)))
+		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
+
+	return -EINVAL;
+}
-- 
1.9.1
