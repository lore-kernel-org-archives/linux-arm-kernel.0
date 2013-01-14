From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Jan 2013 15:21:22 +0000
Subject: Question: ARM: local timers: add num_possible_cpus() in
 local_timer_register()
In-Reply-To: <CAKvkGKfxT6cQF6rXmYZEL5tJbtsm0Yv4i1D_9NXQRsdbNFi2PQ@mail.gmail.com>
References: <20130114133345.GA26701@android11.spreadtrum.com>
 <50F413EA.5010403@arm.com>
 <CAKvkGKfxT6cQF6rXmYZEL5tJbtsm0Yv4i1D_9NXQRsdbNFi2PQ@mail.gmail.com>
Message-ID: <50F42272.3010804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/01/13 14:31, steve.zhan wrote:
> Hi,
>     Russel, Marc,
> 2013/1/14 Marc Zyngier <marc.zyngier@arm.com>:
>> On 14/01/13 13:33, Steve zhan wrote:
>>
>> Hi Steve,
>>
>>>       Do you think we should add num_possible_cpus() in
>>> local_timer_register() function, When core number is
>>>> 1, then reutrn TRUE? Enable the local timer only if
>>> we have more than one CPU, if the current config is
>>> SMP and setup_max_cpus >= 1, but if smp_init_cpus in
>>> platform code have set cpu possible value to One(that
>>> maybe read number from scu or other hardware), then
>>> percpu_timer_setup in smp_prepare_cpus have no chance
>>> to be called.
>>>
>>>       For local timer, because local_timer_register have
>>> return 1, that will miss global timer register.
>>>
>>>       Could you pls check it?
>>
>> I'm not sure I understand your question.
>>
>> We only enable the use of the SMP local timers infrastructure if we're
>> SMP and we have more that one CPU. If you only have one CPU up and
>> running, then you can still use your CPU local timer as a global timer.
>>
>> What would we gain by using the local timer infrastructure when we're
>> not running on SMP hardware?
>>
>>         M.
>> --
>> Jazz is not dead. It just smells funny...
>>
> 
> For these code:
>         err = local_timer_register(&arch_timer_ops);
>         if (err) {
>                 /*
>                  * We couldn't register as a local timer (could be
>                  * because we're on a UP platform, or because some
>                  * other local timer is already present...). Try as a
>                  * global timer instead.
>                  */
>                 arch_timer_global_evt.cpumask = cpumask_of(0);
>                 err = arch_timer_setup(&arch_timer_global_evt);
>         }
> 
> if err == 0, we have no register global arch timer,  but platform code
> platsmp.c will set
> cpu possible number to one, that let percpu_timer_setup in
> smp_prepare_cpus have no
> chance to call becaue ncores = num_possible_cpus() is one.
> Is this right?

Ah, I get it now. Yes, this is a problem. Mark Rutland's patch series
actually fixes this issue entirely though. You may want to check it out.

	M.
-- 
Jazz is not dead. It just smells funny...
