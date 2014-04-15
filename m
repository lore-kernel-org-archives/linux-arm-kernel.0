From: davem@davemloft.net (David Miller)
Date: Tue, 15 Apr 2014 15:51:12 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140415192915.GT24070@n2100.arm.linux.org.uk>
References: <20140415.143054.770827409393483803.davem@davemloft.net>
 <20140415.145006.2299301203857235456.davem@davemloft.net>
 <20140415192915.GT24070@n2100.arm.linux.org.uk>
Message-ID: <20140415.155112.749167433771714690.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 15 Apr 2014 20:29:15 +0100

> On Tue, Apr 15, 2014 at 02:50:06PM -0400, David Miller wrote:
>> From: David Miller <davem@davemloft.net>
>> Date: Tue, 15 Apr 2014 14:30:54 -0400 (EDT)
>> 
>> > Russell, if for example userland stores into the instruction stream
>> > to patch an instruction, what needs to be done on ARM?
>> 
>> Looking around I suspect something like:
>> 
>> 	mcrne	p15, 0, INSN_ADDR, c7, c5, 1
>> 
>> after the instruction stores will do it.
> 
> It does still need to be pushed out of the D-cache first though.  So,
> for ARMv7 for example:
> 
> 	str	NEW_INSN, [INSN_ADDR]		@ store new instruction
> 	mcr	p15, 0, INSN_ADDR, c7, c11, 1	@ clean d line
> 	mcr	p15, 0, INSN_ADDR, c7, c5, 1	@ flush i line
> 
> would do it.  We of course need the user access marking on that (so that
> any fault doesn't oops the kernel) - not only for the store, but also the
> following two instructions which could fault (and oops unless they're
> marked with a fixup) if someone were to munmap() this page in another
> thread.  All those fixups can just do the "lets return -EFAULT" from
> the operation.

Right, you'd need the exception table business used in put_user() et al.
