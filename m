From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 May 2014 17:35:00 +0200
Subject: [PATCH RFCv2 0/5] ARM core support for hardware I/O coherency in
 non-SMP platforms
Message-ID: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Several of the latest Marvell Armada EBU platforms have a special
feature that is fairly uncommon on ARM platforms: hardware I/O
coherency. This feature allows to remove all cache maintenance
operations that are normally needed when doing DMA transfers (only an
I/O sync barrier is needed for DMA transfers from device).

This hardware I/O coherency mechanism needs a set of ARM core
requirements to operate properly:

 1 On Armada 370 (a single core processor)

   a The cache policy of pages must be set to "write allocate".

 2 On Armada XP (which has dual core and quad core variants)

   a The cache policy of pages must be set to "write allocate".
   b The SMP bit in the Auxiliary Functional Modes Control Register 0
     must be set (remember the CPU core is PJ4B)
   c The pages must be set as shareable.

 3 On Armada 375/38x (which have single core and dual core variants)

   a The cache policy of pages must be set to "write allocate".
   b The SMP and TLB broadcast bits must be set in the Auxiliary
     Control Register (the core is a Cortex-A9)
   c The pages must be set as shareable.
   d The SCU must be enabled

All of these requirements are met when the kernel is configured with
CONFIG_SMP *and* when the processor is actually a multiple core
processors (otherwise, due to the current CONFIG_SMP_ON_UP logic,
is_smp() returns false, and most of the requirements above are not
met).

For example, as of today, Armada 370 is broken because even if we
build the kernel CONFIG_SMP, the pages do not have the "write
allocate" attribute, because Armada 370 is single core, therefore the
CONFIG_SMP_ON_UP logic decides that we're not on an SMP system, and
therefore is_smp() returns false. Therefore, the fact that hardware
I/O coherency is enabled on Armada 370 today is incorrect, and there
is no way to fix that without making changes to the ARM core code.

Similarly, the Armada 380 (single core variant of the Armada 385) will
have the same problem: it's a single core processor, but that requires
several characteristics of an SMP configuration to properly use
hardware I/O coherency.

Also:

 - Not being able to use hardware I/O coherency on Armada 370 and
   Armada 380 is not really an option, as it is a major feature of
   those SoCs.

 - Having to enable CONFIG_SMP is also not very nice, as it comes with
   other performance penalties that could be avoided by using a
   !CONFIG_SMP configuration on those single core systems. And again,
   enabling CONFIG_SMP does *not* work for single core processors due
   to CONFIG_SMP_ON_UP.

Therefore, this RFC patch series proposes one solution to allow these
requirements to be met in the situations we are interested.

Even though the patch series is at RFC stage, I'm interested in
collecting ACKs even for certain patches only (like PATCH 1 and PATCH
2, which are probably less complicated than PATCH 3). This way, the
problem could be solved progressively, and the size of the patch
series reduced.

Basically, the patch series goes like this:

 * PATCH 1 makes write allocate the default cache policy for ARMv6+
   system. This was suggested by Catalin Marinas and Rob Herring. This
   patch provides the requirements 1.a, 2.a and 3.a detailed previously.

 * PATCH 2 allows the SCU to be enabled even in !CONFIG_SMP
   configurations. This patch provides the requirement 3.d detailed
   previously.

 * PATCH 3 makes CONFIG_SMP_ON_UP no longer dependent on CONFIG_SMP,
   which allows to enable SMP-related features (SMP bit, TLB broadcast
   bit, shareable pages) even when the platform uses a single core but
   advertises MP features in its MPIDR register. Provided
   CONFIG_SMP_ON_UP is enabled, this allows !CONFIG_SMP configurations
   to use hardware I/O coherency. This patch provides the requirements
   2.b, 2.c, 3.b and 3.c detailed previously.

 * PATCH 4 and 5 are simple additions to the mvebu coherency code.

Changes since v1:

 * Completely move away from the machine_desc flags approach, and
   instead try to find a global solution:
    - Make write allocate the default cache policy on all ARMv6+
      systems.
    - Allow CONFIG_SMP_ON_UP to be used on !CONFIG_SMP configurations,
      in order to enable MP related features in !CONFIG_SMP
      situations.

Thanks,

Thomas

Thomas Petazzoni (5):
  ARM: use write allocate by default on ARMv6+
  ARM: kernel: allow the SCU to be enabled even on !SMP
  ARM: allow CONFIG_SMP_ON_UP on non-SMP configurations
  ARM: mvebu: enable coherency only when possible on Armada XP
  ARM: mvebu: add debugging message indicating the status of I/O
    coherency

 arch/arm/Kconfig                 |  2 +-
 arch/arm/include/asm/assembler.h |  2 +-
 arch/arm/include/asm/smp_plat.h  |  8 ++++----
 arch/arm/include/asm/smp_scu.h   |  2 +-
 arch/arm/kernel/smp_scu.c        |  2 --
 arch/arm/mach-mvebu/coherency.c  | 18 +++++++++++++++---
 arch/arm/mm/mmu.c                | 10 +++++-----
 arch/arm/mm/proc-v6.S            |  2 +-
 arch/arm/mm/proc-v7-2level.S     |  6 +++---
 arch/arm/mm/proc-v7-3level.S     |  6 +++---
 arch/arm/mm/proc-v7.S            |  4 ++--
 11 files changed, 36 insertions(+), 26 deletions(-)

-- 
1.9.3
