From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:16:33 -0400
Subject: [PATCH v2 5/5] ARM: KVM: arch_timers: Wire the init code and config
 option
In-Reply-To: <20121001091528.49694.69990.stgit@ubuntu>
References: <20121001091528.49694.69990.stgit@ubuntu>
Message-ID: <20121001091633.49694.98982.stgit@ubuntu>
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
index 89608c0..8f4aa02 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_KVM_ARM_HOST) += $(addprefix ../../../virt/kvm/, kvm_main.o coalesc
 obj-$(CONFIG_KVM_ARM_HOST) += arm.o guest.o mmu.o emulate.o reset.o
 obj-$(CONFIG_KVM_ARM_HOST) += coproc.o coproc_a15.o
 obj-$(CONFIG_KVM_ARM_VGIC) += vgic.o
+obj-$(CONFIG_KVM_ARM_TIMER) += timer.o
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index c62bf28..f8c377b 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -283,6 +283,7 @@ out:
 void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	kvm_mmu_free_memory_caches(vcpu);
+	kvm_timer_vcpu_terminate(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
@@ -320,6 +321,9 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	/* Set up VGIC */
 	kvm_vgic_vcpu_init(vcpu);
 
+	/* Set up the timer */
+	kvm_timer_vcpu_init(vcpu);
+
 	return 0;
 }
 
@@ -1010,6 +1014,13 @@ static int init_hyp_mode(void)
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
