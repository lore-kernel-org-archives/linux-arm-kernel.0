From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Thu, 22 Nov 2012 16:29:58 -0800
Subject: [PATCH resend 0/4] ARM: KDB FIQ debugger
Message-ID: <20121123002957.GA31679@lizard.mcd25758.sjc.wayport.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew, Russell,

The KDB/NMI core support has been merged into v3.7-rc1, so the only ARM
bits are pending now.

I addressed all the comments ~two month ago, and since then just resending
these patches. I know we're all busy, so no blaming. :) But then let's
pass this via -mm?

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
Anton.

--
 arch/arm/Kconfig                    |  19 ++++
 arch/arm/common/vic.c               |  28 +++++
 arch/arm/include/asm/hardware/vic.h |   2 +
 arch/arm/include/asm/kgdb.h         |   8 ++
 arch/arm/kernel/Makefile            |   1 +
 arch/arm/kernel/entry-armv.S        | 167 +--------------------------
 arch/arm/kernel/entry-header.S      | 170 ++++++++++++++++++++++++++++
 arch/arm/kernel/kgdb_fiq.c          | 124 ++++++++++++++++++++
 arch/arm/kernel/kgdb_fiq_entry.S    |  87 ++++++++++++++
 arch/arm/mach-versatile/Makefile    |   1 +
 arch/arm/mach-versatile/kgdb_fiq.c  |  31 +++++
 11 files changed, 472 insertions(+), 166 deletions(-)
