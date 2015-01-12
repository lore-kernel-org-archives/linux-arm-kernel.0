From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 12 Jan 2015 15:30:42 +0000
Subject: [PATCH] arm/arm64: KVM: extend WFI tracepoint to differentiate
 between wfi and wfe
Message-ID: <1421076642-19983-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the trace printk talks about "wfi" only, though the trace
point triggers both on wfi and wfe traps.
Add a parameter to differentiate between the two.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

this one goes on top of Wei's patch to introduce the wfx trace point
for arm64. This patch here could as well be split up between ARM and
arm64 and the latter could be folded into Wei's patch.

Cheers,
Andre.

 arch/arm/kvm/handle_exit.c   |    8 +++++---
 arch/arm/kvm/trace.h         |   11 +++++++----
 arch/arm64/kvm/handle_exit.c |    9 +++++----
 arch/arm64/kvm/trace.h       |   13 ++++++++-----
 4 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
index a96a804..95f12b2 100644
--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -87,11 +87,13 @@ static int handle_dabt_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
  */
 static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	trace_kvm_wfi(*vcpu_pc(vcpu));
-	if (kvm_vcpu_get_hsr(vcpu) & HSR_WFI_IS_WFE)
+	if (kvm_vcpu_get_hsr(vcpu) & HSR_WFI_IS_WFE) {
+		trace_kvm_wfx(*vcpu_pc(vcpu), true);
 		kvm_vcpu_on_spin(vcpu);
-	else
+	} else {
+		trace_kvm_wfx(*vcpu_pc(vcpu), false);
 		kvm_vcpu_block(vcpu);
+	}
 
 	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 
diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
index b1d640f..f741449 100644
--- a/arch/arm/kvm/trace.h
+++ b/arch/arm/kvm/trace.h
@@ -140,19 +140,22 @@ TRACE_EVENT(kvm_emulate_cp15_imp,
 			__entry->CRm, __entry->Op2)
 );
 
-TRACE_EVENT(kvm_wfi,
-	TP_PROTO(unsigned long vcpu_pc),
-	TP_ARGS(vcpu_pc),
+TRACE_EVENT(kvm_wfx,
+	TP_PROTO(unsigned long vcpu_pc, bool is_wfe),
+	TP_ARGS(vcpu_pc, is_wfe),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	vcpu_pc		)
+		__field(		 bool,	is_wfe		)
 	),
 
 	TP_fast_assign(
 		__entry->vcpu_pc		= vcpu_pc;
+		__entry->is_wfe			= is_wfe;
 	),
 
-	TP_printk("guest executed wfi at: 0x%08lx", __entry->vcpu_pc)
+	TP_printk("guest executed wf%c at: 0x%08lx",
+		__entry->is_wfe ? 'e' : 'i', __entry->vcpu_pc)
 );
 
 TRACE_EVENT(kvm_unmap_hva,
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 4fdb907..6a7eb3c 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -67,12 +67,13 @@ static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
  */
 static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	trace_kvm_wfi_arm64(*vcpu_pc(vcpu));
-
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
index 96c7de0..157416e9 100644
--- a/arch/arm64/kvm/trace.h
+++ b/arch/arm64/kvm/trace.h
@@ -6,19 +6,22 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm
 
-TRACE_EVENT(kvm_wfi_arm64,
-	TP_PROTO(unsigned long vcpu_pc),
-	TP_ARGS(vcpu_pc),
+TRACE_EVENT(kvm_wfx_arm64,
+	TP_PROTO(unsigned long vcpu_pc, bool is_wfe),
+	TP_ARGS(vcpu_pc, is_wfe),
 
 	TP_STRUCT__entry(
-		__field(unsigned long, vcpu_pc)
+		__field(unsigned long,	vcpu_pc)
+		__field(bool,		is_wfe)
 	),
 
 	TP_fast_assign(
 		__entry->vcpu_pc = vcpu_pc;
+		__entry->is_wfe  = is_wfe;
 	),
 
-	TP_printk("guest executed wfxx at: 0x%08lx", __entry->vcpu_pc)
+	TP_printk("guest executed wf%c at: 0x%08lx",
+		  __entry->is_wfe ? 'e' : 'i', __entry->vcpu_pc)
 );
 
 TRACE_EVENT(kvm_hvc_arm64,
-- 
1.7.9.5
