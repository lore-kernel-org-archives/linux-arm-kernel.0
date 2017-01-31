From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Tue, 31 Jan 2017 18:34:46 +0530
Subject: [PATCH v3 0/3] ARM: !MMU: v7-A support, dynamic vectors base handling
Message-ID: <20170131130446.5829-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

ARM core changes to support !MMU Kernel on v7-A MMU processors.

Based on the feedback from Russell, it was decided to handle vector
base dynamically in C for no-MMU & work towards the the goal of
removing VECTORS_BASE from Kconfig.

Exception base address is dynamically found out in C & configured.

This series also does the preparation for CONFIG_VECTORS_BASE removal.
Once vector region setup, used by Cortex-R, is made devoid of
VECTORS_BASE, it can be removed from Kconfig. [2] already decouples it
from Kconfig for MMU.

Vladimir's Tested-by on v2 has been removed from [PATCH 2/3] as it has
been changed. And as it doesn't affect functionality, Tested-by has been
retained on the other two patches, Vladimir, let me know if not okay.

This series has been verified over current mainline plus [1,2] on
1. Vybrid Cosmic+
 a. Cortex-M4 - !MMU Kernel
 b. Cortex-A5 - MMU Kernel.

This series also has been verified over Vladimir's series [3] along
with [1,2] on
1. Vybrid Cosmic+
 a. Cortex-M4 !MMU Kernel
 b. Cortex-A5 MMU Kernel
 c. Cortex-A5 !MMU Kernel
2. AM437x IDK
 a. Cortex-A9 MMU Kernel
 b. Cortex-A9 !MMU Kernel

Regards
afzal

v3:
=> Removed [PATCH 1/4] of v2 as it is in -next
=> Simplify by defining VECTORS_BASE to variable holding dynamically
    calculated exception base address

v2:
=> Fix bisectability issue on !MMU builds
=> UL suffix on VECTORS_BASE definition
=> Use existing helpers to detect security extensions
=> Rewrite a CPP step to C for readability

[1] "[PATCH 1/2] ARM: nommu: allow enabling REMAP_VECTORS_TO_RAM"
    http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/473593.html
    (in -next)

[2] "[PATCH v2 1/4] ARM: mmu: decouple VECTORS_BASE from Kconfig"
    http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/481904.html
    (in -next)

[3] "[RFC v2 PATCH 00/23] Allow NOMMU for MULTIPLATFORM",
    http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/470966.html
    (git://linux-arm.org/linux-vm.git nommu-rfc-v2)

afzal mohammed (3):
  ARM: nommu: dynamic exception base address setting
  ARM: nommu: display vectors base
  ARM: nommu: remove Hivecs configuration is asm

 arch/arm/include/asm/memory.h |  9 ++++++--
 arch/arm/kernel/head-nommu.S  |  5 -----
 arch/arm/mm/nommu.c           | 52 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 57 insertions(+), 9 deletions(-)

-- 
2.11.0
