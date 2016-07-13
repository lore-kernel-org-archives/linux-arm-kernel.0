From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Wed, 13 Jul 2016 17:16:46 -0000
Subject: [patch V2 44/67] arm/kvm/vgic: Convert to hotplug state machine
References: <20160713153219.128052238@linutronix.de>
Message-ID: <20160713153336.546953286@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Cochran <rcochran@linutronix.de>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.
The VGIC callback is run after KVM's main callback since it reflects the
makefile order.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krcmar <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm at vger.kernel.org
Cc: kvmarm at lists.cs.columbia.edu
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 include/linux/cpuhotplug.h |  1 +
 virt/kvm/arm/vgic.c        | 39 ++++++++-------------------------------
 2 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index ef7bfa6..80c15ce 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -43,6 +43,7 @@ enum cpuhp_state {
 	CPUHP_AP_QCOM_TIMER_STARTING,
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
 	CPUHP_AP_KVM_STARTING,
+	CPUHP_AP_KVM_ARM_VGIC_STARTING,
 	CPUHP_AP_LEDTRIG_STARTING,
 	CPUHP_AP_NOTIFY_STARTING,
 	CPUHP_AP_ONLINE,
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index c3bfbb9..67cb5e9 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2326,32 +2326,18 @@ int vgic_has_attr_regs(const struct vgic_io_range *ranges, phys_addr_t offset)
 		return -ENXIO;
 }
 
-static void vgic_init_maintenance_interrupt(void *info)
+static int vgic_starting_cpu(unsigned int cpu)
 {
 	enable_percpu_irq(vgic->maint_irq, 0);
+	return 0;
 }
 
-static int vgic_cpu_notify(struct notifier_block *self,
-			   unsigned long action, void *cpu)
+static int vgic_dying_cpu(unsigned int cpu)
 {
-	switch (action) {
-	case CPU_STARTING:
-	case CPU_STARTING_FROZEN:
-		vgic_init_maintenance_interrupt(NULL);
-		break;
-	case CPU_DYING:
-	case CPU_DYING_FROZEN:
-		disable_percpu_irq(vgic->maint_irq);
-		break;
-	}
-
-	return NOTIFY_OK;
+	disable_percpu_irq(vgic->maint_irq);
+	return 0;
 }
 
-static struct notifier_block vgic_cpu_nb = {
-	.notifier_call = vgic_cpu_notify,
-};
-
 static int kvm_vgic_probe(void)
 {
 	const struct gic_kvm_info *gic_kvm_info;
@@ -2392,19 +2378,10 @@ int kvm_vgic_hyp_init(void)
 		return ret;
 	}
 
-	ret = __register_cpu_notifier(&vgic_cpu_nb);
-	if (ret) {
-		kvm_err("Cannot register vgic CPU notifier\n");
-		goto out_free_irq;
-	}
-
-	on_each_cpu(vgic_init_maintenance_interrupt, NULL, 1);
-
+	cpuhp_setup_state(CPUHP_AP_KVM_ARM_VGIC_STARTING,
+			  "AP_KVM_ARM_VGIC_STARTING", vgic_starting_cpu,
+			  vgic_dying_cpu);
 	return 0;
-
-out_free_irq:
-	free_percpu_irq(vgic->maint_irq, kvm_get_running_vcpus());
-	return ret;
 }
 
 int kvm_irq_map_gsi(struct kvm *kvm,
-- 
2.8.1
