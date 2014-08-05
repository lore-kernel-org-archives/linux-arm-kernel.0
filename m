From: anup.patel@linaro.org (Anup Patel)
Date: Tue,  5 Aug 2014 14:54:13 +0530
Subject: [RFC PATCH 4/6] ARM/ARM64: KVM: Add common code PMU IRQ routing
In-Reply-To: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
References: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1407230655-28864-5-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces common PMU IRQ routing code for
KVM ARM and KVM ARM64 under virt/kvm/arm directory.

The virtual PMU IRQ number for each Guest VCPU will be
provided by user space using set device address vm ioctl
with prameters:
dev_id = KVM_ARM_DEVICE_PMU
type = VCPU number
addr = PMU IRQ number for the VCPU

The low-level context switching code of KVM ARM/ARM64
will determine the state of VCPU PMU IRQ store it in
"irq_pending" flag when saving PMU context for the VCPU.

The common PMU IRQ routing code will inject virtual PMU
IRQ based on "irq_pending" flag and it will also clear
the "irq_pending" flag.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/include/asm/kvm_host.h   |    9 ++++
 arch/arm/include/uapi/asm/kvm.h   |    1 +
 arch/arm/kvm/arm.c                |    6 +++
 arch/arm/kvm/reset.c              |    4 ++
 arch/arm64/include/asm/kvm_host.h |    9 ++++
 arch/arm64/include/uapi/asm/kvm.h |    1 +
 arch/arm64/kvm/Kconfig            |    7 +++
 arch/arm64/kvm/Makefile           |    1 +
 arch/arm64/kvm/reset.c            |    4 ++
 include/kvm/arm_pmu.h             |   52 ++++++++++++++++++
 virt/kvm/arm/pmu.c                |  105 +++++++++++++++++++++++++++++++++++++
 11 files changed, 199 insertions(+)
 create mode 100644 include/kvm/arm_pmu.h
 create mode 100644 virt/kvm/arm/pmu.c

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 193ceaf..a6a778f 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -24,6 +24,7 @@
 #include <asm/kvm_mmio.h>
 #include <asm/fpstate.h>
 #include <kvm/arm_arch_timer.h>
+#include <kvm/arm_pmu.h>
 
 #if defined(CONFIG_KVM_ARM_MAX_VCPUS)
 #define KVM_MAX_VCPUS CONFIG_KVM_ARM_MAX_VCPUS
@@ -53,6 +54,9 @@ struct kvm_arch {
 	/* Timer */
 	struct arch_timer_kvm	timer;
 
+	/* PMU */
+	struct pmu_kvm		pmu;
+
 	/*
 	 * Anything that is not used directly from assembly code goes
 	 * here.
@@ -118,8 +122,13 @@ struct kvm_vcpu_arch {
 
 	/* VGIC state */
 	struct vgic_cpu vgic_cpu;
+
+	/* Timer state */
 	struct arch_timer_cpu timer_cpu;
 
+	/* PMU state */
+	struct pmu_cpu pmu_cpu;
+
 	/*
 	 * Anything that is not used directly from assembly code goes
 	 * here.
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index e6ebdd3..b21e6eb 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -75,6 +75,7 @@ struct kvm_regs {
 
 /* Supported device IDs */
 #define KVM_ARM_DEVICE_VGIC_V2		0
+#define KVM_ARM_DEVICE_PMU		1
 
 /* Supported VGIC address types  */
 #define KVM_VGIC_V2_ADDR_TYPE_DIST	0
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 3c82b37..04130f5 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -140,6 +140,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm_timer_init(kvm);
 
+	kvm_pmu_init(kvm);
+
 	/* Mark the initial VMID generation invalid */
 	kvm->arch.vmid_gen = 0;
 
@@ -567,6 +569,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
 			local_irq_enable();
 			kvm_timer_sync_hwstate(vcpu);
+			kvm_pmu_sync_hwstate(vcpu);
 			kvm_vgic_sync_hwstate(vcpu);
 			continue;
 		}
@@ -601,6 +604,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 *************************************************************/
 
 		kvm_timer_sync_hwstate(vcpu);
+		kvm_pmu_sync_hwstate(vcpu);
 		kvm_vgic_sync_hwstate(vcpu);
 
 		ret = handle_exit(vcpu, run, ret);
@@ -794,6 +798,8 @@ static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
 		if (!vgic_present)
 			return -ENXIO;
 		return kvm_vgic_addr(kvm, type, &dev_addr->addr, true);
+	case KVM_ARM_DEVICE_PMU:
+		return kvm_pmu_addr(kvm, type, &dev_addr->addr, true);
 	default:
 		return -ENODEV;
 	}
diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
index f558c07..42e6996 100644
--- a/arch/arm/kvm/reset.c
+++ b/arch/arm/kvm/reset.c
@@ -28,6 +28,7 @@
 #include <asm/kvm_coproc.h>
 
 #include <kvm/arm_arch_timer.h>
+#include <kvm/arm_pmu.h>
 
 /******************************************************************************
  * Cortex-A15 and Cortex-A7 Reset Values
@@ -79,5 +80,8 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset arch_timer context */
 	kvm_timer_vcpu_reset(vcpu, cpu_vtimer_irq);
 
+	/* Reset pmu context */
+	kvm_pmu_vcpu_reset(vcpu);
+
 	return 0;
 }
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7592ddf..ae4cdb2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -38,6 +38,7 @@
 
 #include <kvm/arm_vgic.h>
 #include <kvm/arm_arch_timer.h>
+#include <kvm/arm_pmu.h>
 
 #define KVM_VCPU_MAX_FEATURES 3
 
@@ -63,6 +64,9 @@ struct kvm_arch {
 
 	/* Timer */
 	struct arch_timer_kvm	timer;
+
+	/* PMU */
+	struct pmu_kvm		pmu;
 };
 
 #define KVM_NR_MEM_OBJS     40
@@ -109,8 +113,13 @@ struct kvm_vcpu_arch {
 
 	/* VGIC state */
 	struct vgic_cpu vgic_cpu;
+
+	/* Timer state */
 	struct arch_timer_cpu timer_cpu;
 
+	/* PMU state */
+	struct pmu_cpu pmu_cpu;
+
 	/*
 	 * Anything that is not used directly from assembly code goes
 	 * here.
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index e633ff8..a7fed09 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -69,6 +69,7 @@ struct kvm_regs {
 
 /* Supported device IDs */
 #define KVM_ARM_DEVICE_VGIC_V2		0
+#define KVM_ARM_DEVICE_PMU		1
 
 /* Supported VGIC address types  */
 #define KVM_VGIC_V2_ADDR_TYPE_DIST	0
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 8ba85e9..672213d 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -26,6 +26,7 @@ config KVM
 	select KVM_ARM_HOST
 	select KVM_ARM_VGIC
 	select KVM_ARM_TIMER
+	select KVM_ARM_PMU
 	---help---
 	  Support hosting virtualized guest machines.
 
@@ -60,4 +61,10 @@ config KVM_ARM_TIMER
 	---help---
 	  Adds support for the Architected Timers in virtual machines.
 
+config KVM_ARM_PMU
+	bool
+	depends on KVM_ARM_VGIC
+	---help---
+	  Adds support for the Performance Monitoring in virtual machines.
+
 endif # VIRTUALIZATION
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 72a9fd5..6be68bc 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -21,3 +21,4 @@ kvm-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_generic_v8.o
 
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o
 kvm-$(CONFIG_KVM_ARM_TIMER) += $(KVM)/arm/arch_timer.o
+kvm-$(CONFIG_KVM_ARM_PMU) += $(KVM)/arm/pmu.o
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 70a7816..27f4041 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -24,6 +24,7 @@
 #include <linux/kvm.h>
 
 #include <kvm/arm_arch_timer.h>
+#include <kvm/arm_pmu.h>
 
 #include <asm/cputype.h>
 #include <asm/ptrace.h>
@@ -108,5 +109,8 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset timer */
 	kvm_timer_vcpu_reset(vcpu, cpu_vtimer_irq);
 
+	/* Reset pmu context */
+	kvm_pmu_vcpu_reset(vcpu);
+
 	return 0;
 }
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
new file mode 100644
index 0000000..1e3aa44
--- /dev/null
+++ b/include/kvm/arm_pmu.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ * Author: Anup Patel <anup.patel@linaro.org>
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __ASM_ARM_KVM_PMU_H
+#define __ASM_ARM_KVM_PMU_H
+
+struct pmu_kvm {
+#ifdef CONFIG_KVM_ARM_PMU
+	/* PMU IRQ Numbers */
+	unsigned int		irq_num[CONFIG_KVM_ARM_MAX_VCPUS];
+#endif
+};
+
+struct pmu_cpu {
+#ifdef CONFIG_KVM_ARM_PMU
+	/* IRQ pending flag. Updated when registers are saved. */
+	u32			irq_pending;
+#endif
+};
+
+#ifdef CONFIG_KVM_ARM_PMU
+void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
+void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu);
+int kvm_pmu_addr(struct kvm *kvm, unsigned long cpu, u64 *irq, bool write);
+int kvm_pmu_init(struct kvm *kvm);
+#else
+static inline void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
+static inline void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu) {}
+static inline int kvm_pmu_addr(struct kvm *kvm,
+				unsigned long cpu, u64 *irq, bool write)
+{
+	return -ENXIO;
+}
+static inline int kvm_pmu_init(struct kvm *kvm) { return 0; }
+#endif
+
+#endif
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
new file mode 100644
index 0000000..98066ad
--- /dev/null
+++ b/virt/kvm/arm/pmu.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ * Author: Anup Patel <anup.patel@linaro.org>
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/cpu.h>
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+
+#include <kvm/arm_vgic.h>
+#include <kvm/arm_pmu.h>
+
+/**
+ * kvm_pmu_sync_hwstate - sync pmu state for cpu
+ * @vcpu: The vcpu pointer
+ *
+ * Inject virtual PMU IRQ if IRQ is pending for this cpu.
+ */
+void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu)
+{
+	struct pmu_cpu *pmu = &vcpu->arch.pmu_cpu;
+	struct pmu_kvm *kpmu = &vcpu->kvm->arch.pmu;
+
+	if (pmu->irq_pending) {
+		kvm_vgic_inject_irq(vcpu->kvm, vcpu->vcpu_id,
+				    kpmu->irq_num[vcpu->vcpu_id],
+				    1);
+		pmu->irq_pending = 0;
+		return;
+	}
+}
+
+/**
+ * kvm_pmu_vcpu_reset - reset pmu state for cpu
+ * @vcpu: The vcpu pointer
+ *
+ */
+void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
+{
+	struct pmu_cpu *pmu = &vcpu->arch.pmu_cpu;
+
+	pmu->irq_pending = 0;
+}
+
+/**
+ * kvm_pmu_addr - set or get PMU VM IRQ numbers
+ * @kvm:   pointer to the vm struct
+ * @cpu:  cpu number
+ * @irq:  pointer to irq number value
+ * @write: if true set the irq number else read the irq number
+ *
+ * Set or get the PMU IRQ number for the given cpu number.
+ */
+int kvm_pmu_addr(struct kvm *kvm, unsigned long cpu, u64 *irq, bool write)
+{
+	struct pmu_kvm *kpmu = &kvm->arch.pmu;
+
+	if (CONFIG_KVM_ARM_MAX_VCPUS <= cpu)
+		return -ENODEV;
+
+	mutex_lock(&kvm->lock);
+
+	if (write) {
+		kpmu->irq_num[cpu] = *irq;
+	} else {
+		*irq = kpmu->irq_num[cpu];
+	}
+
+	mutex_unlock(&kvm->lock);
+
+	return 0;
+}
+
+/**
+ * kvm_pmu_init - Initialize global PMU state for a VM
+ * @kvm: pointer to the kvm struct
+ *
+ * Set all the PMU IRQ numbers to invalid value so that
+ * user space has to explicitly provide PMU IRQ numbers
+ * using set device address ioctl.
+ */
+int kvm_pmu_init(struct kvm *kvm)
+{
+	int i;
+	struct pmu_kvm *kpmu = &kvm->arch.pmu;
+
+	for (i = 0; i < CONFIG_KVM_ARM_MAX_VCPUS; i++) {
+		kpmu->irq_num[i] = UINT_MAX;
+	}
+
+	return 0;
+}
-- 
1.7.9.5
