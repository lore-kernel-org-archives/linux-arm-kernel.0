From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Mon, 13 Jun 2011 13:40:21 +0100 (BST)
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <20110613122601.GC12325@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>
	<20110613122601.GC12325@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1106131334190.25153@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 13 Jun 2011, Russell King - ARM Linux wrote:

> On Mon, Jun 13, 2011 at 01:04:02PM +0100, Frank Hofmann wrote:
>>   To make it clear: IF AND ONLY IF your suspend(-to-ram) func looks like:
>>
>> 	ENTRY(acmeSoC_cpu_suspend)
>> 		stmfd	sp!, {r4-r12,lr}
>> 		ldr	r3, resume_mmu_done
>> 		bl	cpu_suspend
>> 	resume_mmu_done:
>> 		ldmfd	sp!, {r3-r12,pc}
>> 	ENDPROC(acmeSoC_cpu_suspend)
>
> Nothing has that - because you can't execute that ldmfd after the call
> to cpu_suspend returns.  I don't think you've understood what I said on
> that subject in the previous thread.
>

Sorry typo.

Missed the critical lines:

ENTRY(acmeSoC_cpu_suspend)
 	stmfd	sp!, {r3-r12,lr}
 	ldr	r3, =resume_mmu_done
 	[ load r1 with v:p, whichever way - either you or your caller ]

 	bl cpu_suspend

 	[ ... do whatever low power entry stuff ... ]

 	[ function effectively ENDS HERE ... ]

resume_mmu_done:
 	ldmfd	sp!, {r3-r12,pc}



That's the key bits. DO NOTHING OF RELEVANCE BEFORE cpu_suspend AND DO 
NOTHING APART FROM ENTERING LOW POWER AFTERWARDS.


I _have_ understood what you've said. cpu_suspend is not made for this 
purpose, and hence I'm not claiming it should be. The use of it to create 
the core state snapshot for hibernation is merely something that, right 
now, works _by accident_ (or sheer luck, if you want to say that) rather 
than by intent / design.

Since there _is no design_ for what should work / how it should work in 
this context, I'm leaving it as-is, merely stating the constraints. Roll 
your own if you need / want to.


Does that clarify ?


FrankH.
