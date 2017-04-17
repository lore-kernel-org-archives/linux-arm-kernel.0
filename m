From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 17 Apr 2017 11:46:27 -0600
Subject: [PATCH] coresight: etm_perf: Fix using uninitialised work
In-Reply-To: <CAJ9a7VhXVAeMR_KAtqST0HpUczk6COWfWCupBYD=7Bg0aXbKQA@mail.gmail.com>
References: <1490984331-12231-1-git-send-email-suzuki.poulose@arm.com>
 <CAJ9a7VhXVAeMR_KAtqST0HpUczk6COWfWCupBYD=7Bg0aXbKQA@mail.gmail.com>
Message-ID: <20170417174627.GB4633@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 07, 2017 at 03:48:10PM +0100, Mike Leach wrote:
> Tested against the 4.11-rc1 OpenCSD perf tree - reproduced the problem
> and confirmed the patch fixes it on Juno r1.
> Noted that the command line
> ./perf record -e cs_etm/@20010000.etf/ uname
> also causes the same problem,
> 
> Larger question that may need future investigation in the openCSD
> project is why the sink provided in the perf command line is not being
> enabled?

The above command defines a per-cpu event rather than a per-thread event.  This
has the same effect as using the -C option to define a specific set of CPUs to
trace on.

Once upon a time we fixed the enable_sink flag issue by flipping it back to
false when the configuration has been recorded.  That works well when working
with a per-thread scenario because a single event with cpu == -1 is sent down to
the kernel.  

When working with a per-cpu scenario an event is generated for each CPU that is
present in the system.  When the driver receives the first event for CPU0 it
records the sink and flip the sysfs enable_sink flag back, so when events for
the other CPUs are received no sink is selected (as it was just flipped back)
and the whole thing fails.

Fixing this won't be easy.  I looked at the problem before and the only solution
(at least that I could see) was to send down the sink information to the kernel
with each event that is received.  That way any event is independent from the
other and we don't need to play with the sysfs enable_sink flag in the kernel
anymore.

That approach was rejected because of the way event attributes are communicated
to the kernel as part of the system call.  We will have the same problem when we
enhance the solution to support one sink per tracer so I have to start working
on this.

In the mean time I have applied Suzuki's patch as it fix a real problem.

Thanks,
Mathieu

> 
> Regards
> 
> Mike
> 
> On 31 March 2017 at 19:18, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> > With 4.11-rc4, the following command triggers a WARN_ON,
> > when a sink is not enabled.
> >
> >  perf record -e cs_etm/@20010000.etf/
> >
> >  [88286.547741] ------------[ cut here ]------------
> >  [88286.552332] WARNING: CPU: 3 PID: 2156 at kernel/workqueue.c:1442 __queue_work+0x29c/0x3b8
> >  [88286.560427] Modules linked in:
> >  [88286.563451]
> >  [88286.564928] CPU: 3 PID: 2156 Comm: perf_v4.11 Not tainted 4.11.0-rc4 #217
> >  [88286.573453] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Aug 15
> >   2016
> >  [88286.584128] task: ffff80097597c200 task.stack: ffff8009768b0000
> >  [88286.589990] PC is at __queue_work+0x29c/0x3b8
> >  [88286.594303] LR is at __queue_work+0x104/0x3b8
> >  [88286.598614] pc : [<ffff0000080d8c7c>] lr : [<ffff0000080d8ae4>] pstate: a00001c5
> >  [88286.605934] sp : ffff8009768b3aa0
> >  [88286.609212] x29: ffff8009768b3aa0 x28: ffff80097ff3da00
> >  [88286.614477] x27: ffff80097ff89c00 x26: ffff8009751b0e00
> >  [88286.619741] x25: ffff000008c9f000 x24: 0000000000000003
> >  [88286.625004] x23: 0000000000000040 x22: ffff000008d3dab8
> >  [88286.630268] x21: ffff800977804400 x20: 0000000000000007
> >  [88286.635532] x19: ffff000008c54000 x18: 0000fffff9185160
> >  [88286.640795] x17: 0000ffffb33d9a38 x16: ffff000008088270
> >  [88286.646059] x15: 0000ffffb345b590 x14: 0000000000000000
> >  [88286.651322] x13: 0000000000000004 x12: 0000000000000040
> >  [88286.656586] x11: 0000000000000068 x10: 0000000000000000
> >  [88286.661849] x9 : ffff800977400028 x8 : 0000000000000000
> >  [88286.667113] x7 : 0000000000000000 x6 : ffff0000080d8ae4
> >  [88286.672376] x5 : 0000000000000000 x4 : 0000000000000080
> >  [88286.677639] x3 : 0000000000000000 x2 : 0000000000000000
> >  [88286.682903] x1 : 0000000000000000 x0 : ffff8009751b0e08
> >  [88286.688166]
> >  [88286.689638] ---[ end trace 31633f18fd33d4cb ]---
> >  [88286.694206] Call trace:
> >  [88286.696627] Exception stack(0xffff8009768b38d0 to 0xffff8009768b3a00)
> >  [88286.703004] 38c0:                                   ffff000008c54000 0001000000000000
> >  [88286.710757] 38e0: ffff8009768b3aa0 ffff0000080d8c7c ffff8009768b3b50 ffff80097ff8a5b0
> >  [88286.718511] 3900: 0000800977325000 0000000000000000 0000000000000040 ffff80097ffc6180
> >  [88286.726264] 3920: ffff8009768b3940 ffff0000088a8694 ffff80097ffc5800 0000000000000000
> >  [88286.734017] 3940: ffff8009768b3960 ffff0000081919c0 ffff80097ffc5280 0000000000000001
> >  [88286.741771] 3960: ffff8009768b3a50 ffff00000819206c ffff8009751b0e08 0000000000000000
> >  [88286.749523] 3980: 0000000000000000 0000000000000000 0000000000000080 0000000000000000
> >  [88286.757277] 39a0: ffff0000080d8ae4 0000000000000000 0000000000000000 ffff800977400028
> >  [88286.765029] 39c0: 0000000000000000 0000000000000068 0000000000000040 0000000000000004
> >  [88286.772783] 39e0: 0000000000000000 0000ffffb345b590 ffff000008088270 0000ffffb33d9a38
> >  [88286.780537] [<ffff0000080d8c7c>] __queue_work+0x29c/0x3b8
> >  [88286.785883] [<ffff0000080d8df8>] queue_work_on+0x60/0x78
> >  [88286.791146] [<ffff000008764c68>] etm_setup_aux+0x178/0x238
> >  [88286.796578] [<ffff000008183600>] rb_alloc_aux+0x228/0x310
> >  [88286.801925] [<ffff00000817e564>] perf_mmap+0x404/0x5a8
> >  [88286.807015] [<ffff0000081c60cc>] mmap_region+0x394/0x5c0
> >  [88286.812276] [<ffff0000081c654c>] do_mmap+0x254/0x388
> >  [88286.817191] [<ffff0000081a989c>] vm_mmap_pgoff+0xbc/0xe0
> >  [88286.822452] [<ffff0000081c3ffc>] SyS_mmap_pgoff+0xac/0x228
> >  [88286.827884] [<ffff000008088288>] sys_mmap+0x18/0x28
> >  [88286.832714] [<ffff000008082f30>] el0_svc_naked+0x24/0x28
> >
> > The patch makes sure that the event_data->work is initialised
> > properly before we could possibly use it.
> >
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >  drivers/hwtracing/coresight/coresight-etm-perf.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index 26cfac3..df63315 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -201,6 +201,7 @@ static void *etm_setup_aux(int event_cpu, void **pages,
> >         event_data = alloc_event_data(event_cpu);
> >         if (!event_data)
> >                 return NULL;
> > +       INIT_WORK(&event_data->work, free_event_data);
> >
> >         /*
> >          * In theory nothing prevent tracers in a trace session from being
> > @@ -217,8 +218,6 @@ static void *etm_setup_aux(int event_cpu, void **pages,
> >         if (!sink)
> >                 goto err;
> >
> > -       INIT_WORK(&event_data->work, free_event_data);
> > -
> >         mask = &event_data->mask;
> >
> >         /* Setup the path for each CPU in a trace session */
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Blackburn Design Centre. UK
