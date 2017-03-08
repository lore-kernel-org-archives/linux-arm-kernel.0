From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Wed, 8 Mar 2017 12:09:41 +0800
Subject: [PATCH v2 3/3] arm64: KVM: add guest SEI support
In-Reply-To: <1488946181-130774-1-git-send-email-xiexiuqi@huawei.com>
References: <1488946181-130774-1-git-send-email-xiexiuqi@huawei.com>
Message-ID: <1488946181-130774-4-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ghes handling for SEI so that the host kernel could parse and
report detailed error information for SEI which occur in the guest
kernel.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 arch/arm64/include/asm/system_misc.h |  1 +
 arch/arm64/kernel/traps.c            | 18 ++++++++++++++++++
 arch/arm64/kvm/handle_exit.c         | 22 ++++++++++++++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 5b2cecd..d68d61f 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -59,5 +59,6 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 #endif	/* __ASSEMBLY__ */
 
 int handle_guest_sea(unsigned long addr, unsigned int esr);
+int handle_guest_sei(unsigned long addr, unsigned int esr);
 
 #endif	/* __ASM_SYSTEM_MISC_H */
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 65dbfa9..cf9f569 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -616,6 +616,24 @@ const char *esr_get_class_string(u32 esr)
 }
 
 /*
+ * Handle asynchronous SError interrupt that occur in a guest kernel.
+ */
+int handle_guest_sei(unsigned long addr, unsigned int esr)
+{
+	/*
+	 * synchronize_rcu() will wait for nmi_exit(), so no need to
+	 * rcu_read_lock().
+	 */
+	if(IS_ENABLED(CONFIG_ACPI_APEI_SEI)) {
+		rcu_read_lock();
+		ghes_notify_sei();
+		rcu_read_unlock();
+	}
+
+	return 0;
+}
+
+/*
  * bad_mode handles the impossible case in the exception vector. This is always
  * fatal.
  */
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 1bfe30d..8c7dba0 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -28,6 +28,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_psci.h>
+#include <asm/system_misc.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -172,6 +173,23 @@ static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
 	return arm_exit_handlers[hsr_ec];
 }
 
+static int kvm_handle_guest_sei(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	unsigned long fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
+
+	if (handle_guest_sei((unsigned long)fault_ipa,
+				kvm_vcpu_get_hsr(vcpu))) {
+		kvm_err("Failed to handle guest SEI, FSC: EC=%#x xFSC=%#lx ESR_EL2=%#lx\n",
+				kvm_vcpu_trap_get_class(vcpu),
+				(unsigned long)kvm_vcpu_trap_get_fault(vcpu),
+				(unsigned long)kvm_vcpu_get_hsr(vcpu));
+	}
+
+	kvm_inject_vabt(vcpu);
+
+	return 0;
+}
+
 /*
  * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
  * proper exit to userspace.
@@ -195,7 +213,7 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			*vcpu_pc(vcpu) -= adj;
 		}
 
-		kvm_inject_vabt(vcpu);
+		kvm_handle_guest_sei(vcpu, run);
 		return 1;
 	}
 
@@ -205,7 +223,7 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case ARM_EXCEPTION_IRQ:
 		return 1;
 	case ARM_EXCEPTION_EL1_SERROR:
-		kvm_inject_vabt(vcpu);
+		kvm_handle_guest_sei(vcpu, run);
 		return 1;
 	case ARM_EXCEPTION_TRAP:
 		/*
-- 
1.8.3.1
