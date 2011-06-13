From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2011 17:44:52 +0100
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <alpine.DEB.2.00.1106131400090.25153@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>
	<20110613122601.GC12325@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106131400090.25153@localhost6.localdomain6>
Message-ID: <20110613164452.GE13643@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 02:20:12PM +0100, Frank Hofmann wrote:
>
>
> On Mon, 13 Jun 2011, Russell King - ARM Linux wrote:
>
>> On Mon, Jun 13, 2011 at 01:04:02PM +0100, Frank Hofmann wrote:
>>>   To make it clear: IF AND ONLY IF your suspend(-to-ram) func looks like:
>>>
>>> 	ENTRY(acmeSoC_cpu_suspend)
>>> 		stmfd	sp!, {r4-r12,lr}
>>> 		ldr	r3, resume_mmu_done
>>> 		bl	cpu_suspend
>>> 	resume_mmu_done:
>>> 		ldmfd	sp!, {r3-r12,pc}
>>> 	ENDPROC(acmeSoC_cpu_suspend)
>>
>> Nothing has that - because you can't execute that ldmfd after the call
>> to cpu_suspend returns.  I don't think you've understood what I said on
>> that subject in the previous thread.
>>
>
> Ok, to illustrate a bit more, what is ok and what not.

Actually, we can do something about cpu_suspend.

Currently cpu_suspend is not like a normal C function - when it's called
it returns normally to a bunch of code which is not expected to return.
The return path is via code pointed to by 'r3'.

It also corrupts a bunch of registers in ways which make it non-compliant
with a C API.

If we do make this complaint as a normal C-like function, it eliminates
this register saving.  We also swap 'lr' and 'r3', so cpu_suspend
effectively only returns to following code on resume - and r3 points
to the suspend code.

So, this becomes:
	ENTRY(acmeSoC_cpu_suspend)
		stmfd	sp!, {lr}
		adr	r3, soc_finish_suspend
		bl	cpu_suspend
		ldmfd	sp!, {pc}
	ENDPROC(acmeSoC_cpu_suspend)

	soc_finish_suspend:
		blah
		blah
		put soc to sleep
		never return

or even:

static void soc_suspend(void)
{
	[soc specific preparation]

	cpu_suspend(0, PLAT_PHYS_OFFSET - PAGE_OFFSET,
		soc_suspend_arg, soc_suspend_fn);

	[soc specific cleanup ]
}

where soc_suspend_fn can be either assembly or C code - but must never
return.  Patches will follow this evening.
