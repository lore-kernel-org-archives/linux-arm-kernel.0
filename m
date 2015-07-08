From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Wed, 8 Jul 2015 09:50:56 +0800
Subject: [PATCH] thermal: cpu_cooling: Iterate over all CPUs in clip_cpu
 mask to get frequency table
In-Reply-To: <20150707102744.GK14598@linux>
References: <1435723647-3354-1-git-send-email-pi-cheng.chen@linaro.org>
 <1435723994-3882-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150707102744.GK14598@linux>
Message-ID: <CALx668WePBThqxtoDU+z-nbfkoXMRbve2gFAX2MNqtW10BeocA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Tue, Jul 7, 2015 at 6:27 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 01-07-15, 12:13, Pi-Cheng Chen wrote:
>> Sorry for the mistake I made when cherry-picking the patch. Fix and resend
>> again.
>
> You really want above to show up in git logs ?
>
> Any comments like this should be present:
> - in cover-letter
> - OR after the three dashes below ---
> - OR must be followed with a scissors line, like this:
>   --------------8<--------

Thanks for the lesson. :)

>
>> __cpufreq_cooling_register() might fail if some CPU other than first one in
>> clip_cpu mask is present earlier e.g. CPU hotplug. Iterate all CPUs in the mask
>> to handle this case.
>>
>> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
>> ---
>>  drivers/thermal/cpu_cooling.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> index 6509c61..5e90eb6 100644
>> --- a/drivers/thermal/cpu_cooling.c
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -776,9 +776,14 @@ __cpufreq_cooling_register(struct device_node *np,
>>       char dev_name[THERMAL_NAME_LENGTH];
>>       struct cpufreq_frequency_table *pos, *table;
>>       unsigned int freq, i, num_cpus;
>> -     int ret;
>> +     int ret, cpu;
>> +
>> +     for_each_cpu(cpu, clip_cpus) {
>> +             table = cpufreq_frequency_get_table(cpu);
>> +             if (table)
>> +                     break;
>> +     }
>>
>> -     table = cpufreq_frequency_get_table(cpumask_first(clip_cpus));
>
> Nah, that's wrong. I hope that's a hypothetical problem and not a real
> one. Would have been better if cpufreq maintainers were cc'd as they
> can provide more insight into this :)
>
> cpufreq_frequency_get_table() does: policy->freq_table and so it
> doesn't matter if the cpu is online or not.
>
> cpufreq_cpu_data was getting unset earlier on hotplug, but that's not
> the case anymore. So nothing to worry about :)

Yes. This is based on the case before 4.2-rc1 which policy of cpu will
be destroy after all cpus in a cluster are unplugged (right?). Since it
is not the case anymore now, this patch is not needed at all.
Thanks.

Best Regards,
Pi-Cheng

>
> --
> viresh
