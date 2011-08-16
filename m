From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 16 Aug 2011 17:21:41 +0100
Subject: [PATCH 2/3] ARM: entry: Remove unnecessary masking when decoding
	Thumb-2 instructions
In-Reply-To: <alpine.LFD.2.00.1108161217140.20358@xanadu.home>
References: <1313504053-27873-1-git-send-email-dave.martin@linaro.org>
	<1313504053-27873-3-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1108161217140.20358@xanadu.home>
Message-ID: <20110816162141.GE1993@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 12:17:35PM -0400, Nicolas Pitre wrote:
> On Tue, 16 Aug 2011, Dave Martin wrote:
> 
> > When testing whether a Thumb-2 instruction is 32 bits long or not,
> > the masking done in order to test bits 11-15 of the first
> > instruction halfword won't affect the result of the comparison, so
> > remove it.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 

Thanks
---Dave

> 
> > ---
> >  arch/arm/kernel/entry-armv.S |    6 ++----
> >  1 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> > index a87cbf8..b7236d4 100644
> > --- a/arch/arm/kernel/entry-armv.S
> > +++ b/arch/arm/kernel/entry-armv.S
> > @@ -262,8 +262,7 @@ __und_svc:
> >  	ldr	r0, [r4, #-4]
> >  #else
> >  	ldrh	r0, [r4, #-2]			@ Thumb instruction at LR - 2
> > -	and	r9, r0, #0xf800
> > -	cmp	r9, #0xe800			@ 32-bit instruction if xx >= 0
> > +	cmp	r0, #0xe800			@ 32-bit instruction if xx >= 0
> >  	ldrhhs	r9, [r4]			@ bottom 16 bits
> >  	orrhs	r0, r9, r0, lsl #16
> >  #endif
> > @@ -445,8 +444,7 @@ __und_usr:
> >   ARM(	ldrht	r5, [r4], #2	)
> >   THUMB(	ldrht	r5, [r4]	)
> >   THUMB(	add	r4, r4, #2	)
> > -	and	r0, r5, #0xf800			@ mask bits 111x x... .... ....
> > -	cmp	r0, #0xe800			@ 32bit instruction if xx != 0
> > +	cmp	r5, #0xe800			@ 32bit instruction if xx != 0
> >  	blo	__und_usr_unknown
> >  3:	ldrht	r0, [r4]
> >  	add	r2, r2, #2			@ r2 is PC + 2, make it PC + 4
> > -- 
> > 1.7.4.1
> > 
