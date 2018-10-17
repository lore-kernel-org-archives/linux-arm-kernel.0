From: steve.capper@arm.com (Steve Capper)
Date: Wed, 17 Oct 2018 17:34:55 +0100
Subject: [PATCH V2 0/4] 52-bit userspace VAs
Message-ID: <20181017163459.20175-1-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series brings support for 52-bit userspace VAs to systems that
have ARMv8.2-LVA and are running with a 48-bit VA_BITS and a 64KB
PAGE_SIZE.

If no hardware support is present, the kernel runs with a 48-bit VA space
for userspace.

Userspace can exploit this feature by providing an address hint to mmap
where addr[51:48] != 0. Otherwise all the VA mappings will behave in the
same way as a 48-bit VA system (this is to maintain compatibility with
software that assumes the maximum VA size on arm64 is 48-bit).

This patch series applies to 4.19-rc7.

Testing was in a model with Trusted Firmware and UEFI for boot.

The major change to V2 of the series is that mm/mmap.c is altered in the
first patch of the series (rather than copied over to arch/arm64).


Steve Capper (4):
  mm: mmap: Allow for "high" userspace addresses
  arm64: mm: Introduce DEFAULT_MAP_WINDOW
  arm64: mm: Define arch_get_mmap_end, arch_get_mmap_base
  arm64: mm: introduce 52-bit userspace support

 arch/arm64/Kconfig                      |  4 ++++
 arch/arm64/include/asm/assembler.h      |  7 +++----
 arch/arm64/include/asm/elf.h            |  2 +-
 arch/arm64/include/asm/mmu_context.h    |  3 +++
 arch/arm64/include/asm/pgalloc.h        |  4 ++++
 arch/arm64/include/asm/pgtable.h        | 16 +++++++++++++---
 arch/arm64/include/asm/processor.h      | 29 ++++++++++++++++++++++-------
 arch/arm64/kernel/head.S                | 13 +++++++++++++
 arch/arm64/mm/fault.c                   |  2 +-
 arch/arm64/mm/mmu.c                     |  1 +
 arch/arm64/mm/proc.S                    | 10 +++++++++-
 drivers/firmware/efi/arm-runtime.c      |  2 +-
 drivers/firmware/efi/libstub/arm-stub.c |  2 +-
 mm/mmap.c                               | 25 ++++++++++++++++++-------
 14 files changed, 94 insertions(+), 26 deletions(-)

-- 
2.11.0
