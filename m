From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 9 Jun 2015 20:44:39 +0200
Subject: [PATCH 03/15] clk: kill off set_irq_flags usage
In-Reply-To: <1433874401-27161-4-git-send-email-robh@kernel.org>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-4-git-send-email-robh@kernel.org>
Message-ID: <20150609204439.1461f02b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  9 Jun 2015 13:26:29 -0500
Rob Herring <robh@kernel.org> wrote:

> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
> 
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
> 
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also set IRQ_NOPROBE and this has been maintained although it is not
> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-clk at vger.kernel.org
> ---
>  drivers/clk/at91/pmc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 3f27d21..828b196 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -125,7 +125,6 @@ static int pmc_irq_map(struct irq_domain *h, unsigned int virq,
>  
>  	irq_set_chip_and_handler(virq, &pmc_irq,
>  				 handle_level_irq);
> -	set_irq_flags(virq, IRQF_VALID);
>  	irq_set_chip_data(virq, pmc);
>  
>  	return 0;



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
