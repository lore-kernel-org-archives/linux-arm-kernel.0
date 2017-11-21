From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Tue, 21 Nov 2017 11:57:56 +0000
Subject: [RFC 0/9] arm64: 52-bit physical address support
Message-ID: <1511265485-27163-1-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds 52-bit physical address space support to arm64, up from
the current 48 bits. This is an ARMv8.2 feature (ARMv8.2-LPA).

The series is based on 4.14. It has been lightly tested on an ARM Fast
Model. There's still some cases and areas to think through, as well as
more testing to do, which is why this is an RFC for now.

Patches for SMMU 52-bit PA support will be sent separately. A GIC ITS
patch has already been merged [1]. ARMv8.2 also adds 52-bit IPA and VA
features, neither of those are part of this series.

The series depends on the patch "arm64: KVM: fix VTTBR_BADDR_MASK BUG_ON
off-by-one", which has been sent separately.

Thanks,
Kristina

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=30ae9610d275f8f03f5bf7612ce71d8af6fc400b

Kristina Martsenko (9):
  arm64: add kconfig symbol to enable 52-bit PA
  arm64: limit PA size to supported range
  arm64: handle 52-bit addresses in TTBR
  arm64: head.S: handle 52-bit PAs in PTEs in early page table setup
  arm64: don't open code page table entry creation
  arm64: handle 52-bit physical addresses in page table entries
  arm64: increase PHYS_MASK to 52 bits
  arm64: increase sparsemem MAX_PHYSMEM_BITS to 52
  arm64: allow ID map to be extended to 52 bits

 arch/arm/include/asm/kvm_mmu.h         |   7 ++
 arch/arm64/Kconfig                     |  29 ++++++++
 arch/arm64/include/asm/assembler.h     |  32 ++++++++-
 arch/arm64/include/asm/kvm_mmu.h       |  21 +++++-
 arch/arm64/include/asm/mmu_context.h   |  16 ++++-
 arch/arm64/include/asm/pgalloc.h       |   6 +-
 arch/arm64/include/asm/pgtable-hwdef.h |   5 +-
 arch/arm64/include/asm/pgtable.h       |  63 ++++++++++++++---
 arch/arm64/include/asm/sparsemem.h     |   2 +-
 arch/arm64/include/asm/sysreg.h        |   8 +++
 arch/arm64/kernel/head.S               | 119 +++++++++++++++++++++------------
 arch/arm64/kernel/hibernate-asm.S      |  12 ++--
 arch/arm64/kernel/hibernate.c          |   5 +-
 arch/arm64/kvm/hyp-init.S              |  26 ++++---
 arch/arm64/kvm/hyp/s2-setup.c          |   2 +
 arch/arm64/mm/mmu.c                    |  15 +++--
 arch/arm64/mm/pgd.c                    |   8 +++
 arch/arm64/mm/proc.S                   |  19 +++---
 virt/kvm/arm/arm.c                     |   2 +-
 virt/kvm/arm/mmu.c                     |  12 ++--
 20 files changed, 300 insertions(+), 109 deletions(-)

-- 
2.1.4
