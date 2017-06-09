From: john.garry@huawei.com (John Garry)
Date: Fri, 9 Jun 2017 16:10:12 +0100
Subject: [PATCH v8 6/9] drivers: perf: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <20170609143050.GM13955@arm.com>
References: <1495457312-237127-1-git-send-email-zhangshaokun@hisilicon.com>
 <20170608163519.GA19643@leverpostej>
 <8666a0fa-126d-e4a3-ac4b-7962f5d79942@huawei.com>
 <20170609143050.GM13955@arm.com>
Message-ID: <0fbf57f0-9ff7-4fd4-07c7-c5e86028a7d2@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2017 15:30, Will Deacon wrote:
> On Fri, Jun 09, 2017 at 03:18:39PM +0100, John Garry wrote:
>> On 08/06/2017 17:35, Mark Rutland wrote:
>>> Hi,
>>>
>>> On Mon, May 22, 2017 at 08:48:32PM +0800, Shaokun Zhang wrote:
>>>> +/*
>>>> + * hisi_djtag_lock_v2: djtag lock to avoid djtag access conflict b/w kernel
>>>> + * and UEFI.
>>>
>>> The mention of UEFI here worries me somewhat, and I have a number of
>>> questions specifically relating to how we interact with UEFI here.
>>>
>>
>> Hi Mark,
>>
>> This djtag locking mechanism is an advisory software-only policy. The
>> problem is the hardware designers made an interface which does not consider
>> multiple agents in the system concurrently accessing the djtag registers.
>>
>> System wide, djtag is used as an interface to other HW modules, but we only
>> use for perf HW in the kernel.
>>
>>> When precisely does UEFI need to touch the djtag hardware? e.g. does
>>> this happen in runtime services? ... or completely asynchronously?
>>>
>>
>> Actually it's trusted firmware which accesses for L3 cache management in CPU
>> hotplug
>>
>>> What does UEFI do with djtag when it holds the lock?
>>>
>>
>> As mentioned, cache management
>>
>>> Are there other software agents (e.g. secure firmware) which try to
>>> take this lock?
>>>
>>
>> No
>>
>>> Can you explain how the locking scheme works? e.g. is this an advisory
>>> software-only policy, or does the hardware prohibit accesses from other
>>> agents somehow?
>>>
>>
>> The locking scheme is a software solution to spinlock. It's uses djtag
>> module select register as the spinlock flag, to avoid using some shared
>> memory.
>>
>> The tricky part is that there is no test-and-set hardware support, so we use
>> this algorithm:
>> - precondition: flag initially set unlocked
>>
>> a. agent reads flag
>>     - if not unlocked, continues to poll
>>     - otherwise, writes agent's unique lock value to flag
>> b. agent waits defined amount of time *uninterrupted* and then checks the
>> flag
>
> How do you figure out this time period? Doesn't it need to be no shorter
> than the longest critical section?
>

Hi Will,

As you know, we need to delay to guard against contenting set-and-check. 
And the ratio in delay duration would be 2:1 for agents to guard against 
race of the contended set-and-check.

As for the specific time, we were working the basis that a delay of 10us 
would be more than adequate time for the set-and-check to complete.

Sorry, but I didn't get critical section question. Are you questioning 
the possiblity of one agent getting the lock, doing it's djtag 
operation, and releasing, all while other agent is waiting on it's own 
set-and-check?

Thanks,
John

> Will
>
> .
>
