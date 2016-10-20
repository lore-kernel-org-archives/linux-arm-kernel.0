From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Oct 2016 18:14:01 +0100
Subject: [GIT PULL] arm64: fixes for -rc2
Message-ID: <20161020171401.GI24914@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull these arm64 fixes for -rc2. Most of these are CC'd for
stable, but there are a few fixing issues introduced during the recent
merge window too. There's also a fix for the xgene PMU driver, but it
seemed daft to send as a separate pull request, so I've included it
here with the rest of the fixes. More details in the tag.

Thanks,

Will

--->8

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to f7881bd644474a4a62d7bd1ec801176f635f59ae:

  arm64: remove pr_cont abuse from mem_init (2016-10-20 15:27:56 +0100)

----------------------------------------------------------------
arm64 fixes:

- Fix ACPI boot due to recent broken NUMA changes
- Fix remote enabling of CPU features requiring PSTATE bit manipulation
- Add address range check when emulating user cache maintenance
- Fix LL/SC loops that allow compiler to introduce memory accesses
- Fix recently added write_sysreg_s macro
- Ensure MDCR_EL2 is initialised on qemu targets without a PMU
- Avoid kaslr breakage due to MODVERSIONs and DYNAMIC_FTRACE
- Correctly drive recent ld when building relocatable Image
- Remove junk IS_ERR check from xgene PMU driver added during merge window
- pr_cont fixes after core changes in the merge window

----------------------------------------------------------------
Andre Przywara (1):
      arm64: Cortex-A53 errata workaround: check for kernel addresses

Ard Biesheuvel (3):
      arm64: kaslr: fix breakage with CONFIG_MODVERSIONS=y
      arm64: kaslr: keep modules close to the kernel when DYNAMIC_FTRACE=y
      arm64: kernel: force ET_DYN ELF type for CONFIG_RELOCATABLE=y

James Morse (3):
      arm64: cpufeature: Schedule enable() calls instead of calling them via IPI
      arm64: mm: Set PSTATE.PAN from the cpu_enable_pan() call
      arm64: suspend: Reconfigure PSTATE after resume from idle

Lorenzo Pieralisi (1):
      arm64: kernel: numa: fix ACPI boot cpu numa node mapping

Marc Zyngier (1):
      arm64: kernel: Init MDCR_EL2 even in the absence of a PMU

Mark Rutland (2):
      arm64: fix show_regs fallout from KERN_CONT changes
      arm64: remove pr_cont abuse from mem_init

Tai Nguyen (1):
      perf: xgene: Remove bogus IS_ERR() check

Will Deacon (3):
      arm64: sysreg: Fix use of XZR in write_sysreg_s
      arm64: swp emulation: bound LL/SC retries before rescheduling
      arm64: percpu: rewrite ll/sc loops in assembly

 arch/arm64/Kconfig                   |   2 +-
 arch/arm64/Makefile                  |   2 +-
 arch/arm64/include/asm/cpufeature.h  |   2 +-
 arch/arm64/include/asm/exec.h        |   3 +
 arch/arm64/include/asm/module.h      |   5 ++
 arch/arm64/include/asm/percpu.h      | 120 ++++++++++++++++-------------------
 arch/arm64/include/asm/processor.h   |   6 +-
 arch/arm64/include/asm/sysreg.h      |   2 +-
 arch/arm64/include/asm/uaccess.h     |   8 +++
 arch/arm64/kernel/armv8_deprecated.c |  36 +++++++----
 arch/arm64/kernel/cpu_errata.c       |   3 +-
 arch/arm64/kernel/cpufeature.c       |  10 ++-
 arch/arm64/kernel/head.S             |   3 +-
 arch/arm64/kernel/process.c          |  18 ++++--
 arch/arm64/kernel/smp.c              |   1 +
 arch/arm64/kernel/suspend.c          |  11 ++++
 arch/arm64/kernel/traps.c            |  30 +++++----
 arch/arm64/mm/fault.c                |  15 ++++-
 arch/arm64/mm/init.c                 |  26 ++++----
 drivers/perf/xgene_pmu.c             |   2 +-
 20 files changed, 184 insertions(+), 121 deletions(-)
