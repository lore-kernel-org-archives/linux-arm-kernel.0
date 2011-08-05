From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 5 Aug 2011 09:54:45 +0200
Subject: [patch 1/1] iMX: Fix build for iMX53
In-Reply-To: <20110805073253.599604130@rtp-net.org>
References: <20110805073240.162681115@rtp-net.org>
	<20110805073253.599604130@rtp-net.org>
Message-ID: <20110805075445.GO31521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2011 at 09:32:41AM +0200, Arnaud Patard wrote:
> Commit fad107086d5a869c1c07e5bb35b7b57a10ecf578 fixed the wrong test for MX51
> as the MX51 addresses are wrong for MX50 and MX53 but now it's MX51 only, 
> UART_PADDR is not defined anymore when building for MX50/MX53.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Tested-by: Steev Klimaszewski <steev@genesi-usa.com>
> Index: linux-2.6/arch/arm/plat-mxc/include/mach/debug-macro.S
> ===================================================================
> --- linux-2.6.orig/arch/arm/plat-mxc/include/mach/debug-macro.S	2011-08-05 00:38:15.000000000 +0200
> +++ linux-2.6/arch/arm/plat-mxc/include/mach/debug-macro.S	2011-08-05 09:32:32.000000000 +0200
> @@ -44,6 +44,14 @@
>  #define UART_PADDR	MX51_UART1_BASE_ADDR
>  #endif
>  
> +/* iMX50/53 have same addresses, but not iMX51 */
> +#if defined(CONFIG_SOC_IMX50) || defined(CONFIG_SOC_IMX53)
> +#ifdef UART_PADDR
> +#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
> +#endif
> +#define UART_PADDR	MX53_UART1_BASE_ADDR
> +#endif
> +
>  #define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
>  
>  		.macro	addruart, rp, rv
Looks good

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
