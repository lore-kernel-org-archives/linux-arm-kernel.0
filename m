From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  9 Jun 2017 12:49:41 +0100
Subject: [PATCH v3 12/27] KVM: arm64: Enable GICv3 Group-1 sysreg trapping via
 command-line
In-Reply-To: <20170609114956.25963-1-marc.zyngier@arm.com>
References: <20170609114956.25963-1-marc.zyngier@arm.com>
Message-ID: <20170609114956.25963-13-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we're able to safely handle Group-1 sysreg access, let's
give the user the opportunity to enable it by passing a specific
command-line option (vgic_v3.group1_trap).

Tested-by: Alexander Graf <agraf@suse.de>
Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 virt/kvm/arm/vgic/vgic-v3.c                     | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 15f79c27748d..42fe395be6c8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1829,6 +1829,10 @@
 			for all guests.
 			Default is 1 (enabled) if in 64-bit or 32-bit PAE mode.
 
+	kvm-arm.vgic_v3_group1_trap=
+			[KVM,ARM] Trap guest accesses to GICv3 group-1
+			system registers
+
 	kvm-intel.ept=	[KVM,Intel] Disable extended page tables
 			(virtualized MMU) support on capable Intel chips.
 			Default is 1 (enabled)
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index fbd678bc046d..df55818f095c 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -416,6 +416,12 @@ int vgic_v3_map_resources(struct kvm *kvm)
 
 DEFINE_STATIC_KEY_FALSE(vgic_v3_cpuif_trap);
 
+static int __init early_group1_trap_cfg(char *buf)
+{
+	return strtobool(buf, &group1_trap);
+}
+early_param("kvm-arm.vgic_v3_group1_trap", early_group1_trap_cfg);
+
 /**
  * vgic_v3_probe - probe for a GICv3 compatible interrupt controller in DT
  * @node:	pointer to the DT node
@@ -467,6 +473,11 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
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
