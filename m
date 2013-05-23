From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 May 2013 15:30:48 +0200
Subject: [PATCH v2 0/6] Support new Marvell bootloaders for Armada 370/XP
Message-ID: <1369315854-32724-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the second version of this patch series, that switches Armada
370/XP to use internal registers mapped at 0xf1000000, in order to
comply with the new bootloaders shipped by Marvell. It also implements
a temporary solution to allow users of platforms having an old
bootloader to continue to boot properly. See the detailed explanation
below.

Changes since v1
================

 * The patch series is now based on jcooper/mvebu/fixes +
   jcooper/mvebu/cleanup. As a result, I've dropped the first three
   patches of this series, that have been merged by Jason Cooper
   already.

 * This I'm based on mvebu/fixes + mvebu/cleanup, I had to fix a
   conflict in "arm: mvebu: move cache and mvebu-mbus initialization
   later" since that conflicted with the removal of the coherent DMA
   workaround.

 * Improved/fixed two comments in armada-370-xp.c related to the
   register switch. Noticed and suggested by Andrew Lunn.

 * Fixed the virtual address used to remap the internal registers at
   the new address. It needs to be 2 MB aligned, like the one for the
   internal registers at the old address, in order to be compatible
   with what the assembly code in arch/arm/kernel/head.S is doing to
   set up an early virtual->physical mapping. (2 MB because sections
   with LPAE are 2 MB wide, and we support LPAE).

In detail, the patch series has
===============================

 * Patch 1 and 2 slightly rework the way the SMP initialization and
   the coherency unit initialization is done, in order to avoid the
   hardcoded virtual address in the coherency.c file.

   To be applied to mvebu/soc

 * Patch 3 moves the L2 cache and mvebu-mbus initialization a bit
   later (i.e from ->init_early() to ->init_time()) so that they can
   ioremap() their registers without crashing once we remove the
   static I/O mapping (next patch).

 * Patch 4 removes the static I/O mapping that was set up at
   ->map_io() time to cover the entire "internal registers" area.

   To be applied to mvebu/soc

 * Patch 5 removes the hardcoded physical address in the SMP
   initialization code.

   To be applied to mvebu/soc

 * Patch 6 implements the internal register address change itself. The
   DTS changes are included in the same patch as the code changes. It
   is possible to split them in two patches, but applying just one
   patch and not the other would lead to a kernel that doesn't boot at
   all.

   To be applied to mvebu/soc (even though there are admittedly some
   DT changes in here).

Additional details
==================

The aim of this patch series is to move the internal registers space
of the Armada 370 and Armada XP support to 0xf1000000 instead of
0xd0000000, and prepare for the support of the new versions of U-Boot
installed by Marvell on Armada 370 and XP platforms that boot the
kernel with the internal registers space already mapped at 0xf1000000.

Before reading the patches, and especially the last one, please read
on for a description of the problem and the proposed solution. The
solution has been carefully thought of, and all the details explained
below are important to understand how the proposed solution was
designed.

On Marvell EBU SoCs, including earlier families such as Kirkwood or
Dove, all the peripheral registers belong to a memory window of 1 MB,
called the "internal registers window". This window of physical memory
can be freely moved to an arbitrary physical address. At reset, this
memory window is at 0xD0000000, but it can be changed by software to
another address if needed.

The *very* important thing to remember is that the mechanism to get or
change the base address of this "internal registers" window is a
register, which is itself part of this "internal registers"
window. The bottom line is that when you run code on a Marvell SoC,
you have to *know* where the internal registers are located, because
you can't guess dynamically by reading some hardware register. Again,
this is a *very* important characteristic, because it explains many of
the choices of the proposed solution below.

Historically, the bootloaders for Dove and Kirkwood have always
remapped the internal registers window at 0xF1000000, so for those
platforms, the Linux kernel has always made the assumption that
internal registers are accessible at 0xF1000000.

Unfortunately, for Armada 370 and Armada XP, the current generation of
bootloaders that are being shipped on Marvell evaluation boards, but
also on products like the Plathome OpenBlocks AX3 or the Globalscale
Mirabox do not do the remapping, and are leaving the internal
registers at 0xD0000000.

However, this is causing some problems:

 1 The internal registers window sits at 3 GB, in the middle of the
   0-4 GB area of physical memory, which is quite annoying when you
   have more than 3 GB of memory. Having them at 0xF1000000 means that
   you lose less RAM when you have more than 3 GB of physical memory
   installed. And since Armada XP is LPAE capable, you can even have
   more than 4 GB memory: we already have boards with 8 GB of memory
   installed.

 2 This is different from Kirkwood and Dove, which makes sharing some
   early code like earlyprintk complicated, while our goal is
   ultimately to merge all Marvell EBU platforms into mach-mvebu.

(1) is really the primary motivation here, (2) is only a nice
side-effect.

So, the new generation of bootloaders that are shipped on new Marvell
Armada 370/XP platforms are doing the remapping at 0xF1000000 prior to
starting Linux. The current kernel cannot boot on such platforms.

One solution is to move the kernel to use 0xF1000000, and assume the
bootloader has already done the remapping. This can be one option, but
it means that newer kernels would no longer boot on platforms that use
an old bootloader. All existing users of Globalscale Mirabox or
Plathome OpenBlocks AX3, next time they upgrade their kernel, would
have a kernel that simply doesn't boot (and without showing *any*
message, because even the address of the UART has changed).

If the only Armada 370/XP platforms in use today had been evaluation
boards that are available only to a selected number of people,
dropping the compatibility would probably have been
acceptable. However, with a large number of Mirabox and OpenBlocks AX3
devices being already shipped, we believe that breaking the
compatibility is not an option.

Therefore, the last patch of this series adds some early code in the
kernel, at the ->map_io() stage, to switch the internal registers from
0xD0000000 to 0xF1000000 if this has not been done already by the
bootloader. As it was explained above, we unfortunately can't read the
current base address of the internal register window, so we need a
different mechanism to know if the bootloader has done the remapping
at 0xF1000000 (new generation bootloader) or has left the internal
registers at 0xD0000000 (old generation bootloader). In order to
distinguish between those two cases, a CP15 bit is being used. Old
bootloaders do not touch this CP15, so it is set to 0. New bootloaders
set this CP15 bit to 1, so that the kernel knows that the remapping
has already been done. The ->map_io() code looks at this bit to know
if the remapping should be done or not.

Unfortunately, tweaking ->map_io() is not sufficient: we also want
earlyprintk to work. And earlyprintk is used *before* ->map_io() is
called, and *after* ->map_io() is called. So in the earlyprintk code,
we also need to do a little bit of magic to know if we're booted on an
old or new bootloader, and if the remapping has occured or not in the
case of an old bootloader. Since the CP15 bit that we use gets cleared
the first time the 'wfi' instruction is cleared, we use this bit only
in the early kernel boot. As soon as ->map_io() as done its job, it
sets a global variable that tells the earlyprintk code that the
registers are now at 0xF1000000.

I hope this long explanation gives enough context to understand the
problem and the proposed solution. Do not hesitate to ask for more
details if needed.

Notice that the solution would be much simpler if we could do this
remapping earlier in the kernel initialization. Unfortunately,
->map_io() is really the first piece of code that is being called into
SoC-specific code, so it's the only way of doing this without making
changes in generic places in the kernel.

This code has been tested with both an old bootloader and a new
bootloader, on the Armada XP GP platform.

Best regards,

Thomas

Thomas Petazzoni (6):
  arm: mvebu: remove dependency of SMP init on static I/O mapping
  arm: mvebu: avoid hardcoded virtual address in coherency code
  arm: mvebu: move cache and mvebu-mbus initialization later
  arm: mvebu: remove hardcoded static I/O mapping
  arm: mvebu: don't hardcode a physical address in headsmp.S
  arm: mvebu: support new bootloaders shipped by Marvell

 arch/arm/boot/dts/armada-370-xp.dtsi |    2 +-
 arch/arm/boot/dts/armada-370.dtsi    |    3 +-
 arch/arm/boot/dts/armada-xp-gp.dts   |    2 +-
 arch/arm/include/debug/mvebu.S       |   77 +++++++++++++++++++--
 arch/arm/mach-mvebu/armada-370-xp.c  |  124 +++++++++++++++++++++++++++++-----
 arch/arm/mach-mvebu/armada-370-xp.h  |    4 +-
 arch/arm/mach-mvebu/coherency.c      |   36 ++++------
 arch/arm/mach-mvebu/coherency.h      |    4 --
 arch/arm/mach-mvebu/common.h         |    2 +
 arch/arm/mach-mvebu/headsmp.S        |   20 +++---
 arch/arm/mach-mvebu/platsmp.c        |   10 ++-
 11 files changed, 220 insertions(+), 64 deletions(-)

-- 
1.7.9.5
