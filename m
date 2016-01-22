From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Fri, 22 Jan 2016 16:40:35 +0100
Subject: [PATCH v3 04/13] clk: at91: make IRQ optional and register them
 later
In-Reply-To: <1449248628-3486-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1449248628-3486-5-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160122154034.GA20020@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-12-04 18:03:39 [+0100], Alexandre Belloni wrote:
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 295b17b9c689..296d20a29c6c 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -20,6 +20,9 @@
?
> +	pmc->irqdomain = irq_domain_add_linear(pdev->dev.of_node, 32,
> +					       &pmc_irq_ops, pmc);
> +	if (!pmc->irqdomain)
> +		return 0;
>  
> -static void __init of_at91sam9n12_pmc_setup(struct device_node *np)
> -{
> -	of_at91_pmc_setup(np, &at91sam9n12_caps);
> -}
> -CLK_OF_DECLARE(at91sam9n12_clk_pmc, "atmel,at91sam9n12-pmc",
> -	       of_at91sam9n12_pmc_setup);
> +	regmap_write(pmc->regmap, AT91_PMC_IDR, 0xffffffff);
> +	ret = request_irq(pmc->virq, pmc_irq_handler,
> +			  IRQF_SHARED | IRQF_COND_SUSPEND, "pmc", pmc);

You need IRQF_NOTHREAD here becuase pmc_irq_handler() is demuxing
interrupts / invoking generic_handle_irq().
However regmap_read() inside pmc_irq_handler() is taking a sleeping lock
on -RT so this is not going to fly. So either get rid regmap_read() in
the handler or use handle_nested_irq() instead.

> +	if (ret)
> +		return ret;

Sebastian
