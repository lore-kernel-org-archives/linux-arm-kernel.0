From: yang.shi@linaro.org (Shi, Yang)
Date: Thu, 01 Oct 2015 09:03:05 -0700
Subject: [PATCH] arm64: replace read_lock to rcu lock in call_break_hook
In-Reply-To: <20151001150735.GH6963@e104818-lin.cambridge.arm.com>
References: <1443653944-21885-1-git-send-email-yang.shi@linaro.org>
 <20151001150735.GH6963@e104818-lin.cambridge.arm.com>
Message-ID: <560D5939.7080107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/1/2015 8:07 AM, Catalin Marinas wrote:
> On Wed, Sep 30, 2015 at 03:59:04PM -0700, Yang Shi wrote:
>> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
>> index cebf786..eb520d0 100644
>> --- a/arch/arm64/kernel/debug-monitors.c
>> +++ b/arch/arm64/kernel/debug-monitors.c
>> @@ -292,11 +292,11 @@ static int call_break_hook(struct pt_regs *regs, unsigned int esr)
>>   	struct break_hook *hook;
>>   	int (*fn)(struct pt_regs *regs, unsigned int esr) = NULL;
>>
>> -	read_lock(&break_hook_lock);
>> +	rcu_read_lock();
>>   	list_for_each_entry(hook, &break_hook, node)
>>   		if ((esr & hook->esr_mask) == hook->esr_val)
>>   			fn = hook->fn;
>> -	read_unlock(&break_hook_lock);
>> +	rcu_read_unlock();
>>
>>   	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
>>   }
>
> That's not enough, you also need list_(add|del)_rcu where the list is
> modified, together with list_for_each_entry_rcu() here.

Thanks for pointing it out. I'm going to prepare v2 with list_(add|del)_rcu.

Yang

>
