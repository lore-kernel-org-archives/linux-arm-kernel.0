From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 31 Oct 2014 17:26:42 +0000
Subject: [PATCH v3 07/19] arm/arm64: KVM: move kvm_register_device_ops() into
 vGIC probing
In-Reply-To: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1414776414-13426-8-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we unconditionally register the GICv2 emulation device
during the host's KVM initialization. Since with GICv3 support we
may end up with only v2 or only v3 or both supported, we move the
registration into the GIC probing function, where we will later know
which combination is valid.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 include/linux/kvm_host.h |    1 +
 virt/kvm/arm/vgic-v2.c   |    2 ++
 virt/kvm/arm/vgic-v3.c   |    1 +
 virt/kvm/arm/vgic.c      |    5 ++---
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ea53b04..326ba7a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1084,6 +1084,7 @@ void kvm_unregister_device_ops(u32 type);
 
 extern struct kvm_device_ops kvm_mpic_ops;
 extern struct kvm_device_ops kvm_xics_ops;
+extern struct kvm_device_ops kvm_arm_vgic_v2_ops;
 
 #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
 
diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
index bdc8d97..417ecaa 100644
--- a/virt/kvm/arm/vgic-v2.c
+++ b/virt/kvm/arm/vgic-v2.c
@@ -242,6 +242,8 @@ int vgic_v2_probe(struct device_node *vgic_node,
 		goto out_unmap;
 	}
 
+	kvm_register_device_ops(&kvm_arm_vgic_v2_ops, KVM_DEV_TYPE_ARM_VGIC_V2);
+
 	vgic->vcpu_base = vcpu_res.start;
 
 	kvm_info("%s@%llx IRQ%d\n", vgic_node->name,
diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
index a38339e..6825c71 100644
--- a/virt/kvm/arm/vgic-v3.c
+++ b/virt/kvm/arm/vgic-v3.c
@@ -241,6 +241,7 @@ int vgic_v3_probe(struct device_node *vgic_node,
 		ret = -ENXIO;
 		goto out;
 	}
+	kvm_register_device_ops(&kvm_arm_vgic_v2_ops, KVM_DEV_TYPE_ARM_VGIC_V2);
 
 	vgic->init_emul = vgic_v3_init_emul_compat;
 	vgic->vcpu_base = vcpu_res.start;
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 8c2e707..98fffb4 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2511,7 +2511,7 @@ static int vgic_create(struct kvm_device *dev, u32 type)
 	return kvm_vgic_create(dev->kvm, type);
 }
 
-static struct kvm_device_ops kvm_arm_vgic_v2_ops = {
+struct kvm_device_ops kvm_arm_vgic_v2_ops = {
 	.name = "kvm-arm-vgic",
 	.create = vgic_create,
 	.destroy = vgic_destroy,
@@ -2590,8 +2590,7 @@ int kvm_vgic_hyp_init(void)
 
 	on_each_cpu(vgic_init_maintenance_interrupt, NULL, 1);
 
-	return kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
-				       KVM_DEV_TYPE_ARM_VGIC_V2);
+	return 0;
 
 out_free_irq:
 	free_percpu_irq(vgic->maint_irq, kvm_get_running_vcpus());
-- 
1.7.9.5
