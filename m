From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  3 May 2017 11:46:05 +0100
Subject: [PATCH 30/31] KVM: arm64: Enable GICv3 common sysreg trapping via
 command-line
In-Reply-To: <20170503104606.19342-1-marc.zyngier@arm.com>
References: <20170503104606.19342-1-marc.zyngier@arm.com>
Message-ID: <20170503104606.19342-31-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we're able to safely handle common sysreg access, let's
give the user the opportunity to enable it by passing a specific
command-line option (vgic_v3.common_trap).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqchip/arm-gic-v3.h |  1 +
 virt/kvm/arm/vgic/vgic-v3.c        | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 7fef09bcf7b1..2692217ac667 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -403,6 +403,7 @@
 
 #define ICH_HCR_EN			(1 << 0)
 #define ICH_HCR_UIE			(1 << 1)
+#define ICH_HCR_TC			(1 << 10)
 #define ICH_HCR_TALL0			(1 << 11)
 #define ICH_HCR_TALL1			(1 << 12)
 #define ICH_HCR_EOIcount_SHIFT		27
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 445e86c8b00c..717219ab58a2 100644
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
 
 /* check for overlapping regions and for regions crossing the end of memory */
@@ -339,6 +342,12 @@ static int __init early_group1_trap_cfg(char *buf)
 }
 early_param("vgic_v3.group1_trap", early_group1_trap_cfg);
 
+static int __init early_common_trap_cfg(char *buf)
+{
+	return strtobool(buf, &common_trap);
+}
+early_param("vgic_v3.common_trap", early_common_trap_cfg);
+
 /**
  * vgic_v3_probe - probe for a GICv3 compatible interrupt controller in DT
  * @node:	pointer to the DT node
@@ -397,7 +406,7 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
 	}
 #endif
 
-	if (group0_trap || group1_trap) {
+	if (group0_trap || group1_trap || common_trap) {
 		kvm_info("GICv3 sysreg trapping enabled (reduced performance)\n");
 		static_branch_enable(&vgic_v3_cpuif_trap);
 	}
-- 
2.11.0
