From: mario.smarduch@huawei.com (Mario Smarduch)
Date: Tue, 11 Jun 2013 09:43:42 +0200
Subject: [PATCH 2/2] add initial kvm dev passhtrough support
Message-ID: <51B6D52E.4030707@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is the initial device pass through support.
At this time host == guest only is supported.
Basic Operation:

- QEMU parameters: -device kvm-device-assign,host=<device name>
  for example - kvm-device-assign,host='arm-sp804'. Essentially
  any device that does PIO should be supported.
- Host DTS contains the node for device to be passed through
  The host driver is unbound or not compiled in.
- For Guest the intent is to add a DTS node that QEMU can
  parse and find the guest attributes (Mem. resource, IRQs)
  For now these values default to host. This is a future
  work item to get this working on board other then vexpress.
- The physical interrupt is always passed through to CPU
  where the target vCPU executes or will execute.
  Current approach - pins vCPUs to physical CPUs, when 
  Guest updates CPU affinity is updated in KVM vgic dist
  code. Future work item for IRQ affinity allow vCPU to
  float and on schedule in handle IRQ affinity. For high
  IRQ rates (i.e. wireless NEs) static binding may be used. 
  For some other device (env. mgmt IPMI)where latency is not
  important dynamic may be used, it should be upto the user.
- To support flexible affinity a mask is introduced (QEMU param0
  (although not used here yet)
  o vCPU affinity - vCPU --> CPU binding, the IRQ physical
    CPU binding follows vCPU binding dynamically.
- Obviously DMA is not supported
  - early DMA may be supported through a 1:1 mapping but it's unsafe
    and so far we don't know of any hardware that's not behind SMMU.
    This option may be useful in some embedded/wireless environments,
    where the guest may want to swap, secure isolation may not be
    an issue or device like look aside crypto engine is not behind IOMMU.
  - IOMMU/VFIO support is key and next item for us to work on. Especially 
    for ETSI NFV VFIO is key since 4G/IMS NE pull packets
    of wire and switch them directly in user space.

The patch has been tested on fast models in couple ways:
- UP Guest with sp804 timer only - works consistently
- SMP Guest with sp804 timer works consistently. 
  Writes to '/proc/irq/<sp804 irq>/smp_affinity' 
  confirm dynamic CPU affinity.
- IRQ rates (maybe not that important give its emulated env) reached
  excess of 500.

There is a QEMU piece very simple for now that I will
email later, in case someone would like to test.

- Mario



Signed-off-by: Mario Smarduch <mario.smarduch@huawei.com>
---
 arch/arm/include/asm/kvm_host.h |   14 +++
 arch/arm/include/asm/kvm_vgic.h |   10 +++
 arch/arm/kvm/Makefile           |    1 +
 arch/arm/kvm/arm.c              |   60 +++++++++++++
 arch/arm/kvm/assign-dev.c       |  189 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/vgic.c             |  106 ++++++++++++++++++++++
 include/linux/irqchip/arm-gic.h |    1 +
 include/uapi/linux/kvm.h        |   33 +++++++
 8 files changed, 414 insertions(+)
 create mode 100644 arch/arm/kvm/assign-dev.c

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 57cb786..c6ad3a3 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -67,6 +67,10 @@ struct kvm_arch {
 
 	/* Interrupt controller */
 	struct vgic_dist	vgic;
+
+	/* Device Passthrough Fields */
+	struct list_head        assigned_dev_head;
+	struct mutex            dev_pasthru_lock;
 };
 
 #define KVM_NR_MEM_OBJS     40
@@ -146,6 +150,13 @@ struct kvm_vcpu_stat {
 	u32 halt_wakeup;
 };
 
+struct kvm_arm_assigned_dev_kernel {
+	struct list_head list;
+	struct kvm_arm_assigned_device dev;
+	irqreturn_t (*irq_handler)(int, void *);
+	void *irq_arg;
+};
+
 struct kvm_vcpu_init;
 int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 			const struct kvm_vcpu_init *init);
@@ -156,6 +167,9 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 u64 kvm_call_hyp(void *hypfn, ...);
 void force_vm_exit(const cpumask_t *mask);
+int kvm_arm_get_device_resources(struct kvm *,
+	struct kvm_arm_get_device_resources *);
+int kvm_arm_assign_device(struct kvm *, struct kvm_arm_assigned_device *);
 
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 struct kvm;
diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index 343744e..c4370ae 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -107,6 +107,16 @@ struct vgic_dist {
 
 	/* Bitmap indicating which CPU has something pending */
 	unsigned long		irq_pending_on_cpu;
+
+	/* Device passthrough  fields */
+	/* Host irq to guest irq mapping */
+	u8                      guest_irq[VGIC_NR_SHARED_IRQS];
+
+	/* Pending passthruogh irq */
+	struct vgic_bitmap      pasthru_spi_pending;
+
+	/* At least one passthrough IRQ pending for some vCPU */
+	u32                     pasthru_pending;
 #endif
 };
 
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 53c5ed8..823fc38 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -21,3 +21,4 @@ obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
 obj-y += coproc.o coproc_a15.o mmio.o psci.o perf.o
 obj-$(CONFIG_KVM_ARM_VGIC) += vgic.o
 obj-$(CONFIG_KVM_ARM_TIMER) += arch_timer.o
+obj-$(CONFIG_KVM_ARM_INT_PRIO_DROP) += assign-dev.o
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 37d216d..636462d 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -26,6 +26,8 @@
 #include <linux/mman.h>
 #include <linux/sched.h>
 #include <linux/kvm.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <trace/events/kvm.h>
 
 #define CREATE_TRACE_POINTS
@@ -43,6 +45,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
 #include <asm/kvm_psci.h>
+#include <asm/kvm_host.h>
 
 #ifdef REQUIRES_VIRT
 __asm__(".arch_extension	virt");
@@ -139,6 +142,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	/* Mark the initial VMID generation invalid */
 	kvm->arch.vmid_gen = 0;
+	/* Initialize Dev Passthrough Fields */
+	INIT_LIST_HEAD(&kvm->arch.assigned_dev_head);
+	mutex_init(&kvm->arch.dev_pasthru_lock);
 
 	return ret;
 out_free_stage2_pgd:
@@ -169,6 +175,37 @@ int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages)
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	int i;
+	struct list_head *dev_list_ptr = &kvm->arch.assigned_dev_head;
+	struct list_head *ptr, *q;
+	struct kvm_arm_assigned_dev_kernel *assigned_dev = NULL;
+	u64 hpa;
+	u32 sz, irq;
+
+	/* On VM shutdown free-up Passthrough device association */
+	mutex_lock(&kvm->arch.dev_pasthru_lock);
+	list_for_each_safe(ptr, q, dev_list_ptr) {
+		int i;
+		assigned_dev = list_entry(ptr,
+			struct kvm_arm_assigned_dev_kernel, list);
+		for (i = 0; i < assigned_dev->dev.dev_res.resource_cnt; i++) {
+			hpa = assigned_dev->dev.dev_res.host_resources[i].hpa;
+			if (hpa) {
+				sz = assigned_dev->dev.dev_res.host_resources[i].size;
+				release_mem_region(hpa, sz);
+			}
+		}
+		irq = assigned_dev->dev.dev_res.hostirq.hwirq;
+		if (irq) {
+			free_irq(irq, (void *) assigned_dev->irq_arg);
+			/* Clears IRQ for Passthrough, also writes to DIR
+			 * to get it out of deactiveate state for next time.
+			 */
+			gic_spi_clr_priodrop(irq);
+		}
+		list_del(ptr);
+		kfree(assigned_dev);
+	}
+	mutex_unlock(&kvm->arch.dev_pasthru_lock);
 
 	kvm_free_stage2_pgd(kvm);
 
@@ -782,6 +819,29 @@ long kvm_arch_vm_ioctl(struct file *filp,
 			return -EFAULT;
 		return kvm_vm_ioctl_set_device_addr(kvm, &dev_addr);
 	}
+	case KVM_ARM_GET_DEVICE_RESOURCES: {
+		struct kvm_arm_get_device_resources dev_resources;
+		int ret;
+
+		if (copy_from_user(&dev_resources, argp, sizeof(dev_resources)))
+			return -EFAULT;
+		ret = kvm_arm_get_device_resources(kvm, &dev_resources);
+		if (!ret) {
+			if (copy_to_user(argp, &dev_resources,
+					sizeof(dev_resources)))
+				return -EFAULT;
+		}
+		return ret;
+	}
+
+	case KVM_ARM_ASSIGN_DEVICE: {
+		struct kvm_arm_assigned_device dev_assigned;
+
+		if (copy_from_user(&dev_assigned, argp,
+				sizeof(struct kvm_arm_assigned_device)))
+			return -EFAULT;
+		return kvm_arm_assign_device(kvm, &dev_assigned);
+	}
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/arm/kvm/assign-dev.c b/arch/arm/kvm/assign-dev.c
new file mode 100644
index 0000000..2364eb8
--- /dev/null
+++ b/arch/arm/kvm/assign-dev.c
@@ -0,0 +1,189 @@
+/*
+ * Copyright (C) 2012 - Huawei Technologies
+ * Author: Mario Smarduch <mario.smarduch@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/kvm_host.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/fs.h>
+#include <linux/mman.h>
+#include <linux/sched.h>
+#include <linux/kvm.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/interrupt.h>
+#include <trace/events/kvm.h>
+#include <linux/irqnr.h>
+
+#include <asm/kvm_mmu.h>
+
+static irqreturn_t kvm_arm_passthru_handler(int irq, void *dev_id)
+{
+	/* Mark the pass-through IRQ for guest */
+	struct kvm_vcpu *vcpu = dev_id;
+	struct kvm *kvm = vcpu->kvm;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	int idx = irq - VGIC_NR_PRIVATE_IRQS;
+	wait_queue_head_t *wqp;
+
+	set_bit(idx % 32,
+			(void *) &dist->pasthru_spi_pending.shared.reg[idx/32]);
+	dist->pasthru_pending = 1;
+	wqp = kvm_arch_vcpu_wq(vcpu);
+	if (waitqueue_active(wqp)) {
+		wake_up_interruptible(wqp);
+		++vcpu->stat.halt_wakeup;
+	}
+	return IRQ_HANDLED;
+}
+
+int kvm_arm_get_device_resources(struct kvm *kvm,
+				struct kvm_arm_get_device_resources *res_info)
+{
+	struct device_node *dev_node = NULL;
+	struct resource res;
+	char *buf;
+	int res_cnt = 0, ret = 0;
+
+	struct kvm_arm_assigned_dev_kernel *assigned_dev;
+
+	assigned_dev = kzalloc(sizeof(*assigned_dev), GFP_KERNEL);
+	if (!assigned_dev)
+		goto no_resources;
+
+	dev_node = of_find_compatible_node(NULL, NULL, res_info->devname);
+	if (!dev_node) {
+		ret = -ENODEV;
+		goto no_resources;
+	}
+
+	while (!of_address_to_resource(dev_node, res_cnt, &res)) {
+		/* Save device attributes */
+		res_info->host_resources[res_cnt].hpa = res.start;
+		res_info->host_resources[res_cnt].size = resource_size(&res);
+		res_info->host_resources[res_cnt].attr = res.flags;
+		assigned_dev->dev.dev_res.host_resources[res_cnt] =
+			res_info->host_resources[res_cnt];
+		buf = assigned_dev->dev.dev_res.host_resources[res_cnt].host_name;
+		sprintf(buf, "%s-KVM Pass-through/%d", res_info->devname,
+				res_cnt);
+		/* Synchronizes device assignment first assignment
+		 * through - Guest owns the device, until it releases it.
+		 */
+		if (!request_mem_region_exclusive(res.start,
+					resource_size(&res), buf)) {
+			ret = -EBUSY;
+			goto no_resources;
+		}
+		res_cnt++;
+	}
+	res_info->resource_cnt = res_cnt;
+
+	/* Get Device IRQ */
+	if (of_irq_to_resource(dev_node, 0, &res)) {
+		res_info->hostirq.hwirq = res.start;
+		res_info->hostirq.attr = res.flags;
+	}
+
+	assigned_dev->irq_handler = kvm_arm_passthru_handler;
+	assigned_dev->dev.dev_res.hostirq = res_info->hostirq;
+	assigned_dev->dev.dev_res.resource_cnt = res_info->resource_cnt;
+	strcpy(assigned_dev->dev.dev_res.devname, res_info->devname);
+
+	mutex_lock(&kvm->arch.dev_pasthru_lock);
+	list_add(&assigned_dev->list, &kvm->arch.assigned_dev_head);
+	mutex_unlock(&kvm->arch.dev_pasthru_lock);
+
+	return ret;
+
+no_resources:
+	/* If failed release all device regions */
+	while (res_cnt > 0) {
+		release_mem_region(res_info->host_resources[res_cnt-1].hpa,
+			res_info->host_resources[res_cnt-1].size);
+		res_cnt--;
+	}
+	kfree(assigned_dev);
+	return ret;
+}
+
+/* Setup 2nd stage mappings for the Passthrough device, the IRQ is setup later
+ */
+
+int kvm_arm_assign_device(struct kvm *kvm, struct kvm_arm_assigned_device *dev)
+{
+	int i, ret = 0;
+	phys_addr_t pa, ipa;
+	uint64_t hpa;
+	uint32_t sz;
+	struct list_head *dev_list_ptr = &kvm->arch.assigned_dev_head;
+	struct list_head *ptr;
+	struct kvm_arm_assigned_dev_kernel *assigned_dev = NULL;
+
+	mutex_lock(&kvm->arch.dev_pasthru_lock);
+	list_for_each(ptr, dev_list_ptr) {
+		assigned_dev = list_entry(ptr,
+				struct kvm_arm_assigned_dev_kernel, list);
+		if (strcmp(assigned_dev->dev.dev_res.devname,
+					dev->dev_res.devname) == 0) {
+			assigned_dev->dev.guest_res = dev->guest_res;
+			break;
+		}
+	}
+	mutex_unlock(&kvm->arch.dev_pasthru_lock);
+	if (!assigned_dev || strcmp(assigned_dev->dev.dev_res.devname,
+			dev->dev_res.devname) != 0) {
+		ret = -ENODEV;
+		goto dev_not_found;
+	}
+
+	for (i = 0; i < dev->dev_res.resource_cnt; i++) {
+		pa = dev->dev_res.host_resources[i].hpa;
+		sz = dev->dev_res.host_resources[i].size;
+		ipa = dev->guest_res.gpa[i];
+
+		/* Map device into Guest 2nd stage
+		 */
+		ret = kvm_phys_addr_ioremap(kvm, ipa, pa, sz);
+		if (ret) {
+			ret = -ENOMEM;
+			goto assign_dev_failed;
+		}
+	}
+
+	return ret;
+
+assign_dev_failed:
+	for (i = 0; i < assigned_dev->dev.dev_res.resource_cnt; i++) {
+		hpa = assigned_dev->dev.dev_res.host_resources[i].hpa;
+		if (hpa) {
+			sz = assigned_dev->dev.dev_res.host_resources[i].size;
+			release_mem_region(hpa, sz);
+		}
+	}
+	mutex_lock(&kvm->arch.dev_pasthru_lock);
+	list_del(&assigned_dev->list);
+	mutex_unlock(&kvm->arch.dev_pasthru_lock);
+	kfree(assigned_dev);
+dev_not_found:
+	return ret;
+}
+
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 17c5ac7..f4cb804 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -449,6 +449,41 @@ static u32 vgic_get_target_reg(struct kvm *kvm, int irq)
 	return val;
 }
 
+/* Follow the IRQ vCPU affinity so passthrough device interrupts are injected
+ * on physical CPU they execute.
+ */
+static void vgic_set_passthru_affinity(struct kvm *kvm, int irq, u32 target)
+{
+	struct list_head *dev_list_ptr = &kvm->arch.assigned_dev_head;
+	struct list_head *ptr;
+	struct kvm_arm_assigned_dev_kernel *assigned_dev;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	char *buf;
+	int cpu, hwirq;
+
+	mutex_lock(&kvm->arch.dev_pasthru_lock);
+	list_for_each(ptr, dev_list_ptr) {
+		assigned_dev = list_entry(ptr,
+				struct kvm_arm_assigned_dev_kernel, list);
+		if (assigned_dev->dev.guest_res.girq == irq) {
+			if (assigned_dev->irq_arg)
+				free_irq(irq, assigned_dev->irq_arg);
+			cpu = kvm->vcpus[target]->cpu;
+			hwirq = assigned_dev->dev.dev_res.hostirq.hwirq;
+			irq_set_affinity(hwirq, cpumask_of(cpu));
+			assigned_dev->irq_arg = kvm->vcpus[target];
+			buf = assigned_dev->dev.dev_res.hostirq.host_name;
+			sprintf(buf, "%s-KVM Pass-through",
+					assigned_dev->dev.dev_res.devname);
+			gic_spi_set_priodrop(hwirq);
+			dist->guest_irq[hwirq - VGIC_NR_PRIVATE_IRQS] = irq;
+			request_irq(hwirq, assigned_dev->irq_handler, 0, buf,
+							assigned_dev->irq_arg);
+		}
+	}
+	mutex_unlock(&kvm->arch.dev_pasthru_lock);
+}
+
 static void vgic_set_target_reg(struct kvm *kvm, u32 val, int irq)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
@@ -469,6 +504,8 @@ static void vgic_set_target_reg(struct kvm *kvm, u32 val, int irq)
 		target = ffs((val >> shift) & 0xffU);
 		target = target ? (target - 1) : 0;
 		dist->irq_spi_cpu[irq + i] = target;
+		vgic_set_passthru_affinity(kvm, irq + VGIC_NR_PRIVATE_IRQS + i,
+			 target);
 		kvm_for_each_vcpu(c, vcpu, kvm) {
 			bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[c]);
 			if (c == target)
@@ -830,6 +867,9 @@ static void vgic_update_state(struct kvm *kvm)
 	(((lr) & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT)
 #define MK_LR_PEND(src, irq)	\
 	(GICH_LR_PENDING_BIT | ((src) << GICH_LR_PHYSID_CPUID_SHIFT) | (irq))
+#define MK_LR_HWIRQ_PEND(hwirq, gstirq)                 \
+	(GICH_LR_HWIRQ_BIT  | GICH_LR_PENDING_BIT |     \
+	((hwirq) << GICH_LR_PHYSID_CPUID_SHIFT) | gstirq)
 
 /*
  * An interrupt may have been disabled after being made pending on the
@@ -859,6 +899,37 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
 }
 
 /*
+ * Queue Physical Passthrough Interrupt.
+ */
+static bool vgic_queue_phys_irq(struct kvm_vcpu *vcpu, int irq)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	int lr;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int gstirq = dist->guest_irq[irq - VGIC_NR_PRIVATE_IRQS];
+
+	/* Sanitize the input... */
+	BUG_ON(irq >= VGIC_NR_IRQS);
+
+	lr = vgic_cpu->vgic_irq_lr_map[gstirq];
+	if (lr != LR_EMPTY)
+		return false;
+
+	/* Do we have an active interrupt for the same CPUID? */
+	/* Try to use another LR for this interrupt */
+	lr = find_first_zero_bit((unsigned long *)vgic_cpu->lr_used,
+						vgic_cpu->nr_lr);
+	if (lr >= vgic_cpu->nr_lr)
+		return false;
+
+	/* Format LR to hwirq and guest irq */
+	vgic_cpu->vgic_lr[lr] = MK_LR_HWIRQ_PEND(irq, gstirq);
+	vgic_cpu->vgic_irq_lr_map[gstirq] = lr;
+	set_bit(lr, vgic_cpu->lr_used);
+	return true;
+}
+
+/*
  * Queue an interrupt to a CPU virtual interface. Return true on success,
  * or false if it wasn't possible to queue it.
  */
@@ -963,6 +1034,7 @@ static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	int i, vcpu_id;
 	int overflow = 0;
+	unsigned long flags;
 
 	vcpu_id = vcpu->vcpu_id;
 
@@ -972,6 +1044,9 @@ static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 	 * move along.
 	 */
 	if (!kvm_vgic_vcpu_pending_irq(vcpu)) {
+		/* Jump directly to Physical Interrupts */
+		if (dist->pasthru_pending)
+			goto do_passthrough;
 		pr_debug("CPU%d has no pending interrupt\n", vcpu_id);
 		goto epilog;
 	}
@@ -993,6 +1068,37 @@ static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 		if (!vgic_queue_hwirq(vcpu, i + VGIC_NR_PRIVATE_IRQS))
 			overflow = 1;
 	}
+do_passthrough:
+	/* Process passthrough physical interrupts. CPUs that are not targeted
+	 * by the passthrough IRQ may execute this code but will not inject
+	 * the interrupt since target vcpuid is not equal to this one.
+	 * Interrupts are injected from IRQ and distributor can't be locked
+	 * and it's not possible to determine the physical CPU at that time.
+	 */
+
+	/* disable interrupts not mis higher priority interrupts on this CPU */
+	local_irq_save(flags);
+	dist->pasthru_pending = 0;
+	for_each_set_bit(i, dist->pasthru_spi_pending.shared.reg_ul,
+							VGIC_NR_SHARED_IRQS) {
+		/* Convert from phys irq to guest irq */
+		int gstirq = dist->guest_irq[i];
+
+		/* Get vGIC GICD_ITARGETn for gstirq */
+		int cpuid = dist->irq_spi_cpu[gstirq - VGIC_NR_PRIVATE_IRQS];
+
+		/* Check if gstirq enabled if not remember for future inj. */
+		if (cpuid == vcpu_id && vgic_irq_is_enabled(vcpu, gstirq) &&
+			dist->enabled) {
+			if (!vgic_queue_phys_irq(vcpu, i+VGIC_NR_PRIVATE_IRQS)) {
+				overflow = 1;
+				dist->pasthru_pending = 1;
+			} else
+				clear_bit(i % 32, (void *) &dist->pasthru_spi_pending.shared.reg[i/32]);
+		} else
+			dist->pasthru_pending = 1;
+	}
+	local_irq_restore(flags);
 
 epilog:
 	if (overflow) {
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index adb5d00..faf92cc 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -53,6 +53,7 @@
 #define GICH_LR_STATE			(3 << 28)
 #define GICH_LR_PENDING_BIT		(1 << 28)
 #define GICH_LR_ACTIVE_BIT		(1 << 29)
+#define GICH_LR_HWIRQ_BIT               (1 << 31)
 #define GICH_LR_EOI			(1 << 19)
 
 #define GICH_MISR_EOI			(1 << 0)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a5c86fc..e850ca9 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -932,6 +932,10 @@ struct kvm_s390_ucas_mapping {
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
+/* vm fd ioctl for ARM Device Passthrough */
+#define KVM_ARM_GET_DEVICE_RESOURCES _IOW(KVMIO,  0xe1, struct kvm_arm_get_device_resources)
+#define KVM_ARM_ASSIGN_DEVICE     _IOW(KVMIO,  0xe2, struct kvm_arm_assigned_device)
+
 
 /* ioctls for fds returned by KVM_CREATE_DEVICE */
 #define KVM_SET_DEVICE_ATTR	  _IOW(KVMIO,  0xe1, struct kvm_device_attr)
@@ -1060,4 +1064,33 @@ struct kvm_assigned_msix_entry {
 	__u16 padding[3];
 };
 
+/* ARM Device Passthrough Definitions */
+
+/* MAX 6 MMIO resources per device - for now*/
+#define MAX_RES_PER_DEVICE      6
+struct kvm_arm_get_device_resources {
+	char    devname[128];
+	__u32   resource_cnt;
+	struct {
+		__u64   hpa;
+		__u32   size;
+		__u32   attr;
+		char    host_name[64];
+	} host_resources[MAX_RES_PER_DEVICE];
+	struct {
+		__u32   hwirq;
+		__u32   attr;
+		char    host_name[64];
+	} hostirq;
+};
+
+struct kvm_guest_device_resources {
+	__u64   gpa[MAX_RES_PER_DEVICE];
+	__u32   girq;
+};
+
+struct kvm_arm_assigned_device {
+	struct  kvm_arm_get_device_resources dev_res;
+	struct  kvm_guest_device_resources guest_res;
+};
 #endif /* __LINUX_KVM_H */
-- 
1.7.9.5
