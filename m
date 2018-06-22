From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jun 2018 13:49:46 +0100
Subject: [PATCH 1/8] KVM: arm/arm64: Drop resource size check for GICV window
In-Reply-To: <20180622124953.12355-1-marc.zyngier@arm.com>
References: <20180622124953.12355-1-marc.zyngier@arm.com>
Message-ID: <20180622124953.12355-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

When booting a 64 KB pages kernel on a ACPI GICv3 system that
implements support for v2 emulation, the following warning is
produced

  GICV size 0x2000 not a multiple of page size 0x10000

and support for v2 emulation is disabled, preventing GICv2 VMs
from being able to run on such hosts.

The reason is that vgic_v3_probe() performs a sanity check on the
size of the window (it should be a multiple of the page size),
while the ACPI MADT parsing code hardcodes the size of the window
to 8 KB. This makes sense, considering that ACPI does not bother
to describe the size in the first place, under the assumption that
platforms implementing ACPI will follow the architecture and not
put anything else in the same 64 KB window.

So let's just drop the sanity check altogether, and assume that
the window is at least 64 KB in size.

Fixes: 909777324588 ("KVM: arm/arm64: vgic-new: vgic_init: implement kvm_vgic_hyp_init")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-v3.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index ff7dc890941a..cdce653e3c47 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -617,11 +617,6 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
 		pr_warn("GICV physical address 0x%llx not page aligned\n",
 			(unsigned long long)info->vcpu.start);
 		kvm_vgic_global_state.vcpu_base = 0;
-	} else if (!PAGE_ALIGNED(resource_size(&info->vcpu))) {
-		pr_warn("GICV size 0x%llx not a multiple of page size 0x%lx\n",
-			(unsigned long long)resource_size(&info->vcpu),
-			PAGE_SIZE);
-		kvm_vgic_global_state.vcpu_base = 0;
 	} else {
 		kvm_vgic_global_state.vcpu_base = info->vcpu.start;
 		kvm_vgic_global_state.can_emulate_gicv2 = true;
-- 
2.17.1
