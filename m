From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 13 Sep 2017 14:10:41 +0200
Subject: [PATCH v1 02/10] clk: at91: pmc: Save SCSR during suspend
In-Reply-To: <20170908153604.28383-3-romain.izard.pro@gmail.com>
References: <20170908153604.28383-1-romain.izard.pro@gmail.com>
 <20170908153604.28383-3-romain.izard.pro@gmail.com>
Message-ID: <318420d4-044f-d018-f70e-3ed4fcfb0fd0@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2017 at 17:35, Romain Izard wrote:
> The contents of the System Clock Status Register (SCSR) needs to be
> restored into the System Clock Enable Register (SCER).
> 
> As the bootloader will restore some clocks by itself, the issue can be
> missed as only the USB controller, the LCD controller, the Image Sensor
> controller and the programmable clocks will be impacted.
> 
> Fix the obvious typo in the suspend/resume code, as the IMR register
> does not need to be saved twice.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Yes, it looks like a typo:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

I didn't experienced the issue with LCD nor USB though.

Regards,

> ---
>  drivers/clk/at91/pmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 5c2b26de303e..07dc2861ad3f 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -86,7 +86,7 @@ static int pmc_suspend(void)
>  {
>  	int i;
>  
> -	regmap_read(pmcreg, AT91_PMC_IMR, &pmc_cache.scsr);
> +	regmap_read(pmcreg, AT91_PMC_SCSR, &pmc_cache.scsr);
>  	regmap_read(pmcreg, AT91_PMC_PCSR, &pmc_cache.pcsr0);
>  	regmap_read(pmcreg, AT91_CKGR_UCKR, &pmc_cache.uckr);
>  	regmap_read(pmcreg, AT91_CKGR_MOR, &pmc_cache.mor);
> @@ -129,7 +129,7 @@ static void pmc_resume(void)
>  	if (pmc_cache.pllar != tmp)
>  		pr_warn("PLLAR was not configured properly by the firmware\n");
>  
> -	regmap_write(pmcreg, AT91_PMC_IMR, pmc_cache.scsr);
> +	regmap_write(pmcreg, AT91_PMC_SCER, pmc_cache.scsr);
>  	regmap_write(pmcreg, AT91_PMC_PCER, pmc_cache.pcsr0);
>  	regmap_write(pmcreg, AT91_CKGR_UCKR, pmc_cache.uckr);
>  	regmap_write(pmcreg, AT91_CKGR_MOR, pmc_cache.mor);
> 


-- 
Nicolas Ferre
