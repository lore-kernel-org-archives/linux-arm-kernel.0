From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 10 Jun 2015 15:55:45 +0200
Subject: [PATCH] clk: at91: modify PMC peripheral clock to deal with
 newer register layout
In-Reply-To: <1433943764-18506-1-git-send-email-nicolas.ferre@atmel.com>
References: <1433943764-18506-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150610155545.171fd92d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, 10 Jun 2015 15:42:44 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> As some more information is added to the PCR register, we'd better use
> a copy of its content and modify just the peripheral-related bits.
> Implement a read-modify-write for the enable() and disable() callbacks.
> 
> Header file is also modified to have the PCR_DIV mask.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Apart from the below comment you can add my:

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/clk/at91/clk-peripheral.c | 19 +++++++++++++------
>  include/linux/clk/at91_pmc.h      |  3 ++-
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
> index 597fed423d7d..37e2fea14890 100644
> --- a/drivers/clk/at91/clk-peripheral.c
> +++ b/drivers/clk/at91/clk-peripheral.c
> @@ -161,14 +161,17 @@ static int clk_sam9x5_peripheral_enable(struct clk_hw *hw)
>  {
>  	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
>  	struct at91_pmc *pmc = periph->pmc;
> +	u32 tmp;
>  
>  	if (periph->id < PERIPHERAL_ID_MIN)
>  		return 0;
>  
> -	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID) |
> -				     AT91_PMC_PCR_CMD |
> -				     AT91_PMC_PCR_DIV(periph->div) |
> -				     AT91_PMC_PCR_EN);
> +	pmc_lock(pmc);
> +	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID));
> +	tmp = pmc_read(pmc, AT91_PMC_PCR) & ~AT91_PMC_PCR_P_DIV;
> +	pmc_write(pmc, AT91_PMC_PCR, tmp | AT91_PMC_PCR_PDIV(periph->div)
> +					 | AT91_PMC_PCR_EN);
> +	pmc_unlock(pmc);
>  	return 0;
>  }
>  
> @@ -176,12 +179,16 @@ static void clk_sam9x5_peripheral_disable(struct clk_hw *hw)
>  {
>  	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
>  	struct at91_pmc *pmc = periph->pmc;
> +	u32 tmp;
>  
>  	if (periph->id < PERIPHERAL_ID_MIN)
>  		return;
>  
> -	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID) |
> -				     AT91_PMC_PCR_CMD);
> +	pmc_lock(pmc);
> +	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID));
> +	tmp = pmc_read(pmc, AT91_PMC_PCR) & ~AT91_PMC_PCR_EN;
> +	pmc_write(pmc, AT91_PMC_PCR, tmp);
> +	pmc_unlock(pmc);
>  }
>  
>  static int clk_sam9x5_peripheral_is_enabled(struct clk_hw *hw)
> diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
> index 7669f7618f39..4685c3d62f94 100644
> --- a/include/linux/clk/at91_pmc.h
> +++ b/include/linux/clk/at91_pmc.h
> @@ -184,7 +184,8 @@ extern void __iomem *at91_pmc_base;
>  #define AT91_PMC_PCR		0x10c			/* Peripheral Control Register [some SAM9 and SAMA5] */
>  #define		AT91_PMC_PCR_PID	(0x3f  <<  0)		/* Peripheral ID */
>  #define		AT91_PMC_PCR_CMD	(0x1  <<  12)		/* Command (read=0, write=1) */
> -#define		AT91_PMC_PCR_DIV(n)	((n)  <<  16)		/* Divisor Value */
> +#define		AT91_PMC_PCR_P_DIV	(0x3  <<  16)		/* Divisor mask */

How about renaming this macro into AT91_PMC_PCR_PDIV_MSK ?
I know the macro names in this file are not consistent, but maybe it's
time to choose appropriate names for new AT91_PMC macros.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
