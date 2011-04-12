From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Apr 2011 22:01:47 +0100
Subject: [PATCH 3/7] ARM: mmp: set correct uart according to board
In-Reply-To: <1302264944-2759-3-git-send-email-haojian.zhuang@marvell.com>
References: <2011040801>
	<1302264944-2759-1-git-send-email-haojian.zhuang@marvell.com>
	<1302264944-2759-2-git-send-email-haojian.zhuang@marvell.com>
	<1302264944-2759-3-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110412210147.GF7806@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2011 at 08:15:40PM +0800, Haojian Zhuang wrote:
> UART3 is the default console in jasper, brownstone and avengers lite.
> 
> Change-Id: Iacfe665cc0e20a47d50e0b2ad8724097f28e7d2c

Please don't include Change-Ids in patch submissions.

> diff --git a/arch/arm/mach-mmp/include/mach/debug-macro.S b/arch/arm/mach-mmp/include/mach/debug-macro.S
> index 7e2ebd3..b353785 100644
> --- a/arch/arm/mach-mmp/include/mach/debug-macro.S
> +++ b/arch/arm/mach-mmp/include/mach/debug-macro.S
> @@ -14,8 +14,14 @@
>  		.macro	addruart, rp, rv
>  		ldr	\rp, =APB_PHYS_BASE		@ physical
>  		ldr	\rv, =APB_VIRT_BASE		@ virtual
> +#if defined(CONFIG_MACH_BROWNSTONE) || defined(CONFIG_MACH_MARVELL_JASPER) \
> +	|| defined(CONFIG_MACH_AVENGERS_LITE)
> +		orr	\rp, \rp, #0x00018000
> +		orr	\rv, \rv, #0x00018000
> +#else
>  		orr	\rp, \rp, #0x00017000
>  		orr	\rv, \rv, #0x00017000
> +#endif

It probably makes more sense to have this in the configuration scripts:

choice
	prompt "PXA debug uart"
	default DEBUG_PXA_UART0

config DEBUG_PXA_UART0
	bool "UART 0"

config DEBUG_PXA_UART1
	bool "UART 1"
	default y if MACH_BROWNSTONE || MACH_MARVELL_JASPER || MACH_AVENGERS_LITE

endchoice

and select the debug uart address using these symbols.  That'd avoid the
need to couple lots of platform specific stuff into the compiled files.

Alternatively, you could do more in the Kconfig like this:

config DEBUG_PXA_UART
	hex
	default 0x17000 if DEBUG_PXA_UART0
	default 0x18000 if DEBUG_PXA_UART1

and use CONFIG_DEBUG_PXA_UART in the assembly code, eliminating the
need to change sourcecode for additional uarts.  Or maybe combine the
two ideas.
