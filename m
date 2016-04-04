From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 4 Apr 2016 15:22:28 +0100
Subject: [PATCH] arm64: KVM: unregister notifiers in hyp mode teardown path
In-Reply-To: <5702726D.7000505@arm.com>
References: <1459777611-22592-1-git-send-email-sudeep.holla@arm.com>
 <5702726D.7000505@arm.com>
Message-ID: <570278A4.9060600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/04/16 14:55, Marc Zyngier wrote:
> Hi Sudeep,
>
> On 04/04/16 14:46, Sudeep Holla wrote:

[...]

>> @@ -1270,12 +1279,7 @@ static int init_hyp_mode(void)
>>   	free_boot_hyp_pgd();
>>   #endif
>>
>> -	cpu_notifier_register_begin();
>> -
>> -	err = __register_cpu_notifier(&hyp_init_cpu_nb);
>> -
>> -	cpu_notifier_register_done();
>> -
>> +	err = register_cpu_notifier(&hyp_init_cpu_nb);
>
> We went from something like this to the cpu_notifier_register_begin/end
> with 8146875de ("arm, kvm: Fix CPU hotplug callback registration").
>
> What makes it more acceptable now?
>

Correct, but in the initial code even init_hyp_mode was protected under
cpu_notifier_register_begin, but IIUC recent re-org eliminated the need
for that and the above code exactly resembles what register_cpu_notifier
does.

If that's not the case then we need to move cpu_notifier_register_begin
further up and retain __register_cpu_notifier

I mainly changed it to keep it consistent with unregister call.

-- 
Regards,
Sudeep
