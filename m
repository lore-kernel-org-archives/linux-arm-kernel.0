From: john.stultz@linaro.org (John Stultz)
Date: Thu,  9 May 2013 17:10:48 -0700
Subject: [PATCH 0/3] ARM: KDB FIQ debugger
Message-ID: <1368144651-11250-1-git-send-email-john.stultz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey all,
	Just wanted to try to revive Anton's KDB FIQ patches
which have been sent out a number of times since last October
and have gotten almost no response at all.

I've simply updated them to apply to Linus' current HEAD,
and figured I'd send them out again to try to spur some
interest.

Any feedback would be appreciated!

thanks
-john

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


Cc: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: kernel-team at android.com


Anton Vorontsov (3):
  ARM: Move some macros from entry-armv to entry-header
  ARM: Add KGDB/KDB FIQ debugger generic code
  ARM: versatile: Make able to use UART ports for KGDB FIQ debugger

 arch/arm/Kconfig                   |  19 +++++
 arch/arm/include/asm/kgdb.h        |   7 ++
 arch/arm/kernel/Makefile           |   1 +
 arch/arm/kernel/entry-armv.S       | 169 +-----------------------------------
 arch/arm/kernel/entry-header.S     | 171 +++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/kgdb_fiq.c         | 118 +++++++++++++++++++++++++
 arch/arm/kernel/kgdb_fiq_entry.S   |  87 +++++++++++++++++++
 arch/arm/mach-versatile/Makefile   |   1 +
 arch/arm/mach-versatile/kgdb_fiq.c |  55 ++++++++++++
 9 files changed, 460 insertions(+), 168 deletions(-)
 create mode 100644 arch/arm/kernel/kgdb_fiq.c
 create mode 100644 arch/arm/kernel/kgdb_fiq_entry.S
 create mode 100644 arch/arm/mach-versatile/kgdb_fiq.c

-- 
1.8.1.2
