From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 17 Jul 2013 09:19:25 +0300
Subject: sched_clock always 0 and no process time accounting with 3.11-rc1
In-Reply-To: <CAMo8BfLO31GgMMA_hENr0xm=qaUz3EVLtaQ8hewiQHdbV+s6sA@mail.gmail.com>
References: <CAMo8BfLO31GgMMA_hENr0xm=qaUz3EVLtaQ8hewiQHdbV+s6sA@mail.gmail.com>
Message-ID: <20130717061925.GC6950@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Max,

On Mon, Jul 15, 2013 at 06:18:33PM +0400, Max Filippov wrote:
> with 3.11-rc1 printk timestamps are always zero (which means that
> sched_clock is always 0) and process time accounting always shows
> 0 for system/user time. I see it regardless of HZ_PERIODIC/NO_HZ_IDLE
> and HIGH_RES_TIMERS settings. Am I missing any necessary config
> options? Can you see the same issue?

The following patch fixes the issue for me:

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index a326f27..0b479a6 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -121,7 +121,7 @@ void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
 	BUG_ON(bits > 32);
 	WARN_ON(!irqs_disabled());
 	read_sched_clock = read;
-	sched_clock_mask = (1 << bits) - 1;
+	sched_clock_mask = (1ULL << bits) - 1;
 	cd.rate = rate;
 
 	/* calculate the mult/shift to convert counter ticks to ns. */

Apparently the expression '(1 << 32)' evaluates to 1 on xtensa cross gcc, and 
x86_84 native gcc. According to my limited understanding, the C compiler is 
allowed to do so. This caused sched_clock_32() to return constant 0. I wonder 
how it didn't bite the ARM people who are using this code from quite some time 
(added LAKL to CC).

If this patch proves correct I'll send a formal patch to the timekeeping 
maintainers.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
