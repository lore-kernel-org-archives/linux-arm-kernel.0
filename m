From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  9 Jun 2017 12:49:54 +0100
Subject: [PATCH v3 25/27] KVM: arm64: vgic-v3: Log which GICv3 system
 registers are trapped
In-Reply-To: <20170609114956.25963-1-marc.zyngier@arm.com>
References: <20170609114956.25963-1-marc.zyngier@arm.com>
Message-ID: <20170609114956.25963-26-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to facilitate debug, let's log which class of GICv3 system
registers are trapped.

Tested-by: Alexander Graf <agraf@suse.de>
Acked-by: David Daney <david.daney@cavium.com>
Acked-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-v3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 3960e89c05ad..f934a5bb144f 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -499,7 +499,10 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
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
