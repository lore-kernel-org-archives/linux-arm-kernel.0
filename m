From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 25 Sep 2014 21:42:52 +0200
Subject: [PATCH 0/2] arm/arm64: KVM: Host 48-bit VA support and IPA limits
Message-ID: <1411674174-30672-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following two patches fixup some missing memory handling in
KVM/arm64.

The first patch supports 48 bit virtual address space which involves
supporting a different number of levels of page tables in the host
kernel and the stage-2 page tables.  This patch removes "depends on
BROKEN" from CONFIG_ARM64_VA_BITS_48 which was introduced due to the KVM
breakage.

The second patch ensures userspace cannot create memory slots with too
large IPA space given VTCR_EL2.T0SZ = 24.

The following host configurations have been tested with KVM on APM
Mustang:

 1) 4KB  + 39 bits VA space
 2) 4KB  + 48 bits VA space

Due to the 64K/GICV issue, I couldn't test a 64K setup on Mutang.  If
anyone can test this on Seattle, it would be much appreciated.

Tested on TC2 for regressions.

Christoffer Dall (2):
  arm64: KVM: Implement 48 VA support for KVM EL2 and Stage-2
  arm/arm64: KVM: Ensure memslots are within KVM_PHYS_SIZE

 arch/arm/include/asm/kvm_mmu.h   |  23 +++++++
 arch/arm/kvm/arm.c               |   2 +-
 arch/arm/kvm/mmu.c               | 119 +++++++++++++++++++++++++++-------
 arch/arm64/Kconfig               |   1 -
 arch/arm64/include/asm/kvm_mmu.h | 136 ++++++++++++++++++++++++++++++++++++---
 5 files changed, 247 insertions(+), 34 deletions(-)

-- 
2.0.0
