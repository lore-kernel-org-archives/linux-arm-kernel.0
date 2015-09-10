From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Sep 2015 11:07:54 +0100
Subject: [PATCH] arm64: Add support for hardware updates of the access
 and dirty pte bits
In-Reply-To: <55F06A87.3000204@citrix.com>
References: <1436545468-1549-1-git-send-email-catalin.marinas@arm.com>
 <55F06A87.3000204@citrix.com>
Message-ID: <20150910100753.GE12294@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 09, 2015 at 06:21:11PM +0100, Julien Grall wrote:
> I've tried to boot the latest linus/master (a794b4f) which include this
> patch as DOM0 on xgene. This is failing late in the boot with
> a BUG (see trace below).
> 
> The bisector pointed me to this patch. When I disable
> CONFIG_ARM64_HW_AFDBM, I'm able to boot the kernel and use it
> without any issue.
> 
> Although, I'm not sure to understand how this patch could
> possibly break the filesystem subsystem.

I don't understand either. It seems that the kernel raises a BUG on
!PagePrivate but this patch never touches the page structure, only ptes.

I recall to have tested it on XGene but I can try it again (bare metal).
Is the bare metal error for you the same?

> Do you have any insight for debugging this problem?
[...]
> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index 39139a3aa16d..a8be513dff6f 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> > @@ -196,6 +196,19 @@ ENTRY(__cpu_setup)
> >  	 */
> >  	mrs	x9, ID_AA64MMFR0_EL1
> >  	bfi	x10, x9, #32, #3
> > +#ifdef CONFIG_ARM64_HW_AFDBM
> > +	/*
> > +	 * Hardware update of the Access and Dirty bits.
> > +	 */
> > +	mrs	x9, ID_AA64MMFR1_EL1
> > +	and	x9, x9, #0xf
> > +	cbz	x9, 2f
> > +	cmp	x9, #2
> > +	b.lt	1f
> > +	orr	x10, x10, #TCR_HD		// hardware Dirty flag update
> > +1:	orr	x10, x10, #TCR_HA		// hardware Access flag update
> > +2:
> > +#endif	/* CONFIG_ARM64_HW_AFDBM */
> >  	msr	tcr_el1, x10
> >  	ret					// return to head.S
> >  ENDPROC(__cpu_setup)

Just in case some ID registers are wrong, can you do an "#if 0" above
instead of CONFIG_ARM64_HW_AFDBM?

-- 
Catalin
