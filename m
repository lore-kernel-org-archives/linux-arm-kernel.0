From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  9 Jun 2017 12:49:53 +0100
Subject: [PATCH v3 24/27] KVM: arm64: Enable GICv3 common sysreg trapping via
 command-line
In-Reply-To: <20170609114956.25963-1-marc.zyngier@arm.com>
References: <20170609114956.25963-1-marc.zyngier@arm.com>
Message-ID: <20170609114956.25963-25-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we're able to safely handle common sysreg access, let's
give the user the opportunity to enable it by passing a specific
command-line option (vgic_v3.common_trap).

Tested-by: Alexander Graf <agraf@suse.de>
Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 include/linux/irqchip/arm-gic-v3.h              |  1 +
 virt/kvm/arm/vgic/vgic-v3.c                     | 11 ++++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 88bdc421351f..aa8341e73b35 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1837,6 +1837,10 @@
 			[KVM,ARM] Trap guest accesses to GICv3 group-1
 			system registers
 
+	kvm-arm.vgic_v3_common_trap=
+			[KVM,ARM] Trap guest accesses to GICv3 common
+			system registers
+
 	kvm-intel.ept=	[KVM,Intel] Disable extended page tables
 			(virtualized MMU) support on capable Intel chips.
 			Default is 1 (enabled)
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 46a1e0943cf8..f0cebb6e57d0 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -417,6 +417,7 @@
 
 #define ICH_HCR_EN			(1 << 0)
 #define ICH_HCR_UIE			(1 << 1)
+#define ICH_HCR_TC			(1 << 10)
 #define ICH_HCR_TALL0			(1 << 11)
 #define ICH_HCR_TALL1			(1 << 12)
 #define ICH_HCR_EOIcount_SHIFT		27
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index ffc581b70c4e..3960e89c05ad 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -23,6 +23,7 @@
 
 static bool group0_trap;
 static bool group1_trap;
+static bool common_trap;
 
 void vgic_v3_set_underflow(struct kvm_vcpu *vcpu)
 {
@@ -246,6 +247,8 @@ void vgic_v3_enable(struct kvm_vcpu *vcpu)
 		vgic_v3->vgic_hcr |= ICH_HCR_TALL0;
 	if (group1_trap)
 		vgic_v3->vgic_hcr |= ICH_HCR_TALL1;
+	if (common_trap)
+		vgic_v3->vgic_hcr |= ICH_HCR_TC;
 }
 
 int vgic_v3_lpi_sync_pending_status(struct kvm *kvm, struct vgic_irq *irq)
@@ -431,6 +434,12 @@ static int __init early_group1_trap_cfg(char *buf)
 }
 early_param("kvm-arm.vgic_v3_group1_trap", early_group1_trap_cfg);
 
+static int __init early_common_trap_cfg(char *buf)
+{
+	return strtobool(buf, &common_trap);
+}
+early_param("kvm-arm.vgic_v3_common_trap", early_common_trap_cfg);
+
 /**
  * vgic_v3_probe - probe for a GICv3 compatible interrupt controller in DT
  * @node:	pointer to the DT node
@@ -489,7 +498,7 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
 	}
 #endif
 
-	if (group0_trap || group1_trap) {
+	if (group0_trap || group1_trap || common_trap) {
 		kvm_info("GICv3 sysreg trapping enabled (reduced performance)\n");
 		static_branch_enable(&vgic_v3_cpuif_trap);
 	}
-- 
2.11.0
