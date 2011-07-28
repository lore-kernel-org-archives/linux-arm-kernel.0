From: scwilliams@nvidia.com (Scott Williams)
Date: Thu, 28 Jul 2011 10:14:00 -0700
Subject: cpu_suspend does not flush the L2 cache
In-Reply-To: <4E313283.9090807@ti.com>
References: <74C67D49A66F0848B6F4548360B2EDB58DED35BC42@HQMAIL04.nvidia.com>
	<20110725200820.GE14955@n2100.arm.linux.org.uk>
	<CAGsJ_4xSyiJOBf_sBw7eKZY3B+un-zO0tYUKtW5FDkWoBhgLjQ@mail.gmail.com>
	<4E313283.9090807@ti.com>
Message-ID: <74C67D49A66F0848B6F4548360B2EDB58DED35BD6E@HQMAIL04.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the CPU idle case where only one CPU is shutting down, disabling the L2 cache is not an option. I've done experiments cleaning only the lines containing the CPU context (failed after < 100 cpu_suspend cycles) and cleaning the entire L2 cache (failed after ~36K cycles) with additional flushes of the L1 data cache before exiting coherency. The system eventually panics because of an invalid PMD. Initial analysis points to spin lock failure. This only solution I've found so far is to disable the L2 cache entirely (has so far survived >120K cycles). 

--
nvpublic 

-----Original Message-----
From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com] 
Sent: Thursday, July 28, 2011 2:57 AM
To: Barry Song
Cc: Russell King - ARM Linux; Rongjun Ying; Scott Williams; yuping.luo; linux-arm-kernel at lists.infradead.org; Dan Willemsen
Subject: Re: cpu_suspend does not flush the L2 cache

On 7/28/2011 1:45 PM, Barry Song wrote:
> 2011/7/26 Russell King - ARM Linux<linux@arm.linux.org.uk>:
>> On Mon, Jul 25, 2011 at 11:49:43AM -0700, Scott Williams wrote:
>>> In 2.6.39, CPU suspend/resumes crashes if an outer cache controller
>>> (like a PL310) is configured and enabled. cpu_suspend only flushes
>>> the L1 cache.
>>
>> Correct.  cpu_suspend is been a _consolidation_ effort across the various
>> implementations.  Only one implementation deals with the L2 cache issues
>> at present.
>>
>> A bunch of patches have gone in during this merge window to continue
>> that consolidation effort and improve the cpu_suspend interfaces.
>> Eventually the L2 cache issues will be dealt with in core code.
>>
>> So at the moment, platforms are expected to deal with this in their own
>> suspend finisher code.
>
> So one possible way is that platforms clean and flush L2 cache while
> suspending, then disable L2.
> After resuming from wake-up entry, platforms reinitilized L2 by some
> hardware setting and l2x_init.
>
Flushing is not going to address other scenario's with L2. There are 
issues even when only CPU lost it's context and while re-enabling
MMU on it in power up sequence, L2 creates an issue.

>>
>> FYI, I have no platforms at present with L2 cache and are capable of
>> suspend.  I'm still waiting on TI for some prototype code for OMAP4
>> suspend support... until that time, I am unable to progress it further
>> unless I try to address these issues blind.
>
Hopefully we can sort out this issue considering Russell has the
OMAP4 PM code to experiment now.

> On SiRFprimaII, we have tried the suspend/resume when L2 is on. i'd
> like to give a platform example.
> Finally, L2 cache suspend/resume can be in core code.
>>
Flushing L2 isn't solution for the case where L2 memory is
retained but Logic is lost. You might use such states in
CPUIDLE.
For suspend though this will work because you always try
to go to deepest possible low power state and in that
case.

Regards
Santosh
