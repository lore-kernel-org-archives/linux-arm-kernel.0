From: will.deacon@arm.com (Will Deacon)
Date: Fri, 3 Jun 2016 16:37:26 +0100
Subject: [GIT PULL] arm64: fixes for -rc2
Message-ID: <20160603153725.GM9915@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull these arm64 fixes for -rc2. Details in the tag, but the main
thing here is reviving hugetlb support using contiguous ptes, which we
ended up reverting at the last minute in 4.5 pending a fix which went
into the core mm/ code during the recent merge window.

Thanks,

Will

--->8

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to aed7eb8367939244ba19445292ffdfc398e0d66a:

  arm64: fix alignment when RANDOMIZE_TEXT_OFFSET is enabled (2016-06-03 10:57:18 +0100)

----------------------------------------------------------------
arm64 fixes:

- Revert a previous revert and get hugetlb going with contiguous hints
- Wire up missing compat syscalls
- Enable CONFIG_SET_MODULE_RONX by default
- Add missing line to our compat /proc/cpuinfo output
- Clarify levels in our page table dumps
- Fix booting with RANDOMIZE_TEXT_OFFSET enabled
- Misc fixes to the ARM CPU PMU driver (refcounting, probe failure)
- Remove some dead code and update a comment

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Provide "model name" in /proc/cpuinfo for PER_LINUX32 tasks

Julien Grall (3):
      drivers/perf: arm_pmu: Fix reference count of a device_node in of_pmu_irq_cfg
      drivers/perf: arm_pmu: Defer the setting of __oprofile_cpu_pmu
      drivers/perf: arm_pmu: Avoid leaking pmu->irq_affinity on error

Mark Rutland (6):
      arm64: enable CONFIG_SET_MODULE_RONX by default
      arm64: report CPU number in bad_mode
      arm64: update stale PAGE_OFFSET comment
      arm64: mm: dump: log span level
      arm64: move {PAGE,CONT}_SHIFT into Kconfig
      arm64: fix alignment when RANDOMIZE_TEXT_OFFSET is enabled

Robin Murphy (1):
      arm64: Remove orphaned __addr_ok() definition

Will Deacon (2):
      Revert "arm64: hugetlb: partial revert of 66b3923a1a0f"
      arm64: unistd32.h: wire up missing syscalls for compat tasks

 arch/arm64/Kconfig                | 12 ++++++++++++
 arch/arm64/Kconfig.debug          | 25 +++++++++++++------------
 arch/arm64/Makefile               |  4 +++-
 arch/arm64/include/asm/elf.h      |  4 ++--
 arch/arm64/include/asm/memory.h   |  3 ++-
 arch/arm64/include/asm/page.h     | 12 ++----------
 arch/arm64/include/asm/uaccess.h  | 13 -------------
 arch/arm64/include/asm/unistd.h   |  2 +-
 arch/arm64/include/asm/unistd32.h |  8 ++++++++
 arch/arm64/kernel/cpuinfo.c       |  8 +++++++-
 arch/arm64/kernel/traps.c         |  5 +++--
 arch/arm64/mm/dump.c              |  8 +++++++-
 arch/arm64/mm/hugetlbpage.c       | 14 ++++++++++++++
 drivers/perf/arm_pmu.c            | 12 +++++-------
 14 files changed, 79 insertions(+), 51 deletions(-)
