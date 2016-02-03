From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  3 Feb 2016 17:59:54 +0000
Subject: [PATCH v3 01/23] arm/arm64: KVM: Add hook for C-based stage2 init
In-Reply-To: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1454522416-6874-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 4 ++++
 arch/arm/kvm/arm.c                | 1 +
 arch/arm64/include/asm/kvm_host.h | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index f9f2779..f1e86f1 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -220,6 +220,10 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 	kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
 }
 
+static inline void __cpu_init_stage2(void)
+{
+}
+
 static inline int kvm_arch_dev_ioctl_check_extension(long ext)
 {
 	return 0;
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index dda1959..6b76e01 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -985,6 +985,7 @@ static void cpu_init_hyp_mode(void *dummy)
 	vector_ptr = (unsigned long)__kvm_hyp_vector;
 
 	__cpu_init_hyp_mode(boot_pgd_ptr, pgd_ptr, hyp_stack_ptr, vector_ptr);
+	__cpu_init_stage2();
 
 	kvm_arm_init_debug();
 }
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 689d4c9..fe86cf9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -332,6 +332,10 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 		     hyp_stack_ptr, vector_ptr);
 }
 
+static inline void __cpu_init_stage2(void)
+{
+}
+
 static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
-- 
2.1.4
