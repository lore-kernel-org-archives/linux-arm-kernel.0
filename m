From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 15 May 2013 18:29:03 +0200
Subject: [PATCH 3/4] ARM: mm: kill unused TLB_CAN_READ_FROM_L1_CACHE and
 use ALT_SMP instead
In-Reply-To: <20130515154113.GM23869@mudshark.cambridge.arm.com>
References: <1364235581-17900-1-git-send-email-will.deacon@arm.com>
 <1364235581-17900-4-git-send-email-will.deacon@arm.com>
 <51938B3D.2070508@free-electrons.com>
 <20130515134117.GH23869@mudshark.cambridge.arm.com>
 <51939386.7010709@free-electrons.com>
 <20130515140607.GI23869@mudshark.cambridge.arm.com>
 <51939FBC.3060705@free-electrons.com>
 <20130515150402.GK23869@mudshark.cambridge.arm.com>
 <5193AB8B.90100@free-electrons.com>
 <20130515154113.GM23869@mudshark.cambridge.arm.com>
Message-ID: <5193B7CF.2020208@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2013 05:41 PM, Will Deacon wrote:
> On Wed, May 15, 2013 at 04:36:43PM +0100, Gregory CLEMENT wrote:
>> On 05/15/2013 05:04 PM, Will Deacon wrote:
>>> On Wed, May 15, 2013 at 03:46:20PM +0100, Gregory CLEMENT wrote:
>>>> On 05/15/2013 04:06 PM, Will Deacon wrote:
>>>>> You could also try deleting both of the ALT_* lines and just putting a
>>>>> W(nop) in there directly.
>>>>
>>>> If I just delete the both of the ALT_* lines it no more hangs.
>>>> If I put a  W(nop) instead it hangs.
>>
>> It also hang with a simple nop by the way
> 
> Ok. Have you tried adding a different instruction (mov r0, r0, for example)?

it hanged again :(

I also try to boot a kernel in Thumb2, it doesn't hang in the same place but the kernel
crash latter

> 
>>>
>>> Wow. This doesn't sound good for your CPU and you might want to check with
>>> the Marvell guys...
>>>
>>> Extra things you could try:
>>>
>>> 	- Try adding a 16-bit nop instead (remove the W, build thumb-2 and
>>> 	  double check in your diasassembly)
>>>
>>> 	- Try adding the W(nop) to other places in the kernel and see if you
>>> 	  can tickle the lock-up elsewhere.
>>
>> I managed to add  W(nop) elsewhere in the kernel without getting any lock-up.
>>
>> Is the fact that this nop is the first instruction of the macro could have an
>> influence ?
> 
> I can't think why -- the macro is just expanded inline during assembly.

If I put anything before the "dcache_line_size r2, r3" line the kernel hang, but
just after it's ok.
> 
>>
>>>
>>> 	- Can you reproduce on the Armada XP? (since I have access to one of
>>> 	  those)
>>
>> No on Armada XP I don't have this kind of problem even on UP.
> 
> Is that compiling with CONFIG_SMP=n?
Yes

> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
