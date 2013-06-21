From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 21 Jun 2013 17:31:03 +0200
Subject: [PATCH v7] ARM: PJ4B: fix for 3.10-rc
Message-ID: <1371828664-3681-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This path allows to fix one errata for PJ4B CPUs.

Without this the Armada 370 based board can't boot anymore since
3.10-rc1. So this one really need to be applied on 3.10-rc.

Willy Tarreau have reported that with the last version the kernel
crashed in !SMP. The problem was that all the pj4b cpu functions were
defined in the __CPU_INIT section and in !SMP the code was removed
from the memory once the kernel initialization done. In this version I
fixed this issue by moving the code outside this section, and the
kernel now boots in SMP and !SMP.

Nicolas, would you agree to give your acked-by on this new version
before I sumbit it to Russell King's patch system?

Thanks,

V1 -> V2;
 - Fixed various coding style and typo issues
 - Replaced the "mcr p15, 0, r0, c7, c10, 4" by  "dsb"

V2 -> v3:
 - As suggested by Russell, the first errata is now applied
   dynamically according to the processor type

v3 -> v4:
 - Moved the glob_equ maco into proc-macro.S
 - Split the patch in 2 parts, one for fixing the ID and mask of the
   PJ4B and the second for fixing the errata itself

v4 -> v5:
- Added #ifdef all the places the new symbols conditionally defined
  are used.

v5 -> v6:
- Selected the fix by default if MACH_ARMADA_370 is selected, as
  without it there is no point to use Armada 370 base board.

v6 -> v7:
- Move the pj4b cpu functions outside the CPU_INIT section


Gregory CLEMENT (1):
  ARM PJ4B: Add support for errata 4742

 arch/arm/Kconfig                 | 14 ++++++++++++++
 arch/arm/include/asm/glue-proc.h |  9 +++++++++
 arch/arm/mm/proc-macros.S        |  5 +++++
 arch/arm/mm/proc-v7.S            | 34 +++++++++++++++++++++++++++++++---
 4 files changed, 59 insertions(+), 3 deletions(-)

-- 
1.8.1.2
