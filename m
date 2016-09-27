From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:24 +0200
Subject: [PULL 16/50] arm64: KVM: vgic-v2: Enable GICV access from HYP if
 access from guest is unsafe
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-17-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

So far, we've been disabling KVM on systems where the GICV region couldn't
be safely given to a guest. Now that we're able to handle this access
safely by emulating it in HYP, we can enable this feature when we detect
an unsafe configuration.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-v2.c | 69 +++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
index b8da901..0a063af 100644
--- a/virt/kvm/arm/vgic/vgic-v2.c
+++ b/virt/kvm/arm/vgic/vgic-v2.c
@@ -278,12 +278,14 @@ int vgic_v2_map_resources(struct kvm *kvm)
 		goto out;
 	}
 
-	ret = kvm_phys_addr_ioremap(kvm, dist->vgic_cpu_base,
-				    kvm_vgic_global_state.vcpu_base,
-				    KVM_VGIC_V2_CPU_SIZE, true);
-	if (ret) {
-		kvm_err("Unable to remap VGIC CPU to VCPU\n");
-		goto out;
+	if (!static_branch_unlikely(&vgic_v2_cpuif_trap)) {
+		ret = kvm_phys_addr_ioremap(kvm, dist->vgic_cpu_base,
+					    kvm_vgic_global_state.vcpu_base,
+					    KVM_VGIC_V2_CPU_SIZE, true);
+		if (ret) {
+			kvm_err("Unable to remap VGIC CPU to VCPU\n");
+			goto out;
+		}
 	}
 
 	dist->ready = true;
@@ -312,45 +314,51 @@ int vgic_v2_probe(const struct gic_kvm_info *info)
 		return -ENXIO;
 	}
 
-	if (!PAGE_ALIGNED(info->vcpu.start)) {
-		kvm_err("GICV physical address 0x%llx not page aligned\n",
-			(unsigned long long)info->vcpu.start);
-		return -ENXIO;
-	}
+	if (!PAGE_ALIGNED(info->vcpu.start) ||
+	    !PAGE_ALIGNED(resource_size(&info->vcpu))) {
+		kvm_info("GICV region size/alignment is unsafe, using trapping (reduced performance)\n");
+		kvm_vgic_global_state.vcpu_base_va = ioremap(info->vcpu.start,
+							     resource_size(&info->vcpu));
+		if (!kvm_vgic_global_state.vcpu_base_va) {
+			kvm_err("Cannot ioremap GICV\n");
+			return -ENOMEM;
+		}
 
-	if (!PAGE_ALIGNED(resource_size(&info->vcpu))) {
-		kvm_err("GICV size 0x%llx not a multiple of page size 0x%lx\n",
-			(unsigned long long)resource_size(&info->vcpu),
-			PAGE_SIZE);
-		return -ENXIO;
+		ret = create_hyp_io_mappings(kvm_vgic_global_state.vcpu_base_va,
+					     kvm_vgic_global_state.vcpu_base_va + resource_size(&info->vcpu),
+					     info->vcpu.start);
+		if (ret) {
+			kvm_err("Cannot map GICV into hyp\n");
+			goto out;
+		}
+
+		static_branch_enable(&vgic_v2_cpuif_trap);
 	}
 
 	kvm_vgic_global_state.vctrl_base = ioremap(info->vctrl.start,
 						   resource_size(&info->vctrl));
 	if (!kvm_vgic_global_state.vctrl_base) {
 		kvm_err("Cannot ioremap GICH\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	vtr = readl_relaxed(kvm_vgic_global_state.vctrl_base + GICH_VTR);
 	kvm_vgic_global_state.nr_lr = (vtr & 0x3f) + 1;
 
-	ret = kvm_register_vgic_device(KVM_DEV_TYPE_ARM_VGIC_V2);
-	if (ret) {
-		kvm_err("Cannot register GICv2 KVM device\n");
-		iounmap(kvm_vgic_global_state.vctrl_base);
-		return ret;
-	}
-
 	ret = create_hyp_io_mappings(kvm_vgic_global_state.vctrl_base,
 				     kvm_vgic_global_state.vctrl_base +
 					 resource_size(&info->vctrl),
 				     info->vctrl.start);
 	if (ret) {
 		kvm_err("Cannot map VCTRL into hyp\n");
-		kvm_unregister_device_ops(KVM_DEV_TYPE_ARM_VGIC_V2);
-		iounmap(kvm_vgic_global_state.vctrl_base);
-		return ret;
+		goto out;
+	}
+
+	ret = kvm_register_vgic_device(KVM_DEV_TYPE_ARM_VGIC_V2);
+	if (ret) {
+		kvm_err("Cannot register GICv2 KVM device\n");
+		goto out;
 	}
 
 	kvm_vgic_global_state.can_emulate_gicv2 = true;
@@ -361,4 +369,11 @@ int vgic_v2_probe(const struct gic_kvm_info *info)
 	kvm_info("vgic-v2@%llx\n", info->vctrl.start);
 
 	return 0;
+out:
+	if (kvm_vgic_global_state.vctrl_base)
+		iounmap(kvm_vgic_global_state.vctrl_base);
+	if (kvm_vgic_global_state.vcpu_base_va)
+		iounmap(kvm_vgic_global_state.vcpu_base_va);
+
+	return ret;
 }
-- 
2.9.0
