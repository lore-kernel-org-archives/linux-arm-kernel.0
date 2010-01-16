From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 16 Jan 2010 16:34:34 +0530
Subject: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code generic
In-Reply-To: <20100116013515.10065.30649.stgit@baageli.muru.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
	<20100116013515.10065.30649.stgit@baageli.muru.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C06F902C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<snip>
> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Saturday, January 16, 2010 7:05 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org
> Subject: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL 
> code generic
> 
> Define arch_decomp_setup() the same way as some other
> architectures do. Use arch_id to configure the debug uart
> based on the machine_is by storing it into the uart
> scratchpad register for DEBUG_LL code to use.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap1/include/mach/debug-macro.S |   67 +++++++++-
>  arch/arm/mach-omap1/serial.c                   |   12 ++
>  arch/arm/mach-omap2/include/mach/debug-macro.S |   76 ++++++++---
>  arch/arm/mach-omap2/serial.c                   |   11 ++
>  arch/arm/plat-omap/include/plat/serial.h       |   18 +++
>  arch/arm/plat-omap/include/plat/uncompress.h   |  168 
> +++++++++++++++++-------
>  6 files changed, 276 insertions(+), 76 deletions(-)
> 
....

>  static struct plat_serial8250_port serial_platform_data[] = {
> diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S 
> b/arch/arm/mach-omap2/include/mach/debug-macro.S
> index 0c96e1c..1b83584 100644
> --- a/arch/arm/mach-omap2/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
> @@ -15,32 +15,66 @@
>  
>  #include <plat/serial.h>
>  
> +omap_uart_phys:	.word	0x0
> +omap_uart_virt:	.word	0x0
> +
> +		/*
> +		 * Note that this code won't work if the 
> bootloader passes
> +		 * a wrong machine ID number in r1. To debug, 
> just hardcode
> +		 * the desired UART phys and virt addresses 
> temporarily into
> +		 * the omap_uart_phys and omap_uart_virt above.
> +		 */
>  		.macro	addruart,rx
> +
> +		/* Use omap_uart_phys/virt if already configured */
> +10:		mrc	p15, 0, \rx, c1, c0
> +		tst	\rx, #1			@ MMU enabled?
> +		ldreq	\rx, omap_uart_phys	@ physical base address
> +		ldrne	\rx, omap_uart_virt	@ virtual base
> +		cmp	\rx, #0			@ is port configured?
> +		bne	99f			@ already configured
> +
> +		/* Check UART1 scratchpad register for uart to use */
>  		mrc	p15, 0, \rx, c1, c0
>  		tst	\rx, #1			@ MMU enabled?
> -#ifdef  CONFIG_ARCH_OMAP2
>  		moveq	\rx, #0x48000000	@ physical base address
>  		movne	\rx, #0xfa000000	@ virtual base
> -		orr	\rx, \rx, #0x0006a000
> -#ifdef CONFIG_OMAP_LL_DEBUG_UART2
> -		add	\rx, \rx, #0x00002000	@ UART 2
> -#endif
> -#ifdef CONFIG_OMAP_LL_DEBUG_UART3
> -		add	\rx, \rx, #0x00004000	@ UART 3
> -#endif
> -
> -#elif defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> -		moveq	\rx, #0x48000000	@ physical base address
> -		movne	\rx, #0xfa000000	@ virtual base
> -		orr	\rx, \rx, #0x0006a000
> -#ifdef CONFIG_OMAP_LL_DEBUG_UART2
> -		add	\rx, \rx, #0x00002000	@ UART 2
> -#endif
> -#ifdef CONFIG_OMAP_LL_DEBUG_UART3
> -		add	\rx, \rx, #0x00fb0000	@ UART 3
> -		add	\rx, \rx, #0x00006000
> -#endif
> -#endif
> +		orr	\rx, \rx, #0x0006a000	@ uart1 on omap2/3/4
> +		ldrb	\rx, [\rx, #(UART_SCR << 
> OMAP_PORT_SHIFT)] @ scratchpad
> +
> +		/* Select the UART to use based on the UART1 
> scratchpad value */
> +		cmp	\rx, #0			@ no port configured?
> +		beq	21f			@ if none, try 
> to use UART1
> +		cmp	\rx, #OMAP2UART1	@ OMAP2/3/4UART1
> +		beq	21f			@ configure 
> OMAP2/3/4UART1
> +		cmp	\rx, #OMAP2UART2	@ OMAP2/3/4UART2
> +		beq	22f			@ configure 
> OMAP2/3/4UART2
> +		cmp	\rx, #OMAP2UART3	@ only on 24xx
> +		beq	23f			@ configure OMAP2UART3
> +		cmp	\rx, #OMAP3UART3	@ only on 34xx
> +		beq	33f			@ configure OMAP3UART3
Can you please add add OMAP4 UART3 case as well here using 
"OMAP4UART3". 

Attached patch fixes UART3 support for OMAP4 on top of your patches. Tested 
this on OMAP4430 SDP. You can fold this patch if you like

		@ configure OMAP4UART3
> +
> +		/* Configure the UART offset from the phys/virt base */
> +21:		mov	\rx, #0x0006a000	@ OMAP2/3/4UART1
> +22:		mov	\rx, #0x0006a000
> +		add	\rx, \rx, #0x00002000	@ OMAP2/3/4UART2
> +		b	98f
> +23:		mov	\rx, #0x0006a000	@ OMAP2/3/4UART1
> +		add	\rx, \rx, #0x00004000	@ OMAP2UART3
> +		b	98f
> +33:		mov	\rx, #0x0006a000	@ OMAP2/3/4UART1
> +		add	\rx, \rx, #0x00fb0000
> +		add	\rx, \rx, #0x00006000	@ OMAP3UART3
> +
> +		/* Store both phys and virt address for the uart */
> +98:		add	\rx, \rx, #0x48000000	@ phys base
> +		str	\rx, omap_uart_phys
> +		sub	\rx, \rx, #0x48000000	@ phys base
> +		add	\rx, \rx, #0xfa000000	@ virt base
> +		str	\rx, omap_uart_virt
> +		b	10b
> +99:
>  		.endm
>  
>  		.macro	senduart,rd,rx
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Update-DEBUG_LL-for-OMAP4.patch
Type: application/octet-stream
Size: 1271 bytes
Desc: 0001-Update-DEBUG_LL-for-OMAP4.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100116/d90886a2/attachment-0001.obj>
