From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 11 Dec 2015 14:17:12 -0700
Subject: [PATCH V6 18/26] coresight: etb10: implementing AUX space API
In-Reply-To: <87h9jpccfz.fsf@ashishki-desk.ger.corp.intel.com>
References: <1449176702-13213-1-git-send-email-mathieu.poirier@linaro.org>
 <1449176702-13213-19-git-send-email-mathieu.poirier@linaro.org>
 <87h9jpccfz.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkyNE3f49N_rCMAaHgfo+CTSd46ZiTE8qj=bGVubMqTJ6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 December 2015 at 07:00, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> +static void *etb_get_config(struct coresight_device *csdev, int cpu,
>> +                         void **pages, int nr_pages, bool overwrite)
>> +{
>> +     int node;
>> +     struct cs_buffers *buf;
>> +
>> +     if (cpu == -1)
>> +             cpu = smp_processor_id();
>> +     node = cpu_to_node(cpu);
>> +
>> +     buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
>> +     if (!buf)
>> +             return NULL;
>> +
>> +     buf->snapshot = overwrite;
>> +     buf->nr_pages = nr_pages;
>> +     buf->data_pages = pages;
>> +
>> +     return buf;
>> +}
>
> Nitpick: why is this called "get_config"? I was just looking for
> something else and noticed that both sources and sinks have
> .get_config() callback (I was looking for the source's one), but this
> guy doesn't seem to be getting any config, but rather allocating a
> buffer descriptor.

My goal was to harmonise the naming convention between source and
sinks as much as possible, and I'm still not quite sure how to call
that function... Given the end result something like
"etb_alloc_buffer" would likely be more appropriate.

>
> Regards,
> --
> Alex
