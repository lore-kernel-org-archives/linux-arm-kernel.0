From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 16 Nov 2013 19:12:05 -0800
Subject: [PATCH 1/2 v2] arm/arm64: KVM: arch_timer: Initialize cntvoff at
 kvm_init
In-Reply-To: <1384657926-28194-1-git-send-email-christoffer.dall@linaro.org>
References: <1384657926-28194-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1384657926-28194-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the cntvoff at kvm_init_vm time, not before running the VCPUs
at the first time because that will overwrite any potentially restored
values from user space.

Cc: Marc Zynger <marc.zyngier@arm.com>
Cc: Andre Przywara <andre.przywara@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---

Changelog[v2]:
 - Call kvm_timer_init from kvm_arch_init_vm instead of moving the cntvoff to
   vcpu initialization, which would be redundant.

 arch/arm/kvm/arm.c  |    2 ++
 virt/kvm/arm/vgic.c |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index e312e4a..2bc2ec4 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -137,6 +137,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (ret)
 		goto out_free_stage2_pgd;
 
+	kvm_timer_init(kvm);
+
 	/* Mark the initial VMID generation invalid */
 	kvm->arch.vmid_gen = 0;
 
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 685fc72..81e9481 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1409,7 +1409,6 @@ int kvm_vgic_init(struct kvm *kvm)
 	for (i = VGIC_NR_PRIVATE_IRQS; i < VGIC_NR_IRQS; i += 4)
 		vgic_set_target_reg(kvm, 0, i);
 
-	kvm_timer_init(kvm);
 	kvm->arch.vgic.ready = true;
 out:
 	mutex_unlock(&kvm->lock);
-- 
1.7.10.4
