From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 May 2014 17:50:34 +0200
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency in
 non-SMP platforms
Message-ID: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Disclaimer: this is an RFC patch series.

Several of the latest Marvell Armada EBU platforms have a special
feature that is fairly uncommon on ARM platforms: hardware I/O
coherency. This feature allows to remove all cache maintenance
operations that are normally needed when doing DMA transfers (only an
I/O sync barrier is needed for DMA transfers from device).

This hardware I/O coherency mechanism needs a set of ARM core
requirements to operate properly:

 * On Armada 370 (a single core processor)

   - The cache policy of pages must be set to "write allocate".

 * On Armada XP (which has dual core and quad core variants)

   - The cache policy of pages must be set to "write allocate".
   - The SMP bit in the Auxiliary Functional Modes Control Register 0
     must be set (remember the CPU core is PJ4B)
   - The pages must be set as shareable.

 * On Armada 375/38x (which have single core and dual core variants)

   - The cache policy of pages must be set to "write allocate".
   - The SMP and TLB broadcast bits must be set in the Auxiliary
     Control Register (the core is a Cortex-A9)
   - The pages must be set as shareable.
   - The SCU must be enabled

All of these requirements are met when the kernel is configured with
CONFIG_SMP *and* when the processor is actually a multiple core
processors (otherwise, due to the CONFIG_SMP_ON_UP logic, is_smp()
returns false, and most of the requirements above are not met).

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
requirements to be met in the situations we are interested. The patch
series is *only* a proposal, and I'm definitely interested in hearing
about other implementation possibilites to make things look nicer.

Basically, the patch series goes like this:

 * PATCH 1 adds a 'flags' field to 'struct machine_desc' so that each
   platform can tell the ARM kernel core some of its requirements. We
   maybe could have used the Device Tree as well, but accessing the
   Device Tree as early as in paging_init() is a bit problematic as
   far as I understand.

   Two flags are defined: MACHINE_NEEDS_CPOLICY_WRITEALLOC and
   MACHINE_NEEDS_SHAREABLE_PAGES. We need separate flags because
   Armada 370 cannot have the shareable attribute on page tables.

   I am completely open to discussing other possibilities to achieve
   the same goal.

 * PATCH 2 actually implements the logic behind
   MACHINE_NEEDS_CPOLICY_WRITEALLOC and MACHINE_NEEDS_SHAREABLE_PAGES.

 * PATCH 3 sets the SMP and TLB broadcast bits in the Cortex-A9 CP15
   register. This is normally done in proc-v7.S for real SMP systems,
   but if the platform (such as Armada 380) is detected as a single
   core, proc-v7.S will not set the SMP bit and TLB broadcast
   bits. Since we don't have an easy access to the 'struct
   machine_desc' from proc-v7.S, this logic has been added to
   mmu.c. This is done only is is_smp() is false and the platform has
   requested shareable pages.

 * PATCH 4 allows the SCU to be enabled even in !CONFIG_SMP
   configurations. This is needed for the Armada 380, which is a
   single core processor that has hardware I/O coherency support.

 * PATCH 5 splits the Armada 370 and Armada XP machine_desc structures
   into two separate structures, because the two platforms will have
   different flags.

 * PATCH 6 defines the appropriate flags for the Armada 370, Armada
   XP, Armada 375 and Armada 38x 'struct machine_desc'.

 * PATCH 7 now allows Armada 375 and Armada 38x to enable hardware I/O
   coherency even in non-SMP situations (i.e either CONFIG_SMP is
   disabled, or CONFIG_SMP is enabled but the processor is single
   core).

Thanks,

Thomas

Thomas Petazzoni (7):
  ARM: extend machine_desc with additional flags
  ARM: mm: implement the usage of the machine_desc flags
  ARM: mm: enable SMP bit and TLB broadcast bit on !SMP when needed
  ARM: kernel: allow the SCU to be enabled even on !SMP
  ARM: mvebu: split Armada 370 and Armada XP machine_desc
  ARM: mvebu: define the Armada 370/375/38x/XP machine_desc flags
  ARM: mvebu: I/O coherency no longer needs SMP on 375 and 38x

 arch/arm/include/asm/mach/arch.h |  5 +++++
 arch/arm/include/asm/smp_scu.h   |  2 +-
 arch/arm/kernel/smp_scu.c        |  2 --
 arch/arm/mach-mvebu/board-v7.c   | 28 +++++++++++++++++++++++-----
 arch/arm/mach-mvebu/coherency.c  | 13 +++----------
 arch/arm/mm/mmu.c                | 24 ++++++++++++++++++++----
 6 files changed, 52 insertions(+), 22 deletions(-)

-- 
1.9.3
