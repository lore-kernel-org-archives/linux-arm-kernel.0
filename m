From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 29 May 2013 22:59:46 +0800
Subject: [PATCH] ARM: fix kernel decompressor compilation error with
 CONFIG_DEBUG_SEMIHOSTING
In-Reply-To: <alpine.LFD.2.03.1305281654120.1918@syhkavp.arg>
References: <alpine.LFD.2.03.1305281654120.1918@syhkavp.arg>
Message-ID: <20130529145944.GE29528@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 04:59:13PM -0400, Nicolas Pitre wrote:
> 
> ... and add semihosting output support to the decompressor while at it.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Maybe include the error output in commit log.

  AS      arch/arm/boot/compressed/debug.o
arch/arm/boot/compressed/debug.S:4:33: fatal error: mach/debug-macro.S: No such file or directory
compilation terminated.
make[3]: *** [arch/arm/boot/compressed/debug.o] Error 1

Shawn

> 
> diff --git a/arch/arm/boot/compressed/debug.S b/arch/arm/boot/compressed/debug.S
> index 6e8382d5b7..5392ee6333 100644
> --- a/arch/arm/boot/compressed/debug.S
> +++ b/arch/arm/boot/compressed/debug.S
> @@ -1,6 +1,8 @@
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
>  
> +#ifndef CONFIG_DEBUG_SEMIHOSTING
> +
>  #include CONFIG_DEBUG_LL_INCLUDE
>  
>  ENTRY(putc)
> @@ -10,3 +12,29 @@ ENTRY(putc)
>  	busyuart r3, r1
>  	mov	 pc, lr
>  ENDPROC(putc)
> +
> +#else
> +
> +ENTRY(putc)
> +	adr	r1, 1f
> +	ldmia	r1, {r2, r3}
> +	add	r2, r2, r1
> +	ldr	r1, [r2, r3]
> +	strb	r0, [r1]
> +	mov	r0, #0x03		@ SYS_WRITEC
> +   ARM(	svc	#0x123456	)
> + THUMB(	svc	#0xab		)
> +	mov	pc, lr
> +	.align	2
> +1:	.word	_GLOBAL_OFFSET_TABLE_ - .
> +	.word	semi_writec_buf(GOT)
> +ENDPROC(putc)
> +
> +	.bss
> +	.global	semi_writec_buf
> +	.type   semi_writec_buf, %object
> +semi_writec_buf:
> +	.space	4
> +	.size	semi_writec_buf, 4
> +
> +#endif
