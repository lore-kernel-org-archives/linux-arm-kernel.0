From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Feb 2014 11:03:01 +0000
Subject: [RFC PATCH 1/2] arm: mm: Switch back to L_PTE_WRITE
In-Reply-To: <20140221083716.GA2383@linaro.org>
References: <1392396913-13570-1-git-send-email-steve.capper@linaro.org>
 <1392396913-13570-2-git-send-email-steve.capper@linaro.org>
 <20140220172222.GL3615@mudshark.cambridge.arm.com>
 <20140221083716.GA2383@linaro.org>
Message-ID: <20140224110301.GC2553@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 08:37:16AM +0000, Steve Capper wrote:
> On Thu, Feb 20, 2014 at 05:22:22PM +0000, Will Deacon wrote:
> > On Fri, Feb 14, 2014 at 04:55:12PM +0000, Steve Capper wrote:
> > > For LPAE, we have the following means for encoding writable or dirty
> > > ptes:
> > >                               L_PTE_DIRTY       L_PTE_RDONLY
> > >     !pte_dirty && !pte_write        0               1
> > >     !pte_dirty && pte_write         0               1
> > >     pte_dirty && !pte_write         1               1
> > >     pte_dirty && pte_write          1               0
> > > 
> > > So we can't distinguish between writable clean ptes and read only
> > > ptes. This can cause problems with ptes being incorrectly flagged as
> > > read only when they are writable but not dirty.
> > > 
> > > This patch re-introduces the L_PTE_WRITE bit for both short descriptors
> > > and long descriptors, by reverting:
> > >   36bb94b ARM: pgtable: provide RDONLY page table bit rather than WRITE bit
> > > 
> > > For short descriptors the L_PTE_RDONLY bit is renamed to L_PTE_WRITE
> > > and the pertinent logic changed. For long descriptors, L_PTE_WRITE is
> > > implemented as a new software bit and L_PTE_RDONLY is renamed to
> > > PTE_RDONLY to highlight the fact that it is a hardware bit.
> > 
> > This would be a lot easier to review if it was a true revert, but I guess
> > that doesn't apply cleanly to mainline?
> 
> Unfortunately not, we've had the split to 2/3-level pagetables since then.
> Also there are minor alterations to the kernel pte dumping code.

Yeah, I guess as much. Oh well.

> > > diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> > > index 03243f7..8a392ef 100644
> > > --- a/arch/arm/include/asm/pgtable-3level.h
> > > +++ b/arch/arm/include/asm/pgtable-3level.h
> > > @@ -79,12 +79,12 @@
> > >  #define L_PTE_PRESENT          (_AT(pteval_t, 3) << 0)         /* Present */
> > >  #define L_PTE_FILE             (_AT(pteval_t, 1) << 2)         /* only when !PRESENT */
> > >  #define L_PTE_USER             (_AT(pteval_t, 1) << 6)         /* AP[1] */
> > > -#define L_PTE_RDONLY           (_AT(pteval_t, 1) << 7)         /* AP[2] */
> > > +#define PTE_RDONLY             (_AT(pteval_t, 1) << 7)         /* AP[2] */
> > 
> > Why? I think we're just using L_ for consistency here, rather than to
> > distinguish between h/w and Linux bits (e.g. L_PTE_XN).
> 
> The name was changed to break anything that used L_PTE_RDONLY, i.e. in
> case another patch slipped through and started behaving strangely.
> I will change this to something like L_PTE_HW_RDONLY.

I'd personally just stick with L_PTE_RDONLY and have a quick grep around after
the merge window which includes this patch, to see if any new users have
turned up.

> > 
> > >  #define L_PTE_SHARED           (_AT(pteval_t, 3) << 8)         /* SH[1:0], inner shareable */
> > >  #define L_PTE_YOUNG            (_AT(pteval_t, 1) << 10)        /* AF */
> > >  #define L_PTE_XN               (_AT(pteval_t, 1) << 54)        /* XN */
> > >  #define L_PTE_DIRTY            (_AT(pteval_t, 1) << 55)        /* unused */
> > > -#define L_PTE_SPECIAL          (_AT(pteval_t, 1) << 56)        /* unused */
> > > +#define L_PTE_WRITE            (_AT(pteval_t, 1) << 56)
> > 
> > Why have you killed L_PTE_SPECIAL? We could actually use that for LPAE...
> > 
> 
> I was trying to be efficient, as it was unused.
> 
> On the subject of future use of L_PTE_SPECIAL... It was pointed out to
> me that my fast_gup series had a bug in that it didn't check for special
> ptes (and it really should). So I would like to introduce L_PTE_SPECIAL
> usage in another patch ;-).

Leaving the flag intact should be fine, since the pte_mkspecial pte_special
macros don't use it yet iirc (although we *do* have them on arch/arm64, so
you should check your GUP code there :).

> > > diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
> > > index bdd3be4..297fccf 100644
> > > --- a/arch/arm/mm/proc-v7-2level.S
> > > +++ b/arch/arm/mm/proc-v7-2level.S
> > > @@ -84,9 +84,9 @@ ENTRY(cpu_v7_set_pte_ext)
> > >         tst     r1, #1 << 4
> > >         orrne   r3, r3, #PTE_EXT_TEX(1)
> > > 
> > > -       eor     r1, r1, #L_PTE_DIRTY
> > > -       tst     r1, #L_PTE_RDONLY | L_PTE_DIRTY
> > > -       orrne   r3, r3, #PTE_EXT_APX
> > > +       tst     r1, #L_PTE_WRITE
> > > +       tstne   r1, #L_PTE_DIRTY
> > > +       orreq   r3, r3, #PTE_EXT_APX
> > > 
> > >         tst     r1, #L_PTE_USER
> > >         orrne   r3, r3, #PTE_EXT_AP1
> > > diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
> > > index 01a719e..7793b2e 100644
> > > --- a/arch/arm/mm/proc-v7-3level.S
> > > +++ b/arch/arm/mm/proc-v7-3level.S
> > > @@ -78,8 +78,10 @@ ENTRY(cpu_v7_set_pte_ext)
> > >         tst     r3, #1 << (57 - 32)             @ L_PTE_NONE
> > >         bicne   r2, #L_PTE_VALID
> > >         bne     1f
> > > -       tst     r3, #1 << (55 - 32)             @ L_PTE_DIRTY
> > > -       orreq   r2, #L_PTE_RDONLY
> > > +       bic     r2, #PTE_RDONLY
> > 
> > Why do you need this bic?
> 
> I want to clear the read only bit if the pte is writable and dirty.

Ah yes, because that's no longer done by pte_mkwrite.

Will
