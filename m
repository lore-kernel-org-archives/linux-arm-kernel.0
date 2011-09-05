From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Sep 2011 02:44:14 -0700
Subject: [PATCH 2/6] ARM: plat-omap: make OMAP_UART_INFO into a
	relative offset
In-Reply-To: <1314932353-24813-3-git-send-email-nico@fluxnic.net>
References: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
	<1314932353-24813-3-git-send-email-nico@fluxnic.net>
Message-ID: <20110905094414.GA1903@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110901 19:27]:
> --- a/arch/arm/mach-omap1/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
> @@ -46,11 +46,9 @@ omap_uart_virt:	.word	0x0
>  		bne	99f			@ already configured
>  
>  		/* Check the debug UART configuration set in uncompress.h */
> -		mrc	p15, 0, \rp, c1, c0
> -		tst	\rp, #1			@ MMU enabled?
> -		ldreq	\rp, =OMAP_UART_INFO	@ MMU not enabled
> -		ldrne	\rp, =omap_uart_p2v(OMAP_UART_INFO)	@ MMU enabled
> -		ldr	\rp, [\rp, #0]
> +		and	\rp, pc, #0xff000000
> +		ldr	\rv, =OMAP_UART_INFO_OFS
> +		ldr	\rp, [\rp, \rv]
>  
>  		/* Select the UART to use based on the UART1 scratchpad value */
>  10:		cmp	\rp, #0			@ no port configured?
> --- a/arch/arm/mach-omap2/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
> @@ -49,11 +49,10 @@ omap_uart_lsr:	.word	0
>  		bne	99f			@ already configured
>  
>  		/* Check the debug UART configuration set in uncompress.h */
> -		mrc	p15, 0, \rp, c1, c0
> -		tst	\rp, #1			@ MMU enabled?
> -		ldreq	\rp, =OMAP_UART_INFO	@ MMU not enabled
> -		ldrne	\rp, =omap_uart_p2v(OMAP_UART_INFO)	@ MMU enabled
> -		ldr	\rp, [\rp, #0]
> +		mov	\rp, pc
> +		ldr	\rv, =OMAP_UART_INFO_OFS
> +		and	\rp, \rp, #0xff000000
> +		ldr	\rp, [\rp, \rv]
>  
>  		/* Select the UART to use based on the UART1 scratchpad value */
>  		cmp	\rp, #0			@ no port configured?

Any reason to not make it the same for omap1 and omap2+?

It seems to work both ways, but the omap1 version is one line less
of code :)

Other than that:

Tested-by: Tony Lindgren <tony@atomide.com>
