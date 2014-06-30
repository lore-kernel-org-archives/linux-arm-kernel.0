From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 30 Jun 2014 09:53:07 +0100
Subject: [PATCH v7 0/4] arm: KGDB NMI/FIQ support
In-Reply-To: <1403623097-1153-1-git-send-email-daniel.thompson@linaro.org>
References: <1403623097-1153-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1404118391-3850-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes it possible to use kgdb's NMI infrastructure on ARM
platforms.

The patches have been previously circulated as part of a large patchset
mixing together ARM architecture code and driver changes
(http://thread.gmane.org/gmane.linux.ports.arm.kernel/333901 ). This
patchset is dramatically cut down to include only the arch/arm code. The
driver code (irqchip and tty/serial) will follow when/if the arch code
is accepted.

The first two patches modify the FIQ infrastructure to allow interrupt
controller drivers to register callbacks (the fiq_chip structure) to
manage FIQ routings and to signal FIQ EOI. This makes it possible to
use FIQ in multi-platform kernels and with recent ARM interrupt
controllers.

The remaining two patches provide architecture support for KGDB's NMI
feature (and rely upon the preceding changes to the FIQ code).

Tested on qemu (versatile), STiH416 (B2020 board) and Freescale i.MX6
quad (wandboard).

Changes since v6:

- Corrected off-by-one comparison in has_fiq() (Nicolas Pitre)
- Rewrote the FIQ stack initialization (Nicolas Pitre). This fixes a
  serious data corruption bug due to bad stack mismanagement.
- Introduced __fiq_abt to ensure lr_abt and spsr_abt are saved and
  restored if we fast-interrupt an abort (Russell King).
- Significantly improved the commenting of the exception handlers.
- Added a call to trace_hardirqs_on() if we clear the I bit as we
  exit the exception handler.

Changes since v5:

- Separated anything not strictly impacting arch/arm.
- Fixed a spurious add/remove of code within the series (there was
  broken code in intermediate patches)

For previous changes see:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/333901


Anton Vorontsov (2):
  ARM: Move some macros from entry-armv to entry-header
  ARM: Add KGDB/KDB FIQ debugger generic code

Daniel Thompson (2):
  arm: fiq: Add callbacks to manage FIQ routings
  arm: fiq: Allow EOI to be communicated to the intc

 arch/arm/Kconfig                 |   2 +
 arch/arm/Kconfig.debug           |  18 +++++
 arch/arm/include/asm/fiq.h       |  14 ++++
 arch/arm/include/asm/kgdb.h      |   7 ++
 arch/arm/kernel/Makefile         |   1 +
 arch/arm/kernel/entry-armv.S     | 151 +----------------------------------
 arch/arm/kernel/entry-header.S   | 164 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/fiq.c            | 112 +++++++++++++++++++++++++-
 arch/arm/kernel/kgdb_fiq.c       | 127 ++++++++++++++++++++++++++++++
 arch/arm/kernel/kgdb_fiq_entry.S | 130 +++++++++++++++++++++++++++++++
 10 files changed, 574 insertions(+), 152 deletions(-)
 create mode 100644 arch/arm/kernel/kgdb_fiq.c
 create mode 100644 arch/arm/kernel/kgdb_fiq_entry.S

--
1.9.3
