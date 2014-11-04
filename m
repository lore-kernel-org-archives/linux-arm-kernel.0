From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 4 Nov 2014 14:12:14 +0800
Subject: [PATCH] arm: imx: clean up machine mxc_arch_reset_init_dt reset
 init
In-Reply-To: <1414748393-20799-1-git-send-email-jingchang.lu@freescale.com>
References: <1414748393-20799-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20141104061212.GH10821@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 05:39:53PM +0800, Jingchang Lu wrote:
> diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
> index 418dbc8..e0a4e2f 100644
> --- a/arch/arm/mach-imx/imx31-dt.c
> +++ b/arch/arm/mach-imx/imx31-dt.c
> @@ -15,16 +15,8 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
>  
> -#include "common.h"

The change causes the build errors below.

  CC      arch/arm/mach-imx/imx31-dt.o
../arch/arm/mach-imx/imx31-dt.c: In function ?imx31_dt_timer_init?:
../arch/arm/mach-imx/imx31-dt.c:27:2: error: implicit declaration of function ?mx31_clocks_init_dt? [-Werror=implicit-function-declaration]
../arch/arm/mach-imx/imx31-dt.c: At top level:
../arch/arm/mach-imx/imx31-dt.c:31:13: error: ?mx31_map_io? undeclared here (not in a function)
../arch/arm/mach-imx/imx31-dt.c:32:16: error: ?imx31_init_early? undeclared here (not in a function)
../arch/arm/mach-imx/imx31-dt.c:33:14: error: ?mx31_init_irq? undeclared here (not in a function)

So the common.h inclusion needs to be kept.  I fixed it up and applied the patch.

Shawn

>  #include "mx31.h"
>  
> -static void __init imx31_dt_init(void)
> -{
> -	mxc_arch_reset_init_dt();
> -
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> -
>  static const char * const imx31_dt_board_compat[] __initconst = {
>  	"fsl,imx31",
>  	NULL
