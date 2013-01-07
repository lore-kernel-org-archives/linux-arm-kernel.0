From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Sun, 6 Jan 2013 17:22:43 -0800
Subject: [PATCH resend 0/3] ARM: KDB FIQ debugger
Message-ID: <20130107012242.GA31052@lizard.mcd01528.sjc.wayport.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew, Russell,

Just resending this once again...

(Also rebased onto v3.8-rc2, and since there were some irqdomain changes,
I had to drop VIC changes from the series, and place the IRQ rerouting
code into the board code. But that is even better, so far we don't need it
anywhere else.)

Short description of the KDB/FIQ debugger:

 The FIQ debugger is a facility that can be used to debug situations when
 the kernel stuck in uninterruptable sections, e.g. the kernel infinitely
 loops or deadlocked in an interrupt or with interrupts disabled. On some
 development boards there is even a special NMI button, which is very
 useful for debugging weird kernel hangs.

 And FIQ is basically an NMI, it has a higher priority than IRQs, and upon
 IRQ exception FIQs are not disabled. It is still possible to disable FIQs
 (as well as some "NMIs" on other architectures), but via special means.

Old changelogs and a full rationale for these patches can be found here:

	v1-v5, rationale: http://lkml.org/lkml/2012/9/10/2
	v6: http://lkml.org/lkml/2012/9/10/2
	v7: http://lkml.org/lkml/2012/9/13/367
	v8: http://lkml.org/lkml/2012/9/19/525
	v9: http://lkml.org/lkml/2012/9/24/538

Thanks!
Anton

--
 arch/arm/Kconfig                   |  19 ++++
 arch/arm/include/asm/kgdb.h        |   7 ++
 arch/arm/kernel/Makefile           |   1 +
 arch/arm/kernel/entry-armv.S       | 167 +---------------------------
 arch/arm/kernel/entry-header.S     | 170 +++++++++++++++++++++++++++++
 arch/arm/kernel/kgdb_fiq.c         | 118 ++++++++++++++++++++
 arch/arm/kernel/kgdb_fiq_entry.S   |  87 +++++++++++++++
 arch/arm/mach-versatile/Makefile   |   1 +
 arch/arm/mach-versatile/kgdb_fiq.c |  55 ++++++++++
 9 files changed, 459 insertions(+), 166 deletions(-)
