From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Jan 2011 00:44:49 +0000
Subject: [PATCH] ARM: make head.S less dependent on the compile time
	PHYS_OFFSET define
In-Reply-To: <alpine.LFD.2.00.1101140050070.25804@xanadu.home>
References: <alpine.LFD.2.00.1101131659220.11803@xanadu.home>
	<20110113232327.GG24149@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101140050070.25804@xanadu.home>
Message-ID: <20110115004449.GU15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 01:18:20AM -0500, Nicolas Pitre wrote:
> On Thu, 13 Jan 2011, Russell King - ARM Linux wrote:
> 
> > On Thu, Jan 13, 2011 at 05:04:28PM -0500, Nicolas Pitre wrote:
> > > +	.macro phys_offset, rd
> > > +	mov	\rd, pc
> > > +	and	\rd, \rd, #0xf8000000
> > > +	.endm
> > 
> > We can do loads better than that, as the p2v fixup code has proven.
> > Now that r8 has been eliminated, I may rebase the p2v stuff ontop of
> > that commit, and move the computation of phys_offset out of the p2v
> > fixup code - and have it in r8 for __create_page_tables to use.
> > FYI, the real PHYS_OFFSET value can be found by (eg):
> > 
> > 1:	.long	.
> > 	.long	PAGE_OFFSET
> > 
> > 	adr	r0, 1b
> > 	ldmia	r0, {r1, r2}
> > 	sub	r1, r0, r1
> > 	add	r3, r2, r1
> > 
> > r1 now contains the offset between virtual and physical spaces, r2
> > contains the compile-time PAGE_OFFSET constant, and r3 the runtime
> > equivalent of PHYS_OFFSET.
> > 
> > None of this uses troublesome masking which will trip up on platforms
> > such as MSM - we really must stop writing code which assumes that
> > physical memory is aligned to >= 32MB.
> 
> That is more reliable indeed.  But without visibility into your reworked 
> version of that code I opted for a less intrusive solution.
> 
> Unfortunately this trick can't work for CONFIG_AUTO_ZRELADDR.

I've pushed it out under the branch p2v.  I think before this
goes upstream, "ARM: P2V: Use pv_fixup trick to get physical address"
needs merging with "ARM: P2V: make head.S use PLAT_PHYS_OFFSET" -
it doesn't really make sense to fix the same code twice for the same
underlying problem in the same patch set when it's possible to only
fix it once.
