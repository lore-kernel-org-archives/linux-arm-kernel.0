From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 14 May 2014 16:58:37 +0100
Subject: [RFC 0/8] kgdb: NMI/FIQ support for ARM
Message-ID: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes it possible to use the kgdb NMI infrastructure
on ARM platforms.

The kgdb NMI infrastructure works by re-routing an UARTs interrupt
signal from IRQ to FIQ. The UART will no longer function normally
and will instead be managed by kgdb using the polled I/O functions.
Any character delivered to the UART causes the kgdb handler function
to be called. Each serial driver explicitly consents (or not) to this
abuse by calling the appropriate registration functions.

[PATCH 1/8] arm: fiq: Allow EOI to be communicated to the intc
[PATCH 2/8] irqchip: gic: Provide support for interrupt grouping
    Both these patches lay the ground work to allow modern ARM
    interrupt controllers to support FIQ correctly.

[PATCH 3/8] ARM: Move some macros from entry-armv to entry-header
[PATCH 4/8] ARM: Add KGDB/KDB FIQ debugger generic code
    This is the heart of the patch series, allowing FIQs to be
    registered with KGDB and handled by KGDB.

[PATCH 5/8] serial: amba-pl011: Pass on FIQ information to KGDB.
[PATCH 6/8] serial: asc: Add support for KGDB's FIQ/NMI mode
    Extend to UART drivers to allow the register the appropriate FIQ
    (implicitly promising to behave properly when their own IRQ handler 
    is cut off).


[PATCH 7/8] ARM: VIC: Add vic_set_fiq function to select if an...
[PATCH 8/8] arm: fiq: Hack FIQ routing backdoors into GIC and VIC
    Here we hit the serious request-for-comment section. It is not 
    clear what the best way to get the interrupt controller to re-route 
    an interrupt source from the IRQ signal to the FIQ signal.
    
    Clearly the approach here is wrong but it has been enough for me
    to test my work so far.

Anton Vorontsov (2):
  ARM: Move some macros from entry-armv to entry-header
  ARM: Add KGDB/KDB FIQ debugger generic code

Arve Hj?nnev?g (1):
  ARM: VIC: Add vic_set_fiq function to select if an interrupt should
    generate an IRQ or FIQ

Daniel Thompson (5):
  arm: fiq: Allow EOI to be communicated to the intc
  irqchip: gic: Provide support for interrupt grouping
  serial: amba-pl011: Pass on FIQ information to KGDB.
  serial: asc: Add support for KGDB's FIQ/NMI mode
  arm: fiq: Hack FIQ routing backdoors into GIC and VIC

 arch/arm/Kconfig                        |   2 +
 arch/arm/Kconfig.debug                  |  18 ++++
 arch/arm/boot/dts/stih416.dtsi          |   2 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi |   2 +-
 arch/arm/include/asm/fiq.h              |   1 +
 arch/arm/include/asm/kgdb.h             |   7 ++
 arch/arm/kernel/Makefile                |   1 +
 arch/arm/kernel/entry-armv.S            | 151 +----------------------------
 arch/arm/kernel/entry-header.S          | 164 ++++++++++++++++++++++++++++++++
 arch/arm/kernel/fiq.c                   |  50 ++++++++++
 arch/arm/kernel/kgdb_fiq.c              | 117 +++++++++++++++++++++++
 arch/arm/kernel/kgdb_fiq_entry.S        |  87 +++++++++++++++++
 drivers/irqchip/irq-gic.c               |  62 +++++++++++-
 drivers/irqchip/irq-vic.c               |  23 +++++
 drivers/tty/serial/amba-pl011.c         |  18 +++-
 drivers/tty/serial/st-asc.c             |  25 +++++
 include/linux/irqchip/arm-gic.h         |   3 +
 include/linux/irqchip/arm-vic.h         |   1 +
 18 files changed, 576 insertions(+), 158 deletions(-)
 create mode 100644 arch/arm/kernel/kgdb_fiq.c
 create mode 100644 arch/arm/kernel/kgdb_fiq_entry.S

-- 
1.9.0
