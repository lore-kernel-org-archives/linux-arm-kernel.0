From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 14 Jan 2011 01:18:20 -0500 (EST)
Subject: [PATCH] ARM: make head.S less dependent on the compile time
	PHYS_OFFSET define
In-Reply-To: <20110113232327.GG24149@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1101131659220.11803@xanadu.home>
	<20110113232327.GG24149@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101140050070.25804@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jan 2011, Russell King - ARM Linux wrote:

> On Thu, Jan 13, 2011 at 05:04:28PM -0500, Nicolas Pitre wrote:
> > +	.macro phys_offset, rd
> > +	mov	\rd, pc
> > +	and	\rd, \rd, #0xf8000000
> > +	.endm
> 
> We can do loads better than that, as the p2v fixup code has proven.
> Now that r8 has been eliminated, I may rebase the p2v stuff ontop of
> that commit, and move the computation of phys_offset out of the p2v
> fixup code - and have it in r8 for __create_page_tables to use.
> FYI, the real PHYS_OFFSET value can be found by (eg):
> 
> 1:	.long	.
> 	.long	PAGE_OFFSET
> 
> 	adr	r0, 1b
> 	ldmia	r0, {r1, r2}
> 	sub	r1, r0, r1
> 	add	r3, r2, r1
> 
> r1 now contains the offset between virtual and physical spaces, r2
> contains the compile-time PAGE_OFFSET constant, and r3 the runtime
> equivalent of PHYS_OFFSET.
> 
> None of this uses troublesome masking which will trip up on platforms
> such as MSM - we really must stop writing code which assumes that
> physical memory is aligned to >= 32MB.

That is more reliable indeed.  But without visibility into your reworked 
version of that code I opted for a less intrusive solution.

Unfortunately this trick can't work for CONFIG_AUTO_ZRELADDR.


Nicolas
