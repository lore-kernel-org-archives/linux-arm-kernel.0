From: michael@walle.cc (Michael Walle)
Date: Mon, 12 Dec 2011 23:06:09 +0100
Subject: arm and patch phys offset
In-Reply-To: <alpine.LFD.2.02.1112121627030.2907@xanadu.home>
References: <201112112255.32534.michael@walle.cc>
 <201112122212.35506.michael@walle.cc>
 <alpine.LFD.2.02.1112121627030.2907@xanadu.home>
Message-ID: <201112122306.09585.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag 12 Dezember 2011, 22:38:07 schrieb Nicolas Pitre:
> > But the non-patched entries always points to correct v2p/p2v
> > calls and in every case there is the unpatched add/sub instruction.
> 
> Then, might it be possible that the cache is not properly turned off
> prior entering the kernel?
i'll have a look at that

> What bootloader do you use?
U-Boot 2011.09 + patches for bsp support

> You could try instrumenting the patching code, although it is a bit
> tricky because of the non-standard register life rules in that file.
> But something like this should tell you if the expected amount of fixups
> were applied:
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 08c82fd844..7f43d1fe01 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -530,14 +530,23 @@ __fixup_a_pv_table:
>  	bcc	1b
>  	bx	lr
>  #else
> +	mov	r0, #0
>  	b	2f
>  1:	ldr	ip, [r7, r3]
>  	bic	ip, ip, #0x000000ff
>  	orr	ip, ip, r6	@ mask in offset bits 31-24
>  	str	ip, [r7, r3]
> +	add	r0, r0, #1
>  2:	cmp	r4, r5
>  	ldrcc	r7, [r4], #4	@ use branch for delay slot
>  	bcc	1b
> +
> +	mov	r6, r2
> +	mov	r7, r3
> +	bl	printhex8	@ display number of fixups done in r0
> +	mov	r2, r6
> +	mov	r3, r7
> +
>  	mov	pc, lr
>  #endif
>  ENDPROC(__fixup_a_pv_table)

Thanks, although the kernel hangs now after it printed the number, i can see 
it patched the correct number of stubs.

I'll have a look at the bootloader now.

-- 
Michael
