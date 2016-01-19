From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Jan 2016 10:40:46 -0800
Subject: [PATCH 2/5] ARM: OMAP2+: Fix l2dis_3630 for rodata
In-Reply-To: <alpine.LFD.2.20.1601191305370.7882@knanqh.ubzr>
References: <1453225734-16993-1-git-send-email-tony@atomide.com>
 <1453225734-16993-3-git-send-email-tony@atomide.com>
 <alpine.LFD.2.20.1601191305370.7882@knanqh.ubzr>
Message-ID: <20160119184046.GD19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [160119 10:10]:
> On Tue, 19 Jan 2016, Tony Lindgren wrote:
> > --- a/arch/arm/mach-omap2/sleep34xx.S
> > +++ b/arch/arm/mach-omap2/sleep34xx.S
> > @@ -86,7 +86,9 @@ ENTRY(enable_omap3630_toggle_l2_on_restore)
> >  	stmfd	sp!, {lr}	@ save registers on stack
> >  	/* Setup so that we will disable and enable l2 */
> >  	mov	r1, #0x1
> > -	adrl	r2, l2dis_3630	@ may be too distant for plain adr
> > +	adrl	r3, l2dis_3630_offset	@ may be too distant for plain adr
> > +	ldr	r2, [r3]
> > +	add	r2, r2, r3
> >  	str	r1, [r2]
> 
> You could combine the add with the following str:

OK.

> 	str	r1, [r2, r3]
> 
> >  	ldmfd	sp!, {pc}	@ restore regs and return
> >  ENDPROC(enable_omap3630_toggle_l2_on_restore)
> > @@ -415,7 +417,9 @@ ENTRY(omap3_restore)
> >  	cmp	r2, #0x0	@ Check if target power state was OFF or RET
> >  	bne	logic_l1_restore
> >  
> > -	ldr	r0, l2dis_3630
> > +	adr	r1, l2dis_3630_offset
> > +	ldr	r0, [r1]
> > +	add	r0, r0, r1
> >  	cmp	r0, #0x1	@ should we disable L2 on 3630?
> 
> This looks wrong. You're testing the first bit of the address for 
> l2dis_3630 rather than its content.

Ugh yup a ldr missing missing there. Will check the whole series
and repost. Thanks for checking!

Regards,

Tony
