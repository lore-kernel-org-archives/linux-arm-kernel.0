From: wpdster@gmail.com (Patrick Doyle)
Date: Tue, 30 May 2017 09:51:50 -0400
Subject: Fine grain process accounting
Message-ID: <CAF_dkJAOS+YHs9aFAokOr0xQWA6ZqNCT8NivjFY2B6R=UwW7yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am looking for pointers as to which kernel config options I should
enable to support fine grain process accounting on my Cortex-AT
(SAMA5D2x) processor.

I know that, under normal conditions (CONFIG_TICK_CPU_ACCOUNTING),
that user, system, and idle time are recorded with a "per jiffies
granularity".

I would like to know if it is possible to better than this.  It seems
like CONFIG_VIRT_CPU_ACCOUNTING_GEN and CONFIG_IRQ_TIME_ACCOUNTING
should provide the capability that I want, but I don't see evidence of
that in my testing.

Here is what I want:
The kernel should maintain a high resolution counter (I already know
that it does, since I can request times with sub 1ms precision via
clock_gettime()).  When a (real time) thread blocks waiting on a
timeout, I/O, or a mutex, the scheduler should record the time it
spent running that thread (according to the high resolution timer) in
the the thread accounting statistics, and schedule the next thread.

It seems to me, based on my admittedly pathological test case, that
this is not true.  It seems that the CPU accounting for my thread is
still based on the jiffies (timer tick) counter.

My pathological test case looks a lot like a thread that does this:

while (1) {
  compute()
  sleep()
}

where I can configure the amount of time spent in compute() (a for
loop, which I have manually profiled to know used 4 cycles per
iteration).  If I run this test case such that I use .9ms of each 1ms
timer tick interval, I see a CPU utilization of 1 or 2% instead of
90%.

What else should I enable in order to see the 90% CPU utilization in
this test case?

Any thoughts?

Thanks.

--wpd
