From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  3 May 2017 11:45:58 +0100
Subject: [PATCH 23/31] KVM: arm64: Enable GICv3 Group-0 sysreg trapping via
 command-line
In-Reply-To: <20170503104606.19342-1-marc.zyngier@arm.com>
References: <20170503104606.19342-1-marc.zyngier@arm.com>
Message-ID: <20170503104606.19342-24-marc.zyngier@arm.com>
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
index 812f179a6931..7c82c586d44a 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -327,6 +327,12 @@ int vgic_v3_map_resources(struct kvm *kvm)
 
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
