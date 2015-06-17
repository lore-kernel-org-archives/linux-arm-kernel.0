From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 17 Jun 2015 16:39:01 +0200
Subject: [PATCH v2 2/2] clk: at91: modify PMC peripheral clock to deal
 with newer register layout
In-Reply-To: <00aa7c245a7960d6101dad4b284a19cab766ee4a.1434544584.git.nicolas.ferre@atmel.com>
References: <62604b586c61f119ffb5942b77eb9b759c17a790.1434544584.git.nicolas.ferre@atmel.com>
 <00aa7c245a7960d6101dad4b284a19cab766ee4a.1434544584.git.nicolas.ferre@atmel.com>
Message-ID: <20150617163901.721cfdd0@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Jun 2015 14:40:39 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> As some more information is added to the PCR register, we'd better use
> a copy of its content and modify just the peripheral-related bits.
> Implement a read-modify-write for the enable() and disable() callbacks.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
> v2: - modify header file beforehand so that we can use consistent field naming
> 
> 
>  drivers/clk/at91/clk-peripheral.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
> index 61d0adda7088..1e7dcc57925a 100644
> --- a/drivers/clk/at91/clk-peripheral.c
> +++ b/drivers/clk/at91/clk-peripheral.c
> @@ -161,14 +161,18 @@ static int clk_sam9x5_peripheral_enable(struct clk_hw *hw)
>  {
>  	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
>  	struct at91_pmc *pmc = periph->pmc;
> +	u32 tmp;
>  
>  	if (periph->id < PERIPHERAL_ID_MIN)
>  		return 0;
>  
> -	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID_MASK) |
> -				     AT91_PMC_PCR_CMD |
> -				     AT91_PMC_PCR_DIV(periph->div) |
> -				     AT91_PMC_PCR_EN);
> +	pmc_lock(pmc);
> +	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID_MASK));
> +	tmp = pmc_read(pmc, AT91_PMC_PCR) & ~AT91_PMC_PCR_DIV_MASK;
> +	pmc_write(pmc, AT91_PMC_PCR, tmp | AT91_PMC_PCR_DIV(periph->div)
> +					 | AT91_PMC_PCR_CMD
> +					 | AT91_PMC_PCR_EN);
> +	pmc_unlock(pmc);
>  	return 0;
>  }
>  
> @@ -176,12 +180,16 @@ static void clk_sam9x5_peripheral_disable(struct clk_hw *hw)
>  {
>  	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
>  	struct at91_pmc *pmc = periph->pmc;
> +	u32 tmp;
>  
>  	if (periph->id < PERIPHERAL_ID_MIN)
>  		return;
>  
> -	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID_MASK) |
> -				     AT91_PMC_PCR_CMD);
> +	pmc_lock(pmc);
> +	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID_MASK));
> +	tmp = pmc_read(pmc, AT91_PMC_PCR) & ~AT91_PMC_PCR_EN;
> +	pmc_write(pmc, AT91_PMC_PCR, tmp | AT91_PMC_PCR_CMD);
> +	pmc_unlock(pmc);
>  }
>  
>  static int clk_sam9x5_peripheral_is_enabled(struct clk_hw *hw)



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
