From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 1 Oct 2015 16:49:11 -0600
Subject: [RFC PATCH 15/20] coresight: etm-perf: implementing 'setup_aux()'
 API
In-Reply-To: <87bnckjfce.fsf@ashishki-desk.ger.corp.intel.com>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-16-git-send-email-mathieu.poirier@linaro.org>
 <87bnckjfce.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkyjHZOzZqx8X7StegkxE7kuBma4Wz_pZ8OBDs-V3E3irw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2015 at 05:50, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> +static void *etm_setup_aux(int cpu, void **pages,
>> +                           int nr_pages, bool overwrite)
>> +{
>> +     struct coresight_device *csdev;
>> +
>> +     if (cpu == -1)
>> +             cpu = smp_processor_id();
>> +
>> +     csdev = per_cpu(csdev_sink, cpu);
>> +     if (!csdev)
>> +             return NULL;
>> +
>> +     return sink_ops(csdev)->setup_aux(csdev, cpu, pages,
>> +                                       nr_pages, overwrite);
>
> Is it guaranteed that this sink would always have .setup_aux()?

A setup_aux() is vital to the design, both on Intel and ARM.  I really
don't see how one could go without it.  I can return NULL if it hasn't
been provided - that way the setup will fail without triggering a core
dump.

>
> Regards,
> --
> Alex
