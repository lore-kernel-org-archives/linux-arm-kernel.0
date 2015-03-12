From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 20:50:59 +0000
Subject: [RFT/RFC PATCH 1/6] ARM: replace PROCINFO embedded branch with
 relative offset
In-Reply-To: <1426181892-15440-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426181892-15440-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150312205059.GX8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 06:38:07PM +0100, Ard Biesheuvel wrote:
> @@ -138,8 +138,9 @@ ENTRY(stext)
>  						@ mmu has been enabled
>  	adr	lr, BSYM(1f)			@ return (PIC) address
>  	mov	r8, r4				@ set TTBR1 to swapper_pg_dir
> - ARM(	add	pc, r10, #PROCINFO_INITFUNC	)
> - THUMB(	add	r12, r10, #PROCINFO_INITFUNC	)
> +	ldr	r12, [r10, #PROCINFO_INITFUNC]
> + ARM(	add	pc, r12, r10			)
> + THUMB(	add	r12, r12, r10			)
>   THUMB(	ret	r12				)

Given this change, I'd prefer a slightly different result:

	ldr	r12, [r10, #PROCINFO_INITFUNC]
	add	r12, r12, r10
	ret	r12

>  1:	b	__enable_mmu
>  ENDPROC(stext)
> @@ -386,10 +387,11 @@ ENTRY(secondary_startup)
>  	ldr	r8, [r7, lr]			@ get secondary_data.swapper_pg_dir
>  	adr	lr, BSYM(__enable_mmu)		@ return address
>  	mov	r13, r12			@ __secondary_switched address
> - ARM(	add	pc, r10, #PROCINFO_INITFUNC	) @ initialise processor
> -						  @ (return control reg)
> - THUMB(	add	r12, r10, #PROCINFO_INITFUNC	)
> - THUMB(	ret	r12				)
> +	ldr	r12, [r10, #PROCINFO_INITFUNC]
> + ARM(	add	pc, r12, r10		)	@ initialise processor
> +						@ (return control reg)
> + THUMB(	add	r12, r12, r10		)
> + THUMB(	ret	r12			)

and same here.  It means that we have less code to look at, at the expense
of one additional ARM instruction.

> +
> +.macro	initfn, initfunc
> +	.long	\initfunc - . + PROCINFO_INITFUNC
> +.endm

The more I look at this, the more I find it hard to decide whether this
is correct or not, and that means it's bad.  It is correct, but it needs
some thought to confirm that.  I'd prefer a different solution.

The value which we want to place into this location is the difference
between the start of the procinfo structure and the target symbol.  So
let's do that - we have a symbol for each procinfo structure, let's
make "initfn" take that symbol and do the computation using that.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
