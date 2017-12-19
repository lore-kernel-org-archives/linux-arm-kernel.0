From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 23:25:35 +0100
Subject: [PATCH v6 3/3] clk: at91: pmc: Support backup for programmable
 clocks
In-Reply-To: <20171211165535.5126-4-romain.izard.pro@gmail.com>
References: <20171211165535.5126-1-romain.izard.pro@gmail.com>
 <20171211165535.5126-4-romain.izard.pro@gmail.com>
Message-ID: <20171219222535.GU15162@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2017 at 17:55:35 +0100, Romain Izard wrote:
> When an AT91 programmable clock is declared in the device tree, register
> it into the Power Management Controller driver. On entering suspend mode,
> the driver saves and restores the Programmable Clock registers to support
> the backup mode for these clocks.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
> Changes in v2:
> * register PCKs on clock startup
> 
> Changes in v3:
> * improve comments on hanling 0 in pmc_register_id and pmc_register_pck
> * declare local variables earlier for checkpatch
> 
> Changes in v6:
> * Use the correct author email address
> 
>  drivers/clk/at91/clk-programmable.c |  2 ++
>  drivers/clk/at91/pmc.c              | 35 +++++++++++++++++++++++++++++++++++
>  drivers/clk/at91/pmc.h              |  2 ++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
> index 85a449cf61e3..0e6aab1252fc 100644
> --- a/drivers/clk/at91/clk-programmable.c
> +++ b/drivers/clk/at91/clk-programmable.c
> @@ -204,6 +204,8 @@ at91_clk_register_programmable(struct regmap *regmap,
>  	if (ret) {
>  		kfree(prog);
>  		hw = ERR_PTR(ret);
> +	} else {
> +		pmc_register_pck(id);
>  	}
>  
>  	return hw;
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 07dc2861ad3f..1fa27f4ea538 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -22,6 +22,7 @@
>  #include "pmc.h"
>  
>  #define PMC_MAX_IDS 128
> +#define PMC_MAX_PCKS 8
>  
>  int of_at91_get_clk_range(struct device_node *np, const char *propname,
>  			  struct clk_range *range)
> @@ -50,6 +51,7 @@ EXPORT_SYMBOL_GPL(of_at91_get_clk_range);
>  static struct regmap *pmcreg;
>  
>  static u8 registered_ids[PMC_MAX_IDS];
> +static u8 registered_pcks[PMC_MAX_PCKS];
>  
>  static struct
>  {
> @@ -66,8 +68,13 @@ static struct
>  	u32 pcr[PMC_MAX_IDS];
>  	u32 audio_pll0;
>  	u32 audio_pll1;
> +	u32 pckr[PMC_MAX_PCKS];
>  } pmc_cache;
>  
> +/*
> + * As Peripheral ID 0 is invalid on AT91 chips, the identifier is stored
> + * without alteration in the table, and 0 is for unused clocks.
> + */
>  void pmc_register_id(u8 id)
>  {
>  	int i;
> @@ -82,9 +89,28 @@ void pmc_register_id(u8 id)
>  	}
>  }
>  
> +/*
> + * As Programmable Clock 0 is valid on AT91 chips, there is an offset
> + * of 1 between the stored value and the real clock ID.
> + */
> +void pmc_register_pck(u8 pck)
> +{
> +	int i;
> +
> +	for (i = 0; i < PMC_MAX_PCKS; i++) {
> +		if (registered_pcks[i] == 0) {
> +			registered_pcks[i] = pck + 1;
> +			break;
> +		}
> +		if (registered_pcks[i] == (pck + 1))
> +			break;
> +	}
> +}
> +
>  static int pmc_suspend(void)
>  {
>  	int i;
> +	u8 num;
>  
>  	regmap_read(pmcreg, AT91_PMC_SCSR, &pmc_cache.scsr);
>  	regmap_read(pmcreg, AT91_PMC_PCSR, &pmc_cache.pcsr0);
> @@ -103,6 +129,10 @@ static int pmc_suspend(void)
>  		regmap_read(pmcreg, AT91_PMC_PCR,
>  			    &pmc_cache.pcr[registered_ids[i]]);
>  	}
> +	for (i = 0; registered_pcks[i]; i++) {
> +		num = registered_pcks[i] - 1;
> +		regmap_read(pmcreg, AT91_PMC_PCKR(num), &pmc_cache.pckr[num]);
> +	}
>  
>  	return 0;
>  }
> @@ -119,6 +149,7 @@ static bool pmc_ready(unsigned int mask)
>  static void pmc_resume(void)
>  {
>  	int i;
> +	u8 num;
>  	u32 tmp;
>  	u32 mask = AT91_PMC_MCKRDY | AT91_PMC_LOCKA;
>  
> @@ -143,6 +174,10 @@ static void pmc_resume(void)
>  			     pmc_cache.pcr[registered_ids[i]] |
>  			     AT91_PMC_PCR_CMD);
>  	}
> +	for (i = 0; registered_pcks[i]; i++) {
> +		num = registered_pcks[i] - 1;
> +		regmap_write(pmcreg, AT91_PMC_PCKR(num), pmc_cache.pckr[num]);
> +	}
>  
>  	if (pmc_cache.uckr & AT91_PMC_UPLLEN)
>  		mask |= AT91_PMC_LOCKU;
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 858e8ef7e8db..d22b1fa9ecdc 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -31,8 +31,10 @@ int of_at91_get_clk_range(struct device_node *np, const char *propname,
>  
>  #ifdef CONFIG_PM
>  void pmc_register_id(u8 id);
> +void pmc_register_pck(u8 pck);
>  #else
>  static inline void pmc_register_id(u8 id) {}
> +static inline void pmc_register_pck(u8 pck) {}
>  #endif
>  
>  #endif /* __PMC_H_ */
> -- 
> 2.14.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
