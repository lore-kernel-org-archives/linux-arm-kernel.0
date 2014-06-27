From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jun 2014 09:58:45 +0100
Subject: [PATCH] arm64: fpsimd: avoid restoring fpcr if the contents
 haven't changed
In-Reply-To: <CAKv+Gu8rFmURfT9PLSQE4z91q5D03aoR7UOEJFSGRrBMXGsdOQ@mail.gmail.com>
References: <1403804062-22239-1-git-send-email-will.deacon@arm.com>
 <CAKv+Gu8rFmURfT9PLSQE4z91q5D03aoR7UOEJFSGRrBMXGsdOQ@mail.gmail.com>
Message-ID: <20140627085845.GD26276@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 10:10:00PM +0100, Ard Biesheuvel wrote:
> Hey Will,

Hi Ard,

> On 26 June 2014 19:34, Will Deacon <will.deacon@arm.com> wrote:
> > Writing to the FPCR is commonly implemented as a self-synchronising
> > operation in the CPU, so avoid writing to the register when the saved
> > value matches that in the hardware already.
> >
> > Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/fpsimdmacros.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
> > index 768414d55e64..137c0f45b0a8 100644
> > --- a/arch/arm64/include/asm/fpsimdmacros.h
> > +++ b/arch/arm64/include/asm/fpsimdmacros.h
> > @@ -40,6 +40,7 @@
> >         str     w\tmpnr, [\state, #16 * 2 + 4]
> >  .endm
> >
> > +/* Clobbers \state */
> >  .macro fpsimd_restore state, tmpnr
> >         ldp     q0, q1, [\state, #16 * 0]
> >         ldp     q2, q3, [\state, #16 * 2]
> > @@ -60,7 +61,15 @@
> >         ldr     w\tmpnr, [\state, #16 * 2]
> >         msr     fpsr, x\tmpnr
> >         ldr     w\tmpnr, [\state, #16 * 2 + 4]
> > +       /*
> > +        * Writes to fpcr may be self-synchronising, so avoid restoring
> > +        * the register if it hasn't changed.
> > +        */
> > +       mrs     \state, fpcr
> > +       cmp     x\tmpnr, \state
> > +       b.eq    9999f
> >         msr     fpcr, x\tmpnr
> > +9999:
> >  .endm
> >
> 
> I would assume the same would apply to the partial restore that was
> merged during the last window?

Good point; I'll take a look.

Cheers,

Will
