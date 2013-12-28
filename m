From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 28 Dec 2013 11:15:33 +0000
Subject: [PATCH 01/15] arm/arm64: KVM: arch_timer: Initialize cntvoff at
 kvm_init
In-Reply-To: <1388229347-24185-1-git-send-email-marc.zyngier@arm.com>
References: <1388229347-24185-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1388229347-24185-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Initialize the cntvoff at kvm_init_vm time, not before running the VCPUs
at the first time because that will overwrite any potentially restored
values from user space.

Cc: Andre Przywara <andre.przywara@linaro.org>
Acked-by: Marc Zynger <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c  | 2 ++
 virt/kvm/arm/vgic.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 2a700e0..13205bd 100644
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
1.8.5.1
