From: john.garry@huawei.com (John Garry)
Date: Wed, 14 Jun 2017 12:59:00 +0100
Subject: [PATCH v8 6/9] drivers: perf: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <20170614114039.GN16190@arm.com>
References: <1495457312-237127-1-git-send-email-zhangshaokun@hisilicon.com>
 <20170608163519.GA19643@leverpostej>
 <8666a0fa-126d-e4a3-ac4b-7962f5d79942@huawei.com>
 <20170609143050.GM13955@arm.com>
 <0fbf57f0-9ff7-4fd4-07c7-c5e86028a7d2@huawei.com>
 <20170614100658.GE16190@arm.com> <20170614104230.GC6085@leverpostej>
 <20170614110141.GL16190@arm.com>
 <53af9b5b-ac93-eaf9-8551-75fb25a243aa@huawei.com>
 <20170614114039.GN16190@arm.com>
Message-ID: <7162e895-6a0f-8d83-85fb-f0618c33f4c3@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/2017 12:40, Will Deacon wrote:
> On Wed, Jun 14, 2017 at 12:35:07PM +0100, John Garry wrote:
>> On 14/06/2017 12:01, Will Deacon wrote:
>>> On Wed, Jun 14, 2017 at 11:42:30AM +0100, Mark Rutland wrote:
>>>> On Wed, Jun 14, 2017 at 11:06:58AM +0100, Will Deacon wrote:
>>>>> Apologies, I misunderstood your algorithm (I thought step (a) was on one CPU
>>>>> and step (b) was on another). Still, I don't understand the need for the
>>>>> timeout. If you instead read back the flag immediately, wouldn't it still
>>>>> work? e.g.
>>>>>
>>>>>
>>>>> lock:
>>>>>  Readl_relaxed flag
>>>>>  if (locked)
>>>>>    goto lock;
>>>>>
>>>>>  Writel_relaxed unique ID to flag
>>>>>  Readl flag
>>>>>  if (locked by somebody else)
>>>>>    goto lock;
>>>>>
>>>>> <critical section>
>>>>>
>>>>> unlock:
>>>>>  Writel unlocked value to flag
>>>>>
>>>>>
>>>>> Given that we're dealing with iomem, I think it will work, but I could be
>>>>> missing something obvious.
>>>>
>>>> Don't we have the race below where both threads can enter the critical
>>>> section?
>>>>
>>>> 	// flag f initial zero (unlocked)
>>>>
>>>> 	// t1, flag 1			// t2, flag 2
>>>> 	readl(f); // reads 0		l = readl(f); // reads 0
>>>>
>>>> 	<thinks lock is free>		<thinks lock is free>
>>>>
>>>> 	writel(1, f);
>>>> 	readl(f); // reads 1
>>>> 	<thinks lock owned>
>>>> 					writel(2, f);
>>>> 					readl(f) // reads 2
>>>> 					<thinks lock owned>
>>>>
>>>> 	<crticial section>		<critical section>
>>>
>>> Urgh, yeah, of course and *that's* what the udelay is trying to avoid,
>>> by "ensuring" that the <thinks lock is free> time and subsequent write
>>> propagation is all over before we re-read the flag.
>>>
>>> John -- how much space do you have on this device? Do you have, e.g. a byte
>>> for each CPU?
>>
>> Hi Will,
>>
>> To be clear, the agents in our case are the kernel and UEFI. Within the
>> kernel, we use a kernel spinlock to lock the same djtag between threads, for
>> these reasons:
>> - kernel has a native spinlock
>
> If we only have to effectively deal with two threads, then we might be able
> to use something like Dekker's.
>
>> - we are limited in locking values, as the lock flag is only a 8b field in
>> v2 hw (called module select)
>
> By 8b do you mean 8 bits or 8 bytes? If the latter, does it support sub-word
> accesses?

8 bits

So the size depends: on v1 hw is a 6-bit field in a 32-bit register 
(recent news to me), and on v2 hw it is a 8-bit field in a 32-bit register.

So for reading and writing the flag, we use readl/writel and also 
necessary shifts+masks. Obviously this is not atomic, but the whole 
process of write-and-check is not atomic - hence the delay.

I am not sure if sub-word access is required.

Thanks,
John

>
> Will
>
> .
>
