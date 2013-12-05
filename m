From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 5 Dec 2013 21:18:13 +0100
Subject: [PATCH 0/12] Getting rid of mach/timex.h usages below arch/arm
In-Reply-To: <1384292466-31725-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1384292466-31725-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131205201813.GA4707@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

short version: I still need acks from akpm and Nicolas Ferre for my
cleanup series.

long version:

codewise I'm happy with my series now. The last patch removes all
remaining <mach/timex.h> files and even drops the global (dummy)
definition of CLOCK_TICK_RATE.

The following patches are included:

Linus Walleij (1):
( 1)      ARM/serial: at91: switch atmel serial to use gpiolib

Uwe Kleine-K?nig (11):
( 2)      rtc: at91sam9: include <mach/hardware.h> explicitly
( 3)      rtc: pxa: drop usage of CLOCK_TICK_RATE
( 4)      clocksource: sirf/marco+prima2: drop usage of CLOCK_TICK_RATE
( 5)      ARM: sa1100: stop using mach/timex.h
( 6)      ARM: netx: stop using mach/timex.h
( 7)      ARM: mmp: stop using mach/timex.h
( 8)      ARM: ep93xx: stop using mach/timex.h
( 9)      ARM: at91: don't use <mach/timex.h>
(10)      input: ixp4xx-beeper: don't use symbols from <mach/timex.h>
(11)      ARM: ixp4xx: stop using <mach/timex.h>
(12)      ARM: drop <mach/timex.h> for !ARCH_MULTIPLATFORM, too

The things still open from my side are:

 - I don't have an explicit blessing from Nicolas Ferre to take patch 1
   in this series
 - For the rtc patches (2, 3) I don't have an rtc maintainer ack, patch
   2 is already in next-20131125 (commit:6a3f18c5874e, branch
   akpm-current/current) and also later next releases. I asked Andrew
   for his blessing to take the two patches, no reply yet.
 - I didn't get feedback for the sa1100 and ixp4xx patch (5, 11). I
   think this isn't a big problem though because these are in the area
   of the arm-soc maintainers.

The series is available from

	git://git.pengutronix.de/git/ukl/linux.git deprecatemachtimexh

and has the nice shortstat

	73 files changed, 129 insertions(+), 722 deletions(-)

. The only patch not yet sent out as it is now is patch 12. It's just
diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
index 83f2aa8..f6fcc67 100644
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -12,12 +12,6 @@
 #ifndef _ASMARM_TIMEX_H
 #define _ASMARM_TIMEX_H
 
-#ifdef CONFIG_ARCH_MULTIPLATFORM
-#define CLOCK_TICK_RATE 1000000
-#else
-#include <mach/timex.h>
-#endif
-
 typedef unsigned long cycles_t;
 #define get_cycles()   ({ cycles_t c; read_current_timer(&c) ? 0 : c; })
 
plus rm arch/arm/mach-*/include/mach/timex.h. I'll send it out in reply
to this mail.

Merging next/master into my branch results in 4 conflicts in
arch/arm/mach-at91/at91sam9{26[013],rl}.c. This is commit 2edb90a (ARM:
at91: move at91_pmc.h to include/linux/clk/at91_pmc.h) in
armsoc/at91/sama5-ccf vs. my patch "ARM: at91: don't use <mach/timex.h>"
(9). The former removes

	#include <mach/at91_pmc.h>

at the location where my patch adds

	#include <mach/hardware.h>

. The fix is to do exactly this. Olof already agreed on irc that he is
OK to resolve that when merging.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
