From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Tue, 08 Jan 2013 13:43:34 -0500
Subject: [PATCH v5 4/4] ARM: KVM: arch_timers: Wire the init code and config
 option
In-Reply-To: <20130108184259.46758.17939.stgit@ubuntu>
References: <20130108184259.46758.17939.stgit@ubuntu>
Message-ID: <20130108184334.46758.93766.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

It is now possible to select CONFIG_KVM_ARM_TIMER to enable the
KVM architected timer support.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/kvm/Kconfig  |    8 ++++++++
 arch/arm/kvm/Makefile |    1 +
 arch/arm/kvm/arm.c    |   11 +++++++++++
 arch/arm/kvm/vgic.c   |    1 +
 4 files changed, 21 insertions(+)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index d32e33f..739500b 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -59,6 +59,14 @@ config KVM_ARM_VGIC
 	---help---
 	  Adds support for a hardware assisted, in-kernel GIC emulation.
 
+config KVM_ARM_TIMER
+        bool "KVM support for Architected Timers"
+	depends on KVM_ARM_VGIC && ARM_ARCH_TIMER
+	select HAVE_KVM_IRQCHIP
+	default y
+	---help---
+	  Adds support for the Architected Timers in virtual machines
+
 source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 3c6620c..43c4cad 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -20,3 +20,4 @@ obj-y += kvm-arm.o init.o interrupts.o
 obj-y += arm.o guest.o mmu.o emulate.o reset.o
 obj-y += coproc.o coproc_a15.o mmio.o decode.o
 obj-$(CONFIG_KVM_ARM_VGIC) += vgic.o
+obj-$(CONFIG_KVM_ARM_TIMER) += arch_timer.o
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 22f39d6..38ad78a 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -287,6 +287,7 @@ int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	kvm_mmu_free_memory_caches(vcpu);
+	kvm_timer_vcpu_terminate(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
@@ -328,6 +329,9 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	if (ret)
 		return ret;
 
+	/* Set up the timer */
+	kvm_timer_vcpu_init(vcpu);
+
 	return 0;
 }
 
@@ -1084,6 +1088,13 @@ static int init_hyp_mode(void)
 		vgic_present = true;
 #endif
 
+	/*
+	 * Init HYP architected timer support
+	 */
+	err = kvm_timer_hyp_init();
+	if (err)
+		goto out_free_mappings;
+
 	kvm_info("Hyp mode initialized successfully\n");
 	return 0;
 out_free_vfp:
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 083639b..7eb94fa 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -1405,6 +1405,7 @@ int kvm_vgic_init(struct kvm *kvm)
 	for (i = VGIC_NR_PRIVATE_IRQS; i < VGIC_NR_IRQS; i += 4)
 		vgic_set_target_reg(kvm, 0, i);
 
+	kvm_timer_init(kvm);
 	kvm->arch.vgic.ready = true;
 out:
 	mutex_unlock(&kvm->lock);
