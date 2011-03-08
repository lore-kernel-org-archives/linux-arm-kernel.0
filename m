From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 8 Mar 2011 18:49:13 +0200
Subject: SMP soft lockup on smp_call_function_many when doing
	flush_tlb_page
In-Reply-To: <AANLkTinX+1wwxcSPf0HfyE1pG1TJv7zf0cQ9aP+DWCCD@mail.gmail.com>
References: <AANLkTimk6zmQNdZaVaxDbd5Ff+75RERhrxgmsbM55vs1@mail.gmail.com>
	<1299591229.19820.91.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinX+1wwxcSPf0HfyE1pG1TJv7zf0cQ9aP+DWCCD@mail.gmail.com>
Message-ID: <AANLkTi=HzSUP0aXSBSg=5zKLngJz+8Jwqr+oLrW+tEyL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> ? ? ? ?atomic_set(&data->refs, cpumask_weight(data->cpumask));
>> + ? ? ? if (unlikely(!atomic_read(&data->refs))) {
>> + ? ? ? ? ? ? ? csd_unlock(&data->csd);
>> + ? ? ? ? ? ? ? return;
>> + ? ? ? }
> I don't think this is save, if the mask get cleaned after having cpu
> set to valid value and before calculating the next_cpu, the code with
> go to the fast path (smp_call_function_single)
I was wrong, this is actually not a problem, taking the fast path will
not hang the process.

>> An alternative would be to copy the cpumask to a local variable in
>> on_each_cpu_mask(), though the workaround above would cover other cases
>> that we haven't spotted yet. Also, the smp_call_function_many()
>> description doesn't state that the cpumask should not be modified.
>>
>>
>> diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
>> index 8f57f32..1717dec 100644
>> --- a/arch/arm/kernel/smp_tlb.c
>> +++ b/arch/arm/kernel/smp_tlb.c
>> @@ -16,10 +16,13 @@
>> ?static void on_each_cpu_mask(void (*func)(void *), void *info, int wait,
>> ? ? ? ?const struct cpumask *mask)
>> ?{
>> + ? ? ? struct cpumask call_mask;
>> +
>> ? ? ? ?preempt_disable();
>>
>> + ? ? ? cpumask_copy(&call_mask, mask);
>> ? ? ? ?smp_call_function_many(mask, func, info, wait);
> ?I'll check this one, but the mask here should be call_mask.
>> - ? ? ? if (cpumask_test_cpu(smp_processor_id(), mask))
>> + ? ? ? if (cpumask_test_cpu(smp_processor_id(), &call_mask))
>> ? ? ? ? ? ? ? ?func(info);
>>
this patch increases my system instability, for some reason, the
call_function_data data get corrupted when the
generic_smp_call_function_interrupt() is running.
saeed
