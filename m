From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Nov 2017 18:16:29 +0000
Subject: v4.14-rc{4,7} null pointer dereference in event_sched_out()
In-Reply-To: <20171124181056.vhpjuucr3kewrj2v@lakrids.cambridge.arm.com>
References: <20171030162314.yxi2fyli6omtphvw@lakrids.cambridge.arm.com>
 <20171115180019.GO19071@arm.com>
 <20171124181056.vhpjuucr3kewrj2v@lakrids.cambridge.arm.com>
Message-ID: <20171124181629.tjvjuhqlr2bm5bqh@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 06:10:56PM +0000, Mark Rutland wrote:
> On Wed, Nov 15, 2017 at 06:00:20PM +0000, Will Deacon wrote:
> > On Mon, Oct 30, 2017 at 04:23:15PM +0000, Mark Rutland wrote:
> > > As a heads-up, while fuzzing arm64 v4.14-rc{4,7} with Syzkaller, I hit a
> > > KASAN splat in event_sched_out():
> > Did you get anywhere with this?
> 
> I got a *bit* further, but I haven't figured out the underlying issue
> yet.

Forgot to mention, the above all applies to a vanilla v4.14 arm64
kernel; defconfig + KASAN_INLINE.

Thanks,
Mark.

> 
> I minimized the reproducer down to the following:
> 
> ----
> # {Threaded:true Collide:true Repeat:true Procs:1 Sandbox:none Fault:false FaultCall:-1 FaultNth:0 EnableTun:true UseTmpDir:true HandleSegv:true WaitRepeat:true Debug:false Repro:false}
> 
> r2 = gettid()
> mmap(&(0x7f0000000000/0xd3f000)=nil, 0xd3f000, 0x3, 0x32, 0xffffffffffffffff, 0x0)
> r0 = perf_event_open(&(0x7f0000d15000-0x78)={0x1, 0x78, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x9, 0x30, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, r2, 0xffffffff, 0xffffffffffffffff, 0x0)
> mmap(&(0x7f0000d3f000/0x1000)=nil, 0x1000, 0x3, 0x32, 0xffffffffffffffff, 0x0)
> r1 = perf_event_open(&(0x7f0000d15000-0x78)={0x1, 0x78, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x30, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, r2, 0xffffffff, r0, 0x0)
> dup3(0, 0, 0)
> perf_event_open(&(0x7f0000b13000-0x78)={0x0, 0x78, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x30, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, r2, 0xffffffff, r0, 0x0)
> ----
> 
> Note: the dup3() is an expensive NOP (since oldfd == newfd), but I think
> it's triggering an interesting scheduling pattern, since thus far I
> haven't managed to trigger the bug without it.
> 
> That creates a perf_cpu_clock event, adds another to that group, and
> adds a HW event to that same group. In parallel.
> 
> Sometimes at the point the HW event is added, the leading SW event is in
> PERF_EVENT_STATE_INACTIVE, but the follower SW event is in
> PERF_EVENT_STATE_ACTIVE. The context both are held in is inactive, so
> the follower event's state makes no sense.
> 
> I added a dump to event_sched_out() that catches this:
> 
> [   35.995144] Uh-oh:
> [   35.995144]   event ffff800039a1f880
> [   35.995144]   event->state 1
> [   35.995144]   event->cpu -1
> [   35.995144]   pmu ffff20000a3b2600 (perf_cpu_clock, AKA (null))
> [   35.995144]   leader ffff800039a1a480
> [   35.995144]   leader->state -1
> [   35.995144]   pmu ffff20000a3b2600 (perf_cpu_clock, AKA (null))
> [   35.995144]   ctx ffff80003932e180, pmu ffff20000a3b2600 (perf_cpu_clock AKA (null))
> 
> I'll try to dig into this a bit more next week.
> 
> I can't reproduce this with Syzkaller running in a single thread, nor
> with some multi-threaded tests I wrote in C, so I guess there's a subtle
> race I'm not managing to hit.
> 
> Thanks,
> Mark.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
