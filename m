From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:00:38 +0100 (CET)
Subject: [RFC PATCH 06/33] irqchip/gic-v3-its: Add probing for VLPI
 properties
In-Reply-To: <1484648454-21216-7-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131057290.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:
> +	typer = gic_read_typer(its_base + GITS_TYPER);
>  	its->base = its_base;
>  	its->phys_base = res->start;
> -	its->ite_size = ((gic_read_typer(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
> +	its->ite_size = ((typer >> 4) & 0xf) + 1;
> +	its->is_v4 = !!(typer & GITS_TYPER_VLPIS);
> +	if (its->is_v4 && !(typer & GITS_TYPER_VMOVP)) {
> +		int its_number;
> +
> +		its_number = find_first_zero_bit(&its_list_map, 16);

s/16/ITS_MAX_ENTITIES or whatever.

> +		if (its_number >= 16) {
> +			pr_err("ITS@%pa: No ITSList entry available!\n",
> +			       &res->start);
> +			err = -EINVAL;
> +			goto out_free_its;
> +		}
> +
> +		ctlr = readl_relaxed(its_base + GITS_CTLR);
> +		ctlr &= ~GITS_CTLR_ITS_NUMBER;
> +		ctlr |= its_number << GITS_CTLR_ITS_NUMBER_SHIFT;
> +		writel_relaxed(ctlr, its_base + GITS_CTLR);
> +		ctlr = readl_relaxed(its_base + GITS_CTLR);
> +		if ((ctlr & GITS_CTLR_ITS_NUMBER) != (its_number << GITS_CTLR_ITS_NUMBER_SHIFT)) {
> +			its_number = ctlr & GITS_CTLR_ITS_NUMBER;
> +			its_number >>= GITS_CTLR_ITS_NUMBER_SHIFT;
> +		}
> +
> +		if (test_and_set_bit(its_number, &its_list_map)) {

You just established above that the bit is not set. I assume that this is
code which has no concurrency concerns....

Thanks,

	tglx
