From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Thu, 19 Jan 2017 02:05:25 +0530
Subject: [PATCH 0/4] ARM: v7-A !MMU support,
 CONFIG_VECTORS_BASE removal (almost)
Message-ID: <20170118203525.6246-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

ARM core changes to support !MMU Kernel on v7-A MMU processors. This
series also does the preparation for CONFIG_VECTORS_BASE removal.

Based on the feedback from Russell on the initial patches (part RFC),
it was decided to handle vector base dynamically in C & work towards
the the goal of removing VECTORS_BASE from Kconfig. MMU platform's
always have exception base address at 0xffff0000, while no-MMU CP15
scenario was handled dynamically in C. Hivecs handling for no-MMU CP15
that was done in asm has been moved to C as part of dynamic handling.
This now leaves only vector region setup, used by Cortex-R, to be made
devoid of VECTORS_BASE so as to remove it from Kconfig.

Vladimir is planning to rework MPU code, so it has been left untouched.
VECTORS_BASE is to be removed from Kconfig after the MPU region rework.

This series has been tested on top of mainline on,
1. Vybrid CM4 (!MMU)
2. Vybrid CA5 (MMU)

and on top of Vladimir's series[1] on,
1. Vybrid CM4 (!MMU)
2. Vybrid CA5 (MMU & !MMU)
3. AM437x IDK (MMU & !MMU)

Both above had an additional patch [2] as well, which is in next now.

Regards
afzal

[1] "[RFC v2 PATCH 00/23] Allow NOMMU for MULTIPLATFORM",
    http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/470966.html
    (git://linux-arm.org/linux-vm.git nommu-rfc-v2)

[2] "[PATCH 1/2] ARM: nommu: allow enabling REMAP_VECTORS_TO_RAM"
    http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/473593.html

afzal mohammed (4):
  ARM: mmu: decouple VECTORS_BASE from Kconfig
  ARM: nommu: dynamic exception base address setting
  ARM: nommu: display vectors base
  ARM: nommu: remove Hivecs configuration is asm

 arch/arm/include/asm/memory.h  |  2 ++
 arch/arm/kernel/head-nommu.S   |  5 ----
 arch/arm/mach-berlin/platsmp.c |  3 +-
 arch/arm/mm/dump.c             |  5 ++--
 arch/arm/mm/init.c             |  9 ++++--
 arch/arm/mm/mm.h               |  5 ++--
 arch/arm/mm/nommu.c            | 64 ++++++++++++++++++++++++++++++++++++++++--
 7 files changed, 79 insertions(+), 14 deletions(-)

-- 
2.11.0
