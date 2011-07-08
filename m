From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Jul 2011 09:22:37 +0100
Subject: [PATCH 01/17] ARM: proc: add definition of cpu_reset for ARMv6
	and ARMv7 cores
In-Reply-To: <4E16596D.9060103@ti.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-2-git-send-email-lorenzo.pieralisi@arm.com>
	<4E16596D.9060103@ti.com>
Message-ID: <20110708082237.GB16849@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 02:12:13AM +0100, Santosh Shilimkar wrote:
> Minor nit,
> 
> On 7/7/2011 8:50 AM, Lorenzo Pieralisi wrote:
> > From: Will Deacon<will.deacon@arm.com>
> >
> > This patch adds simple definitions of cpu_reset for ARMv6 and ARMv7
> > cores, which disable the MMU via the SCTLR.
> >
> > Signed-off-by: Will Deacon<will.deacon@arm.com>
> > ---
> >   arch/arm/mm/proc-v6.S |    5 +++++
> >   arch/arm/mm/proc-v7.S |    7 +++++++
> >   2 files changed, 12 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
> > index 1d2b845..f3b5232 100644
> > --- a/arch/arm/mm/proc-v6.S
> > +++ b/arch/arm/mm/proc-v6.S
> > @@ -56,6 +56,11 @@ ENTRY(cpu_v6_proc_fin)
> >    */
> >   	.align	5
> >   ENTRY(cpu_v6_reset)
> > +	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
> > +	bic	r1, r1, #0x1			@ ...............m
> > +	mcr	p15, 0, r1, c1, c0, 0		@ disable MMU
> > +	mov	r1, #0
> > +	mcr	p15, 0, r1, c7, c5, 4		@ ISB
> >   	mov	pc, r0
> >
> >   /*
> > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > index 089c0b5..15d6191 100644
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -58,9 +58,16 @@ ENDPROC(cpu_v7_proc_fin)
> >    *	to what would be the reset vector.
> >    *
> >    *	- loc   - location to jump to for soft reset
> > + *
> > + *	This code must be executed using a flat identity mapping with
> > + *      caches disabled.
> Align the text body.

Bah, I somehow ended up with spaces instead of a tab. I've already sent a
pull request with this patch in, so I'll leave it like it is but make a
note to fix it next time I'm in there.

Will
