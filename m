From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 23 Jan 2014 11:32:18 -0800
Subject: [PATCH] arm64: Add CONFIG_CC_STACKPROTECTOR
In-Reply-To: <alpine.LFD.2.11.1401231419110.1652@knanqh.ubzr>
References: <1390325166-16840-1-git-send-email-lauraa@codeaurora.org>
 <20140122112847.GG1621@mudshark.cambridge.arm.com>
 <52E00AFF.1060701@codeaurora.org>
 <alpine.LFD.2.11.1401231419110.1652@knanqh.ubzr>
Message-ID: <52E16E42.5040000@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/23/2014 11:23 AM, Nicolas Pitre wrote:
> On Wed, 22 Jan 2014, Laura Abbott wrote:
>> On 1/22/2014 3:28 AM, Will Deacon wrote:
>>> On Tue, Jan 21, 2014 at 05:26:06PM +0000, Laura Abbott wrote:
>>>> @@ -288,6 +294,9 @@ struct task_struct *__switch_to(struct task_struct
>>>> @@ *prev,
>>>>    {
>>>>     struct task_struct *last;
>>>>
>>>> +#if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
>>>> +	__stack_chk_guard = next->stack_canary;
>>>> +#endif
>>>
>>> I don't get the dependency on !SMP. Assumedly, the update of
>>> __stack_chk_guard would be racy otherwise, but that sounds solvable with
>>> atomics. Is the stack_canary updated periodically somewhere else?
>>>
>>
>> It has nothing to do with atomics, it's the fact that __stack_chk_guard is a
>> global variable and with SMP you can have n different processes running each
>> with a different canary (see kernel/fork.c, dup_task_struct) . c.f the commit
>> added by Nicolas Pitre:
>>
>> commit df0698be14c6683606d5df2d83e3ae40f85ed0d9
>> Author: Nicolas Pitre <nico@fluxnic.net>
>> Date:   Mon Jun 7 21:50:33 2010 -0400
>>
>>      ARM: stack protector: change the canary value per task
>>
>>      A new random value for the canary is stored in the task struct whenever
>>      a new task is forked.  This is meant to allow for different canary
>> values
>>      per task.  On ARM, GCC expects the canary value to be found in a global
>>      variable called __stack_chk_guard.  So this variable has to be updated
>>      with the value stored in the task struct whenever a task switch occurs.
>>
>>      Because the variable GCC expects is global, this cannot work on SMP
>>      unfortunately.  So, on SMP, the same initial canary value is kept
>>      throughout, making this feature a bit less effective although it is
>> still
>>      useful.
>>
>>      One way to overcome this GCC limitation would be to locate the
>>      __stack_chk_guard variable into a memory page of its own for each CPU,
>>      and then use TLB locking to have each CPU see its own page at the same
>>      virtual address for each of them.
>>
>>      Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>
> Did gcc for Aarch64 replicate the same global variable arrangement?
> That would be unfortunate...
>

Based on my experiments they did unfortunately do so.

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
