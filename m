From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Sun, 22 Jan 2017 08:46:52 +0530
Subject: [PATCH v2 0/4] ARM: v7-A !MMU support,
 prepare CONFIG_VECTORS_BASE removal
Message-ID: <20170122031652.13074-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

ARM core changes to support !MMU Kernel on v7-A MMU processors. This
series also does the preparation for CONFIG_VECTORS_BASE removal.

Based on the feedback from Russell, it was decided to handle vector
base dynamically in C for no-MMU & work towards the the goal of
removing VECTORS_BASE from Kconfig. MMU platform's always have
exception base address at 0xffff0000, hence a macro was defined and
it was decoupled from Kconfig. No-MMU CP15 scenario is handled
dynamically in C. Once vector region setup, used by Cortex-R, is
made devoid of VECTORS_BASE, it can be removed from Kconfig.

This series has been verified over current mainline plus [2] on
Vybrid Cosmic+, Cortex-M4 - !MMU Kernel and Cortex-A5 - MMU Kernel.

This series also has been verified over Vladimir's series plus [2] on
1. Vybrid Cosmic+
 a. Cortex-M4 !MMU Kernel
 b. Cortex-A5 MMU Kernel
 c. Cortex-A5 !MMU Kernel
2. AM437x IDK
 a. Cortex-A9 MMU Kernel
 b. Cortex-A9 !MMU Kernel

Regards
afzal


v2:
=> Fix bisectability issue on !MMU builds
=> UL suffix on VECTORS_BASE definition
=> Use existing helpers to detect security extensions
=> Rewrite a CPP step to C for readability

[1] "[RFC v2 PATCH 00/23] Allow NOMMU for MULTIPLATFORM",
    http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/470966.html
    (git://linux-arm.org/linux-vm.git nommu-rfc-v2)

[2] "[PATCH 1/2] ARM: nommu: allow enabling REMAP_VECTORS_TO_RAM"
    http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/473593.html
    (in -next)

afzal mohammed (4):
  ARM: mmu: decouple VECTORS_BASE from Kconfig
  ARM: nommu: dynamic exception base address setting
  ARM: nommu: display vectors base
  ARM: nommu: remove Hivecs configuration is asm

 arch/arm/include/asm/memory.h  |  2 ++
 arch/arm/kernel/head-nommu.S   |  5 ----
 arch/arm/mach-berlin/platsmp.c |  3 ++-
 arch/arm/mm/dump.c             |  5 ++--
 arch/arm/mm/init.c             |  9 ++++++--
 arch/arm/mm/mm.h               |  5 ++--
 arch/arm/mm/nommu.c            | 52 ++++++++++++++++++++++++++++++++++++++++--
 7 files changed, 67 insertions(+), 14 deletions(-)

-- 
2.11.0
