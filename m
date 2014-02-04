From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 4 Feb 2014 10:04:11 +0100
Subject: [PATCH 1/3] clk: at91: fix programmable clk irq handling
In-Reply-To: <1391426731-9392-2-git-send-email-b.brezillon@overkiz.com>
References: <1391426731-9392-1-git-send-email-b.brezillon@overkiz.com>
 <1391426731-9392-2-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52F0AD0B.3030106@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2014 12:25, Boris BREZILLON :
> The prog irq is a level irq reflecting the prog clk status. As a result the
> irq line will stay high when the prog clk is ready and the system will
> hang.
> Disable the irq when it is handled to avoid this problem.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/clk/at91/clk-programmable.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
> index fd792b2..02f62a0 100644
> --- a/drivers/clk/at91/clk-programmable.c
> +++ b/drivers/clk/at91/clk-programmable.c
> @@ -55,6 +55,7 @@ static irqreturn_t clk_programmable_irq_handler(int irq, void *dev_id)
>  	struct clk_programmable *prog = (struct clk_programmable *)dev_id;
>  
>  	wake_up(&prog->wait);
> +	disable_irq_nosync(prog->irq);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -74,8 +75,10 @@ static int clk_programmable_prepare(struct clk_hw *hw)
>  
>  	pmc_write(pmc, AT91_PMC_PCKR(id), tmp);
>  
> -	while (!(pmc_read(pmc, AT91_PMC_SR) & mask))
> +	while (!(pmc_read(pmc, AT91_PMC_SR) & mask)) {
> +		enable_irq(prog->irq);
>  		wait_event(prog->wait, pmc_read(pmc, AT91_PMC_SR) & mask);
> +	}
>  
>  	return 0;
>  }
> 


-- 
Nicolas Ferre
