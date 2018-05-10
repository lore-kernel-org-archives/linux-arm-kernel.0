From: steve.capper@arm.com (Steve Capper)
Date: Thu, 10 May 2018 17:23:39 +0100
Subject: [PATCH V3 0/8] 52-bit kernel VAs for arm64
Message-ID: <20180510162347.3858-1-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series brings 52-bit kernel VA support to arm64; if supported
at boot time. A new kernel option CONFIG_ARM64_VA_BITS_52 is available
when configured with a 64KB PAGE_SIZE (as on ARMv8.2-LPA, 52-bit VAs are
only allowed when running with a 64KB granule).

Switching between 48 and 52-bit does not involve any changes to the number
of page table levels. The number of PGDIR entries increases when running
with a 52 bit kernel VA.

In order to allow the kernel to switch between VA spaces at boot time, we
need to re-arrange the current kernel VA space. In particular, the KASAN
end address needs to be valid for both 48-bit and 52-bit VA spaces, meaning
we need to flip the kernel VA space s.t. the KASAN end address is high and
the direct linear mapping is low.

This patch series applies to 4.17-rc4.

Changes to V3:
 * VA_BITS now kepts constant (to mean maximum VA space size),
 * VA_BITS_MIN refers to minimum size of VA space, whilst VA_BITS_ACTUAL
   refers to runtime size.
 * Code to ensure plts veneers can address full 52-bit space added (code
   from Ard, I've put it into a patch).

Changes to V2:
 * Kernel VA space only flipped, the order of modules, kImage etc are now
   retained,
 * 4.15-rc4 is used as a base as it includes a fix from V1 that has been
   merged already,
 * HASLR patch series is used as a base meaning HYP VA fixes are no
   longer required.


Ard Bieusheuval (1):
  arm64: module-plts: Extend veneer to address 52-bit VAs

Steve Capper (7):
  arm/arm64: KVM: Formalise end of direct linear map
  arm64: mm: Flip kernel VA space
  arm64: kasan: Switch to using KASAN_SHADOW_OFFSET
  arm64: mm: Replace fixed map BUILD_BUG_ON's with BUG_ON's
  arm64: dump: Make kernel page table dumper dynamic again
  arm64: mm: Make VA space size variable
  arm64: mm: Add 48/52-bit kernel VA support

 Documentation/arm64/kasan-offsets.sh   | 20 ++++++++++++
 arch/arm/include/asm/memory.h          |  1 +
 arch/arm64/Kconfig                     | 22 +++++++++++++
 arch/arm64/Makefile                    |  9 ------
 arch/arm64/include/asm/efi.h           |  4 +--
 arch/arm64/include/asm/kasan.h         | 11 +++----
 arch/arm64/include/asm/memory.h        | 30 ++++++++++++------
 arch/arm64/include/asm/mmu_context.h   |  2 +-
 arch/arm64/include/asm/module.h        | 13 +++++++-
 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 arch/arm64/include/asm/pgtable.h       |  4 +--
 arch/arm64/include/asm/processor.h     |  2 +-
 arch/arm64/kernel/head.S               |  6 ++--
 arch/arm64/kernel/kaslr.c              |  6 ++--
 arch/arm64/kernel/machine_kexec.c      |  2 +-
 arch/arm64/kernel/module-plts.c        | 12 +++++++
 arch/arm64/kvm/va_layout.c             | 14 ++++----
 arch/arm64/mm/dump.c                   | 58 +++++++++++++++++++++++++++-------
 arch/arm64/mm/fault.c                  |  4 +--
 arch/arm64/mm/init.c                   | 14 ++++----
 arch/arm64/mm/kasan_init.c             |  9 +++---
 arch/arm64/mm/mmu.c                    | 17 ++++++----
 arch/arm64/mm/proc.S                   | 41 ++++++++++++++++++++++++
 virt/kvm/arm/mmu.c                     |  4 +--
 24 files changed, 225 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/arm64/kasan-offsets.sh

-- 
2.11.0
