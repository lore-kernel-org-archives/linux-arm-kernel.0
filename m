From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 30 Nov 2011 05:55:02 +0100
Subject: [PATCH 5/6] ARM: at91: Fix at91sam9g45 and at91cap9 reset
In-Reply-To: <20111129221229.GQ9581@n2100.arm.linux.org.uk>
References: <20111129173514.GW15008@game.jcrosoft.org>
 <1322589162-5212-5-git-send-email-plagnioj@jcrosoft.com>
 <20111129221229.GQ9581@n2100.arm.linux.org.uk>
Message-ID: <20111130045502.GA15008@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:12 Tue 29 Nov     , Russell King - ARM Linux wrote:
> On Tue, Nov 29, 2011 at 06:52:41PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > +			.globl	at91sam9g45_restart
> > +
> > +at91sam9g45_restart:
> > +			ldr	r0, .at91_va_base_sdramc0	@ preload constants
> > +			ldr	r1, .at91_va_base_rstc_cr
> > +
> > +			mov	r2, #1
> > +			mov	r3, #AT91_DDRSDRC_LPCB_POWER_DOWN
> > +			ldr	r4, =AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST
> > +
> > +			.balign	32				@ align to cache line
> > +
> > +			str	r2, [r0, #AT91_DDRSDRC_RTR]	@ disable DDR0 access
> > +			str	r3, [r0, #AT91_DDRSDRC_LPR]	@ power down DDR0
> > +			str	r4, [r1]			@ reset processor
> > +
> > +			b	.
> > +
> > +.at91_va_base_sdramc0:
> > +	.word AT91_VA_BASE_SYS + AT91_DDRSDRC0
> 
> So is the only change between this new file and arch/arm/mach-at91/at91sam9_alt_reset.S
> this line above?
> 
> arch/arm/mach-at91/at91sam9_alt_reset.S has:
>         .word AT91_VA_BASE_SYS + AT91_SDRAMC0
> 
> Maybe the at91sam9_alt_reset.S version should take this as an argument so
> the errata fix can be re-used on different AT91 versions, rather than
> having to duplicate code just because one register address has changed.
its not only the register base address but also the registers offset

I get the same idea but at the end when I did it I end with more code
and the only patrt in common  are

ldr     r1, at91_va_base_rstc_cre
mov     r2, #1
ldr     r4, =AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST
str     r4, [r1]

so I chosse to split it

as if I want to do the second way I need to pass 5 params to the asm fucntion
and create one c function for sam9 and 9g45

Best Regards,
J.
