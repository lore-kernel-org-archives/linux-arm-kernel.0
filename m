From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 27 Apr 2015 18:47:49 -0400
Subject: [PATCH 00/11] Delete new __cpuinit users and then delete stubs
Message-ID: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We removed the __cpuinit stuff in 3.11-rc1 with commit 
22f0a27367742f65130c0fb25ef00f7297e032c1 ("init.h: remove __cpuinit
sections from the kernel") but we left some no-op stubs as
a courtesy to unmerged code.

Here we get rid of the stubs as well, since (as can be seen in these
changes) they are enabling use cases to sneak back in, primarily from
older BSP code that has been living out of tree for some time prior
to getting mainlined.  So we get rid of these "new" users 1st and
then get rid of the stubs.

Obviously, getting rid of the stubs can't happen until all the users
are gone, so this might as well stay together as a series.  I'll feed
it into linux-next once I've sent out some other pending cleanups that
need to get coverage there as well.

Paul.

---

Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mips at linux-mips.org

Paul Gortmaker (11):
  sched/core: remove __cpuinit section tag that crept back in.
  arm/mach-keystone: remove legacy __cpuinit sections that crept in
  arm/mach-mvebu: remove legacy __cpuinit sections that crept in
  arm/mach-rockchip: remove legacy __cpuinit section that crept in
  arm/mach-hisi: remove legacy __CPUINIT section that crept in
  mips/ath25: remove legacy __cpuinit section that crept in
  mips/bcm77xx: remove legacy __cpuinit sections that crept in
  mips/c-r4k: remove legacy __cpuinit section that crept in
  kernel/cpu.c: remove new instance of __cpuinit that crept back in
  mips/mm/tlbex: remove new instance of __cpuinit that crept back in
  init: delete the __cpuinit related stubs

 arch/arm/mach-hisi/headsmp.S       |  3 ---
 arch/arm/mach-keystone/platsmp.c   |  4 ++--
 arch/arm/mach-mvebu/headsmp-a9.S   |  3 ---
 arch/arm/mach-mvebu/platsmp-a9.c   |  2 +-
 arch/arm/mach-rockchip/platsmp.c   |  3 +--
 arch/mips/ath25/board.c            |  2 +-
 arch/mips/bcm47xx/prom.c           |  2 +-
 arch/mips/include/asm/pgtable-32.h |  2 +-
 arch/mips/mm/c-r4k.c               |  2 +-
 arch/mips/mm/tlb-r4k.c             |  2 +-
 arch/mips/mm/tlbex.c               |  2 +-
 include/linux/init.h               | 11 -----------
 kernel/cpu.c                       |  2 +-
 kernel/sched/core.c                |  2 +-
 scripts/tags.sh                    |  2 +-
 15 files changed, 13 insertions(+), 31 deletions(-)

-- 
2.2.1
