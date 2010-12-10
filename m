From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 10 Dec 2010 14:58:35 +0900
Subject: [PATCH 00/02][RFC] ARM: Subarch IRQ handler macro support
Message-ID: <20101210055835.8635.98614.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: Subarch IRQ handler macro support

[PATCH 01/02][RFC] ARM: Introduce Subarch IRQ handler macros
[PATCH 02/02][RFC] ARM: shmobile: Use Subarch IRQ handler for INTC

These patches add a macro for per-subarch use together with some
example code that shows how to use it.

The first patch simply breaks out code from the irq_handler macro
in entry-armv.S to the new macro arch_irq_handler that is put in a
shared header file. The new header file also adds the new macro
arch_irq_handler_default which replaces previous code in the
entry-armv.S file.

Patch number two gives an example on how to make use of the macro
arch_irq_handler on the SH-Mobile ARM subarch. Compile-time tested
on top of RMKs devel tree with the CONFIG_MULTI_IRQ_HANDLER patch
by Eric Miao. Please note that this patch isn't suitable for merge
since it needs to be reworked to fit on the sh-2.6 tree where the
rest of the SH-Mobile changes are.

In short, the per-subarch code is reduced to the following on the
sh7372 uniprocessor:

+#include <asm/entry-macro-multi.S>
+
+#define INTFLGA        0xe6980018
+
+       .macro  get_irqnr_preamble, base, tmp
+       ldr     \base, =INTFLGA
+       .endm
+
+       .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+       ldr     \irqnr, [\base]
+       cmp     \irqnr, #0
+       beq     1000f
+       /* intevt to irq number */
+       lsr     \irqnr, \irqnr, #0x5
+       subs    \irqnr, \irqnr, #16
+1000:
+       .endm
+
+       arch_irq_handler shmobile_handle_irq_intc

This code depends on the following patch by Eric Miao:

 [PATCH] ARM: Allow machine to specify it's own IRQ handlers at run-time

Comments are more than welcome!

Signed-off-by: Magnus Damm <damm@opensource.se>
---
 arch/arm/include/asm/entry-macro-multi.S          |   43 +++++++++++++++++++++
 arch/arm/kernel/entry-armv.S                      |   31 ---------------
 arch/arm/mach-shmobile/Kconfig                    |    3 +
 arch/arm/mach-shmobile/Makefile                   |   12 ++++-
 arch/arm/mach-shmobile/board-ap4evb.c             |    1 
 arch/arm/mach-shmobile/board-g3evm.c              |    1 
 arch/arm/mach-shmobile/board-g4evm.c              |    1 
 arch/arm/mach-shmobile/entry-intc.S               |   30 ++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h      |    1 
 arch/arm/mach-shmobile/include/mach/entry-macro.S |   27 -------------
 arch/arm/mach-shmobile/include/mach/hardware.h    |    3 -
 11 files changed, 91 insertions(+), 62 deletions(-)
