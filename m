From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:49 +0100
Subject: [GIT PULL 20/36] arm/arm64: KVM: move kvm_register_device_ops() into
 vGIC probing
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-21-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

Currently we unconditionally register the GICv2 emulation device
during the host's KVM initialization. Since with GICv3 support we
may end up with only v2 or only v3 or both supported, we move the
registration into the GIC probing function, where we will later know
which combination is valid.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/arm/vgic-v2.c   | 2 ++
 virt/kvm/arm/vgic-v3.c   | 1 +
 virt/kvm/arm/vgic.c      | 5 ++---
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3b934cc..25d7ce3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1051,6 +1051,7 @@ void kvm_unregister_device_ops(u32 type);
 
 extern struct kvm_device_ops kvm_mpic_ops;
 extern struct kvm_device_ops kvm_xics_ops;
+extern struct kvm_device_ops kvm_arm_vgic_v2_ops;
 
 #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
 
diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
index 2935405..e1cd3cb 100644
--- a/virt/kvm/arm/vgic-v2.c
+++ b/virt/kvm/arm/vgic-v2.c
@@ -229,6 +229,8 @@ int vgic_v2_probe(struct device_node *vgic_node,
 		goto out_unmap;
 	}
 
+	kvm_register_device_ops(&kvm_arm_vgic_v2_ops, KVM_DEV_TYPE_ARM_VGIC_V2);
+
 	vgic->vcpu_base = vcpu_res.start;
 
 	kvm_info("%s@%llx IRQ%d\n", vgic_node->name,
diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
index 1c2c8ee..d14c75f 100644
--- a/virt/kvm/arm/vgic-v3.c
+++ b/virt/kvm/arm/vgic-v3.c
@@ -230,6 +230,7 @@ int vgic_v3_probe(struct device_node *vgic_node,
 		ret = -ENXIO;
 		goto out;
 	}
+	kvm_register_device_ops(&kvm_arm_vgic_v2_ops, KVM_DEV_TYPE_ARM_VGIC_V2);
 
 	vgic->vcpu_base = vcpu_res.start;
 	vgic->vctrl_base = NULL;
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 9b63141..69f6e7a 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2564,7 +2564,7 @@ static int vgic_create(struct kvm_device *dev, u32 type)
 	return kvm_vgic_create(dev->kvm, type);
 }
 
-static struct kvm_device_ops kvm_arm_vgic_v2_ops = {
+struct kvm_device_ops kvm_arm_vgic_v2_ops = {
 	.name = "kvm-arm-vgic",
 	.create = vgic_create,
 	.destroy = vgic_destroy,
@@ -2643,8 +2643,7 @@ int kvm_vgic_hyp_init(void)
 
 	on_each_cpu(vgic_init_maintenance_interrupt, NULL, 1);
 
-	return kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
-				       KVM_DEV_TYPE_ARM_VGIC_V2);
+	return 0;
 
 out_free_irq:
 	free_percpu_irq(vgic->maint_irq, kvm_get_running_vcpus());
-- 
2.1.2.330.g565301e.dirty
