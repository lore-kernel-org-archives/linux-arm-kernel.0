From: dan@debian.org (Daniel Jacobowitz)
Date: Mon, 11 Jan 2010 17:54:36 -0500
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100111223503.GD7925@n2100.arm.linux.org.uk>
References: <20100111215816.GA1068@caradoc.them.org>
	<20100111223503.GD7925@n2100.arm.linux.org.uk>
Message-ID: <20100111225436.GA7408@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 10:35:03PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 11, 2010 at 04:58:16PM -0500, Daniel Jacobowitz wrote:
> > The problem I'm solving is that of stepping through IT blocks.  We
> > shouldn't use the BKPT instruction, which would interfere with an
> > attached hardware debugger.  The undefined instruction pattern
> > currently used as a breakpoint will not trigger an exception if the IT
> > block flags prevent its execution.  And without adding most of a
> > Thumb-2 simulator to GDB, we can't statically predict what the
> > next instruction will do to the CPSR flags, so we don't know which
> > of the following instructions in the IT block will be executed.
> 
> Can't you read the CPSR in gdb, and look at the IT state bits?  See
> A2.5.2 and CPSR register format in the ARM ARM.

I already have code to do that, but it's not enough on its own.

It's easy to tell whether the instruction at the current pc will be
executed, but hard to tell whether the following instruction will be
executed.  Software single step works by computing the pc after
execution of the next instruction, and setting a breakpoint there; but
to get this right GDB would have to simulate the flag setting effects
of every possible 32-bit Thumb instruction (the 16-bit ones mostly
don't set flags inside the IT block).

In the example from my mail:

   cmp   r0, r0
   itt   eq
A: cmpeq r0, r1
B: moveq r0, r2
C: nop

The cmpeq can be an adcs.w, eors.w, et cetera.  We're at A, trying to
figure out whether to put a breakpoint on B or C (both of which could
validly be branches).

It's possible I've missed something obvious, of course!

-- 
Daniel Jacobowitz
CodeSourcery
