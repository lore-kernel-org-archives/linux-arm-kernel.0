From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 20 Jan 2014 11:04:31 +0900
Subject: [PATCH] arm64: mm: use ubfm for dcache_line_size
In-Reply-To: <20140117111307.GE16003@mudshark.cambridge.arm.com>
References: <000301cf135a$c1390e40$43ab2ac0$%han@samsung.com>
 <20140117111307.GE16003@mudshark.cambridge.arm.com>
Message-ID: <002001cf1583$f54f0790$dfed16b0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Friday, January 17, 2014 8:13 PM
> To: Jingoo Han
> Cc: Catalin Marinas; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] arm64: mm: use ubfm for dcache_line_size
> 
> On Fri, Jan 17, 2014 at 08:04:32AM +0000, Jingoo Han wrote:
> > Use 'ubfm' for the bitfield move instruction; thus, single
> > instruction can be used instead of two instructions, when
> > getting the minimum D-cache line size from CTR_EL0 register.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  arch/arm64/mm/proc-macros.S |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
> > index 8957b82..c31f41e 100644
> > --- a/arch/arm64/mm/proc-macros.S
> > +++ b/arch/arm64/mm/proc-macros.S
> > @@ -38,8 +38,7 @@
> >   */
> >  	.macro	dcache_line_size, reg, tmp
> >  	mrs	\tmp, ctr_el0			// read CTR
> > -	lsr	\tmp, \tmp, #16
> > -	and	\tmp, \tmp, #0xf		// cache line size encoding
> > +	ubfm	\tmp, \tmp, #0x16, 0x19		// cache line size encoding
> 
> 0x16 and 0x19. Are you sure?

(+cc Ard Biesheuvel)

Oh, it's my mistake.
CTR_EL0[19:16] is a proper bit-field; it means 'DminLine'.
So, I will fit it as below:

ubfm    \tmp, \tmp, #16, #19

> 
> You can also grep for other occurences of this pattern and change
> those too (pgtable stuff in head.S, clidr in cache.S).

OK, I will change others of this pattern.
I appreciate your comments. :-)

Best regards,
Jingoo Han
