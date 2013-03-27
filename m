From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 27 Mar 2013 11:54:49 +0100
Subject: [PATCH v10 0/3] ARM: ARMv7-M (i.e. Cortex-M3) support
In-Reply-To: <1363901310-9474-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1363901310-9474-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1364381692-7955-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this is the next iteration of the Cortex-M3 support series. This reroll
addresses Jonny's comments. The only thing that I didn't take (I think)
is the sp alignment stuff on exception return. The facts are described
below, I'd be happy to read a few more thoughts on it.

This series still bases on the same commit as before, i.e. Russell's
devel-stable at that time.

I updated my tree

	git://git.pengutronix.de/git/ukl/linux.git efm32

to be based on this version of the patch set.

Now about the sp alignment during exception entry/return:

When an exception occurs the currently used stack pointer is 8-byte
aligned and than an exception frame is written to the stack. Depending
on sp being already aligned or not a bit is set in the exception frame
or not. On exception return this effect is reversed by the hardware,
i.e. if the bit is set in the frame it adds 4 to sp.

Now Jonny argues that there is no need to recheck if I need
to set or clear the bit on exception return because the hardware did it
right on exception entry. While this saves some overhead (three
instructions) during exception return it feels wrong (IMHO) because then
sp isn't necessarily restored to the value saved in pt_regs but to

	(pt_regs.sp & ~4) | (sp_on_exceptionentry & 4)

I think in practise there isn't any difference, but I claim to know all
ways how pt_regs.sp could change. So I prefer to recheck if I need to
set this bit or not to get more robust and maximally correct code.

The bit in question is saved to the xPSR value but this location is
reserved in the actual register. That means that this bit is never
really set in xPSR and is only valid in the exception frame. That made
me wonder if the cleanest approach is to even clear the bit in pt_regs
(and then necessarily recalculate it on exception return).

What do you think?

Best regards
Uwe


Catalin Marinas (1):
  ARM: Add base support for ARMv7-M

Uwe Kleine-K?nig (2):
  ARM: ARMv7-M: Add support for exception handling
  ARM: ARMv7-M: Allow the building of new kernel port

 arch/arm/Kconfig                   |   4 +-
 arch/arm/Kconfig-nommu             |   2 +-
 arch/arm/Makefile                  |   1 +
 arch/arm/include/asm/assembler.h   |  17 +++-
 arch/arm/include/asm/cputype.h     |  12 ++-
 arch/arm/include/asm/glue-cache.h  |  27 ++++++
 arch/arm/include/asm/glue-df.h     |   8 ++
 arch/arm/include/asm/glue-proc.h   |   9 ++
 arch/arm/include/asm/irqflags.h    |  22 +++--
 arch/arm/include/asm/ptrace.h      |   4 +
 arch/arm/include/asm/system_info.h |   1 +
 arch/arm/include/asm/v7m.h         |  44 ++++++++++
 arch/arm/include/uapi/asm/ptrace.h |  35 ++++++--
 arch/arm/kernel/Makefile           |   8 +-
 arch/arm/kernel/entry-common.S     |   4 +
 arch/arm/kernel/entry-header.S     | 124 ++++++++++++++++++++++++++++
 arch/arm/kernel/entry-v7m.S        | 142 +++++++++++++++++++++++++++++++
 arch/arm/kernel/head-nommu.S       |  10 ++-
 arch/arm/kernel/setup.c            |  17 +++-
 arch/arm/kernel/traps.c            |   8 ++
 arch/arm/mm/Kconfig                |  21 ++++-
 arch/arm/mm/Makefile               |   2 +
 arch/arm/mm/cache-nop.S            |  53 ++++++++++++
 arch/arm/mm/nommu.c                |   7 ++
 arch/arm/mm/proc-v7m.S             | 165 +++++++++++++++++++++++++++++++++++++
 25 files changed, 721 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/include/asm/v7m.h
 create mode 100644 arch/arm/kernel/entry-v7m.S
 create mode 100644 arch/arm/mm/cache-nop.S
 create mode 100644 arch/arm/mm/proc-v7m.S

-- 
1.8.2.rc2
