From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 9 Feb 2016 12:02:17 +0000
Subject: [PATCH v3 23/23] arm64: Panic when VHE and non VHE CPUs coexist
In-Reply-To: <20160208162402.GC14146@leverpostej>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
 <1454522416-6874-24-git-send-email-marc.zyngier@arm.com>
 <20160208160445.GS6076@e104818-lin.cambridge.arm.com>
 <20160208162402.GC14146@leverpostej>
Message-ID: <20160209120217.GE16122@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 04:24:03PM +0000, Mark Rutland wrote:
> On Mon, Feb 08, 2016 at 04:04:46PM +0000, Catalin Marinas wrote:
> > On Wed, Feb 03, 2016 at 06:00:16PM +0000, Marc Zyngier wrote:
> > > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > > index 6f2f377..f9b6a5b 100644
> > > --- a/arch/arm64/kernel/head.S
> > > +++ b/arch/arm64/kernel/head.S
> > > @@ -578,7 +578,24 @@ ENTRY(set_cpu_boot_mode_flag)
> > >  1:	str	w20, [x1]			// This CPU has booted in EL1
> > >  	dmb	sy
> > >  	dc	ivac, x1			// Invalidate potentially stale cache line
> > > +	adr_l	x1, __run_cpu_mode
> > > +	ldr	w0, [x1]
> > > +	mrs	x20, CurrentEL
> > > +	cbz	x0, skip_el_check
> > > +	cmp	x0, x20
> > > +	bne	mismatched_el
> > >  	ret
> > > +skip_el_check:			// Only the first CPU gets to set the rule
> > > +	str	w20, [x1]
> > > +	dmb	sy
> > > +	dc	ivac, x1	// Invalidate potentially stale cache line
> > > +	ret
> > > +mismatched_el:
> > > +	str	w20, [x1, #4]
> > > +	dmb	sy
> > > +	dc	ivac, x1	// Invalidate potentially stale cache line
> > > +1:	wfi
> > > +	b	1b
> > >  ENDPROC(set_cpu_boot_mode_flag)
> > 
> > Do we need to wait for the D-cache maintenance completion before
> > entering WFI (like issuing a DSB)? Same for the skip_el_check path
> > before the RET.
> 
> We would need that to complete the maintenance, yes.
> 
> However, given we're going into WFI immediately afterwards, and not
> signalling completion to other CPUs, what we gain is somewhat
> questionable.
> 
> Perhaps it's always better to do the maintenance on the read side (for
> consistency with [1]).
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/404661.html

While [1] looks clearer to me, it seems that it is not consistent with
the rest of the head.S file. Maybe we can clean them up as a separate
patch and leave the dc ivac here. We also seem to miss barriers in other
similar situations in head.S.

-- 
Catalin
