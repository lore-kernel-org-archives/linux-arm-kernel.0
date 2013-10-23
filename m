From: dave.long@linaro.org (David Long)
Date: Tue, 22 Oct 2013 21:21:08 -0400
Subject: [PATCH v2 04/13] uprobes: allow arch-specific initialization
In-Reply-To: <20131019164223.GB7837@redhat.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-5-git-send-email-dave.long@linaro.org>
 <20131019164223.GB7837@redhat.com>
Message-ID: <52672484.9010201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/13 12:42, Oleg Nesterov wrote:
> On 10/15, David Long wrote:
>>
>> Add a weak function for any architecture-specific initialization.  ARM
>> will use this to register the handlers for the undefined instructions it
>> uses to implement uprobes.
>
> Could you explain why ARM can't simply do the necessary initialization in
> arch/arm/kernel/uprobes-arm.c ?
>
>
>> +int __weak __init arch_uprobes_init(void)
>> +{
>> +	return 0;
>> +}
>> +
>>   static int __init init_uprobes(void)
>>   {
>> +	int ret;
>>   	int i;
>>
>>   	for (i = 0; i < UPROBES_HASH_SZ; i++)
>> @@ -1870,6 +1876,10 @@ static int __init init_uprobes(void)
>>   	if (percpu_init_rwsem(&dup_mmap_sem))
>>   		return -ENOMEM;
>>
>> +	ret = arch_uprobes_init();
>> +	if (ret)
>> +		return ret;
>> +
>>   	return register_die_notifier(&uprobe_exception_nb);
>>   }
>>   module_init(init_uprobes);
>
> IOW, why do we need to call arch_uprobes_init() from init_uprobes().
>
> Oleg
>

I don't know how you would do the initialization without invoking it 
through the module_init function, which I think you can only have one 
of.  Could you explain in more detail what you had in mind?

-dl
