From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Nov 2016 15:06:52 +0530
Subject: [PATCH 1/2] ARM: davinci: PM: rework init, support DT platforms
In-Reply-To: <20161114230441.356-2-khilman@baylibre.com>
References: <20161114230441.356-1-khilman@baylibre.com>
 <20161114230441.356-2-khilman@baylibre.com>
Message-ID: <835e8f6b-0c8f-7381-21e1-2fb4b0b006ca@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Looks good to me overall, I have some minor comments.

On Tuesday 15 November 2016 04:34 AM, Kevin Hilman wrote:
> Remove fake platform device used for PM init.  Move pdata values which
> are common across all current platforms into pm.c.
> 
> Also add PM support for DT platforms (vi da8xx-dt.c)

Can you please separate out PM enabling on DT platform to a separate
patch? Its a small change, but it will be nice to separate it from rest
of the cleanup.

> diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
> index f9f9713aacdd..3d7a13789661 100644
> --- a/arch/arm/mach-davinci/include/mach/da8xx.h
> +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
> @@ -101,7 +101,6 @@ int da8xx_register_gpio(void *pdata);
>  int da850_register_cpufreq(char *async_clk);
>  int da8xx_register_cpuidle(void);
>  void __iomem *da8xx_get_mem_ctlr(void);
> -int da850_register_pm(struct platform_device *pdev);
>  int da850_register_sata(unsigned long refclkpn);
>  int da850_register_vpif(void);
>  int da850_register_vpif_display
> diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
> index 8929569b1f8a..fc6a5710b3fa 100644
> --- a/arch/arm/mach-davinci/pm.c
> +++ b/arch/arm/mach-davinci/pm.c
> @@ -23,13 +23,18 @@
>  #include <mach/da8xx.h>
>  #include "sram.h"
>  #include <mach/pm.h>
> +#include <mach/mux.h>

Can you please add the mux.h inclusion above pm.h? Looks like the sram.h
inclusion is out of place already, but since you are touching this part,
can you please move it below along with rest of the local includes.

I see that linux/ includes are not sorted as well, but lets keep that
aside until someone needs to touch them.

>  #include "clock.h"
> +#include "psc.h"
>  
> +#define DA850_PLL1_BASE		0x01e1a000
>  #define DEEPSLEEP_SLEEPCOUNT_MASK	0xFFFF
> +#define DEEPSLEEP_SLEEPCOUNT		128
>  
>  static void (*davinci_sram_suspend) (struct davinci_pm_config *);
> -static struct davinci_pm_config *pdata;
> +static struct davinci_pm_config pm_config;
> +static struct davinci_pm_config *pdata = &pm_config;
>  
>  static void davinci_sram_push(void *dest, void *src, unsigned int size)
>  {
> @@ -117,17 +122,38 @@ static const struct platform_suspend_ops davinci_pm_ops = {
>  	.valid		= suspend_valid_only_mem,
>  };
>  
> -static int __init davinci_pm_probe(struct platform_device *pdev)
> +int __init davinci_pm_init(void)
>  {
> -	pdata = pdev->dev.platform_data;
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "cannot get platform data\n");
> -		return -ENOENT;
> +	int ret;
> +
> +	ret = davinci_cfg_reg(DA850_RTC_ALARM);
> +	if (ret)
> +		return ret;
> +
> +	pdata->sleepcount = DEEPSLEEP_SLEEPCOUNT;
> +	pdata->ddr2_ctlr_base = da8xx_get_mem_ctlr();
> +	pdata->deepsleep_reg = DA8XX_SYSCFG1_VIRT(DA8XX_DEEPSLEEP_REG);
> +	pdata->ddrpsc_num = DA8XX_LPSC1_EMIF3C;

Some of these could be statically initialized in pm_config. Can you
please move the constants to static initialization.

Thanks,
Sekhar
