From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  1 Jun 2018 16:27:30 +0100
Subject: [PATCH 16/33] KVM: arm64: Save host SVE context as appropriate
In-Reply-To: <20180601152747.23613-1-marc.zyngier@arm.com>
References: <20180601152747.23613-1-marc.zyngier@arm.com>
Message-ID: <20180601152747.23613-17-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <Dave.Martin@arm.com>

This patch adds SVE context saving to the hyp FPSIMD context switch
path.  This means that it is no longer necessary to save the host
SVE state in advance of entering the guest, when in use.

In order to avoid adding pointless complexity to the code, VHE is
assumed if SVE is in use.  VHE is an architectural prerequisite for
SVE, so there is no good reason to turn CONFIG_ARM64_VHE off in
kernels that support both SVE and KVM.

Historically, software models exist that can expose the
architecturally invalid configuration of SVE without VHE, so if
this situation is detected at kvm_init() time then KVM will be
disabled.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h   |  1 +
 arch/arm64/Kconfig                |  7 +++++++
 arch/arm64/include/asm/kvm_host.h | 13 +++++++++++++
 arch/arm64/kvm/fpsimd.c           |  1 -
 arch/arm64/kvm/hyp/switch.c       | 20 +++++++++++++++++++-
 virt/kvm/arm/arm.c                |  7 +++++++
 6 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index ac870b2cd5d1..3b85bbb4b23e 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -280,6 +280,7 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
+static inline bool kvm_arch_check_sve_has_vhe(void) { return true; }
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf4938f6d..b0d3820081c8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1130,6 +1130,7 @@ endmenu
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
+	depends on !KVM || ARM64_VHE
 	help
 	  The Scalable Vector Extension (SVE) is an extension to the AArch64
 	  execution state which complements and extends the SIMD functionality
@@ -1155,6 +1156,12 @@ config ARM64_SVE
 	  booting the kernel.  If unsure and you are not observing these
 	  symptoms, you should assume that it is safe to say Y.
 
+	  CPUs that support SVE are architecturally required to support the
+	  Virtualization Host Extensions (VHE), so the kernel makes no
+	  provision for supporting SVE alongside KVM without VHE enabled.
+	  Thus, you will need to enable CONFIG_ARM64_VHE if you want to support
+	  KVM in the same kernel image.
+
 config ARM64_MODULE_PLTS
 	bool
 	select HAVE_MOD_ARCH_SPECIFIC
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index b3fe7301bdbe..fda9289f3b9c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -405,6 +405,19 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 	kvm_call_hyp(__kvm_set_tpidr_el2, tpidr_el2);
 }
 
+static inline bool kvm_arch_check_sve_has_vhe(void)
+{
+	/*
+	 * The Arm architecture specifies that implementation of SVE
+	 * requires VHE also to be implemented.  The KVM code for arm64
+	 * relies on this when SVE is present:
+	 */
+	if (system_supports_sve())
+		return has_vhe();
+	else
+		return true;
+}
+
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 365933a98a7c..dc6ecfa5a2d2 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -59,7 +59,6 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
  */
 void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 {
-	BUG_ON(system_supports_sve());
 	BUG_ON(!current->mm);
 
 	vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED | KVM_ARM64_HOST_SVE_IN_USE);
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 118f3002b9ce..a6a8c7d9157d 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -21,6 +21,7 @@
 
 #include <kvm/arm_psci.h>
 
+#include <asm/cpufeature.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_host.h>
@@ -28,6 +29,7 @@
 #include <asm/kvm_mmu.h>
 #include <asm/fpsimd.h>
 #include <asm/debug-monitors.h>
+#include <asm/processor.h>
 #include <asm/thread_info.h>
 
 /* Check whether the FP regs were dirtied while in the host-side run loop: */
@@ -329,6 +331,8 @@ static bool __hyp_text __skip_instr(struct kvm_vcpu *vcpu)
 void __hyp_text __hyp_switch_fpsimd(u64 esr __always_unused,
 				    struct kvm_vcpu *vcpu)
 {
+	struct user_fpsimd_state *host_fpsimd = vcpu->arch.host_fpsimd_state;
+
 	if (has_vhe())
 		write_sysreg(read_sysreg(cpacr_el1) | CPACR_EL1_FPEN,
 			     cpacr_el1);
@@ -339,7 +343,21 @@ void __hyp_text __hyp_switch_fpsimd(u64 esr __always_unused,
 	isb();
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_HOST) {
-		__fpsimd_save_state(vcpu->arch.host_fpsimd_state);
+		/*
+		 * In the SVE case, VHE is assumed: it is enforced by
+		 * Kconfig and kvm_arch_init().
+		 */
+		if (system_supports_sve() &&
+		    (vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE)) {
+			struct thread_struct *thread = container_of(
+				host_fpsimd,
+				struct thread_struct, uw.fpsimd_state);
+
+			sve_save_state(sve_pffr(thread), &host_fpsimd->fpsr);
+		} else {
+			__fpsimd_save_state(host_fpsimd);
+		}
+
 		vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
 	}
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index bee226cec40b..ce7c6f36471b 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -16,6 +16,7 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
+#include <linux/bug.h>
 #include <linux/cpu_pm.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -41,6 +42,7 @@
 #include <asm/mman.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #include <asm/virt.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
@@ -1574,6 +1576,11 @@ int kvm_arch_init(void *opaque)
 		return -ENODEV;
 	}
 
+	if (!kvm_arch_check_sve_has_vhe()) {
+		kvm_pr_unimpl("SVE system without VHE unsupported.  Broken cpu?");
+		return -ENODEV;
+	}
+
 	for_each_online_cpu(cpu) {
 		smp_call_function_single(cpu, check_kvm_target_cpu, &ret, 1);
 		if (ret < 0) {
-- 
2.17.1
