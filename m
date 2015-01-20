From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Jan 2015 09:16:12 -0800
Subject: [PATCHv2 5/5] arm: omap: specify PMUs are for ARMv7 CPUs
In-Reply-To: <1421770049-32029-6-git-send-email-mark.rutland@arm.com>
References: <1421770049-32029-1-git-send-email-mark.rutland@arm.com>
 <1421770049-32029-6-git-send-email-mark.rutland@arm.com>
Message-ID: <20150120171612.GG7718@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Rutland <mark.rutland@arm.com> [150120 08:12]:
> Now that we can specify which PMU variant we're likely to deal with, do
> so in the omap board code. This will allow us to split the ARMv6, ARMv7,
> and XScale PMU drivers.
> 
> The unnecessary include of asm/pmu.h is also removed.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/mach-omap2/pmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
> index 33c8846..a69e9a3 100644
> --- a/arch/arm/mach-omap2/pmu.c
> +++ b/arch/arm/mach-omap2/pmu.c
> @@ -13,7 +13,7 @@
>   */
>  #include <linux/of.h>
>  
> -#include <asm/pmu.h>
> +#include <asm/system_info.h>
>  
>  #include "soc.h"
>  #include "omap_hwmod.h"
> @@ -37,7 +37,8 @@ static int __init omap2_init_pmu(unsigned oh_num, char *oh_names[])
>  {
>  	int i;
>  	struct omap_hwmod *oh[3];
> -	char *dev_name = "arm-pmu";
> +	char *dev_name = cpu_architecture() == CPU_ARCH_ARMv6 ?
> +			 "armv6-pmu" : "armv7-pmu";
>  
>  	if ((!oh_num) || (oh_num > 3))
>  		return -EINVAL;

Looks OK to me and should not conflict with anything I have queued:

Acked-by: Tony Lindgren <tony@atomide.com>
