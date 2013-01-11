From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Jan 2013 13:10:52 -0500 (EST)
Subject: [PATCH 01/16] ARM: b.L: secondary kernel entry code
In-Reply-To: <50F048D7.6000904@ti.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-2-git-send-email-nicolas.pitre@linaro.org>
 <50F048D7.6000904@ti.com>
Message-ID: <alpine.LFD.2.02.1301111301300.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Jan 2013, Santosh Shilimkar wrote:

> On Thursday 10 January 2013 05:50 AM, Nicolas Pitre wrote:
> > +ENTRY(bL_entry_point)
> > +
> > + THUMB(	adr	r12, BSYM(1f)	)
> > + THUMB(	bx	r12		)
> > + THUMB(	.thumb			)
> > +1:
> > +	mrc	p15, 0, r0, c0, c0, 5
> > +	ubfx	r9, r0, #0, #4			@ r9 = cpu
> > +	ubfx	r10, r0, #8, #4			@ r10 = cluster
> > +	mov	r3, #BL_CPUS_PER_CLUSTER
> > +	mla	r4, r3, r10, r9			@ r4 = canonical CPU index
> > +	cmp	r4, #(BL_CPUS_PER_CLUSTER * BL_NR_CLUSTERS)
> > +	blo	2f
> > +
> > +	/* We didn't expect this CPU.  Try to make it quiet. */
> > +1:	wfi
> > +	wfe
> 
> Why do you need a wfe followed by wif ?
> Just curious.

If the WFI doesn't work because an interrupt is pending then the WFE 
might work better.  But as I mentioned before, this is not intended to 
be used for other purposes than "we're really screwed so at least let's 
try to cheaply quieten this CPU" case.


Nicolas
