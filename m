From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Wed, 9 Sep 2015 19:06:21 -0300
Subject: ARM: domains: Possible regression in v7-M
In-Reply-To: <20150909202433.GG21084@n2100.arm.linux.org.uk>
References: <55F06797.3060706@gmail.com>
 <55F06C55.5070205@vanguardiasur.com.ar>
 <20150909175230.GF21084@n2100.arm.linux.org.uk>
 <55F079A5.1010501@vanguardiasur.com.ar>
 <20150909202433.GG21084@n2100.arm.linux.org.uk>
Message-ID: <55F0AD5D.5000707@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


El 09/09/15 a las 17:24, Russell King - ARM Linux escribi?:
> On Wed, Sep 09, 2015 at 03:25:41PM -0300, Ariel D'Alessandro wrote:
>> Russell,
>>
>> El 09/09/15 a las 14:52, Russell King - ARM Linux escribi?:
>>> On Wed, Sep 09, 2015 at 02:28:53PM -0300, Ariel D'Alessandro wrote:
>>>> Doing a bisect I've observed that regression appears to be caused by:
>>>>
>>>> commit 1eef5d2f1b461c120bcd82077edee5ec706ac53b
>>>> Author: Russell King <rmk+kernel@arm.linux.org.uk>
>>>> Date:   Wed Aug 19 21:23:48 2015 +0100
>>>>
>>>>     ARM: domains: switch to keeping domain value in register
>>>>
>>>>
>>>> Stacktrace paste below.
>>>>
>>>> [    0.171071] Unhandled exception: IPSR = 00000006 LR = fffffff1
>>>
>>> This looks to be ARMv7M, which is nommu...  I guess what's causing this
>>> is this change in arch/arm/kernel/process.c:
>>>
>>> +       /*
>>> +        * Copy the initial value of the domain access control register
>>> +        * from the current thread: thread->addr_limit will have been
>>> +        * copied from the current thread via setup_thread_stack() in
>>> +        * kernel/fork.c
>>> +        */
>>> +       thread->cpu_domain = get_domain();
>>> +
>>>
>>> which probably needs to be #ifdef'd out for !MMU.  Can you try adding:
>>>
>>> #ifndef CONFIG_MMU
>>
>> I think you meant #ifdef CONFIG_MMU.
>>
>>> ...
>>> #endif
>>>
>>> around that please?  Thanks.
>>>
>>
>> Yeah, that works!
>>
>> Added:
>>
>> #ifdef CONFIG_MMU
>> ...
>> #endif
>>
>> around that code block and it booted.
> 
> Thanks.  I've settled on using CONFIG_CPU_USE_DOMAINS here, as it only
> makes sense to save this value if that option is set, and it won't be
> set for noMMU platforms.

OK, that makes sense.

> 
> Thanks for reporting this and confirming the problem site.  If you're
> okay with it, I'll add:
> 
> Reported-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
> 
> to the commit to acknowledge your help in finding this.

Sure. Thanks to you for the quick solution.

-- 
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
