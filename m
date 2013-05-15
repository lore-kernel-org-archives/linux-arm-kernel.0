From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 15 May 2013 17:36:43 +0200
Subject: [PATCH 3/4] ARM: mm: kill unused TLB_CAN_READ_FROM_L1_CACHE and
 use ALT_SMP instead
In-Reply-To: <20130515150402.GK23869@mudshark.cambridge.arm.com>
References: <1364235581-17900-1-git-send-email-will.deacon@arm.com>
 <1364235581-17900-4-git-send-email-will.deacon@arm.com>
 <51938B3D.2070508@free-electrons.com>
 <20130515134117.GH23869@mudshark.cambridge.arm.com>
 <51939386.7010709@free-electrons.com>
 <20130515140607.GI23869@mudshark.cambridge.arm.com>
 <51939FBC.3060705@free-electrons.com>
 <20130515150402.GK23869@mudshark.cambridge.arm.com>
Message-ID: <5193AB8B.90100@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2013 05:04 PM, Will Deacon wrote:
> On Wed, May 15, 2013 at 03:46:20PM +0100, Gregory CLEMENT wrote:
>> On 05/15/2013 04:06 PM, Will Deacon wrote:
>>> You could also try deleting both of the ALT_* lines and just putting a
>>> W(nop) in there directly.
>>
>> If I just delete the both of the ALT_* lines it no more hangs.
>> If I put a  W(nop) instead it hangs.

It also hang with a simple nop by the way

> 
> Wow. This doesn't sound good for your CPU and you might want to check with
> the Marvell guys...
> 
> Extra things you could try:
> 
> 	- Try adding a 16-bit nop instead (remove the W, build thumb-2 and
> 	  double check in your diasassembly)
> 
> 	- Try adding the W(nop) to other places in the kernel and see if you
> 	  can tickle the lock-up elsewhere.

I managed to add  W(nop) elsewhere in the kernel without getting any lock-up.

Is the fact that this nop is the first instruction of the macro could have an
influence ?


> 
> 	- Can you reproduce on the Armada XP? (since I have access to one of
> 	  those)

No on Armada XP I don't have this kind of problem even on UP.

> 
>>> Early in boot (head.S:__fixup_smp), we detect whether the CPU has the MP
>>> extensions then, if we're actually UP but the kernel has CONFIG_SMP=y, we
>>> walk over the .alt.smp.init section looking at each entry in there. The
>>> ALT_UP macro spits out an (address, instruction) pair, so in
>>> __do_fixup_smp_on_up, we store the instruction to the address for each pair,
>>> replacing the SMP instruction which sat there in the compiled image.
>>>
>>> It could be that the CPUID checks are failing on your Marvell part. Can you
>>> tell me what you have in your mpidr (mrc p15, 0, Rd, c0, c0, 5) and also
>>> your midr (mrc p15, 0, Rd, c0, c0) please?
>>
>> mpidr= 0x0
>> midr= 0x561F5811
> 
> Should be fine, but it doesn't look like the patching is the issue here.
> 
> Will
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
