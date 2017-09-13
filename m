From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 13 Sep 2017 14:29:35 +0200
Subject: [PATCH v1 03/10] clk: at91: pmc: Support backup for programmable
 clocks
In-Reply-To: <20170908153604.28383-4-romain.izard.pro@gmail.com>
References: <20170908153604.28383-1-romain.izard.pro@gmail.com>
 <20170908153604.28383-4-romain.izard.pro@gmail.com>
Message-ID: <b0c7e816-4a7c-609d-2bc7-281fc6ca751d@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2017 at 17:35, Romain Izard wrote:
> From: Romain Izard <romain.izard@mobile-devices.fr>
> 
> Save and restore the System Clock and Programmable Clock register for
> the backup use case.

"System Clock" seems to be handled in another patch.

> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
>  drivers/clk/at91/pmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 07dc2861ad3f..5421b03553ec 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -66,6 +66,7 @@ static struct
>  	u32 pcr[PMC_MAX_IDS];
>  	u32 audio_pll0;
>  	u32 audio_pll1;
> +	u32 pckr[3];

Some products have different numbers of PCK (only 2 on at91sam9x5 for
instance)...

>  } pmc_cache;
>  
>  void pmc_register_id(u8 id)
> @@ -103,6 +104,8 @@ static int pmc_suspend(void)
>  		regmap_read(pmcreg, AT91_PMC_PCR,
>  			    &pmc_cache.pcr[registered_ids[i]]);
>  	}
> +	for (i = 0; i < 3; i++)

And it might be a good practice to have this constant value in a #define.
We have "#define PROG_ID_MAX  7" defined in
drivers/clk/at91/clk-programmable.c.

Regards,


> +		regmap_read(pmcreg, AT91_PMC_PCKR(i), &pmc_cache.pckr[i]);
>  
>  	return 0;
>  }
> @@ -143,6 +146,8 @@ static void pmc_resume(void)
>  			     pmc_cache.pcr[registered_ids[i]] |
>  			     AT91_PMC_PCR_CMD);
>  	}
> +	for (i = 0; i < 3; i++)
> +		regmap_write(pmcreg, AT91_PMC_PCKR(i), pmc_cache.pckr[i]);
>  
>  	if (pmc_cache.uckr & AT91_PMC_UPLLEN)
>  		mask |= AT91_PMC_LOCKU;
> 


-- 
Nicolas Ferre
