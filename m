From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 16 Apr 2011 21:14:02 -0000
Subject: [RFC patch 00/20] Interrupt chip consolidation
Message-ID: <20110416211221.853079766@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A search for patterns of interrupt chips and their implementations
came up with at least two very common variants:

 - mask register based, where a bit flips the masked state of the
   corresponding interrupt line. Most common is to unmask with the bit
   set, but the inverted version exists as well. Interestingly enough
   almost none of the chips implementations cache the register value
   and read it back from the chip before every write.
   
 - clear/set register based, where a bit written to one of the
   registers either clears or sets the interrupt mask.

There are more patterns, but for now I restricted the patches on those
two.

The core code provides now a generic irq chip mechanism which
dynamically allocates the data structures. The chip assumes that the
interrupt hardware is using 32bit wide registers. For each interrupt
bank (32 irqs) a separate chip is allocated and configured. If
possible the generic callbacks for mask/unmask/ack/eoi are used. There
is also a generic version for irq_set_wake, which just caches the
wakeup sources in the chip data structure to replace home brewn
caching mechanisms.

The core code has new callbacks irq_suspend/irq_resume as well, which
can be used to replace the sys device implementations for the various
irq chips.

I converted and cleaned up a bunch of irq chip implementations in
arch/arm to see whether this works out as intended.

Note, that this is mostly compile tested only, but I'd like to get
some feedback on that before going further. There is more room for
consolidation (especially a bunch of slightly different VIC copies
poked my eyes).

The core code adds about 500 lines, but it's massivly commented. The
binary size with all functionality compiled in is about 1500 bytes
which could be reduced with some ifdeffery, but it's probably not
worth the mess.

The diffstat for the arm part is:

 arch/arm/mach-msm/irq.c                                      |  151 ----
 linux-2.6/arch/arm/common/sa1111.c                           |  193 ------
 linux-2.6/arch/arm/common/vic.c                              |  262 +-------
 linux-2.6/arch/arm/mach-bcmring/irq.c                        |   98 ---
 linux-2.6/arch/arm/mach-davinci/irq.c                        |   90 --
 linux-2.6/arch/arm/mach-msm/Kconfig                          |    1 
 linux-2.6/arch/arm/mach-msm/Makefile                         |    2 
 linux-2.6/arch/arm/mach-msm/include/mach/irqs.h              |    3 
 linux-2.6/arch/arm/mach-msm/include/mach/sirc.h              |   43 -
 linux-2.6/arch/arm/mach-msm/irq-vic.c                        |  344 +----------
 linux-2.6/arch/arm/mach-msm/sirc.c                           |  172 +----
 linux-2.6/arch/arm/mach-pxa/irq.c                            |  192 ++----
 linux-2.6/arch/arm/mach-s3c64xx/irq.c                        |    7 
 linux-2.6/arch/arm/mach-tcc8k/irq.c                          |   83 --
 linux-2.6/arch/arm/plat-orion/gpio.c                         |  110 +--
 linux-2.6/arch/arm/plat-orion/include/plat/gpio.h            |    1 
 linux-2.6/arch/arm/plat-orion/irq.c                          |   49 -
 linux-2.6/arch/arm/plat-s5p/irq-gpioint.c                    |  115 ---
 linux-2.6/arch/arm/plat-s5p/irq.c                            |    6 
 linux-2.6/arch/arm/plat-samsung/include/plat/irq-vic-timer.h |    2 
 linux-2.6/arch/arm/plat-samsung/irq-uart.c                   |   82 --
 linux-2.6/arch/arm/plat-samsung/irq-vic-timer.c              |   73 --
 22 files changed, 455 insertions(+), 1624 deletions(-)

That converts 18 irq_chips and removes at least one duplicated VIC
implementation.

Please have a look and check also the not yet converted chips whether
they could make use of such an generic implementation. We better have
some oddball callback functions in the generic code than ten slightly
different instances of them all over the place.

Thanks,

	tglx
