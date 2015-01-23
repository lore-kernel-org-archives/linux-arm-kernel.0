From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:32 +0100
Subject: [GIT PULL 03/36] arm/arm64: KVM: add tracing support for arm64 exit
 handler
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Huang <wei@redhat.com>

arm64 uses its own copy of exit handler (arm64/kvm/handle_exit.c).
Currently this file doesn't hook up with any trace points. As a result
users might not see certain events (e.g. HVC & WFI) while using ftrace
with arm64 KVM. This patch fixes this issue by adding a new trace file
and defining two trace events (one of which is shared by wfi and wfe)
for arm64. The new trace points are then linked with related functions
in handle_exit.c.

Signed-off-by: Wei Huang <wei@redhat.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/kvm_arm.h     |  2 ++
 arch/arm64/include/asm/kvm_emulate.h |  5 ++++
 arch/arm64/kvm/handle_exit.c         | 13 +++++++--
 arch/arm64/kvm/trace.h               | 55 ++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kvm/trace.h

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 8afb863..3da2d3a 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -257,4 +257,6 @@
 
 #define ESR_EL2_EC_WFI_ISS_WFE	(1 << 0)
 
+#define ESR_EL2_HVC_IMM_MASK	((1UL << 16) - 1)
+
 #endif /* __ARM64_KVM_ARM_H__ */
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 8127e45..a6fa2d2 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -126,6 +126,11 @@ static inline phys_addr_t kvm_vcpu_get_fault_ipa(const struct kvm_vcpu *vcpu)
 	return ((phys_addr_t)vcpu->arch.fault.hpfar_el2 & HPFAR_MASK) << 8;
 }
 
+static inline u32 kvm_vcpu_hvc_get_imm(const struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_get_hsr(vcpu) & ESR_EL2_HVC_IMM_MASK;
+}
+
 static inline bool kvm_vcpu_dabt_isvalid(const struct kvm_vcpu *vcpu)
 {
 	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_EL2_ISV);
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 34b8bd0..6a7eb3c 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -26,12 +26,18 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_psci.h>
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 typedef int (*exit_handle_fn)(struct kvm_vcpu *, struct kvm_run *);
 
 static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	int ret;
 
+	trace_kvm_hvc_arm64(*vcpu_pc(vcpu), *vcpu_reg(vcpu, 0),
+			    kvm_vcpu_hvc_get_imm(vcpu));
+
 	ret = kvm_psci_call(vcpu);
 	if (ret < 0) {
 		kvm_inject_undefined(vcpu);
@@ -61,10 +67,13 @@ static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
  */
 static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	if (kvm_vcpu_get_hsr(vcpu) & ESR_EL2_EC_WFI_ISS_WFE)
+	if (kvm_vcpu_get_hsr(vcpu) & ESR_EL2_EC_WFI_ISS_WFE) {
+		trace_kvm_wfx_arm64(*vcpu_pc(vcpu), true);
 		kvm_vcpu_on_spin(vcpu);
-	else
+	} else {
+		trace_kvm_wfx_arm64(*vcpu_pc(vcpu), false);
 		kvm_vcpu_block(vcpu);
+	}
 
 	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 
diff --git a/arch/arm64/kvm/trace.h b/arch/arm64/kvm/trace.h
new file mode 100644
index 0000000..157416e9
--- /dev/null
+++ b/arch/arm64/kvm/trace.h
@@ -0,0 +1,55 @@
+#if !defined(_TRACE_ARM64_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ARM64_KVM_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kvm
+
+TRACE_EVENT(kvm_wfx_arm64,
+	TP_PROTO(unsigned long vcpu_pc, bool is_wfe),
+	TP_ARGS(vcpu_pc, is_wfe),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,	vcpu_pc)
+		__field(bool,		is_wfe)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc = vcpu_pc;
+		__entry->is_wfe  = is_wfe;
+	),
+
+	TP_printk("guest executed wf%c at: 0x%08lx",
+		  __entry->is_wfe ? 'e' : 'i', __entry->vcpu_pc)
+);
+
+TRACE_EVENT(kvm_hvc_arm64,
+	TP_PROTO(unsigned long vcpu_pc, unsigned long r0, unsigned long imm),
+	TP_ARGS(vcpu_pc, r0, imm),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, vcpu_pc)
+		__field(unsigned long, r0)
+		__field(unsigned long, imm)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc = vcpu_pc;
+		__entry->r0 = r0;
+		__entry->imm = imm;
+	),
+
+	TP_printk("HVC at 0x%08lx (r0: 0x%08lx, imm: 0x%lx)",
+		  __entry->vcpu_pc, __entry->r0, __entry->imm)
+);
+
+#endif /* _TRACE_ARM64_KVM_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.1.2.330.g565301e.dirty
