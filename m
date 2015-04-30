From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 30 Apr 2015 11:12:04 -0400 (EDT)
Subject: [RFC] arm: pick the r2 passed DTB over the appended one
In-Reply-To: <55422267.2050206@keymile.com>
References: <1429880030-21473-1-git-send-email-valentin.longchamp@keymile.com>
 <alpine.LFD.2.11.1504282315320.1582@knanqh.ubzr>
 <5540A0DA.9060409@keymile.com>
 <alpine.LFD.2.11.1504290929090.1582@knanqh.ubzr>
 <5540FD7A.8040002@keymile.com>
 <alpine.LFD.2.11.1504291157110.1582@knanqh.ubzr>
 <55422267.2050206@keymile.com>
Message-ID: <alpine.LFD.2.11.1504301107330.1582@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Apr 2015, Valentin Longchamp wrote:

> On 04/29/2015 06:43 PM, Nicolas Pitre wrote:
> > On Wed, 29 Apr 2015, Valentin Longchamp wrote:
> > 
> >> On 04/29/2015 03:58 PM, Nicolas Pitre wrote:
> >>> Now, to fix your test, you'd simply have to augment it with:
> >>>
> >>> +		cmp	r6, r8		@ is r8 pointing to the appended DTB?
> >>> +		beq	1f
> >>> 		ldr	lr, [r8, #0]	@ conventionaly passed dtb ?
> >>> 		cmp	lr, r1
> >>> 		beq	dtb_check_done	@ yes, do not manage it
> >>> +1:
> >>>
> >>
> >> I had thought the same and implemented a similar test as you propose (patch
> >> attached, with some more debug code - please excuse my poor assembler). However
> >> it does not work ! The reason for it is that on the second run, r6 contains
> >> another value. As the output below seems to show, this 2nd run r6 value seems to
> >> point to a DTB since the first jump to dtb_check_done is not performed. However,
> >> since r8 now points to the "initial" appended DTB, the 2nd test jumps to
> >> dtb_check_done. Please see the output below.
> > 
> > Right.  On the second run, r6 points at the relocated DTB.  That's the 
> > one that should be used. r8 points at the initial, non relocated and 
> > about to be overwritten DTB. By giving priority to r8 with your patch, 
> > you're picking the wrong one.
> > 
> > The following should fix this issue:
> > 
> > diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> > index c41a793b51..bbce6a0f0d 100644
> > --- a/arch/arm/boot/compressed/head.S
> > +++ b/arch/arm/boot/compressed/head.S
> > @@ -399,6 +399,16 @@ dtb_check_done:
> >  1:
> >  #endif
> >  
> > +#ifdef CONFIG_ARM_APPENDED_DTB
> > +		/*
> > +		 * If r8 refers to an appended DTB, it is no longer valid
> > +		 * and should be revalidated once relocated.
> > +		 */
> > +		cmp	r8, r5
> > +		cmpcs	r6, r8
> > +		movcs	r8, #0
> > +#endif
> > +
> >  		sub	r9, r6, r5		@ size to copy
> >  		add	r9, r9, #31		@ rounded up to a multiple
> >  		bic	r9, r9, #31		@ ... of 32 bytes
> > 
> > 
> > Nicolas
> > 
> 
> Thank you very much for your help Nicolas, this fixed the issue indeed. I now
> have the behavior I wanted.
> 
> Do you think it makes sense to send the updated patch for mainline inclusion or
> is this a too "exotic" use case ?

I don't know.  We can't be sure this won't break someone else's use case 
i.e. overriding the bootloader's DTB by appending one to zImage.

I'd suggest we wait to see if more people require this feature.


Nicolas
