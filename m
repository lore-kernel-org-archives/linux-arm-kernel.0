From: david.vrabel@citrix.com (David Vrabel)
Date: Wed, 4 Jan 2012 16:35:45 +0000
Subject: [PATCH v6 6/9] ARM: vexpress: Motherboard RS1 memory map support
In-Reply-To: <1323957761-13553-7-git-send-email-pawel.moll@arm.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-7-git-send-email-pawel.moll@arm.com>
Message-ID: <4F047FE1.5030002@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/11 14:02, Pawel Moll wrote:
> This patch adds support for RS1 memory map based Versatile Express
> motherboard.
> 
[...]
> --- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
> +++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
> @@ -10,12 +10,41 @@
>   * published by the Free Software Foundation.
>   */
>  
> -#define DEBUG_LL_UART_OFFSET	0x00009000
> +#define DEBUG_LL_PHYS_BASE		0x10000000
> +#define DEBUG_LL_UART_OFFSET		0x00009000
> +
> +#define DEBUG_LL_PHYS_BASE_RS1		0x1c000000
> +#define DEBUG_LL_UART_OFFSET_RS1	0x00090000
> +
> +#define DEBUG_LL_VIRT_BASE		0xf8000000
>  
>  		.macro	addruart,rp,rv,tmp
> -		mov	\rp, #DEBUG_LL_UART_OFFSET
> -		orr	\rv, \rp, #0xf8000000	@ virtual base
> -		orr	\rp, \rp, #0x10000000	@ physical base
> +
> +		@ Check the MMU state
> +#if defined(CONFIG_MMU)
> +		mrc	p15, 0, \tmp, c1, c0	@ SCTRL
> +		tst	\tmp, #1		@ MMU enabled?
> +		moveq	\tmp, #DEBUG_LL_PHYS_BASE
> +		movne	\tmp, #DEBUG_LL_VIRT_BASE
> +#else
> +		mov	\tmp, #DEBUG_LL_PHYS_BASE
> +#endif
> +
> +		@ PL011 present in "original" place?
> +		orr	\tmp, \tmp, #DEBUG_LL_UART_OFFSET
> +		ldr	\tmp, [\tmp, #0xfe0]	@ PeriphID0

This doesn't work with CONFIG_EARLY_PRINTK=y on a system with the RS1
memory map.   __create_page_tables has only mapped the single physical
page at 0x1c090000 and thus the test for the UART in the other memory
map faults.

I made it work with this hack, but I'm not sure what the correct
solution would be.

diff --git a/arch/arm/mach-vexpress/include/mach/debug-macro.S
b/arch/arm/mach-vexpress/include/mach/debug-macro.S
index 8010ff9..af443b4 100644
--- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
@@ -30,6 +30,7 @@
 		mov	\tmp, #DEBUG_LL_PHYS_BASE
 #endif

+#if 0
 		@ PL011 present in "original" place?
 		orr	\tmp, \tmp, #DEBUG_LL_UART_OFFSET
 		ldr	\tmp, [\tmp, #0xfe0]	@ PeriphID0
@@ -39,11 +40,12 @@
 		moveq	\rp, #DEBUG_LL_UART_OFFSET
 		orreq	\rv, \rp, #DEBUG_LL_VIRT_BASE
 		orreq	\rp, \rp, #DEBUG_LL_PHYS_BASE
+#endif

-		@ RS1 memory map
-		movne	\rp, #DEBUG_LL_UART_OFFSET_RS1
-		orrne	\rv, \rp, #DEBUG_LL_VIRT_BASE
-		orrne	\rp, \rp, #DEBUG_LL_PHYS_BASE_RS1
+       		@ RS1 memory map
+		mov	\rp, #DEBUG_LL_UART_OFFSET_RS1
+		mov	\rv, \rp, #DEBUG_LL_VIRT_BASE
+		orr	\rp, \rp, #DEBUG_LL_PHYS_BASE_RS1

 		.endm

> +		teq	\tmp, #0x11		@ PL011
> +
> +		@ Original memory map
> +		moveq	\rp, #DEBUG_LL_UART_OFFSET
> +		orreq	\rv, \rp, #DEBUG_LL_VIRT_BASE
> +		orreq	\rp, \rp, #DEBUG_LL_PHYS_BASE
> +
> +		@ RS1 memory map
> +		movne	\rp, #DEBUG_LL_UART_OFFSET_RS1
> +		orrne	\rv, \rp, #DEBUG_LL_VIRT_BASE
> +		orrne	\rp, \rp, #DEBUG_LL_PHYS_BASE_RS1
> +
>  		.endm
>  
>  #include <asm/hardware/debug-pl01x.S>

David
