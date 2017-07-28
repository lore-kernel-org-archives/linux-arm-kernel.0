From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Jul 2017 17:16:08 +0100
Subject: [GIT PULL] arm64 fixes for 4.13-rc3
Message-ID: <20170728161607.GA6571@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull these arm64 fixes for 4.13. I'd been collecting these whilst
we debugged a CPU hotplug failure, but we ended up diagnosing that one
to tglx, who has taken a fix via -tip separately.

We're seeing some NFS issues that we haven't gotten to the bottom of yet,
and we've uncovered some issues with our backtracing too so there might
be another fixes pull before we're done.

Cheers,

Will

--->8

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 92bbd16e500c85bc210ba48caecbfbdb721bb5b4:

  arm64: mmu: Place guard page after mapping of kernel image (2017-07-28 10:32:14 +0100)

----------------------------------------------------------------
arm64 fixes:

- Ensure we have a guard page after the kernel image in vmalloc

- Fix incorrect prefetch stride in copy_page

- Ensure irqs are disabled in die()

- Fix for event group validation in QCOM L2 PMU driver

- Fix requesting of PMU IRQs on AMD Seattle

- Minor cleanups and fixes

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64/lib: copy_page: use consistent prefetch stride

Dave Martin (1):
      arm64: sysreg: Fix unprotected macro argmuent in write_sysreg

Neil Leeder (1):
      perf: qcom_l2: fix column exclusion check

Punit Agrawal (1):
      arm64/numa: Drop duplicate message

Qiao Zhou (1):
      arm64: traps: disable irq in die()

Rob Herring (2):
      arm64: Convert to using %pOF instead of full_name
      perf: Convert to using %pOF instead of full_name

Will Deacon (4):
      arm64: uaccess: Remove redundant __force from addr cast in __range_ok
      arm64: atomics: Remove '&' from '+&' asm constraint in lse atomics
      drivers/perf: arm_pmu: Request PMU SPIs with IRQF_PER_CPU
      arm64: mmu: Place guard page after mapping of kernel image

 arch/arm/mach-ux500/cpu-db8500.c    |  1 +
 arch/arm64/include/asm/atomic_lse.h |  2 +-
 arch/arm64/include/asm/sysreg.h     |  4 ++--
 arch/arm64/include/asm/uaccess.h    |  2 +-
 arch/arm64/kernel/cpu_ops.c         |  4 ++--
 arch/arm64/kernel/smp.c             | 12 +++++------
 arch/arm64/kernel/topology.c        | 22 ++++++++++----------
 arch/arm64/kernel/traps.c           |  8 ++++++--
 arch/arm64/lib/copy_page.S          |  9 ++++----
 arch/arm64/mm/mmu.c                 | 18 +++++++++-------
 arch/arm64/mm/numa.c                |  7 +------
 drivers/perf/arm_pmu.c              | 41 ++++++++++++++++++++++++-------------
 drivers/perf/arm_pmu_platform.c     |  9 ++++----
 drivers/perf/qcom_l2_pmu.c          |  2 ++
 include/linux/perf/arm_pmu.h        |  4 ++++
 15 files changed, 84 insertions(+), 61 deletions(-)
