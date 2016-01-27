From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 27 Jan 2016 11:33:46 -0700
Subject: [PATCH V8 18/23] coresight: etm-perf: new PMU driver for ETM
 tracers
In-Reply-To: <878u3c744r.fsf@ashishki-desk.ger.corp.intel.com>
References: <1452807977-8069-1-git-send-email-mathieu.poirier@linaro.org>
 <1452807977-8069-19-git-send-email-mathieu.poirier@linaro.org>
 <878u3c744r.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkxVoS0YLajgKrTf-RhA+2jO5nd5cLHEmrOroafNHfcvbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 January 2016 at 08:27, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> +static int etm_event_init(struct perf_event *event)
>> +{
>> +     if (event->attr.type != etm_pmu.type)
>> +             return -ENOENT;
>> +
>> +     if (event->cpu >= nr_cpu_ids)
>> +             return -EINVAL;
>
> perf_event_alloc() already does this. Except for this one doesn't cover
> the negative space.

Ack

>
> [snip]
>
>> +static void etm_free_aux(void *data)
>> +{
>> +     struct etm_event_data *event_data = data;
>> +
>> +     pr_err("Queing work\n");
>
> Probably not pr_err().

That's an old debug message - I've removed it already.

>
>> +     schedule_work(&event_data->work);
>> +}
>
> [snip]
>
>> +static void etm_event_start(struct perf_event *event, int flags)
>> +{
>> +     int cpu = smp_processor_id();
>> +     struct etm_event_data *event_data;
>> +     struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
>> +     struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
>> +
>> +     if (!csdev)
>> +             goto fail;
>> +
>> +     /*
>> +      * Deal with the ring buffer API and get a handle on the
>> +      * session's information.
>> +      */
>> +     event_data = perf_aux_output_begin(handle, event);
>> +     if (WARN_ON_ONCE(!event_data))
>> +             goto fail;
>
> There really shouldn't be a warning here. I understand that the 'no
> buffer' case is taped over by the !csdev check above, but there are
> other ligitimate reasons for perf_aux_output_begin() to return NULL,
> like no-space-left.

That's too harsh yes.

>
>> +
>> +     /* We need a sink, no need to continue without one */
>> +     sink = coresight_get_sink(event_data->path[cpu]);
>> +     if (!sink || !sink_ops(sink)->set_buffer)
>> +             goto fail_end_stop;
>
> Is this possible after the coresight_build_path() things in setup_aux?
> Might be a better candidate for WARN_*ONCE().
>
>> +
>> +     /* Configure the sink */
>> +     if (sink_ops(sink)->set_buffer(sink, handle,
>> +                                    event_data->snk_config))
>> +             goto fail_end_stop;
>> +
>> +     /* Nothing will happen without a path */
>> +     if (coresight_enable_path(event_data->path[cpu], CS_MODE_PERF))
>> +             goto fail_end_stop;
>
> I'd like to understand all the potential failures here, because it's
> really a good idea to keep those to a minimum for the sake of
> consistency. That is, if the user succeeded in creating an event, about
> the only good reason for the event not starting is a filled up buffer.

Enabling a path should fail when one or many components of that path
are already enabled by an ongoing trace session.  This situation is
quite likely to happen since in a lot of design tracers share the link
and sinks.

>
> This is why it makes a lot of sense to keep all the
> coresight_build_path()/coresight_enable_path() to the .event_init()
> phase and let them fail early, if they should fail.

If we do enable enable paths in .event_init() we can't support
multiple concurrent trace session (see explanation above).  The
ultimate design is to have a source directly connected to a sink but
so far none of the coresight topologies I've seen have been wired like
that.

>
> Regards,
> --
> Alex
