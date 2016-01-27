From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Jan 2016 18:45:12 +0000
Subject: [GIT PULL] arm64: fixes for -rc2
Message-ID: <20160127184511.GE25545@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull these arm64 fixes for -rc2. Details in the tag, but the main
thing here is to get us booting under qemu again after it turned out
that not all of the PMU registers are emulated there, causing us to
die early in boot.

Cheers,

Will

--->8

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 57adec866c0440976c96a4b8f5b59fb411b1cacb:

  arm64: mm: avoid calling apply_to_page_range on empty range (2016-01-26 15:56:44 +0000)

----------------------------------------------------------------
arm64 fixes:

- Ensure we don't access PMU registers of the PMU is not implemented
  (fixes booting under QEMU)

- Fix BUG_ON triggered during module loading with DEBUG_SET_MODULE_RONX

- Ensure the kasan zero page is read-only

- Hide __efistub_ symbol aliases from kallsyms, since they otherwise
  confuse the backtrace code

- Ensure !PTE_WRITE kernel ptes are marked as read-only

- defconfig updates based on requests and patches on the list

- Other minor fixes (typos, build system)

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64: hide __efistub_ aliases from kallsyms
      arm64: kasan: ensure that the KASAN zero page is mapped read-only

Catalin Marinas (1):
      arm64: Honour !PTE_WRITE in set_pte_at() for kernel mappings

Lorenzo Pieralisi (1):
      arm64: kernel: fix architected PMU registers unconditional access

Masanari Iida (1):
      arm64: Fix an enum typo in mm/dump.c

Mika Penttil? (1):
      arm64: mm: avoid calling apply_to_page_range on empty range

Will Deacon (1):
      arm64: defconfig: updates for 4.5

William Cohen (1):
      Eliminate the .eh_frame sections from the aarch64 vmlinux and kernel modules

dann frazier (1):
      arm64: errata: Add -mpc-relative-literal-loads to build flags

 arch/arm64/Makefile              |  2 ++
 arch/arm64/configs/defconfig     | 42 ++++++++++++++++++++++++----------------
 arch/arm64/include/asm/pgtable.h | 21 ++++++++++----------
 arch/arm64/kernel/head.S         |  5 +++++
 arch/arm64/kernel/image.h        | 40 ++++++++++++++++++++++++--------------
 arch/arm64/mm/dump.c             |  2 +-
 arch/arm64/mm/kasan_init.c       |  9 +++++++++
 arch/arm64/mm/pageattr.c         |  3 +++
 arch/arm64/mm/proc-macros.S      | 12 ++++++++++++
 arch/arm64/mm/proc.S             |  4 ++--
 10 files changed, 94 insertions(+), 46 deletions(-)
