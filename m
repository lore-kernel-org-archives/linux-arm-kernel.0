From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 24 Aug 2016 21:46:54 +0100
Subject: [PATCH v2 4/9] arm64: head.S: move KASLR processing out of
 __enable_mmu()
In-Reply-To: <20160824203609.GA1642@remoulade>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
 <1472049366-10922-5-git-send-email-ard.biesheuvel@linaro.org>
 <20160824203609.GA1642@remoulade>
Message-ID: <20160824204654.GA1775@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 09:36:10PM +0100, Mark Rutland wrote:
> On Wed, Aug 24, 2016 at 04:36:01PM +0200, Ard Biesheuvel wrote:
> > +__primary_switch:
> > +#ifdef CONFIG_RANDOMIZE_BASE
> > +	mov	x19, x0				// preserve new SCTLR_EL1 value
> > +	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
> > +#endif
> > +
> > +	adr	x27, 0f
> > +	b	__enable_mmu
> 
> As we do elsewhere, it's probably worth a comment on the line with the ADR into
> x27, mentioning that __enable_mmu will branch there.
> 
> ... or perhaps we should just have __enable_mmu return to the LR like a normal
> AAPCS function, place the switch routines in the idmap, and use the idiomatic
> sequence:
> 
> __thing_switch:
> 	bl	__enable_mmu
> 	ldr	xN, =__thing
> 	blr	xN

... and now I see that this is what subsequent patches do ;)

Is it possible to first AAPCS-ify __enable_mmu (with shuffling of callers as
above) in one patch, prior to this? That would avoid introducing the unusual 0f
label above, and the temporary x30 usage in a subsequent patch.

Thanks,
Mark.
