From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 9 Jul 2018 15:45:17 -0600
Subject: [PATCH v2 2/7] perf/core: Use ioctl to communicate driver
 configuration to kernel
In-Reply-To: <CANLsYkxkhbB3i2NP-DCyPUo7sSUNPvEsPM5MLaJOJbd6ZwLYNA@mail.gmail.com>
References: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
 <1530828827-11604-3-git-send-email-mathieu.poirier@linaro.org>
 <20180706182222.8af97a96d613c90415cb202f@arm.com>
 <CANLsYkxkhbB3i2NP-DCyPUo7sSUNPvEsPM5MLaJOJbd6ZwLYNA@mail.gmail.com>
Message-ID: <CANLsYkxdmTsi4xGrVPvYC1cDtW-ca6ETj-BK8FOTQH5RE1XELw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 Jul 2018 at 10:49, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> On Fri, 6 Jul 2018 at 17:22, Kim Phillips <kim.phillips@arm.com> wrote:
> >
> > On Thu,  5 Jul 2018 16:13:42 -0600
> > Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >
> > Hi Mathieu,
> >
> > > This patch adds the mechanic needed for user space to send PMU specific
> >                       ^^^^^^^^
> > I think you meant 'mechanism' here:  mechanics fix cars :)
>
> I really meant "mechanic", as in "functional details or procedure" [1]
>
> [1]. https://www.merriam-webster.com/dictionary/mechanics
>
> >
> > > +static void perf_drv_config_replace(struct perf_event *event, void *drv_data)
> > > +{
> > > +     unsigned long flags;
> > > +     void *old_drv_data;
> > > +     struct pmu_drv_config *drv_config = &event->hw.drv_config;
> > > +
> > > +     if (!has_drv_config(event))
> > > +             return;
> > > +
> > > +     /* Children take their configuration from their parent */
> > > +     if (event->parent)
> > > +             return;
> > > +
> > > +     /* Make sure the PMU doesn't get a handle on the data */
> > > +     raw_spin_lock_irqsave(&drv_config->lock, flags);
> > > +
> > > +     old_drv_data = drv_config->config;
> > > +     drv_config->config = drv_data;
> > > +
> > > +     raw_spin_unlock_irqrestore(&drv_config->lock, flags);
> > > +
> > > +     /* Free PMU private data allocated by pmu::drv_config_validate() */
> > > +     event->pmu->drv_config_free(old_drv_data);
> > > +}
> >
> > I got this stacktrace whilst testing a perf tool *without* this series
> > applied, running on a kernel *with* this series applied:
>
> That shouldn't matter as I kept the changes backward compatible
> specifically to handle this situation.
>
> >
> > [  132.942054] INFO: trying to register non-static key.
> > [  132.946964] the code is fine but needs lockdep annotation.
> > [  132.952389] turning off the locking correctness validator.
> > [  132.957818] CPU: 2 PID: 2835 Comm: perf64-sans Not tainted 4.18.0-rc3-00196-g5b5d957532a8-dirty #146
> > [  132.966856] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan 23 2017
> > [  132.977527] Call trace:
> > [  132.979947]  dump_backtrace+0x0/0x1c0
> > [  132.983567]  show_stack+0x24/0x30
> > [  132.986845]  dump_stack+0x90/0xb4
> > [  132.990122]  register_lock_class+0x57c/0x580
> > [  132.994343]  __lock_acquire.isra.12+0x6c/0x980
> > [  132.998736]  lock_acquire+0x100/0x1e8
> > [  133.002357]  _raw_spin_lock_irqsave+0x58/0x78
> > [  133.006667]  perf_drv_config_replace+0x4c/0x80
> > [  133.011061]  _free_event+0xbc/0x460
> > [  133.014507]  put_event+0x2c/0x38
> > [  133.017697]  perf_event_release_kernel+0x1ac/0x300
> > [  133.022434]  perf_release+0x10/0x20
> > [  133.025883]  __fput+0xa8/0x1e0
> > [  133.028901]  ____fput+0x20/0x30
> > [  133.032006]  task_work_run+0xa0/0xd0
> > [  133.035539]  do_notify_resume+0x118/0x120
> > [  133.039503]  work_pending+0x8/0x10
> >
> > Is a raw_spin_lock_init missing perhaps?

I read your email too fast... That's exactly what it was.

Thanks for giving this a spin,
Mathieu

>
> Not that I can tell - I need to investigate.
>
> >
> > Thanks,
> >
> > Kim
