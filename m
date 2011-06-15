From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Wed, 15 Jun 2011 14:35:26 +0100 (BST)
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <20110613164452.GE13643@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>
	<20110613122601.GC12325@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106131400090.25153@localhost6.localdomain6>
	<20110613164452.GE13643@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1106151349520.11405@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jun 2011, Russell King - ARM Linux wrote:

> On Mon, Jun 13, 2011 at 02:20:12PM +0100, Frank Hofmann wrote:
>>
>>
>> On Mon, 13 Jun 2011, Russell King - ARM Linux wrote:
>>
>>> On Mon, Jun 13, 2011 at 01:04:02PM +0100, Frank Hofmann wrote:
>>>>   To make it clear: IF AND ONLY IF your suspend(-to-ram) func looks like:
>>>>
>>>> 	ENTRY(acmeSoC_cpu_suspend)
>>>> 		stmfd	sp!, {r4-r12,lr}
>>>> 		ldr	r3, resume_mmu_done
>>>> 		bl	cpu_suspend
>>>> 	resume_mmu_done:
>>>> 		ldmfd	sp!, {r3-r12,pc}
>>>> 	ENDPROC(acmeSoC_cpu_suspend)
>>>
>>> Nothing has that - because you can't execute that ldmfd after the call
>>> to cpu_suspend returns.  I don't think you've understood what I said on
>>> that subject in the previous thread.
>>>
>>
>> Ok, to illustrate a bit more, what is ok and what not.
>
> Actually, we can do something about cpu_suspend.
>
> Currently cpu_suspend is not like a normal C function - when it's called
> it returns normally to a bunch of code which is not expected to return.
> The return path is via code pointed to by 'r3'.
>
> It also corrupts a bunch of registers in ways which make it non-compliant
> with a C API.
>
> If we do make this complaint as a normal C-like function, it eliminates
> this register saving.  We also swap 'lr' and 'r3', so cpu_suspend
> effectively only returns to following code on resume - and r3 points
> to the suspend code.

Hi Russell,


this change is perfect; with this, the hibernation support code turns into 
the attached.

That's both better and simpler to perform a full suspend/resume cycle (via 
resetting in the cpu_suspend "finisher") after the snapshot image has been 
created, instead of shoehorning a return into this.


I've tested the attached on v6 (samsung) and v7 (omap3 nonsecure - yes I 
know ...) kernels that have the cpu_suspend changes in you've posted 
Monday.

It does what it's supposed to do. And yes, aware that's not enough yet, 
this is only an attempt to address the "how to snapshot the core state", 
other outstanding issues will be addressed later.


It'd be great to know why this makes your toenails curl so much ...

Anyway, this again shows that as far as the core SoC state is concerned, 
the only difference between the hibernation snapshot and the s2ram soc 
suspend side are what the "finisher" does:

 	hibernate:		s2ram:

 	swsusp_save()		low power self-refresh settings, ...
 	<reset>			<poweroff>

Why would calling swsusp_save() not be acceptable in this context ? It's 
supposed to run in a restricted env (no ints, no scheduling, ...) anyway.


FrankH.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hibernation-15Jun2011.patch
Type: text/x-diff
Size: 5726 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110615/b7790fe8/attachment-0001.bin>
