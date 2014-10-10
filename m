From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 10 Oct 2014 12:14:27 +0200
Subject: [PATCH v3 0/3] arm/arm64: KVM: Host 48-bit VA support and IPA limits
Message-ID: <1412936070-18860-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following two patches fixup some missing memory handling in
KVM/arm64.

The first patch supports 48 bit virtual address space which involves
supporting a different number of levels of page tables in the host
kernel and the stage-2 page tables.

The second patch ensures userspace cannot create memory slots with too
large IPA space given VTCR_EL2.T0SZ = 24.

Finally, we enable 48-bit VA support in Linux.

The following host configurations have been tested with KVM on APM
Mustang:

 1)  4KB  + 39 bits VA space
 2)  4KB  + 48 bits VA space
 3) 64KB  + 39 bits VA space
 4) 64KB  + 48 bits VA space

Tested on TC2 for regressions.

Christoffer Dall (3):
  arm64: KVM: Implement 48 VA support for KVM EL2 and Stage-2
  arm/arm64: KVM: Ensure memslots are within KVM_PHYS_SIZE
  arm64: Allow 48-bits VA space without ARM_SMMU

 arch/arm/include/asm/kvm_mmu.h   |  29 +++++++-
 arch/arm/kvm/arm.c               |   2 +-
 arch/arm/kvm/mmu.c               | 142 +++++++++++++++++++++++++++++++--------
 arch/arm64/Kconfig               |   2 +-
 arch/arm64/include/asm/kvm_mmu.h | 125 +++++++++++++++++++++++++++++++---
 5 files changed, 258 insertions(+), 42 deletions(-)

-- 
2.1.2.330.g565301e.dirty
