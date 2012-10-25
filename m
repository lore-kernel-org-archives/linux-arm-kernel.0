From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 18:18:23 +0200
Subject: DEBUG_LL broken for socfpga
Message-ID: <20121025181823.6c3fa0de@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dinh,

The arch/arm/include/debug/socfpga.S file implements only addruart, and
forgets to implement waituart, senduart, busyuart:

  AS      arch/arm/kernel/debug.o
/home/thomas/projets/linux-2.6/arch/arm/kernel/debug.S: Assembler messages:
/home/thomas/projets/linux-2.6/arch/arm/kernel/debug.S:83: Error: bad instruction `waituart r2,r3'
/home/thomas/projets/linux-2.6/arch/arm/kernel/debug.S:84: Error: bad instruction `senduart r1,r3'
/home/thomas/projets/linux-2.6/arch/arm/kernel/debug.S:85: Error: bad instruction `busyuart r2,r3'

Since the socfpga UART is apparently 8250 compatible, adding:

#define UART_SHIFT      2
#include <asm/hardware/debug-8250.S>

at the end of socfpga.S should be sufficient. However, socfpga.S uses
an undefined DEBUG_LL_UART_OFFSET. And also most likely there is a
missing static mapping for the UART registers in
arch/arm/mach-socfpga/socfpga.c in order to get a virtual address for
the UART registers soon enough for earlyprintk to work.

Probably easy to fix, but I have no hardware and no datasheet.
Certainly better if someone having those could handle the
implementation of the fix.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
