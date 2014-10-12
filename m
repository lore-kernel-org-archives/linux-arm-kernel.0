From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 12 Oct 2014 20:48:13 +0200
Subject: [RFC 1/7] ARM: vf610: add low level debug support for !MMU
In-Reply-To: <331b5f06d72890ac348adcd8cce616db576eb10e.1413136383.git.stefan@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
 <331b5f06d72890ac348adcd8cce616db576eb10e.1413136383.git.stefan@agner.ch>
Message-ID: <2650196.D7500rgcAr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 12 October 2014 20:13:55 Stefan Agner wrote:
> Add support for !MMU low level debug required for the secondary
> Cortex-M4 core in Vybrid.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/include/debug/vf.S | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/include/debug/vf.S b/arch/arm/include/debug/vf.S
> index b889338..63c7ef7 100644
> --- a/arch/arm/include/debug/vf.S
> +++ b/arch/arm/include/debug/vf.S
> @@ -17,12 +17,22 @@
>  
>  #define VF_UART_VIRTUAL_BASE	0xfe000000
>  
> +#ifdef CONFIG_MMU
> +
>  	.macro	addruart, rp, rv, tmp
>  	ldr	\rp, =VF_UART_PHYSICAL_BASE 	@ physical
>  	and	\rv, \rp, #0xffffff		@ offset within 16MB section
>  	add	\rv, \rv, #VF_UART_VIRTUAL_BASE
>  	.endm
>  
> +#else /* !CONFIG_MMU */
> +
> +	.macro	addruart, rx, tmp
> +	ldr	\rx, =(VF_UART_PHYSICAL_BASE)	@ physical
> +	.endm
> +
> +#endif /* CONFIG_MMU */
> +
>  	.macro	senduart, rd, rx
>  	strb	\rd, [\rx, #0x7]	@ Data Register
>  	.endm
> 
Hmm, I've previously needed to add this patch for randconfig testing:

index 78c91b5f97d4..ea9646cc2a0e 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -35,7 +35,7 @@
 
 #else /* !CONFIG_MMU */
                .macro  addruart_current, rx, tmp1, tmp2
-               addruart        \rx, \tmp1
+               addruart        \rx, \tmp1, \tmp2
                .endm
 
 #endif /* CONFIG_MMU */



If we do this instead, could we avoid your patch?

	Arnd
