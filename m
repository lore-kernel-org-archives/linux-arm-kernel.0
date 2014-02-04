From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Feb 2014 18:36:41 +0000
Subject: Weird sched_clock behaviour during boot with -rc1
Message-ID: <20140204183641.GA25127@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

Booting -rc1 on my TC2 gives the following strange entries in the dmesg:


  Uncompressing Linux... done, booting the kernel.
  [    0.000000] Booting Linux on physical CPU 0x0

  [...]

  [    0.000000]   HighMem zone: 329728 pages, LIFO batch:31
  [    7.789662] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956969942ns
  [    0.000129] PERCPU: Embedded 9 pages/cpu @ee7bd000 s12800 r8192 d15872 u36864

  [...]

  [    0.868297] NR_IRQS:16 nr_irqs:16 16
  [    0.886350] Architected cp15 timer(s) running at 24.00MHz (phys).
  [ 2915.164998] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 2863311519744ns
  [    0.000002] Switching to timer-based delay loop
  [    0.014249] Console: colour dummy device 80x30


so it looks like something whacky goes on during sched_clock registration.
Sure enough, we're doing a pr_info in-between updating cs.* and calling
update_sched_clock(), so moving the print sorts things out (diff below).

What I can't figure out is why this has suddenly started happening with
3.14. Any ideas?

Cheers,

Will

--->8

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 0abb36464281..f3de5d113afc 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -147,9 +147,6 @@ void __init sched_clock_register(u64 (*read)(void), int bits,
 
        /* calculate the ns resolution of this counter */
        res = cyc_to_ns(1ULL, cd.mult, cd.shift);
-       pr_info("sched_clock: %u bits at %lu%cHz, resolution %lluns, wraps every %lluns\n",
-               bits, r, r_unit, res, wrap);
-
        update_sched_clock();
 
        /*
@@ -161,6 +158,9 @@ void __init sched_clock_register(u64 (*read)(void), int bits,
        if (irqtime > 0 || (irqtime == -1 && rate >= 1000000))
                enable_sched_clock_irqtime();
 
+       pr_info("sched_clock: %u bits at %lu%cHz, resolution %lluns, wraps every %lluns\n",
+               bits, r, r_unit, res, wrap);
+
        pr_debug("Registered %pF as sched_clock source\n", read);
 }
