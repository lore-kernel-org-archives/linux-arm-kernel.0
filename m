From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat, 15 Sep 2012 11:39:47 -0400
Subject: [PATCH 5/5] ARM: KVM: arch_timers: Wire the init code and config
 option
In-Reply-To: <20120915153902.21673.37552.stgit@ubuntu>
References: <20120915153902.21673.37552.stgit@ubuntu>
Message-ID: <20120915153947.21673.48043.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

It is now possible to select CONFIG_KVM_ARM_TIMER to enable the
KVM architected timer support.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/kvm/Kconfig  |    7 +++++++
 arch/arm/kvm/Makefile |    1 +
 arch/arm/kvm/arm.c    |   11 +++++++++++
 arch/arm/kvm/vgic.c   |    4 ++++
 4 files changed, 23 insertions(+)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 867551e..ade2673 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -47,6 +47,13 @@ config KVM_ARM_VGIC
 	---help---
 	  Adds support for a hardware assisted, in-kernel GIC emulation.
 
+config KVM_ARM_TIMER
+        bool "KVM support for Architected Timers"
+	depends on KVM_ARM_VGIC && ARM_ARCH_TIMER
+	select HAVE_KVM_IRQCHIP
+	---help---
+	  Adds support for the Architected Timers in virtual machines
+
 source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 0917695..916c1eb 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_KVM_ARM_HOST) += $(addprefix ../../../virt/kvm/, kvm_main.o coalesc
 
 obj-$(CONFIG_KVM_ARM_HOST) += arm.o guest.o mmu.o emulate.o reset.o coproc.o
 obj-$(CONFIG_KVM_ARM_VGIC) += vgic.o
+obj-$(CONFIG_KVM_ARM_TIMER) += timer.o
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index af71560..45b4dc3 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -285,6 +285,7 @@ out:
 void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	kvm_mmu_free_memory_caches(vcpu);
+	kvm_timer_vcpu_terminate(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
@@ -316,6 +317,9 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	/* Set up VGIC */
 	kvm_vgic_vcpu_init(vcpu);
 
+	/* Set up the timer */
+	kvm_timer_vcpu_init(vcpu);
+
 	return 0;
 }
 
@@ -1016,6 +1020,13 @@ static int init_hyp_mode(void)
 	if (!err)
 		vgic_present = true;
 
+	/*
+	 * Init HYP architected timer support
+	 */
+	err = kvm_timer_hyp_init();
+	if (err)
+		goto out_free_mappings;
+
 	return 0;
 out_free_vfp:
 	free_percpu(kvm_host_vfp_state);
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 63fe0dd..494d94d 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -1111,5 +1111,9 @@ int kvm_vgic_init(struct kvm *kvm)
 
 out:
 	mutex_unlock(&kvm->lock);
+
+	if (!ret)
+		kvm_timer_init(kvm);
+
 	return ret;
 }
