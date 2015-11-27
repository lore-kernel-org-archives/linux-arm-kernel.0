From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Nov 2015 17:55:59 +0000
Subject: [GIT PULL] arm64 fixes for 4.4-rc3
Message-ID: <20151127175556.GA32029@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 66362c9afc1d4a806280b9e3646d2d0a26cf83e9:

  arm64: efi: fix initcall return values (2015-11-26 18:15:54 +0000)

----------------------------------------------------------------
arm64 fixes:

- Build fix when !CONFIG_UID16 (the patch is touching generic files but
  it only affects arm64 builds; submitted by Arnd Bergmann)

- EFI fixes to deal with early_memremap() returning NULL and correctly
  mapping run-time regions

- Fix CPUID register extraction of unsigned fields (not to be
  sign-extended)

- ASID allocator fix to deal with long-running tasks over multiple
  generation roll-overs

- Revert support for marking page ranges as contiguous PTEs (it leads to
  TLB conflicts and requires additional non-trivial kernel changes)

- Proper early_alloc() failure check

- Disable KASan for 48-bit VA and 16KB page configuration (the pgd is
  larger than the KASan shadow memory)

- Update the fault_info table (original descriptions based on early
  engineering spec)

----------------------------------------------------------------
Andrey Ryabinin (1):
      arm64: KASAN depends on !(ARM64_16K_PAGES && ARM64_VA_BITS_48)

Ard Biesheuvel (2):
      arm64: efi: deal with NULL return value of early_memremap()
      arm64: efi: fix initcall return values

Arnd Bergmann (1):
      arm64: fix building without CONFIG_UID16

Catalin Marinas (1):
      Revert "arm64: Mark kernel page ranges contiguous"

Mark Rutland (2):
      arm64: mm: fix fault_info table xFSC decoding
      arm64: efi: correctly map runtime regions

Suzuki K. Poulose (4):
      arm64: early_alloc: Fix check for allocation failure
      arm64: cpufeature: Add helpers for extracting unsigned values
      arm64: cpufeature: Track unsigned fields
      arm64: debug: Treat the BRPs/WRPs as unsigned

Will Deacon (1):
      arm64: mm: keep reserved ASIDs in sync with mm after multiple rollovers

 arch/arm64/Kconfig                     |  2 +-
 arch/arm64/include/asm/cpufeature.h    | 22 +++++++++-
 arch/arm64/include/asm/hw_breakpoint.h |  6 ++-
 arch/arm64/kernel/cpufeature.c         | 37 +++++++++-------
 arch/arm64/kernel/efi.c                | 33 +++++++++------
 arch/arm64/mm/context.c                | 38 +++++++++++------
 arch/arm64/mm/fault.c                  | 28 ++++++-------
 arch/arm64/mm/mmu.c                    | 77 +++++++---------------------------
 include/linux/syscalls.h               |  2 +-
 include/linux/types.h                  |  2 +-
 10 files changed, 124 insertions(+), 123 deletions(-)

-- 
Catalin
