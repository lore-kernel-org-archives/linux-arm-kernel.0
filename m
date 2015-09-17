From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Sep 2015 15:04:24 +0100
Subject: [GIT PULL] arm64: fixes for -rc2
Message-ID: <20150917140424.GF25634@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the following arm64 fixes for 4.3-rc2. They address some
problems with filesystem writeback due to the recently merged hardware
DBM patches, which caused us to treat some read-only pages as dirty.

There are also some other, less significant fixes that are described in
the tag.

Cheers,

Will

--->8

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to df057cc7b4fa59e9b55f07ffdb6c62bf02e99a00:

  arm64: errata: add module build workaround for erratum #843419 (2015-09-17 11:57:03 +0100)

----------------------------------------------------------------
arm64 fixes for 4.3-rc2

A mixture of fixes for regressions introduced during the merge window,
some longer standing problems that we spotted and a couple of hardware
errata. The main changes are:

  - Fix fallout from the h/w DBM patches, causing filesystem writeback
    issues on both v8 and v8.1 CPUs
  - Workaround for Cortex-A53 erratum #843419 in the module loader
  - Fix for long-standing issue with compat big-endian signal handlers
    using the saved floating point state

----------------------------------------------------------------
Catalin Marinas (2):
      arm64: Fix the pte_hw_dirty() check when AF/DBM is enabled
      arm64: Fix pte_modify() to preserve the hardware dirty information

Jisheng Zhang (1):
      arm64: dma-mapping: check whether cma area is initialized or not

Leo Yan (1):
      arm64: enable generic idle loop

Will Deacon (5):
      arm64: pgtable: use a single bit for PTE_WRITE regardless of DBM
      arm64: head.S: initialise mdcr_el2 in el2_setup
      arm64: cpu hotplug: ensure we mask out CPU_TASKS_FROZEN in notifiers
      arm64: compat: fix vfp save/restore across signal handlers in big-endian
      arm64: errata: add module build workaround for erratum #843419

 arch/arm64/Kconfig                 | 17 ++++++++++++++
 arch/arm64/Makefile                |  4 ++++
 arch/arm64/include/asm/pgtable.h   | 12 ++++------
 arch/arm64/kernel/debug-monitors.c |  2 +-
 arch/arm64/kernel/head.S           |  5 ++++
 arch/arm64/kernel/hw_breakpoint.c  |  2 +-
 arch/arm64/kernel/module.c         |  2 ++
 arch/arm64/kernel/signal32.c       | 47 +++++++++++++++++++++++++++++---------
 arch/arm64/mm/dma-mapping.c        |  2 +-
 9 files changed, 71 insertions(+), 22 deletions(-)
