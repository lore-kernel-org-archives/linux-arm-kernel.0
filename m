From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Apr 2013 17:27:20 -0700
Subject: [GIT PULL] Timer clean-ups for 3.10, Part 2
In-Reply-To: <516720B4.3000703@gmail.com>
References: <516720B4.3000703@gmail.com>
Message-ID: <516DEC68.8030101@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/13 13:44, Rob Herring wrote:
>
> Rob Herring (13):
>       ARM: sched_clock: allow changing to higher frequency counter
>       ARM: make sched_clock just call a function pointer
>       ARM: arch_timer: use full 64-bit counter for sched_clock

If I leave my system in the bootloader for a while this seems to cause
my sched_clock timestamps to jump once the sched_clock is setup. It also
sets up a sched_clock twice because read_sched_clock ==
jiffy_sched_clock_read.

[    0.000000] Switching to timer-based delay loop
[    0.000000] sched_clock: ARM arch timer >56 bits at 19200kHz,
resolution 52ns
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns,
wraps every 4294967286ms
[    0.000000] Console: colour dummy device 80x30
[16645.193054] Calibrating delay loop (skipped), value calculated using
timer frequency.. 38.40 BogoMIPS (lpj=192000)

I suspect it's because we don't do any cyc_to_sched_clock() stuff in the
arm architected timer case. Instead we just return the value from the
counter when we really should do some sort of subtraction from the first
value we read.

I'm also curious how this is going to work for suspend/resume because it
doesn't look like we're going to stop sched_clock on arm architected
timer systems. See 6a4dae5e138a3 (ARM: 7565/1: sched: stop sched_clock()
during suspend, 2012-10-23) for why we need to do this.

Finally, looks like this is unused now...

---8<----

diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 8805848..48ab64a 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -24,7 +24,6 @@ struct clock_data {
        u32 mult;
        u32 shift;
        bool suspended;
-       bool needs_suspend;
 };
 
 static void sched_clock_poll(unsigned long wrap_ticks);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
