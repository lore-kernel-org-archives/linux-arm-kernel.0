From: Russ.Dill@ti.com (Russ Dill)
Date: Tue,  3 Sep 2013 09:44:21 -0700
Subject: [RFC 0/4] Create infrastructure for running C code from SRAM.
Message-ID: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This RFC patchset explores an idea for loading C code into SRAM.
Currently, all the code I'm aware of that needs to run from SRAM is written
in assembler. The most common reason for code needing to run from SRAM is
that the memory controller is being disabled/ enabled or is already
disabled. arch/arm has by far the most examples, but code also exists in
powerpc and sh.

The code is written in asm for two primary reasons. First so that markers
can be put in indicating the size of the code they it can be copied. Second
so that data can be placed along with text and accessed in a position
independant manner.

SRAM handling code is in the process of being moved from arch directories
into drivers/misc/sram.c using device tree and genalloc [1] [2]. This RFC
patchset builds on that, including the limitation that the SRAM address is
not known at compile time. Because the SRAM address is not known at compile
time, the code that runs from SRAM must be compiled with -fPIC. Even if
the code were loaded to a fixed virtual address, portions of the code must
often be run with the MMU disabled.

The general idea is that for each SRAM user (such as an SoC specific
suspend/resume mechanism) to create a group of sections. The section group
is created with a single macro for each user, but end up looking like this:

.sram.am33xx : AT(ADDR(.sram.am33xx) - 0) {
  __sram_am33xx_start = .;
  *(.sram.am33xx.*)
  __sram_am33xx_end = .;
}

Any data or functions that should be copied to SRAM for this use should be
maked with an appropriate __section() attribute. A helper is then added for
translating between the original kernel symbol, and the address of that
function or variable once it has been copied into SRAM. Once control is
passed to a function within the SRAM section grouping, it can access any
variables or functions within that same SRAM section grouping without
translation.

[1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4984c6
[2] http://www.spinics.net/lists/linux-omap/msg96504.html

Russ Dill (4):
  Misc: SRAM: Create helpers for loading C code into SRAM
  ARM: SRAM: Add macro for generating SRAM resume trampoline
  Misc: SRAM: Hack for allowing executable code in SRAM.
  ARM: AM33XX: Move suspend/resume assembly to C

 arch/arm/include/asm/suspend.h    |  14 ++
 arch/arm/kernel/vmlinux.lds.S     |   2 +
 arch/arm/mach-omap2/Makefile      |   2 +-
 arch/arm/mach-omap2/pm33xx.c      |  50 ++---
 arch/arm/mach-omap2/pm33xx.h      |  23 +--
 arch/arm/mach-omap2/sleep33xx.S   | 394 --------------------------------------
 arch/arm/mach-omap2/sleep33xx.c   | 309 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/sram.c        |  15 --
 drivers/misc/sram.c               | 106 +++++++++-
 include/asm-generic/vmlinux.lds.h |   7 +
 include/linux/sram.h              |  44 +++++
 11 files changed, 509 insertions(+), 457 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/sleep33xx.S
 create mode 100644 arch/arm/mach-omap2/sleep33xx.c
 create mode 100644 include/linux/sram.h

-- 
1.8.3.2
