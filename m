From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  1 Jun 2017 11:21:09 +0100
Subject: [PATCH v2 17/25] KVM: arm64: Enable GICv3 Group-0 sysreg trapping via
 command-line
In-Reply-To: <20170601102117.17750-1-marc.zyngier@arm.com>
References: <20170601102117.17750-1-marc.zyngier@arm.com>
Message-ID: <20170601102117.17750-18-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we're able to safely handle Group-0 sysreg access, let's
give the user the opportunity to enable it by passing a specific
command-line option (vgic_v3.group0_trap).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-v3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 7525216ef988..1486ce25edcb 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -419,6 +419,12 @@ int vgic_v3_map_resources(struct kvm *kvm)
 
 DEFINE_STATIC_KEY_FALSE(vgic_v3_cpuif_trap);
 
+static int __init early_group0_trap_cfg(char *buf)
+{
+	return strtobool(buf, &group0_trap);
+}
+early_param("vgic_v3.group0_trap", early_group0_trap_cfg);
+
 static int __init early_group1_trap_cfg(char *buf)
 {
 	return strtobool(buf, &group1_trap);
-- 
2.11.0
