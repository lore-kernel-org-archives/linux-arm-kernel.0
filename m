From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jul 2012 18:41:22 +0100
Subject: [PATCH] Fix undefined instruction exception handling
In-Reply-To: <20120730133619.GH6802@n2100.arm.linux.org.uk>
References: <20120729182236.GG6802@n2100.arm.linux.org.uk>
 <20120730112607.GD15195@mudshark.cambridge.arm.com>
 <20120730133619.GH6802@n2100.arm.linux.org.uk>
Message-ID: <20120730174122.GK15195@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 02:36:19PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 30, 2012 at 12:26:07PM +0100, Will Deacon wrote:
> > >  __und_svc:
> > >  #ifdef CONFIG_KPROBES
> > > @@ -261,7 +274,7 @@ ENDPROC(__irq_svc)
> > >  	@
> > >  	@  r0 - instruction
> > >  	@
> > > -#ifndef	CONFIG_THUMB2_KERNEL
> > > +#ifndef CONFIG_THUMB2_KERNEL
> > >  	ldr	r0, [r4, #-4]
> > >  #else
> > >  	ldrh	r0, [r4, #-2]			@ Thumb instruction at LR - 2
> > > @@ -269,17 +282,24 @@ ENDPROC(__irq_svc)
> > >  	ldrhhs	r9, [r4]			@ bottom 16 bits
> > >  	orrhs	r0, r9, r0, lsl #16
> > 
> > Do we not need an addhs r4, r4, #2 here?
> 
> And we'd need to store it back into the pt_regs struct.

[...]

> New patch below.

[...]

>  __und_svc:
>  #ifdef CONFIG_KPROBES
> @@ -261,25 +274,32 @@ __und_svc:
>  	@
>  	@  r0 - instruction
>  	@
> -#ifndef	CONFIG_THUMB2_KERNEL
> +#ifndef CONFIG_THUMB2_KERNEL
>  	ldr	r0, [r4, #-4]
>  #else
> +	mov	r1, #2
>  	ldrh	r0, [r4, #-2]			@ Thumb instruction at LR - 2
>  	cmp	r0, #0xe800			@ 32-bit instruction if xx >= 0
> -	ldrhhs	r9, [r4]			@ bottom 16 bits
> -	orrhs	r0, r9, r0, lsl #16
> +	blo	__und_svc_fault
> +	ldrh	r9, [r4]			@ bottom 16 bits
> +	add	r4, r4, #2
> +	str	r4, [sp, #S_PSR]

If you change that to #S_PC then:

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
