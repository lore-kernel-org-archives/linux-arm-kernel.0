From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Feb 2012 13:15:36 +0000
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CAMsRxfJH+9MS=Svmh0BvDSb8xqsPe2HPobkeKcn8JO35npjhwQ@mail.gmail.com>
References: <1328578047.1724.17.camel@dave-Dell-System-XPS-L502X>
 <CAMQu2gwfo5JXAqQaLUNs7C7J3TUhEO2zOcyD0Rk-D_O61Yrfag@mail.gmail.com>
 <CAMsRxfLNBbQO5XF+EHJqNsnW+s=ay3mjSV5dh=sxdwzktUu03g@mail.gmail.com>
 <CAMQu2gzfNAwtf1c6jrTZpfGMSqBgBrQKmFTeCFzbvMh9ESBDUg@mail.gmail.com>
 <CAMsRxfKR1ODH56BtcUT5Dv6qOVEYGVheEcW9ugXsZmLKok==bg@mail.gmail.com>
 <CAMQu2gwWt6oQPjxc1YHgOoxVkHdck_q78Xf==7ncwRj0_uS-JQ@mail.gmail.com>
 <CAMQu2gyCPtbNfBa5V8ve2JORN+sDeAY+hvR0g0_9U354JgcuiA@mail.gmail.com>
 <CAMsRxfJVEgVJoHcaPQbMg5mwz=tZUce4oibDUxtnevSF8bGY9g@mail.gmail.com>
 <CAMQu2gxVUqDF2HkPD=QeX0N_tUd=9FTd+T+1LHCR0tsCgQxC8Q@mail.gmail.com>
 <CAMsRxfJH+9MS=Svmh0BvDSb8xqsPe2HPobkeKcn8JO35npjhwQ@mail.gmail.com>
Message-ID: <20120213131536.GC5893@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephane,

On Tue, Feb 07, 2012 at 11:59:21AM +0000, stephane eranian wrote:
> An easier way to verify we're getting the right number of samples is
> to use perf top:
> 
> $ taskset -c 1 noploop 1000 &
> $ sudo perf top
> 
> You'll see around 850 irqs/sec, should be closer to 1000.
> But if I drop the rate to 100Hz, then it works:
> 
> $ sudo perf top -F 100
> 
> That leads me to believe there is too much overhead somewhere.
> Could be in perf_event itself.
> 
> Will, do you get 1000 irsq/sec running the same test on your systems?

I finally got around to testing this and yes, the perf top invocation above
yields ~1005 interrupts/second on my board.

However, with -rc3 I get a WARNING in dmesg due to PERF_EF_RELOAD being
set on an event that's not PERF_HES_UPTODATE:


[   52.907666] ------------[ cut here ]------------
[   52.921530] WARNING: at arch/arm/kernel/perf_event.c:251 armpmu_start+0x74/0x80()
[   52.943986] [<c00137e4>] (unwind_backtrace+0x0/0xf8) from [<c001ebd0>] (warn_slowpath_common+0x50/0x60)
[   52.972157] [<c001ebd0>] (warn_slowpath_common+0x50/0x60) from [<c001ec94>] (warn_slowpath_null+0x1c/0x24)
[   53.001105] [<c001ec94>] (warn_slowpath_null+0x1c/0x24) from [<c0015f44>] (armpmu_start+0x74/0x80)
[   53.027975] [<c0015f44>] (armpmu_start+0x74/0x80) from [<c007eb0c>] (perf_adjust_freq_unthr_context+0x140/0x194)
[   53.058487] [<c007eb0c>] (perf_adjust_freq_unthr_context+0x140/0x194) from [<c007ed20>] (perf_event_task_tick+0x1c0/0x290)
[   53.091609] [<c007ed20>] (perf_event_task_tick+0x1c0/0x290) from [<c00446bc>] (scheduler_tick+0xf0/0x12c)
[   53.120308] [<c00446bc>] (scheduler_tick+0xf0/0x12c) from [<c002b3c8>] (update_process_times+0x60/0x6c)
[   53.148475] [<c002b3c8>] (update_process_times+0x60/0x6c) from [<c00586f4>] (tick_sched_timer+0x94/0xd8)
[   53.176913] [<c00586f4>] (tick_sched_timer+0x94/0xd8) from [<c003d220>] (__run_hrtimer.clone.28+0x44/0xf8)
[   53.205869] [<c003d220>] (__run_hrtimer.clone.28+0x44/0xf8) from [<c003ded8>] (hrtimer_interrupt+0xf0/0x274)
[   53.235338] [<c003ded8>] (hrtimer_interrupt+0xf0/0x274) from [<c0012e8c>] (twd_handler+0x34/0x44)
[   53.261954] [<c0012e8c>] (twd_handler+0x34/0x44) from [<c006de54>] (handle_percpu_devid_irq+0x88/0xa0)
[   53.289861] [<c006de54>] (handle_percpu_devid_irq+0x88/0xa0) from [<c006aad8>] (generic_handle_irq+0x20/0x30)
[   53.319601] [<c006aad8>] (generic_handle_irq+0x20/0x30) from [<c000e864>] (handle_IRQ+0x58/0xac)
[   53.345943] [<c000e864>] (handle_IRQ+0x58/0xac) from [<c0008520>] (gic_handle_irq+0x2c/0xac)
[   53.371243] [<c0008520>] (gic_handle_irq+0x2c/0xac) from [<c000dbc0>] (__irq_svc+0x40/0x70)
[   53.396270] Exception stack(0xc04b1f68 to 0xc04b1fb0)
[   53.411405] 1f60:                   00000001 200f0093 c04b1fb0 00000000 c04b0000 c04d2348
[   53.435919] 1f80: c04b2454 c03a5ae8 c04b5db0 410fc091 00000000 00000000 0094e000 c04b1fb0
[   53.460427] 1fa0: c000eac8 c000eacc 600f0013 ffffffff
[   53.475571] [<c000dbc0>] (__irq_svc+0x40/0x70) from [<c000eacc>] (default_idle+0x24/0x28)
[   53.500090] [<c000eacc>] (default_idle+0x24/0x28) from [<c000ec94>] (cpu_idle+0xd4/0x108)
[   53.524611] [<c000ec94>] (cpu_idle+0xd4/0x108) from [<c0487790>] (start_kernel+0x2a4/0x2b0)
[   53.549638] ---[ end trace 1b75b31a2719ed1e ]---


Reverting your throttling fix - e050e3f0 ("perf: Fix broken interrupt rate
throttling") makes the problem disappear.

Will
