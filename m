From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 30 Apr 2013 07:49:22 -0700
Subject: [PATCH 01/15] ARM: KVM: add support for minimal host vs guest
 profiling
In-Reply-To: <1367333376-30983-1-git-send-email-cdall@cs.columbia.edu>
References: <1367333376-30983-1-git-send-email-cdall@cs.columbia.edu>
Message-ID: <1367333376-30983-2-git-send-email-cdall@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

In order to be able to correctly profile what is happening on the
host, we need to be able to identify when we're running on the guest,
and log these events differently.

Perf offers a simple way to register callbacks into KVM. Mimic what
x86 does and enjoy being able to profile your KVM host.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@cs.columbia.edu>
---
 arch/arm/include/asm/kvm_host.h |    3 ++
 arch/arm/kvm/Makefile           |    2 +-
 arch/arm/kvm/arm.c              |    4 +++
 arch/arm/kvm/perf.c             |   68 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/kvm/perf.c

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 0c4e643..78813b8 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -207,4 +207,7 @@ static inline void __cpu_init_hyp_mode(unsigned long long pgd_ptr,
 	kvm_call_hyp((void *)pgd_low, pgd_high, hyp_stack_ptr, vector_ptr);
 }
 
+int kvm_perf_init(void);
+int kvm_perf_teardown(void);
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 8dc5e76..53c5ed8 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -18,6 +18,6 @@ kvm-arm-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
 
 obj-y += kvm-arm.o init.o interrupts.o
 obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
-obj-y += coproc.o coproc_a15.o mmio.o psci.o
+obj-y += coproc.o coproc_a15.o mmio.o psci.o perf.o
 obj-$(CONFIG_KVM_ARM_VGIC) += vgic.o
 obj-$(CONFIG_KVM_ARM_TIMER) += arch_timer.o
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 1497e18..7403f88 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -920,7 +920,10 @@ static int init_hyp_mode(void)
 	if (err)
 		goto out_free_mappings;
 
+	kvm_perf_init();
+
 	kvm_info("Hyp mode initialized successfully\n");
+
 	return 0;
 out_free_vfp:
 	free_percpu(kvm_host_vfp_state);
@@ -964,6 +967,7 @@ out_err:
 /* NOP: Compiling as a module not supported */
 void kvm_arch_exit(void)
 {
+	kvm_perf_teardown();
 }
 
 static int arm_init(void)
diff --git a/arch/arm/kvm/perf.c b/arch/arm/kvm/perf.c
new file mode 100644
index 0000000..1a3849d
--- /dev/null
+++ b/arch/arm/kvm/perf.c
@@ -0,0 +1,68 @@
+/*
+ * Based on the x86 implementation.
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/perf_event.h>
+#include <linux/kvm_host.h>
+
+#include <asm/kvm_emulate.h>
+
+static int kvm_is_in_guest(void)
+{
+        return kvm_arm_get_running_vcpu() != NULL;
+}
+
+static int kvm_is_user_mode(void)
+{
+	struct kvm_vcpu *vcpu;
+
+	vcpu = kvm_arm_get_running_vcpu();
+
+	if (vcpu)
+		return !vcpu_mode_priv(vcpu);
+
+	return 0;
+}
+
+static unsigned long kvm_get_guest_ip(void)
+{
+	struct kvm_vcpu *vcpu;
+
+	vcpu = kvm_arm_get_running_vcpu();
+
+	if (vcpu)
+		return *vcpu_pc(vcpu);
+
+	return 0;
+}
+
+static struct perf_guest_info_callbacks kvm_guest_cbs = {
+	.is_in_guest	= kvm_is_in_guest,
+	.is_user_mode	= kvm_is_user_mode,
+	.get_guest_ip	= kvm_get_guest_ip,
+};
+
+int kvm_perf_init(void)
+{
+	return perf_register_guest_info_callbacks(&kvm_guest_cbs);
+}
+
+int kvm_perf_teardown(void)
+{
+	return perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
+}
-- 
1.7.9.5
