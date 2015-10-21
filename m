From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 21 Oct 2015 09:35:46 +0800
Subject: [PATCH] EDAC: Add AMD Seattle SoC EDAC
In-Reply-To: <5626B199.4050209@amd.com>
References: <1445282597-18999-1-git-send-email-brijeshkumar.singh@amd.com>
 <5625A528.1040803@huawei.com> <5626B199.4050209@amd.com>
Message-ID: <5626EBF2.50107@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/10/21 5:26, Brijesh Singh wrote:
> Hi Hanjun,
>
> Thanks for review.
>
> -Brijesh 
> On 10/19/2015 09:21 PM, Hanjun Guo wrote:
>> Hi Brijesh,
>>
>> On 2015/10/20 3:23, Brijesh Singh wrote:
[...]
>> The codes above are common for all A57 architectures, other A57 SoCs will use the same
>> code for L1/L2 caches error report, can we put those codes in common place and reused
>> for all A57 architectures?
>>
> Code is generic to A57 and I will follow Mark Rutland suggestion to make it cortex_a57_edac. If you have something else in mind then please let me know.

Sorry, I missed Mark's comments before I sent my email, I'm fine with
the file name suggested.

>
>>> +
>>> +static void cpu_check_errors(void *args)
>>> +{
>>> +	struct edac_device_ctl_info *edev_ctl = args;
>>> +
>>> +	check_cpumerrsr_el1_error(edev_ctl);
>>> +	check_l2merrsr_el1_error(edev_ctl);
>>> +}
>>> +
>>> +static void edac_check_errors(struct edac_device_ctl_info *edev_ctl)
>>> +{
>>> +	int cpu;
>>> +
>>> +	/* read L1 and L2 memory error syndrome register on possible CPU's */
>>> +	for_each_possible_cpu(cpu)
>>> +		smp_call_function_single(cpu, cpu_check_errors, edev_ctl, 0);
>> Seems that error syndrome registers for L2 cache are cluster lever (each cluster share the
>> L2 cache, you can refer to ARM doc: DDI0488D, Cortex-A57 Technical Reference Manual),
>> so for L2 cache, we need to check the error at cluster lever not the cpu core lever.
>>
> Yes L1 seems to be CPU specific and L2 is shared in a cluster. So I am thinking of making the following changes in this function.
>
> static void edac_check_errors(struct edac_device_ctl_info *edev_ctl)
> {
>         int cpu;
>         struct cpumask cluster_mask, old_mask;
>
>         cpumask_clear(&cluster_mask);
>         cpumask_clear(&old_mask);
>
>         for_each_possible_cpu(cpu) {
>                 smp_call_function_single(cpu, check_cpumerrsr_el1_error, 
>                                          edev_ctl, 0); 
>                 cpumask_copy(&cluster_mask, topology_core_cpumask(cpu));
>                 if (cpumask_equal(&cluster_mask, &old_mask))
>                         continue;
>                 cpumask_copy(&old_mask, &cluster_mask);
>                 smp_call_function_any(&cluster_mask, check_l2merrsr_el1_error,
>                                       edev_ctl, 0); 
>         }   
> }
>
> Read L1 on each CPU and L2 once in a cluster. Does this address your feedback ?

Yes, at least it will work as expected :)

Thanks
Hanjun
