From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 20 Oct 2015 11:30:46 -0600
Subject: [PATCH V2 20/30] coresight: etb10: implementing buffer
 set/reset() API
In-Reply-To: <877fmhhnhc.fsf@ashishki-desk.ger.corp.intel.com>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
 <1445192687-24112-21-git-send-email-mathieu.poirier@linaro.org>
 <877fmhhnhc.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkwFcdAeu20EtzapUeRA557dneHeXNexqrL-jbBK6+1gFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 October 2015 at 03:56, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> Implementing perf related APIs to activate and terminate
>> a trace session.  More specifically dealing with the sink
>> buffer's internal mechanic along with perf's API to start
>> and stop interactions with the ring buffers.
>
> A matter of preference, but I'd say that it would be easier to review
> this part if you merged all the buffer related patches together.
>
>> +static void etb_reset_buffer(struct coresight_device *csdev,
>> +                          struct perf_output_handle *handle,
>> +                          void *sink_config)
>> +{
>> +     struct cs_buffers *buf = sink_config;
>> +     struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +     if (buf) {
>> +             /*
>> +              * In snapshot mode ->data_size holds the new address of the
>> +              * ring buffer's head.  The size itself is the whole address
>> +              * range since we want the latest information.
>> +              */
>> +             if (buf->snapshot)
>> +                     handle->head = local_xchg(&buf->data_size,
>> +                                               buf->nr_pages << PAGE_SHIFT);
>
> Does it make sense to do this in etb_update_buffer() instead?

I toyed with that idea for a while.  I would make sense if the ETB was
generating an interrupt when it is full but since cross-triggers
aren't implemented yet I didn't want to introduce code I can't test.

>
>> +             perf_aux_output_end(handle, local_xchg(&buf->data_size, 0),
>> +                                 local_xchg(&buf->lost, 0));
>
> The corresponding perf_aux_output_begin() is done in etm_event_add(),
> I'd suggest that you do this in etm_event_del(),

I'm in total agreement.  Since perf_aux_output_begin() is called in
etm_event_add(), perf_aux_output_end() should really be called in
etm_event_del().  The problem is that "buf->data_size" and "buf->lost"
are specific to the sink buffer and shouldn't be made public outside
of it.  Let me think about this further.

> unconditionally. Otherwise you're risking ending up with a refcount leak
> and all sorts of horror.
>
> Regards,
> --
> Alex
