From: Wenyou.Yang@microchip.com (Wenyou.Yang at microchip.com)
Date: Wed, 29 Mar 2017 04:50:18 +0000
Subject: [PATCH v2 02/11] ARM: at91: pm: Move at91_ramc_read/write to pm.c
In-Reply-To: <20170328111938.21297-3-alexandre.belloni@free-electrons.com>
References: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
 <20170328111938.21297-3-alexandre.belloni@free-electrons.com>
Message-ID: <F9F4555C4E01D7469D37975B62D0EFBB51D786@CHN-SV-EXMX07.mchp-main.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: 2017?3?28? 19:19
> To: Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Boris
> Brezillon <boris.brezillon@free-electrons.com>; Wenyou Yang - A41535
> <Wenyou.Yang@microchip.com>; Alexandre Belloni <alexandre.belloni@free-
> electrons.com>
> Subject: [PATCH v2 02/11] ARM: at91: pm: Move at91_ramc_read/write to pm.c
> 
> Those macros are only used in pm.c, move them there so we can remove the test
> on __ASSEMBLY__.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Wenyou Yang <wenyou.yang@atmel.com>

> ---
>  arch/arm/mach-at91/pm.c | 6 ++++++
>  arch/arm/mach-at91/pm.h | 8 --------
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c index
> 9e2b5c1e503e..41789aa4df86 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -45,6 +45,12 @@ static struct {
>  } at91_pm_data;
> 
>  static void __iomem *at91_ramc_base[2];
> +#define at91_ramc_read(id, field) \
> +	__raw_readl(at91_ramc_base[id] + field)
> +
> +#define at91_ramc_write(id, field, value) \
> +	__raw_writel(value, at91_ramc_base[id] + field)
> +
> 
>  static int at91_pm_valid_state(suspend_state_t state)  { diff --git
> a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h index
> bf980c6ef294..8eed156ef19a 100644
> --- a/arch/arm/mach-at91/pm.h
> +++ b/arch/arm/mach-at91/pm.h
> @@ -17,14 +17,6 @@
>  #include <soc/at91/at91sam9_ddrsdr.h>
>  #include <soc/at91/at91sam9_sdramc.h>
> 
> -#ifndef __ASSEMBLY__
> -#define at91_ramc_read(id, field) \
> -	__raw_readl(at91_ramc_base[id] + field)
> -
> -#define at91_ramc_write(id, field, value) \
> -	__raw_writel(value, at91_ramc_base[id] + field)
> -#endif
> -
>  #define AT91_MEMCTRL_MC		0
>  #define AT91_MEMCTRL_SDRAMC	1
>  #define AT91_MEMCTRL_DDRSDR	2
> --
> 2.11.0
