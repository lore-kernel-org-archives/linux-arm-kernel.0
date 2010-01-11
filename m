From: dan@debian.org (Daniel Jacobowitz)
Date: Mon, 11 Jan 2010 18:17:02 -0500
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100111231027.GA30714@shareable.org>
References: <20100111215816.GA1068@caradoc.them.org>
	<20100111223503.GD7925@n2100.arm.linux.org.uk>
	<20100111225436.GA7408@caradoc.them.org>
	<20100111231027.GA30714@shareable.org>
Message-ID: <20100111231702.GA9485@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 11:10:27PM +0000, Jamie Lokier wrote:
> Isn't the itt sequence for Thumb-2 supposed to be consistent with the
> condition sequence for ARM, so that it should be:
> 
>     cmp   r0, r0
>     itt   eq
>  A: cmpeq r0, r1
>  B: movne r0, r2   <- that is, ne not eq, because it's the "then" branch
>  C: nop

No, that'd be if you wrote "ite eq".  This is a more complicated
sequence; you can get the ARM equivalent by ignoring the itt
instruction (the assembler will just use it for a consistency check).

This block is "(r0 == r0 && r0 == r1) -> r0 = r2".

> And does the cmp at A really affect execution of the instructions at B
> and C in a Thumb-2 itt sequence, rather than the condition being
> checked once at the time of the itt instruction and played out for the
> following 3 instructions?

Yes, it really does.  Useful for compound conditions, and for maximal
confusion.  Thankfully, both branches into IT blocks and branches
leaving IT blocks not at the last instruction are forbidden.

-- 
Daniel Jacobowitz
CodeSourcery
