From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 2 Mar 2017 17:21:49 -0600
Subject: ARM64 perf stacktraces on tracepoint events
In-Reply-To: <20170302104349.GA19632@leverpostej>
References: <CAEi0qNm3NKSWQOD6A2Z0NTNEfp1kLNEZz-=y+dbVCwYMP0HFoQ@mail.gmail.com>
 <20170302104349.GA19632@leverpostej>
Message-ID: <20170302172149.168b430ff75d63adfe9ab389@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Mar 2017 10:44:11 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> [Adding James, Takahiro-san, and Will, for stacktracing and arm64 perf]
> 
> On Wed, Mar 01, 2017 at 04:42:17PM -0800, Joel Fernandes wrote:
> > Hi,
> > 
> > On 3.18 kernel running on an arm64 device, I tried running:
> > perf record -a -g -e sched:sched_wakeup
> > 
> > I was expecting something like the output at:
> > www.brendangregg.com/perf.html
> > 
> > But I don't see stacktraces, could I be missing any patches you could
> > point me to?
> 
> I can't spot much obvious, looking at arm64's stacktrace.c and perf_callchain.c
> since v3.18. There's commit:
> 
>   9702970c7bd3e2d6 (Revert "ARM64: unwind: Fix PC calculation")
> 
> ... though that was Cc'd stable.
> 
> I can't immediately see why that would truncate unwinding, though I'm also not
> sure how perf and ftrace interact here, so I may be missing something obvious.
> 
> > I do see stack traces if I do regular perf profiling
> > (perf record -F 99 -a -g).
> 
> > Below is the output I get. Thanks for any insight into this.
> > 
> > Regards,
> > Joel
> > 
> > sailfish:/data # ./perf report
> >        # Samples: 22  of event 'sched:sched_wakeup'
> > # Event count (approx.): 410333
> > #
> > # Children      Self  Trace output
> > # ........  ........
> > .............................................................
> > #
> >     61.29%    61.29%  comm=ksoftirqd/0 pid=3 prio=120 success=1 target_cpu=000
> >             |
> >             ---0
> > 
> >     33.25%    33.25%  comm=hw pid=12777 prio=120 success=1 target_cpu=002
> >             |
> >             ---0
> > 
> >      2.46%     2.46%  comm=kworker/u8:2 pid=12482 prio=120 success=1
> > target_cpu=002
> >             |
> >             ---0
> > 
> >      1.39%     1.39%  comm=migration/2 pid=21 prio=0 success=1 target_cpu=002
> >             |
> >             ---0
> 
> FWIW, on a recent HEAD (86292b33d4b79ee0), I see reasonable looking backtraces,
> e.g.

I cross-built the perf tool on an Ubuntu 16.10 system, after rewinding
its base linux tree to ~v4.6 (e.g., commit 8beeb00 because it precedes a
perf libunwind series), and still see reasonable output:

#
# Total Lost Samples: 0
#
# Samples: 30  of event 'sched:sched_wakeup'
# Event count (approx.): 30
#
# Children      Self  Trace output                                         
# ........  ........  .....................................................
#
    20.00%    20.00%  comm=rcu_preempt pid=7 prio=120 target_cpu=006
            |
            ---0x807f71c4
               secondary_start_kernel
               cpu_startup_entry
               do_idle
               call_cpuidle
               cpuidle_enter
               cpuidle_enter_state
               el1_irq
               gic_handle_irq
               __handle_domain_irq
               irq_exit
               __do_softirq
               |          
               |--16.67%--run_timer_softirq
               |          expire_timers
               |          call_timer_fn
               |          process_timeout
               |          wake_up_process
               |          try_to_wake_up
               |          ttwu_do_activate
               |          ttwu_do_wakeup
               |          ttwu_do_wakeup
               |          
                --3.33%--rcu_process_callbacks
                          note_gp_changes
                          rcu_gp_kthread_wake
                          swake_up
                          swake_up_locked
                          wake_up_process
                          try_to_wake_up
                          ttwu_do_activate
                          ttwu_do_wakeup
                          ttwu_do_wakeup

I tried to go even further back, e.g., v4.1-rc4-15-g10b48f7 but the
compiler wouldn't build perf any more, e.g.,:

util/event.c:416:2: error: ?readdir_r? is deprecated [-Werror=deprecated-declarations]

Is it possible to try a newer perf binary (assuming it's also 3.18
based), or check whether libunwind contains aarch64 support?  Note that
it's possible to 'perf archive' the aarch64 run and run perf report on a
more up-to-date x86 host also.

Thanks,

Kim
