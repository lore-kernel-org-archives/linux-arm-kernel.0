From: gang.chen.5i5j@gmail.com (Chen Gang)
Date: Tue, 02 Dec 2014 04:13:51 +0800
Subject: [PATCH v3] virt: kvm: arm: vgic: Process the failure case when
 kvm_register_device_ops() fails
Message-ID: <547CCBFF.5070605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kvm_register_device_ops() may fail, so need process the related failure
case.

Since it is related with neither vgic_arch_setup() nor on_each_cpu(),
can move it before them, then simplify the related failure processing
code.

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 virt/kvm/arm/vgic.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index cf23c13..814cae2 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2471,13 +2471,20 @@ int kvm_vgic_hyp_init(void)
 		goto out_free_irq;
 	}
 
+	ret = kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
+				      KVM_DEV_TYPE_ARM_VGIC_V2);
+	if (ret) {
+		__unregister_cpu_notifier(&vgic_cpu_nb);
+		kvm_err("Cannot register vgic device ops\n");
+		goto out_free_irq;
+	}
+
 	/* Callback into for arch code for setup */
 	vgic_arch_setup(vgic);
 
 	on_each_cpu(vgic_init_maintenance_interrupt, NULL, 1);
 
-	return kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
-				       KVM_DEV_TYPE_ARM_VGIC_V2);
+	return 0;
 
 out_free_irq:
 	free_percpu_irq(vgic->maint_irq, kvm_get_running_vcpus());
-- 
1.9.3
