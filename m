From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Mar 2017 10:44:11 +0000
Subject: ARM64 perf stacktraces on tracepoint events
In-Reply-To: <CAEi0qNm3NKSWQOD6A2Z0NTNEfp1kLNEZz-=y+dbVCwYMP0HFoQ@mail.gmail.com>
References: <CAEi0qNm3NKSWQOD6A2Z0NTNEfp1kLNEZz-=y+dbVCwYMP0HFoQ@mail.gmail.com>
Message-ID: <20170302104349.GA19632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding James, Takahiro-san, and Will, for stacktracing and arm64 perf]

On Wed, Mar 01, 2017 at 04:42:17PM -0800, Joel Fernandes wrote:
> Hi,
> 
> On 3.18 kernel running on an arm64 device, I tried running:
> perf record -a -g -e sched:sched_wakeup
> 
> I was expecting something like the output at:
> www.brendangregg.com/perf.html
> 
> But I don't see stacktraces, could I be missing any patches you could
> point me to?

I can't spot much obvious, looking at arm64's stacktrace.c and perf_callchain.c
since v3.18. There's commit:

  9702970c7bd3e2d6 (Revert "ARM64: unwind: Fix PC calculation")

... though that was Cc'd stable.

I can't immediately see why that would truncate unwinding, though I'm also not
sure how perf and ftrace interact here, so I may be missing something obvious.

> I do see stack traces if I do regular perf profiling
> (perf record -F 99 -a -g).

> Below is the output I get. Thanks for any insight into this.
> 
> Regards,
> Joel
> 
> sailfish:/data # ./perf report
>        # Samples: 22  of event 'sched:sched_wakeup'
> # Event count (approx.): 410333
> #
> # Children      Self  Trace output
> # ........  ........
> .............................................................
> #
>     61.29%    61.29%  comm=ksoftirqd/0 pid=3 prio=120 success=1 target_cpu=000
>             |
>             ---0
> 
>     33.25%    33.25%  comm=hw pid=12777 prio=120 success=1 target_cpu=002
>             |
>             ---0
> 
>      2.46%     2.46%  comm=kworker/u8:2 pid=12482 prio=120 success=1
> target_cpu=002
>             |
>             ---0
> 
>      1.39%     1.39%  comm=migration/2 pid=21 prio=0 success=1 target_cpu=002
>             |
>             ---0


FWIW, on a recent HEAD (86292b33d4b79ee0), I see reasonable looking backtraces,
e.g.

    77.48%     0.00%  swapper      [kernel.kallsyms]  [k] do_idle
            |
            ---do_idle
               |          
               |--68.84%--call_cpuidle
               |          cpuidle_enter
               |          cpuidle_enter_state
               |          |          
               |           --61.05%--el1_irq
               |                     gic_handle_irq
               |                     __handle_domain_irq
               |                     irq_exit
               |                     __do_softirq
               |                     |          
               |                     |--22.29%--run_timer_softirq


Thanks,
Mark.
