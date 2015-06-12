From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Jun 2015 12:06:35 +0100
Subject: [PATCH 0/2] arm64: KVM: Use instruction patching for GIC world switch
Message-ID: <1434107197-4919-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current way we deal with the GIC world switch on arm64 is a bit
convoluted. As we have two possible backends, we rely on a couple of
indirections set at boot time. These indirection never change, so it
would make more sense to directly patch in a branch to the right
function.

To do this, we introduce a new CPU feature that detect the presence of
a GICv3 CPU interface. When detected, we patch branches to the GICv3
save/restore functions that otherwise point to the GICv2 backend.

Tested on both GICv2 (Juno, Seattle) and GICv3 (FVP Base model).

These patches have been on the various lists for quite a while as part
of a series dealing with instruction patching. Now that the
prerequisite are queued for 4.2, it would make sense for these to be
merged alongside.

Catalin, would you mind taking them through the arm64 tree?

Marc Zyngier (2):
  arm64: alternative: Introduce feature for GICv3 CPU interface
  arm64: KVM: Switch vgic save/restore to alternative_insn

 arch/arm/include/asm/kvm_host.h     |  5 -----
 arch/arm64/include/asm/cpufeature.h |  8 +++++++-
 arch/arm64/include/asm/kvm_asm.h    |  5 -----
 arch/arm64/include/asm/kvm_host.h   | 23 -----------------------
 arch/arm64/kernel/asm-offsets.c     |  1 -
 arch/arm64/kernel/cpufeature.c      | 16 ++++++++++++++++
 arch/arm64/kvm/hyp.S                | 18 ++++--------------
 virt/kvm/arm/vgic.c                 |  3 ---
 8 files changed, 27 insertions(+), 52 deletions(-)

-- 
2.1.4
