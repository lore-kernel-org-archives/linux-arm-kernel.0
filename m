From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jun 2016 18:07:58 +0100
Subject: [GIT PULL] arm64: fixes for -rc4
Message-ID: <20160617170758.GF1284@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull these fixes for arm64. The main things are getting kgdb up
and running with upstream GDB after a protocol change was reverted and
fixing our spin_unlock_wait/spin_is_locked implementations after doing
some similar work with PeterZ on the qspinlock code last week. Whilst we
haven't seen any failures in practice, it's still worth getting this
fixed.

Thanks,

Will

--->8

The following changes since commit 5edb56491d4812c42175980759da53388e5d86f5:

  Linux 4.7-rc3 (2016-06-12 07:20:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 0d15ef677839dab8313fbb86c007c3175b638d03:

  arm64: kgdb: Match pstate size with gdbserver protocol (2016-06-16 19:20:51 +0100)

----------------------------------------------------------------
arm64 fixes:

- Plug the ongoing spin_unlock_wait/spin_is_locked mess
- KGDB protocol fix to sync w/ GDB
- Fix MIDR-based PMU probing for old 32-bit SMP systems (OMAP4/Realview)
- Minor tweaks to the fault handling path

----------------------------------------------------------------
Daniel Thompson (1):
      arm64: kgdb: Match pstate size with gdbserver protocol

Mark Rutland (2):
      arm64: fix dump_instr when PAN and UAO are in use
      arm64: mm: mark fault_info table const

Mark Salter (1):
      arm: pmu: Fix non-devicetree probing

Will Deacon (3):
      arm64: spinlock: order spin_{is_locked,unlock_wait} against local locks
      arm64: spinlock: fix spin_unlock_wait for LSE atomics
      arm64: spinlock: Ensure forward-progress in spin_unlock_wait

 arch/arm64/include/asm/kgdb.h     | 45 ++++++++++++++++++++++++++++++++-------
 arch/arm64/include/asm/spinlock.h | 42 +++++++++++++++++++++++++++++++-----
 arch/arm64/kernel/kgdb.c          | 14 +++++++++++-
 arch/arm64/kernel/traps.c         | 26 +++++++++++-----------
 arch/arm64/mm/fault.c             |  2 +-
 drivers/perf/arm_pmu.c            |  2 +-
 6 files changed, 102 insertions(+), 29 deletions(-)
