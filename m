From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 13 Jul 2010 23:58:10 -0400 (EDT)
Subject: [RFC,
	PATCH 2/3] arm: use addruart macro to establish debug mappings
In-Reply-To: <1279073377.401935.180250562939.2.gpush@pororo>
References: <1279073377.401935.180250562939.2.gpush@pororo>
Message-ID: <alpine.LFD.2.00.1007132343410.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Jul 2010, Jeremy Kerr wrote:

> @@ -289,19 +293,24 @@ __create_page_tables:
>  	str	r6, [r0]
>  
>  #ifdef CONFIG_DEBUG_LL
> -	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
>  	/*
>  	 * Map in IO space for serial debugging.
>  	 * This allows debug messages to be output
>  	 * via a serial console before paging_init.
>  	 */
> -	ldr	r3, [r8, #MACHINFO_PGOFFIO]
> +	addruart r7, r3
> +	lsr	r3, r3, #20
> +	lsl	r3, r3, #2

Not all binutils versions support that syntax. You should rather use:

	mov	r3, r3, lsr #20
	mov	r3, r3, lsl #2

>  	add	r0, r4, r3
>  	rsb	r3, r3, #0x4000			@ PTRS_PER_PGD*sizeof(long)
>  	cmp	r3, #0x0800			@ limit to 512MB
>  	movhi	r3, #0x0800
>  	add	r6, r0, r3
> -	ldr	r3, [r8, #MACHINFO_PHYSIO]
> +	mov	r3, #0xff000000
> +	orr	r3, r3, #0x00c00000
> +	and	r3, r7, r3
> +	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
>  	orr	r3, r3, r7

You may replace those last 5 instructions with:

	ldr	r3, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
	mov	r7, r7, lsr #20
	orr	r3, r3, r7, lsl #20	


Nicolas
