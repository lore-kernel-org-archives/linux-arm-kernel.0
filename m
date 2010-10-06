From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Oct 2010 16:17:31 +0900
Subject: [PATCH 00/08] ARM: Dynamic IRQ demux support
Message-ID: <20101006071731.28048.89938.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: Dynamic IRQ demux support 

[PATCH 01/08] ARM: Move entry-header.S to asm/
[PATCH 02/08] ARM: Move macros from entry-armv.S
[PATCH 03/08] ARM: Make alignment_trap macro self-contained
[PATCH 04/08] ARM: Convert __irq_svc and __usr_svc to macros
[PATCH 05/08] ARM: Move the unwind header to entry-header.S
[PATCH 06/08] ARM: Add setup_irq_stubs() function
[PATCH 07/08] ARM: Add CONFIG_DEFAULT_IRQ_DEMUX
[PATCH 08/08] ARM: Dynamic IRQ demux for SH-Mobile

These patches break out the IRQ demux code from entry-armv.S to
allow multiple IRQ demux instances to coexist. A registration 
function is also added that allows per-mach/plat code to chose
which IRQ demux instance to register at runtime.

Useful to support the upcoming single-kernel-binary-on-multiple-machines
_and_ for future SH-Mobile hardware support which will need to tie in
the GIC in the demux code for some processors.

The existing kernel behaviour remains unchanged as long as the kconfig
option CONFIG_DEFAULT_IRQ_DEMUX is set to Y.

A single IRQ demuxer instance (on UP) is written like this:

+#include <asm/entry-header.S>
+
+       .macro  get_irqnr_preamble, base, tmp
[blah]
+       .endm
+
+       .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
[bleh]
+       .endm
+
+       __irq_svc shmobile_common
+       __irq_usr shmobile_common

The per-mach IRQ setup code then registers whatever demuxing functions
it requires using:

+       setup_irq_stubs(__irq_usr_shmobile_common, __irq_svc_shmobile_common);

To strip down memory usage the kconfig option CONFIG_DEFAULT_IRQ_DEMUX
may be set to N to remove the default IRQ demux code. Most macros in
entry-macro.S will then become unused.

The macros disable_fiq and arch_ret_to_user are kept as-is for now.

Signed-off-by: Magnus Damm <damm@opensource.se>
---
 arch/arm/Kconfig                                  |    4 
 arch/arm/include/asm/entry-header.S               |  417 ++++++++++++++++++++-
 arch/arm/include/asm/traps.h                      |    1 
 arch/arm/kernel/entry-armv.S                      |  239 ------------
 arch/arm/kernel/entry-common.S                    |    4 
 arch/arm/kernel/entry-header.S                    |  181 ---------
 arch/arm/kernel/traps.c                           |   14 
 arch/arm/mach-shmobile/Makefile                   |    1 
 arch/arm/mach-shmobile/entry-irq-common.S         |   38 +
 arch/arm/mach-shmobile/include/mach/common.h      |    1 
 arch/arm/mach-shmobile/include/mach/entry-macro.S |   17 
 arch/arm/mach-shmobile/intc-sh7367.c              |    4 
 arch/arm/mach-shmobile/intc-sh7372.c              |    4 
 arch/arm/mach-shmobile/intc-sh7377.c              |    4 
 14 files changed, 506 insertions(+), 423 deletions(-)
