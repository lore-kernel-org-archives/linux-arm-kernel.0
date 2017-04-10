From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 10 Apr 2017 10:19:42 +0100
Subject: [PATCH 0/2] GICv3 world-switch fixes for -next
Message-ID: <20170410091944.19963-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a couple of fixes for issues I've spotted when running our
current -next branch on a GICv3 system.

The first patch fixes our v2-on-v3 handling of VMCR_EL2, which cannot
be safely save/restored when ICC_SRE_EL1.SRE is set (in that case,
VMCR_EL2.VFIQen is RES1, and Group0 interrupts get delivered as
FIQ). This is effectively de-optimizing VMCR_EL2 save/restore for
v2-on-v3, which is a pretty rare use case.

The second patch fixes a typo that leads to a HYP panic when the CPU
accesses an unimplemented list register, or the corruption of some
memory if all 16 architectural list registers are used.

Both patches tested on -rc6 + kvmarm/next on a rk3399 platform.

Marc Zyngier (2):
  KVM: arm/arm64: vgic-v3: De-optimize VMCR save/restore when emulating
    a GICv2
  KVM: arm/arm64: vgic-v3: Fix off-by-one LR access

 virt/kvm/arm/hyp/vgic-v3-sr.c | 10 +++++++---
 virt/kvm/arm/vgic/vgic.c      | 26 ++++++++++++++++++++------
 2 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.11.0
