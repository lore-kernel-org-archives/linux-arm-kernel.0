From: james.morse@arm.com (James Morse)
Date: Tue, 18 Oct 2016 11:27:45 +0100
Subject: [PATCH 0/3] PAN Fixes
Message-ID: <1476786468-2173-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series fixes two issues for PAN discovered by Vladimir and Tony:
 * Patch 2 changes the cpu_enable_pan() to not only enable the automatic
   PAN setting when return to the kernel from userspace, but also turn
   it on right now. This covers the case where a pre-empted task may be
   migrated to a new CPU that hasn't yet done a return-to-user.

 * Patch 1 is a prerequisite which fixes the enable() calls to not use
   an IPI, (details in the patch). This means we can modify PSTATE from
   an enable call, which is broken today, but we don't actually depend
   on it...

Patch 3 fixes a third issue where we lose the PSTATE value over cpu-idle,
this will be a problem in the same pre-empted task migrated to a
'new' CPU case above, and if we return from idle to a user task, (which
I believe suspend-to-ram does).

Patch 1 changes the prototype of all the enable calls, so can't be
backported. I will produce separate backports for v4.4.25 and v4.7.8.

Based on v4.9-rc1, with [0] applied locally to fix cpuhotplug. This
series can be retrieved from:


Thanks,

James


[0]  https://www.spinics.net/lists/kernel/msg2357812.html

James Morse (3):
  arm64: cpufeature: Schedule enable() calls instead of calling them via
    IPI
  arm64: mm: Set PSTATE.PAN from the cpu_enable_pan() call
  arm64: suspend: Reconfigure PSTATE after resume from idle

 arch/arm64/include/asm/cpufeature.h |  2 +-
 arch/arm64/include/asm/exec.h       |  3 +++
 arch/arm64/include/asm/processor.h  |  6 +++---
 arch/arm64/kernel/cpu_errata.c      |  3 ++-
 arch/arm64/kernel/cpufeature.c      | 10 +++++++++-
 arch/arm64/kernel/process.c         |  3 ++-
 arch/arm64/kernel/suspend.c         | 11 +++++++++++
 arch/arm64/kernel/traps.c           |  3 ++-
 arch/arm64/mm/fault.c               | 15 +++++++++++++--
 9 files changed, 46 insertions(+), 10 deletions(-)

-- 
2.8.0.rc3
