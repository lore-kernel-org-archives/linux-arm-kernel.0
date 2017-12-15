From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Dec 2017 18:31:20 +0000
Subject: [GIT PULL] arm64: fixes for -rc4
Message-ID: <20171215183120.GD23959@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the following arm64 fixes for 4.15-rc4.

I've included the usual summary in the tag, but there are some significant
fixes in here for FP state corruption, hardware access/dirty PTE corruption
and an erratum workaround for the Falkor CPU. I'm hoping that things
finally settle down now, but never say never...

Cheers,

Will

--->8

The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to a4544831370618cb3627e27ffcc27d1cc857868f:

  arm64: fpsimd: Fix copying of FP state from signal frame into task struct (2017-12-15 16:12:35 +0000)

----------------------------------------------------------------
arm64 fixes:

- Fix FPSIMD context switch regression introduced in -rc2

- Fix ABI break with SVE CPUID register reporting

- Fix use of uninitialised variable

- Fixes to hardware access/dirty management and sanity checking

- CPU erratum workaround for Falkor CPUs

- Fix reporting of writeable+executable mappings

- Fix signal reporting for RAS errors

----------------------------------------------------------------
Dave Martin (1):
      arm64/sve: Report SVE to userspace via CPUID only if supported

Dongjiu Geng (1):
      arm64: fault: avoid send SIGBUS two times

Mark Rutland (1):
      arm64: fix CONFIG_DEBUG_WX address reporting

Shanker Donthineni (2):
      arm64: Define cputype macros for Falkor CPU
      arm64: Add software workaround for Falkor erratum 1041

Steve Capper (2):
      arm64: Initialise high_memory global variable earlier
      arm64: mm: Fix pte_mkclean, pte_mkdirty semantics

Will Deacon (3):
      arm64: mm: Fix false positives in set_pte_at access/dirty race detection
      arm64: hw_breakpoint: Use linux/uaccess.h instead of asm/uaccess.h
      arm64: fpsimd: Fix copying of FP state from signal frame into task struct

 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 12 +++++++++-
 arch/arm64/include/asm/assembler.h     | 10 +++++++++
 arch/arm64/include/asm/cpufeature.h    |  3 +++
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/include/asm/pgtable.h       | 41 ++++++++++++++++++----------------
 arch/arm64/kernel/cpu-reset.S          |  1 +
 arch/arm64/kernel/cpufeature.c         |  3 ++-
 arch/arm64/kernel/efi-entry.S          |  2 ++
 arch/arm64/kernel/fpsimd.c             |  2 +-
 arch/arm64/kernel/head.S               |  1 +
 arch/arm64/kernel/hw_breakpoint.c      |  2 +-
 arch/arm64/kernel/relocate_kernel.S    |  1 +
 arch/arm64/kvm/hyp-init.S              |  1 +
 arch/arm64/mm/dump.c                   |  2 +-
 arch/arm64/mm/fault.c                  |  5 ++---
 arch/arm64/mm/init.c                   |  3 ++-
 17 files changed, 64 insertions(+), 28 deletions(-)
