From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 27 Jan 2016 13:55:43 -0700
Subject: [PATCH V8 16/23] coresight: etb10: implementing AUX API
In-Reply-To: <8760yg72wb.fsf@ashishki-desk.ger.corp.intel.com>
References: <1452807977-8069-1-git-send-email-mathieu.poirier@linaro.org>
 <1452807977-8069-17-git-send-email-mathieu.poirier@linaro.org>
 <8760yg72wb.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkyUD6AgnN81Kui4bV+iNFr4YEkY0B-qE3MtJ9X7yyry7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 January 2016 at 08:53, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> Adding an ETB10 specific AUX area operations to be used
>> by the perf framework when events are initialised.
>>
>> Part of this operation involves modeling the mmap'ed area
>> based on the specific ways a sink buffer gathers information.
>
> I don't mind being CC'd on the rest of the patches too, btw. :)

Most definitely.

>
>> +static unsigned long etb_reset_buffer(struct coresight_device *csdev,
>> +                                   struct perf_output_handle *handle,
>> +                                   void *sink_config, bool *lost)
>> +{
>> +     unsigned long size = 0;
>> +     struct cs_buffers *buf = sink_config;
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
>> +
>> +             /*
>> +              * Tell the tracer PMU how much we got in this run and if
>> +              * something went wrong along the way.  Nobody else can use
>> +              * this cs_buffers instance until we are done.  As such
>> +              * resetting parameters here and squaring off with the ring
>> +              * buffer API in the tracer PMU is fine.
>> +              */
>> +             *lost = local_xchg(&buf->lost, 0);
>
> This is a thin ice, you can't really make assumptions about bool's
> storage size or even type, afaict.

You are theoretically correct but I wonder if the value of &buf->lost
can get to a size where it won't fit in *lost... Nevertheless I'll fix
it with:

*lost = !!local_xchg(&buf->lost, 0);

>
>> +             size = local_xchg(&buf->data_size, 0);
>> +     }
>> +
>> +     return size;
>> +}
>> +
>> +static void etb_update_buffer(struct coresight_device *csdev,
>> +                           struct perf_output_handle *handle,
>> +                           void *sink_config)
>> +{
>> +     int i, cur;
>> +     u8 *buf_ptr;
>> +     u32 read_ptr, write_ptr, capacity;
>> +     u32 status, read_data, to_read;
>> +     unsigned long flags, offset;
>> +     struct cs_buffers *buf = sink_config;
>> +     struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +     if (!buf)
>> +             return;
>> +
>> +     capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
>> +
>> +     spin_lock_irqsave(&drvdata->spinlock, flags);
>
> This spinlock seems to be held over the entire readout operation,
> however, I can't find clear rules wrt what structures etc are serialized
> on it. Instead, the comment says "only one at a time pls". Same for
> etm's big drvdata spinlock.

That spinlock is there to serialise actions coming from sysFS.  I
originally added the spinlock to 'etb_update_buffer()' to guard
against reading the internal RAM buffer from sysfs while a perf
session is active.  But after supplementing 'etb_dump()' with 'mode'
awareness this spinlock it is no longer required.

>
> Regards,
> --
> Alex
