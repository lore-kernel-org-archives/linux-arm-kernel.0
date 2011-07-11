From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Mon, 11 Jul 2011 12:06:09 +0300
Subject: [PATCH 1/1] ARM: i.MX50/53: debug-macro: fix UART_PADDR
In-Reply-To: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20110711090609.GB2482@matterhorn1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 Jul 09, Troy Kisky wrote:
> The i.MX51 UART_PADDR value does not work for MX50/53.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Acked-by: Amit Kucheria <amit.kucheria@canonical.com>

but I think we should switch to runtime detection of the machine (machine
ID?) and then set the port address.

See arch/arm/plat-omap/include/plat/uncompress.h for a possible scheme.

> ---
>  arch/arm/plat-mxc/include/mach/debug-macro.S |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
> index 8e8d175..3919ad4 100644
> --- a/arch/arm/plat-mxc/include/mach/debug-macro.S
> +++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
> @@ -37,13 +37,20 @@
>  #define UART_PADDR	MX3x_UART1_BASE_ADDR
>  #endif
>  
> -#ifdef CONFIG_ARCH_MX5
> +#ifdef CONFIG_ARCH_MX51
>  #ifdef UART_PADDR
>  #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
>  #endif
>  #define UART_PADDR	MX51_UART1_BASE_ADDR
>  #endif
>  
> +#if defined(CONFIG_ARCH_MX50) || defined(CONFIG_ARCH_MX53)
> +#ifdef UART_PADDR
> +#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
> +#endif
> +#define UART_PADDR	MX53_UART1_BASE_ADDR
> +#endif
> +
>  #define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
>  
>  		.macro	addruart, rp, rv
> -- 
> 1.7.0.4
> 

-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
