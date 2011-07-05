From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Tue, 5 Jul 2011 14:37:46 +0200
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <alpine.DEB.2.00.1106151349520.11405@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>	<20110613122601.GC12325@n2100.arm.linux.org.uk>	<alpine.DEB.2.00.1106131400090.25153@localhost6.localdomain6>	<20110613164452.GE13643@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106151349520.11405@localhost6.localdomain6>
Message-ID: <4E13059A.4060606@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frank Hofmann a ?crit :
> On Mon, 13 Jun 2011, Russell King - ARM Linux wrote:
> 
>> On Mon, Jun 13, 2011 at 02:20:12PM +0100, Frank Hofmann wrote:
>>>
>>> On Mon, 13 Jun 2011, Russell King - ARM Linux wrote:
>>>
>>>> On Mon, Jun 13, 2011 at 01:04:02PM +0100, Frank Hofmann wrote:
>>>>>   To make it clear: IF AND ONLY IF your suspend(-to-ram) func looks like:
>>>>>
>>>>> 	ENTRY(acmeSoC_cpu_suspend)
>>>>> 		stmfd	sp!, {r4-r12,lr}
>>>>> 		ldr	r3, resume_mmu_done
>>>>> 		bl	cpu_suspend
>>>>> 	resume_mmu_done:
>>>>> 		ldmfd	sp!, {r3-r12,pc}
>>>>> 	ENDPROC(acmeSoC_cpu_suspend)
>>>> Nothing has that - because you can't execute that ldmfd after the call
>>>> to cpu_suspend returns.  I don't think you've understood what I said on
>>>> that subject in the previous thread.
>>>>
>>> Ok, to illustrate a bit more, what is ok and what not.
>> Actually, we can do something about cpu_suspend.
>>
>> Currently cpu_suspend is not like a normal C function - when it's called
>> it returns normally to a bunch of code which is not expected to return.
>> The return path is via code pointed to by 'r3'.
>>
>> It also corrupts a bunch of registers in ways which make it non-compliant
>> with a C API.
>>
>> If we do make this complaint as a normal C-like function, it eliminates
>> this register saving.  We also swap 'lr' and 'r3', so cpu_suspend
>> effectively only returns to following code on resume - and r3 points
>> to the suspend code.
> 
> Hi Russell,
> 
> 
> this change is perfect; with this, the hibernation support code turns into 
> the attached.
> That's both better and simpler to perform a full suspend/resume cycle (via 
> resetting in the cpu_suspend "finisher") after the snapshot image has been 
> created, instead of shoehorning a return into this.
> 


> 
> +static void notrace __swsusp_arch_restore_image(void)
> +{
> +	extern struct pbe *restore_pblist;
> +	struct pbe *pbe;
> +
> +	cpu_switch_mm(swapper_pg_dir, &init_mm);
> +
> +	for (pbe = restore_pblist; pbe; pbe = pbe->next)
> +		copy_page(pbe->orig_address, pbe->address);
> +

One question : isn't dangerous to modify the code where we are running ?

I believe the code shouldn't change too much between the kernel that do the
resume and the resumed kernel and the copy routine should fit in the instruction
cache, but I want to be sure it doesn't cause any problem on recent arm cores
(instruction prefetching , ...)


Matthieu
