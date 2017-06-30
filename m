From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:45:07 +0100
Subject: [PATCH 51/58] KVM: arm64: vgic-v3: Log which GICv3 system registers
 are trapped
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-52-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to facilitate debug, let's log which class of GICv3 system
registers are trapped.

Tested-by: Alexander Graf <agraf@suse.de>
Acked-by: David Daney <david.daney@cavium.com>
Acked-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-v3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 91cf8b4f01f1..96ea597db0e7 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -518,7 +518,10 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
 #endif
 
 	if (group0_trap || group1_trap || common_trap) {
-		kvm_info("GICv3 sysreg trapping enabled (reduced performance)\n");
+		kvm_info("GICv3 sysreg trapping enabled ([%s%s%s], reduced performance)\n",
+			 group0_trap ? "G0" : "",
+			 group1_trap ? "G1" : "",
+			 common_trap ? "C"  : "");
 		static_branch_enable(&vgic_v3_cpuif_trap);
 	}
 
-- 
2.11.0
