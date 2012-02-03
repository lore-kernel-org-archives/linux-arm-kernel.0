From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Feb 2012 19:30:59 +0000
Subject: [PATCH 00/17] SA11x0 cleanups (mainly assabet/neponset)
Message-ID: <20120203193059.GF14129@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a series of cleanups and improvements to the SA11x0 code, in
particular the Assabet, and Assabet with the Neponset daughter board.

The main SA11x0 change is to switch to using the DEFINE_RES_xxx() for
resources, which obviously reduces the lines of code quite a bit.

The Assabet-only changes reduce power consumption of the board, and
illustrate why pins left as inputs when they're supposed to be outputs
are bad news - while it's undriven, it floats and increases the power
consumption by a measurable amount.

Neponset wise, there's fixes in here to restore it to fully working
state (rather than just being buildable.)  Unfortunately, genirq had
seriously broken the Neponset interrupt support code by genirq having
some 'improved checks' added without auditing the genirq users.

Neponset also gets ready for sparse IRQ support, meaning that its
interrupt numbers are no longer statically fixed.  We also move the
registration of the neponset device to assabet, which helps reduce
the knowledge spread of whether the board is fitted.

The random places which the NCR_0 board register is written are turned
into a function call instead, so that the NCR_0 register access can be
centralized and properly protected against concurrent access for this
platform.

Since neponset becomes mostly self-contained, most of the boards CPLD
register definitions are moved to the board file rather than exposing
them in the board header file.  That then paves the way to get rid of
its static mapping for its own registers, using ioremap() instead.

 arch/arm/mach-sa1100/assabet.c               |   39 ++-
 arch/arm/mach-sa1100/badge4.c                |   19 +-
 arch/arm/mach-sa1100/cerf.c                  |   13 +-
 arch/arm/mach-sa1100/collie.c                |   24 +-
 arch/arm/mach-sa1100/generic.c               |   93 +----
 arch/arm/mach-sa1100/h3xxx.c                 |   13 +-
 arch/arm/mach-sa1100/hackkit.c               |    7 +-
 arch/arm/mach-sa1100/include/mach/irqs.h     |    8 -
 arch/arm/mach-sa1100/include/mach/neponset.h |   52 +---
 arch/arm/mach-sa1100/irq.c                   |    7 +-
 arch/arm/mach-sa1100/jornada720.c            |   31 +--
 arch/arm/mach-sa1100/nanoengine.c            |   11 +-
 arch/arm/mach-sa1100/neponset.c              |  534 +++++++++++++++-----------
 arch/arm/mach-sa1100/pci-nanoengine.c        |    8 +-
 arch/arm/mach-sa1100/pleb.c                  |   24 +-
 arch/arm/mach-sa1100/shannon.c               |    7 +-
 arch/arm/mach-sa1100/simpad.c                |   11 +-
 drivers/net/ethernet/smsc/smc91x.c           |    2 +-
 drivers/pcmcia/sa1100_neponset.c             |    7 +-
 19 files changed, 402 insertions(+), 508 deletions(-)
