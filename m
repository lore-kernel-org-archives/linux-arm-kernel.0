From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 20 Jun 2012 10:43:34 +0200
Subject: [PATCH v2 3/5] ARM: topology: Update cpu_power according to DT
 information
In-Reply-To: <877gv2hjhb.fsf@sejong.aot.lge.com>
References: <1340094536-20873-1-git-send-email-vincent.guittot@linaro.org>
 <1340094536-20873-4-git-send-email-vincent.guittot@linaro.org>
 <877gv2hjhb.fsf@sejong.aot.lge.com>
Message-ID: <CAKfTPtDhS3Hj+ErN5E_U_Ji=zE75m2Ya68UW4jLDEjoiO9bAsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20 June 2012 03:15, Namhyung Kim <namhyung@kernel.org> wrote:
>
>
>
> On Tue, 19 Jun 2012 10:28:54 +0200, Vincent Guittot wrote:
>> Use cpu compatibility field and clock-frequency field of DT to
>> estimate the capacity of each core of the system and to update
>> the cpu_power field accordingly.
>> This patch enables to put more running tasks on big cores than
>> on LITTLE ones. But this patch doesn't ensure that long running
>> tasks will run on big cores and short ones on LITTLE cores.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
> [snip]
>> +static void __init parse_dt_topology(void)
>> +{
>> + ? ? struct cpu_efficiency *cpu_eff;
>> + ? ? struct device_node *cn = NULL;
>> + ? ? unsigned long min_capacity = (unsigned long)(-1);
>> + ? ? unsigned long max_capacity = 0;
>> + ? ? unsigned long capacity = 0;
>> + ? ? int alloc_size, cpu = 0;
>> +
>> + ? ? alloc_size = nr_cpu_ids * sizeof(struct cpu_capacity);
>> + ? ? cpu_capacity = (struct cpu_capacity *)kzalloc(alloc_size, GFP_NOWAIT);
>> +
>> + ? ? while ((cn = of_find_node_by_type(cn, "cpu"))) {
>> + ? ? ? ? ? ? const u32 *rate, *reg;
>> + ? ? ? ? ? ? char *compatible;
>> + ? ? ? ? ? ? int len;
>> +
>> + ? ? ? ? ? ? if (cpu >= num_possible_cpus())
>> + ? ? ? ? ? ? ? ? ? ? break;
>> +
>> + ? ? ? ? ? ? compatible = of_get_property(cn, "compatible", &len);
>
> Why is this line needed?

not needed is the final version, should have been removed.

>
>
>> +
>> + ? ? ? ? ? ? for (cpu_eff = table_efficiency; cpu_eff->compatible; cpu_eff++)
>> + ? ? ? ? ? ? ? ? ? ? if (of_device_is_compatible(cn, cpu_eff->compatible))
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
>> +
>> + ? ? ? ? ? ? if (cpu_eff->compatible == NULL)
>> + ? ? ? ? ? ? ? ? ? ? continue;
>> +
>> + ? ? ? ? ? ? rate = of_get_property(cn, "clock-frequency", &len);
>> + ? ? ? ? ? ? if (!rate || len != 4) {
>> + ? ? ? ? ? ? ? ? ? ? pr_err("%s missing clock-frequency property\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? cn->full_name);
>> + ? ? ? ? ? ? ? ? ? ? continue;
>> + ? ? ? ? ? ? }
>> +
>> + ? ? ? ? ? ? reg = of_get_property(cn, "reg", &len);
>> + ? ? ? ? ? ? if (!reg || len != 4) {
>> + ? ? ? ? ? ? ? ? ? ? pr_err("%s missing reg property\n", cn->full_name);
>> + ? ? ? ? ? ? ? ? ? ? continue;
>> + ? ? ? ? ? ? }
>> +
>> + ? ? ? ? ? ? capacity = ((be32_to_cpup(rate)) >> 20)
>> + ? ? ? ? ? ? ? ? ? ? * cpu_eff->efficiency;
>
> Why did you break this line?

It was more than 80 chars large previously but no more the case.
I'm going to correct

Thanks
>
> Thanks,
> Namhyung
>
>
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
