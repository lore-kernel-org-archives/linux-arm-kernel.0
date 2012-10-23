From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 23 Oct 2012 22:32:44 +0200
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <alpine.LFD.2.02.1210111103230.16518@xanadu.home>
References: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
 <1349959402-24164-1-git-send-email-robherring2@gmail.com>
 <20121011130955.GP4625@n2100.arm.linux.org.uk> <5076CA43.9070503@gmail.com>
 <20121011134130.GQ4625@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1210111103230.16518@xanadu.home>
Message-ID: <5086FEEC.5090203@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2012 05:44 PM, Nicolas Pitre wrote:
> On Thu, 11 Oct 2012, Russell King - ARM Linux wrote:
> 
>> On Thu, Oct 11, 2012 at 08:31:47AM -0500, Rob Herring wrote:
>>> On 10/11/2012 08:09 AM, Russell King - ARM Linux wrote:
>>>> On Thu, Oct 11, 2012 at 07:43:22AM -0500, Rob Herring wrote:
>>>>> The contents of this were already reviewed on this thread, so I sent this
>>>>> to the patch system and this was Russell's reply:
>>>>
>>>> So that's why I couldn't find it - the mailing list thread has a different
>>>> subject line to the patch.  Don't do that.  Given the amount of list
>>>> traffic we have today, that's as good as not having been posted at all.
>>>>
>>>>>> NAK for two reasons.
>>>>>>
>>>>>> 1. It hasn't been on the list (I can't find a match for "clear SCTLR.A"
>>>>>> in my mailbox)
>>>>>>
>>>>>> 2. The behaviour of unaligned accesses vary depending on CPU.  Some
>>>>>> fix-up the access, others load the word and then rotate it.  If we have
>>>>>> decompressors which perform unaligned accesses, we need to fix this
>>>>>> properly to avoid the CPU specific behaviour, rather than tweaking
>>>>>> control bits to hide the problem.
>>>>>
>>>>> I'm simply matching the behavior of the kernel itself. The A bit is cleared
>>>>> for v7 kernels and compilers only generate unaligned accesses for v7.
>>>>> Without this the initial state of the A bit is undefined as a bootloader
>>>>> could have cleared it already. We should document the required state or set
>>>>> it to what we want.
>>>>
>>>> Irrespective of this, (2) still stands.  Unaligned accesses in the
>>>> decompressor without a fixup (which will be very hard to provide)
>>>> will return different data depending on the CPU as I mention in point
>>>> 2.
>>>
>>> This only affects v7 cores. It should not vary for v7 cores as unaligned
>>> access is a required feature. So how is it going to vary on v7 CPUs?
>>> We've got bigger problems if there are v7 cores that don't handle
>>> unaligned accesses.
>>
>> Rob,
>>
>> Your patch may only affect v7 cores, but you've raised the issue of the
>> decompressor performing unaligned accesses in general.  Shall I re-repeat
>> my point over that or is the problem here going to finally sink in?
> 
> The decompressor is not performing direct unaligned accesses.  It uses 
> the get_unaligned() and put_unaligned() accessors.  That means that 
> we're in control of how this is happening.
> 
> So let's talk about the how.  On pre ARMv7, those accesses are performed 
> with a series of byte accesses.  When compiling for ARMv7, gcc knows and 
> that the hardware can do unaligned accesses, and it does optimize its 
> output by using ldr/str instructions.  But the A bit has to be cleared 
> in that case, and only in that case.  This is why the patch clears the A 
> bit only for ARMv7.
> 
> So this patch is only setting up the hardware to match gcc's 
> expectations when generating code from the use of get_unaligned() and 
> put_unaligned() when optimizing for ARMv7.
> 
> As always, any code doing unaligned access and _not_ using those 
> accessors is broken.

So is there a chance that this patch will be applied for 3.7?

Currently I can't boot anymore Armada XP or Armada 370, if kernel is
compressed in LZO. It's annoying.

Russell, did Nicolas manage to convince you?
If not, what should be the solution to fix this issue?

Thanks,

Gregory
