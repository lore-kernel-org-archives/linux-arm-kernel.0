From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 20 Oct 2015 13:15:51 -0600
Subject: [PATCH V2 22/30] coresight: etm-perf: new PMU driver for ETM
 tracers
In-Reply-To: <87a8rdhoiq.fsf@ashishki-desk.ger.corp.intel.com>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
 <1445192687-24112-23-git-send-email-mathieu.poirier@linaro.org>
 <87a8rdhoiq.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYky7pytCD=AZAaPy9Jqc4_EFu+_NV=noLBTgwXNyYydi-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 October 2015 at 03:34, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> +static void *etm_setup_aux(struct perf_event *event, void **pages,
>> +                        int nr_pages, bool overwrite)
>> +{
>> +     int cpu;
>> +     cpumask_t *mask;
>> +     struct etm_event_data *event_data = NULL;
>> +     struct coresight_device *csdev;
>> +
>> +     event_data = alloc_event_data(event->cpu);
>> +     if (!event_data)
>> +             return NULL;
>> +
>> +     mask = &event_data->mask;
>> +
>> +     if (event->cpu != -1)
>> +             cpumask_set_cpu(event->cpu, mask);
>> +     else
>> +             cpumask_copy(mask, cpu_online_mask);
>> +
>> +     for_each_cpu(cpu, mask) {
>> +             struct coresight_device *sink;
>> +
>> +             csdev = per_cpu(csdev_src, cpu);
>> +             if (!csdev)
>> +                     goto err;
>> +
>> +             /* Get the tracer's config from perf */
>> +             if (!source_ops(csdev)->perf_get_config)
>> +                     goto err;
>> +
>> +             event_data->source_config[cpu] =
>> +                     source_ops(csdev)->perf_get_config(csdev, event);
>> +
>> +             if (!event_data->source_config[cpu])
>> +                     goto err;
>> +
>> +             /*
>> +              * Get a handle on the sink buffer associated
>> +              * with this tracer.
>> +              */
>> +             event_data->sink[cpu] = (void *)etm_event_build_path(cpu, true);
>
> There are several problems here. What is created/allocated during
> setup_aux(), has to be undone in free_aux(), however, the effect of
> build_path() will only be undone in the event::destroy() path. So if the
> user unmaps the aux buffer and then maps it again, we'll go ahead and
> try to build the path again. (Btw, coresight_build_paths() and other
> non-static functions and especially exported ones are really lacking
> documentation at the moment).
>
> It really looks like this has to be done in pmu::add(), so that the
> source<=>sink connection exists only while the event is scheduled and
> otherwise other events are free to connect their sources to these
> sinks. And at pmu::del() the connection has to be torn down. This way we
> can have a sensible multisession support. That is, provided my
> understanding of the coresight driver architecture is correct.
>
> Also, you won't have to configure things on multiple cpus for cpu==-1 if
> you keep the source<=>sink connection only between pmu::add() and
> pmu::del(), as an event can only be scheduled on one cpu at a time,
> which should make things simpler.

I am well aware of all this...  Currently the process of building a
path is too heavy to be done at context switch time.  To be efficient
the components of a path would have to be kept in a linked list that
is then enabled/disabled when the time comes.  I've been meaning to do
something better for a while now.  This might be the perfect time to
address the problem.

Thanks for reviewing the patch set,
Mathieu

>
>> +
>> +             if (!event_data->sink[cpu])
>> +                     goto err;
>> +
>> +             sink = event_data->sink[cpu];
>> +
>> +             if (!sink_ops(sink)->setup_aux)
>> +                     goto err;
>> +
>> +             /* Finally get the AUX specific data from the sink buffer */
>> +             event_data->sink_config[cpu] =
>> +                             sink_ops(sink)->setup_aux(sink, cpu, pages,
>> +                                                       nr_pages, overwrite);
>
> Now this is a sensible thing to do. I understand that you'll have to
> know which sink you're using so that you can pick the right sink_ops and
> build an appropriate configuration, but perhaps it also makes sense to
> release it once you got the sink_config.
>
>> +static void etm_event_stop(struct perf_event *event, int mode)
>> +{
>> +     int cpu = smp_processor_id();
>> +     struct coresight_device *csdev = per_cpu(csdev_src, cpu);
>> +
>> +     if (event->hw.state == PERF_HES_STOPPED)
>> +             return;
>> +
>> +     if (!csdev)
>> +             return;
>> +
>> +     /* stop tracer */
>> +     if (!source_ops(csdev)->perf_disable)
>> +             return;
>
> This really shouldn't happen. It makes sense to make sure that we have
> all the callbacks that we rely on in pmu::event_init() or pmu::add() and
> refuse to start if we don't, but at this point we really shouldn't end
> up in a situation where we suddenly don't have one of the callbacks.
>
>> +     if (source_ops(csdev)->perf_disable(csdev))
>> +             return;
>
> This has a similar problem. I'd say that this callback should not be
> able to fail and return anything other than success.
>
>> +     /* tell the core */
>> +     event->hw.state = PERF_HES_STOPPED;
>> +
>> +
>> +     if (mode & PERF_EF_UPDATE) {
>> +             struct coresight_device *sink;
>> +             struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
>> +             struct etm_event_data *event_data = perf_get_aux(handle);
>> +
>> +             if (WARN_ON_ONCE(handle->event != event))
>> +                     return;
>> +
>> +             if (WARN_ON_ONCE(!event_data))
>> +                     return;
>> +
>> +             sink = event_data->sink[cpu];
>> +             if (WARN_ON_ONCE(!sink))
>> +                     return;
>> +
>> +             /* update trace information */
>> +             if (!sink_ops(sink)->update_buffer)
>> +                     return;
>> +
>> +             sink_ops(sink)->update_buffer(sink, handle,
>> +                                           event_data->sink_config[cpu]);
>> +     }
>> +}
>> +
>> +static void etm_event_start(struct perf_event *event, int flags)
>> +{
>> +     int cpu = smp_processor_id();
>> +     struct coresight_device *csdev = per_cpu(csdev_src, cpu);
>> +
>> +     if (!csdev)
>> +             goto fail;
>> +
>> +     /* tell the perf core the event is alive */
>> +     event->hw.state = 0;
>> +
>> +     if (!source_ops(csdev)->perf_enable)
>> +             goto fail;
>
> Same here.
>
>> +
>> +     if (source_ops(csdev)->perf_enable(csdev))
>> +             goto fail;
>
> This may fail, I suppose.
>
>> +
>> +     return;
>> +
>> +fail:
>> +     event->hw.state = PERF_HES_STOPPED;
>> +}
>> +
>> +static void etm_event_del(struct perf_event *event, int mode)
>> +{
>> +     int cpu = smp_processor_id();
>> +     struct coresight_device *sink;
>> +     struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
>> +     struct etm_event_data *event_data = perf_get_aux(handle);
>> +
>> +     if (WARN_ON_ONCE(!event_data))
>> +             return;
>> +
>> +     sink = event_data->sink[cpu];
>> +     if (!sink)
>> +             return;
>
> This also shouldn't be able to prevent us from stopping the event.
>
>> +
>> +     etm_event_stop(event, PERF_EF_UPDATE);
>> +
>> +     if (!sink_ops(sink)->reset_buffer)
>> +             return;
>> +
>> +     sink_ops(sink)->reset_buffer(sink, handle,
>> +                                  event_data->sink_config[cpu]);
>> +}
>> +
>> +static int etm_event_add(struct perf_event *event, int mode)
>> +{
>> +
>> +     int ret = -EBUSY, cpu = smp_processor_id();
>> +     struct etm_event_data *event_data;
>> +     struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
>> +     struct hw_perf_event *hwc = &event->hw;
>> +     struct coresight_device *csdev = per_cpu(csdev_src, cpu);
>> +     struct coresight_device *sink;
>> +
>> +     if (handle->event)
>> +             goto out;
>> +
>> +     event_data = perf_aux_output_begin(handle, event);
>> +     ret = -EINVAL;
>> +     if (WARN_ON_ONCE(!event_data))
>> +             goto fail_stop;
>> +
>> +     sink = event_data->sink[cpu];
>
> So if you're able to fetch the sink right here and release it in
> _del(). Of course, this being a hot path and an atomic context needs to
> be taken into account.
>
> Regards,
> --
> Alex
