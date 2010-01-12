From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 12 Jan 2010 00:17:28 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100111231702.GA9485@caradoc.them.org>
References: <20100111215816.GA1068@caradoc.them.org>
	<20100111223503.GD7925@n2100.arm.linux.org.uk>
	<20100111225436.GA7408@caradoc.them.org>
	<20100111231027.GA30714@shareable.org>
	<20100111231702.GA9485@caradoc.them.org>
Message-ID: <20100112001728.GB4465@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Jacobowitz wrote:
> On Mon, Jan 11, 2010 at 11:10:27PM +0000, Jamie Lokier wrote:
> > And does the cmp at A really affect execution of the instructions at B
> > and C in a Thumb-2 itt sequence, rather than the condition being
> > checked once at the time of the itt instruction and played out for the
> > following 3 instructions?
> 
> Yes, it really does.  Useful for compound conditions, and for maximal
> confusion.  Thankfully, both branches into IT blocks and branches
> leaving IT blocks not at the last instruction are forbidden.

Russel King wrote:
> The CPSR records the IT state.

And therefore, would it be possible to modify the CPSR when
single-stepping to change the IT state so that the instruction
following the next one, i.e. the breakpoint, is unconditional?
So you only need one breakpoint after all.

You'd need to check for particular instructions being single-stepped
and probably emulate these: single-step into another 'it' :-), into
something which reads or writes CPSR directly so they see the correct
values, and jump instructions.

-- Jamie
