From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Jul 2018 19:01:23 +0100
Subject: [PATCH 2/2] KVM: arm/arm64: vgic: fix possible spectre-v1 write in
 vgic_mmio_write_apr()
In-Reply-To: <20180710180123.56461-1-mark.rutland@arm.com>
References: <20180710180123.56461-1-mark.rutland@arm.com>
Message-ID: <20180710180123.56461-3-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's possible for userspace to control n. Sanitize n when using it as an
array index, to inhibit the potential spectre-v1 write gadget.

Note that while it appears that n must be bound to the interval [0,3]
due to the way it is extracted from addr, we cannot guarantee that
compiler transformations (and/or future refactoring) will ensure this is
the case, and given this is a slow path it's better to always perform
the masking.

Found by smatch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
---
 virt/kvm/arm/vgic/vgic-mmio-v2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
index ffc587bf4742..64e571cc02df 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
@@ -352,6 +352,9 @@ static void vgic_mmio_write_apr(struct kvm_vcpu *vcpu,
 
 		if (n > vgic_v3_max_apr_idx(vcpu))
 			return;
+
+		n = array_index_nospec(n, 4);
+
 		/* GICv3 only uses ICH_AP1Rn for memory mapped (GICv2) guests */
 		vgicv3->vgic_ap1r[n] = val;
 	}
-- 
2.11.0
