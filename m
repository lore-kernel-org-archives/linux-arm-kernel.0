From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jul 2015 21:39:12 +0100
Subject: [PATCH 0/3] Shared NMI backtracing support for ARM/x86
Message-ID: <20150715203911.GF7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Back in September, I stumbled across a single CPU IRQs-off lockup of an
ARM SMP system, and decided to hack something together based on a much
older hacky implementation used with StrongARM CPUs from early 2000s.

This resulted in a copy of the x86 NMI backtrace code into ARM as it was
back then, and feedback indicated that it wasn't a good time to push
such an effort forward, as printk() in NMI context is dodgy.

Over time, the x86 code has had this problem addressed, and last week
I updated the patch which I've been carrying in my tree to move the
shared code out of arch/x86 into lib/ rather than duplicating it, and
switch the ARM implementation to use it.

Discussing this with Thomas Gliexner, he agreed to give it a test over
last weekend, and he has reported to me this evening "no explosion so
far".  Since then, I've made a change to add the NOKPROBE_SYMBOL() to
the generic handler as per the x86 original code.

I'm aware that there are other competing implementations out there -
Daniel has one based on my patch from September time, but I don't think
that goes far enough with code sharing.  I'm also partially aware of
an implementation from Petr too.

 arch/arm/include/asm/irq.h    |   5 ++
 arch/arm/kernel/smp.c         |  18 +++++
 arch/x86/kernel/apic/hw_nmi.c | 133 ++--------------------------------
 include/linux/nmi.h           |   6 ++
 lib/Makefile                  |   2 +-
 lib/nmi_backtrace.c           | 162 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 196 insertions(+), 130 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
