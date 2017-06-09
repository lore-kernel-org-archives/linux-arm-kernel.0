From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  9 Jun 2017 12:49:46 +0100
Subject: [PATCH v3 17/27] KVM: arm64: Enable GICv3 Group-0 sysreg trapping via
 command-line
In-Reply-To: <20170609114956.25963-1-marc.zyngier@arm.com>
References: <20170609114956.25963-1-marc.zyngier@arm.com>
Message-ID: <20170609114956.25963-18-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we're able to safely handle Group-0 sysreg access, let's
give the user the opportunity to enable it by passing a specific
command-line option (vgic_v3.group0_trap).

Tested-by: Alexander Graf <agraf@suse.de>
Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 virt/kvm/arm/vgic/vgic-v3.c                     | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42fe395be6c8..88bdc421351f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1829,6 +1829,10 @@
 			for all guests.
 			Default is 1 (enabled) if in 64-bit or 32-bit PAE mode.
 
+	kvm-arm.vgic_v3_group0_trap=
+			[KVM,ARM] Trap guest accesses to GICv3 group-0
+			system registers
+
 	kvm-arm.vgic_v3_group1_trap=
 			[KVM,ARM] Trap guest accesses to GICv3 group-1
 			system registers
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 06773b985b4e..e0e50ca547de 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -419,6 +419,12 @@ int vgic_v3_map_resources(struct kvm *kvm)
 
 DEFINE_STATIC_KEY_FALSE(vgic_v3_cpuif_trap);
 
+static int __init early_group0_trap_cfg(char *buf)
+{
+	return strtobool(buf, &group0_trap);
+}
+early_param("kvm-arm.vgic_v3_group0_trap", early_group0_trap_cfg);
+
 static int __init early_group1_trap_cfg(char *buf)
 {
 	return strtobool(buf, &group1_trap);
-- 
2.11.0
