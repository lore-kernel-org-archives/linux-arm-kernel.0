From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 16 Nov 2016 14:33:16 +0530
Subject: [PATCH v2 1/3] ARM: davinci: PM: rework init, support DT platforms
In-Reply-To: <20161115195421.19983-2-khilman@baylibre.com>
References: <20161115195421.19983-1-khilman@baylibre.com>
 <20161115195421.19983-2-khilman@baylibre.com>
Message-ID: <59f6af1d-d36a-c68c-59fc-024042fd79e0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 November 2016 01:24 AM, Kevin Hilman wrote:
> Remove fake platform device used for PM init.  Move pdata values which
> are common across all current platforms into pm.c.
> 
> Also, since PM is only used on da8xx, remove davinci_pm_init() from
> common init code, and only use in da850/omapl138 board files that are
> currently creating the fake platform_device.
> 
> Suggested-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

> diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
> index 8929569b1f8a..3f1fb191c03f 100644
> --- a/arch/arm/mach-davinci/pm.c
> +++ b/arch/arm/mach-davinci/pm.c
> @@ -21,15 +21,23 @@
>  
>  #include <mach/common.h>
>  #include <mach/da8xx.h>
> -#include "sram.h"
> +#include <mach/mux.h>
>  #include <mach/pm.h>
>  
>  #include "clock.h"
> +#include "psc.h"
> +#include "sram.h"
>  
> +#define DA850_PLL1_BASE		0x01e1a000
>  #define DEEPSLEEP_SLEEPCOUNT_MASK	0xFFFF
> +#define DEEPSLEEP_SLEEPCOUNT		128
>  
>  static void (*davinci_sram_suspend) (struct davinci_pm_config *);
> -static struct davinci_pm_config *pdata;
> +static struct davinci_pm_config pm_config = {
> +	.sleepcount = DEEPSLEEP_SLEEPCOUNT,
> +	.ddrpsc_num = DA8XX_LPSC1_EMIF3C,
> +};

I added an empty line here while applying. This was pointed to by
checkpatch --strict

> +static struct davinci_pm_config *pdata = &pm_config;

And also adjusted the subject line since there is no DT support being
added in this patch anymore. New subject line:

ARM: davinci: PM: rework init, remove platform device

Applied to v4.10/cleanup

Thanks,
Sekhar
