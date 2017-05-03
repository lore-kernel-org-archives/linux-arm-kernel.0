From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  3 May 2017 11:45:53 +0100
Subject: [PATCH 18/31] KVM: arm64: Enable GICv3 Group-1 sysreg trapping via
 command-line
In-Reply-To: <20170503104606.19342-1-marc.zyngier@arm.com>
References: <20170503104606.19342-1-marc.zyngier@arm.com>
Message-ID: <20170503104606.19342-19-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we're able to safely handle Group-1 sysreg access, let's
give the user the opportunity to enable it by passing a specific
command-line option (vgic_v3.group1_trap).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-v3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 547b8374fb64..71ecf448ca49 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -324,6 +324,12 @@ int vgic_v3_map_resources(struct kvm *kvm)
 
 DEFINE_STATIC_KEY_FALSE(vgic_v3_cpuif_trap);
 
+static int __init early_group1_trap_cfg(char *buf)
+{
+	return strtobool(buf, &group1_trap);
+}
+early_param("vgic_v3.group1_trap", early_group1_trap_cfg);
+
 /**
  * vgic_v3_probe - probe for a GICv3 compatible interrupt controller in DT
  * @node:	pointer to the DT node
@@ -375,6 +381,11 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
 	if (kvm_vgic_global_state.vcpu_base == 0)
 		kvm_info("disabling GICv2 emulation\n");
 
+	if (group1_trap) {
+		kvm_info("GICv3 sysreg trapping enabled (reduced performance)\n");
+		static_branch_enable(&vgic_v3_cpuif_trap);
+	}
+
 	kvm_vgic_global_state.vctrl_base = NULL;
 	kvm_vgic_global_state.type = VGIC_V3;
 	kvm_vgic_global_state.max_gic_vcpus = VGIC_V3_MAX_CPUS;
-- 
2.11.0
