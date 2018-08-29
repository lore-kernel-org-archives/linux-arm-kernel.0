From: steve.capper@arm.com (Steve Capper)
Date: Wed, 29 Aug 2018 13:45:38 +0100
Subject: [PATCH 0/5] 52-bit userspace VAs
Message-ID: <20180829124543.25314-1-steve.capper@arm.com>
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

This patch series applies to 4.19-rc1.

Testing was in a model with Trusted Firmware and UEFI for boot.

Steve Capper (5):
  arm64: mm: Introduce DEFAULT_MAP_WINDOW
  arm64: mm: introduce 52-bit userspace support
  arm64: mm: Copy over arch_get_unmapped_area
  arm64: mmap: Allow for "high" 52-bit VA allocations
  arm64: mm: Activate 52-bit userspace VA support

 arch/arm64/Kconfig                      |  4 ++
 arch/arm64/include/asm/assembler.h      |  7 +--
 arch/arm64/include/asm/cpucaps.h        |  3 +-
 arch/arm64/include/asm/elf.h            |  2 +-
 arch/arm64/include/asm/mmu_context.h    |  3 +
 arch/arm64/include/asm/pgalloc.h        |  4 ++
 arch/arm64/include/asm/pgtable.h        | 23 +++++++-
 arch/arm64/include/asm/processor.h      | 19 ++++---
 arch/arm64/kernel/cpufeature.c          | 16 ++++++
 arch/arm64/kernel/entry.S               |  6 +-
 arch/arm64/kernel/head.S                | 13 +++++
 arch/arm64/mm/fault.c                   |  2 +-
 arch/arm64/mm/mmap.c                    | 98 +++++++++++++++++++++++++++++++++
 arch/arm64/mm/mmu.c                     |  1 +
 arch/arm64/mm/proc.S                    | 10 +++-
 drivers/firmware/efi/arm-runtime.c      |  2 +-
 drivers/firmware/efi/libstub/arm-stub.c |  2 +-
 17 files changed, 194 insertions(+), 21 deletions(-)

-- 
2.11.0
