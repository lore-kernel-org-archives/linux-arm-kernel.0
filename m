From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 May 2015 12:32:59 -0600
Subject: BCM2836 (Raspberry Pi 2) port
In-Reply-To: <87wq0c4bgv.fsf@eliezer.anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <4137213.WVJY1et48u@kongar> <55516738.306@wwwdotorg.org>
 <1701192.WcfjCoBWQN@kongar> <55522468.3050606@wwwdotorg.org>
 <87d2254s6y.fsf@eliezer.anholt.net> <555278BA.50903@wwwdotorg.org>
 <87wq0c4bgv.fsf@eliezer.anholt.net>
Message-ID: <555398DB.8050206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2015 11:46 AM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
>
>> On 05/12/2015 11:32 AM, Eric Anholt wrote:
>>> Stephen Warren <swarren@wwwdotorg.org> writes:
>>>
>>>> On 05/12/2015 09:39 AM, Alexander Stein wrote:
>>>>> On Monday 11 May 2015, 20:36:40 wrote Stephen Warren:
>>>>>> On 05/08/2015 10:14 AM, Alexander Stein wrote:
>>>>>>> On Thursday 23 April 2015, 22:25:08 wrote Stephen Warren:
>>>>>>>>> Hit any key to stop autoboot:  0
>>>>>>>>> U-Boot> setenv fdt_high fffffff
>>>>>>>
>>>>>>> Any specific reason to set fdt_high to fffffff?
>>>>>>
>>>>>> Yes, it prevents U-Boot's annoying habit of moving the DTB from where it
>>>>>> was loaded to some other place. This was especially important in this
>>>>>> case since I was trying to find out exactly which piece of RAM being
>>>>>> over-written caused the issues I was seeing.
>>>>>
>>>>> Shouldn't this then be part of the default raspberry (2 only?) environment?
>>>>
>>>> Eventually yes. So far, nobody seems to know which areas of RAM are
>>>> off-limits (presumably since the RAM is used as a CPU1..3 pen), so I was
>>>> experimenting to try and find that out.
>>>
>>> If I'm reading this right, the CPU1-3 pen is in the bottom 8k of memory
>>> (actually much less than 8k).
>>
>> Hmm. I wondered if that was the case. I don't think anything I was doing
>> in U-Boot /should/ touch those pages, but there have been bugs before
>> where some pointer was left at NULL, and some DM (U-Boot Device Model)
>> code ended up putting structures in page 0 by mistake. Perhaps something
>> like that has resurfaced. I'll try to find time to diff page 0
>> before/after various U-Boot operations, and see if it's getting modified...
>
> How about on the Linux side?  What's reserving that memory for us, if
> anything?

Likely nothing at present. I was starting to see what looked like 
SMP-pen-related issues just in U-Boot, before even attempting to boot a 
kernel at all. So, I didn't put any though into how to communicate this 
to the kernel.

>  Weird things happen if I put "ARM: bcm2836: Add a DT binding
> for the ARM local registers." and "ARM: bcm2835: Use a syscon regmap to
> set up timer frequency." before the SMP support in the bcm2836-smp tree
> (init crashes).

This issue would probably explain that; if the kernel just happens to 
allocate a physical page of RAM that overlaps the SMP pen memory.

A /memreserve/ in the DT would probably solve this. Adjusting the 
content of the /memory/reg property to remove the SMP pen would likely 
work too.

Is there no way to disable CPU1..n other than using an SMP pen in 
memory? If the CPUs simply weren't executing anything at all, but could 
be unblocked/powered-up/... later, that'd simplify life.
