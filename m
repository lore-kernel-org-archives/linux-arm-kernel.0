From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 02 Oct 2015 07:50:25 +0300
Subject: [RFC PATCH 15/20] coresight: etm-perf: implementing 'setup_aux()'
 API
In-Reply-To: <CANLsYkyjHZOzZqx8X7StegkxE7kuBma4Wz_pZ8OBDs-V3E3irw@mail.gmail.com>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-16-git-send-email-mathieu.poirier@linaro.org>
 <87bnckjfce.fsf@ashishki-desk.ger.corp.intel.com>
 <CANLsYkyjHZOzZqx8X7StegkxE7kuBma4Wz_pZ8OBDs-V3E3irw@mail.gmail.com>
Message-ID: <87si5t3mcu.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> On 30 September 2015 at 05:50, Alexander Shishkin
> <alexander.shishkin@linux.intel.com> wrote:
>> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>>
>>> +static void *etm_setup_aux(int cpu, void **pages,
>>> +                           int nr_pages, bool overwrite)
>>> +{
>>> +     struct coresight_device *csdev;
>>> +
>>> +     if (cpu == -1)
>>> +             cpu = smp_processor_id();
>>> +
>>> +     csdev = per_cpu(csdev_sink, cpu);
>>> +     if (!csdev)
>>> +             return NULL;
>>> +
>>> +     return sink_ops(csdev)->setup_aux(csdev, cpu, pages,
>>> +                                       nr_pages, overwrite);
>>
>> Is it guaranteed that this sink would always have .setup_aux()?
>
> A setup_aux() is vital to the design, both on Intel and ARM.  I really
> don't see how one could go without it.  I can return NULL if it hasn't
> been provided - that way the setup will fail without triggering a core
> dump.

It wasn't clear to me that the sink that ends up in csdev_sink will
always be the one that does have .setup_aux(). And if it indeed doesn't,
it's better to refuse to setup a buffer than crash.

Regards,
--
Alex
