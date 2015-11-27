From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Nov 2015 18:50:09 +0000
Subject: [PATCH v2 15/21] arm64: KVM: Add panic handling
In-Reply-To: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
References: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1448650215-15218-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the panic handler, together with the small bits of assembly
code to call the kernel's panic implementation.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/hyp-entry.S | 11 ++++++++++-
 arch/arm64/kvm/hyp/hyp.h       |  1 +
 arch/arm64/kvm/hyp/switch.c    | 30 ++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 8334407..39d6935 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -150,7 +150,16 @@ el1_irq:
 	mov	x1, #ARM_EXCEPTION_IRQ
 	b	__guest_exit
 
-.macro invalid_vector	label, target = __kvm_hyp_panic
+ENTRY(__hyp_do_panic)
+	mov	lr, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
+		      PSR_MODE_EL1h)
+	msr	spsr_el2, lr
+	ldr	lr, =panic
+	msr	elr_el2, lr
+	eret
+ENDPROC(__hyp_do_panic)
+
+.macro invalid_vector	label, target = __hyp_panic
 	.align	2
 \label:
 	b \target
diff --git a/arch/arm64/kvm/hyp/hyp.h b/arch/arm64/kvm/hyp/hyp.h
index 18365dd..87f16fa 100644
--- a/arch/arm64/kvm/hyp/hyp.h
+++ b/arch/arm64/kvm/hyp/hyp.h
@@ -74,6 +74,7 @@ static inline bool __fpsimd_enabled(void)
 }
 
 u64 __guest_enter(struct kvm_vcpu *vcpu, struct kvm_cpu_context *host_ctxt);
+void __noreturn __hyp_do_panic(unsigned long, ...);
 
 #endif /* __ARM64_KVM_HYP_H__ */
 
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 8affc19..7b81089 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -140,3 +140,33 @@ int __hyp_text __guest_run(struct kvm_vcpu *vcpu)
 
 	return exit_code;
 }
+
+static const char __hyp_panic_string[] = "HYP panic:\nPS:%08llx PC:%016llx ESR:%08llx\nFAR:%016llx HPFAR:%016llx PAR:%016llx\nVCPU:%p\n";
+
+void __hyp_text __noreturn __hyp_panic(void)
+{
+	unsigned long str_va = (unsigned long)__hyp_panic_string;
+	u64 spsr = read_sysreg(spsr_el2);
+	u64 elr = read_sysreg(elr_el2);
+	u64 par = read_sysreg(par_el1);
+
+	if (read_sysreg(vttbr_el2)) {
+		struct kvm_vcpu *vcpu;
+		struct kvm_cpu_context *host_ctxt;
+
+		vcpu = (struct kvm_vcpu *)read_sysreg(tpidr_el2);
+		host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
+		__deactivate_traps(vcpu);
+		__deactivate_vm(vcpu);
+		__sysreg_restore_state(host_ctxt);
+	}
+
+	/* Call panic for real */
+	__hyp_do_panic(str_va - HYP_PAGE_OFFSET + PAGE_OFFSET,
+		       spsr,  elr,
+		       read_sysreg(esr_el2),   read_sysreg(far_el2),
+		       read_sysreg(hpfar_el2), par,
+		       (void *)read_sysreg(tpidr_el2));
+
+	unreachable();
+}
-- 
2.1.4
