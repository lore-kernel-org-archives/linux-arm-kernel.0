From: gang.chen.5i5j@gmail.com (Chen Gang)
Date: Thu, 13 Nov 2014 23:04:05 +0800
Subject: [PATCH] virt: kvm: arm: vgic: Process the failure case when
 kvm_register_device_ops() fails
Message-ID: <5464C865.90504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When kvm_register_device_ops() fails, also need call free_percpu_irq()
just like others have down within kvm_vgic_hyp_init().

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 virt/kvm/arm/vgic.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 3aaca49..b799f17 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2470,8 +2470,14 @@ int kvm_vgic_hyp_init(void)
 
 	on_each_cpu(vgic_init_maintenance_interrupt, NULL, 1);
 
-	return kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
-				       KVM_DEV_TYPE_ARM_VGIC_V2);
+	ret = kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
+				      KVM_DEV_TYPE_ARM_VGIC_V2);
+	if (ret) {
+		kvm_err("Cannot register device ops\n");
+		goto out_free_irq;
+	}
+
+	return 0;
 
 out_free_irq:
 	free_percpu_irq(vgic->maint_irq, kvm_get_running_vcpus());
-- 
1.9.3
