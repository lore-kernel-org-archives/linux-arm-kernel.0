From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 18 Jul 2018 16:11:16 -0600
Subject: [PATCH] coresight: etm_perf: Rework alloc/free methods to avoid
 lockep warning
In-Reply-To: <d648155e-0486-7d7c-5e29-2bda6c536dba@arm.com>
References: <1531942988-20901-1-git-send-email-mathieu.poirier@linaro.org>
 <d648155e-0486-7d7c-5e29-2bda6c536dba@arm.com>
Message-ID: <CANLsYkw5eXvVg+8QGBFsQ_kawL-Okuny-e4VPY=q6w3_27Dq_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jul 2018 at 15:31, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mathieu,
>
> On 07/18/2018 08:43 PM, Mathieu Poirier wrote:
> > When enabling the lockdep mechanic and working with CPU-wide scenarios we
> > get the following console output:
> >
>
> > This is fixed by working with the cpu_present_mask, avoinding at the same
> > the need to use get/put_online_cpus() that triggers lockdep.
>
> The patch looks correct to me. In fact I have a patch [1], which
> does the same thing and switches to using per-cpu variable for the
> paths.

Not only did you beat me to the punch but I think using a per-cpu
variable is cleaner, so let's go with yours.

Mathieu

>
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm-perf.c | 39 +++++++++++++-----------
> >   1 file changed, 21 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index 677695635211..16b9c87d9d00 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -108,26 +108,32 @@ static int etm_event_init(struct perf_event *event)
> >   static void free_event_data(struct work_struct *work)
> >   {
> >       int cpu;
> > +     void *snk_config;
> >       cpumask_t *mask;
> >       struct etm_event_data *event_data;
> >       struct coresight_device *sink;
> >
> >       event_data = container_of(work, struct etm_event_data, work);
> >       mask = &event_data->mask;
> > -     /*
> > -      * First deal with the sink configuration.  See comment in
> > -      * etm_setup_aux() about why we take the first available path.
> > -      */
> > -     if (event_data->snk_config) {
> > -             cpu = cpumask_first(mask);
> > -             sink = coresight_get_sink(event_data->path[cpu]);
> > -             if (sink_ops(sink)->free_buffer)
> > -                     sink_ops(sink)->free_buffer(event_data->snk_config);
> > -     }
> > +     snk_config = event_data->snk_config;
> >
> >       for_each_cpu(cpu, mask) {
> > -             if (!(IS_ERR_OR_NULL(event_data->path[cpu])))
> > -                     coresight_release_path(event_data->path[cpu]);
> > +             if (IS_ERR_OR_NULL(event_data->path[cpu]))
> > +                     continue;
> > +
> > +             /*
> > +              * Free sink configuration - there can only be one sink
> > +              * per event.
> > +              */
> > +             if (snk_config) {
> > +                     sink = coresight_get_sink(event_data->path[cpu]);
> > +                     if (sink_ops(sink)->free_buffer) {
> > +                             sink_ops(sink)->free_buffer(snk_config);
> > +                             snk_config = NULL;
> > +                     }
> > +             }
> > +
> > +             coresight_release_path(event_data->path[cpu]);
> >       }
>
> >
> >       kfree(event_data->path);
> > @@ -145,16 +151,13 @@ static void *alloc_event_data(int cpu)
> >       if (!event_data)
> >               return NULL;
> >
> > -     /* Make sure nothing disappears under us */
> > -     get_online_cpus();
> > -     size = num_online_cpus();
> > -
> >       mask = &event_data->mask;
> > +     size = num_present_cpus();
> > +
> >       if (cpu != -1)
> >               cpumask_set_cpu(cpu, mask);
> >       else
> > -             cpumask_copy(mask, cpu_online_mask);
> > -     put_online_cpus();
> > +             cpumask_copy(mask, cpu_present_mask);
>
> I think it is safe to use cpu_online_mask outside the
> get/put_online_cpus(). Using present_mask may fail as
> we could fail to create a path for a CPU that is not online.
>
>
> Please could you check if [1] fixes the problem for you ?
>
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/591606.html
>
> Cheers
> Suzuki
