From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Mar 2015 11:08:56 +0100
Subject: [PATCH 02/10] ARM: zx: add low level debug support
In-Reply-To: <20150316023740.GH20455@dragon>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <20150315224817.GC8656@n2100.arm.linux.org.uk>
 <20150316023740.GH20455@dragon>
Message-ID: <2441999.X7UitNkZIV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 March 2015 10:37:42 Shawn Guo wrote:
> 
> We chose to duplicate the file to avoid churning generic pl01x.S.  Would
> something like below be acceptable?  Or any better idea?
> 
> diff --git a/arch/arm/include/debug/pl01x.S b/arch/arm/include/debug/pl01x.S
> index 92ef808a2337..da83512c4788 100644
> --- a/arch/arm/include/debug/pl01x.S
> +++ b/arch/arm/include/debug/pl01x.S
> @@ -12,6 +12,13 @@
>  */
>  #include <linux/amba/serial.h>
>  
> +#ifdef CONFIG_ARCH_ZX
> +#undef UART01x_DR
> +#undef UART01x_FR
> +#define UART01x_DR     0x04
> +#define UART01x_FR     0x14
> +#endif
> +
>  #ifdef CONFIG_DEBUG_UART_PHYS
> 

This is almost right, but breaks a corner case where you want to debug
the boot on a platform other than ZX, but in a kernel that also has
ARCH_ZX enabled. I think the best way to solve this is to have
CONFIG_DEBUG_ZTE_ZX select CONFIG_DEBUG_UART_PL01X, and then
use #ifdef CONFIG_DEBUG_ZTE_ZX above rather than CONFIG_ARCH_ZX.

	Arnd
