From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 20 Oct 2015 10:40:43 -0600
Subject: [PATCH V2 19/30] coresight: etb10: implementing the setup_aux()
 API
In-Reply-To: <87lhazgegt.fsf@ashishki-desk.ger.corp.intel.com>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
 <1445192687-24112-20-git-send-email-mathieu.poirier@linaro.org>
 <87lhazgegt.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkwUvyhBy=kEahtFvvmsh8Zsb+rpD4cgeUKXLcBMgyxa1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 October 2015 at 07:44, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> Adding an ETB10 specific auxiliary area setup operation to be
>> used by the perf framework when events are initialised.
>>
>> Part of this operation involves modeling the mmap'ed area based
>> on the specific ways a sink buffer gathers information.
>
> It really doesn't seem to be ETB10 specific at all. When you add more
> sinks, you'll probably end up copying this code every time.

That will depend on how that specific sinks work, but indeed, it is
pretty generic.

>
> Furthermore,
>
>> +static void *etb_setup_aux(struct coresight_device *csdev, int cpu,
>> +                        void **pages, int nr_pages, bool overwrite)
>> +{
>> +     int node, pg;
>> +     struct cs_buffers *buf;
>> +
>> +     if (cpu == -1)
>> +             cpu = smp_processor_id();
>> +     node = cpu_to_node(cpu);
>> +
>> +     buf = kzalloc_node(offsetof(struct cs_buffers, addr[nr_pages]),
>> +                        GFP_KERNEL, node);
>> +     if (!buf)
>> +             return NULL;
>> +
>> +     buf->snapshot = overwrite;
>> +     buf->nr_pages = nr_pages;
>> +
>> +     /* Record information about buffers */
>> +     for (pg = 0; pg < buf->nr_pages; pg++)
>> +             buf->addr[pg] = pages[pg];
>> +
>> +     return buf;
>> +}
>> +
>
> this one is so generic that I'm tempted to move this into perf's
> ring_buffer code, because by the looks of it we'll need it pretty much
> in every setup_aux().

It is tempting but I suggest we wait to see what kind of trend we get
before moving ahead with this.  There is always opportunity for
further consolidation should the need arise.

>
> Regards,
> --
> Alex
