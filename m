From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 29 Jul 2015 09:15:31 +0200
Subject: [PATCH v4] clk: at91: add generated clock driver
In-Reply-To: <1438099685-5592-1-git-send-email-nicolas.ferre@atmel.com>
References: <1438099685-5592-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150729091531.2f167170@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Tue, 28 Jul 2015 18:08:05 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:


> +static void clk_generated_startup(struct clk_generated *gck)
> +{
> +	struct at91_pmc *pmc = gck->pmc;
> +	u32 tmp;
> +
> +	pmc_lock(pmc);
> +	pmc_write(pmc, AT91_PMC_PCR, (gck->id & AT91_PMC_PCR_PID_MASK));
> +	tmp = pmc_read(pmc, AT91_PMC_PCR);
> +	pmc_unlock(pmc);
> +
> +	gck->parent_id = (tmp & AT91_PMC_PCR_GCKCSS_MASK)
> +					>> AT91_PMC_PCR_GCKCSS_OFFSET;
> +	/*
> +	 * make sure that what we read in hardware is coherent with
> +	 * what we've just probed
> +	 */
> +	if (gck->parent_id >= __clk_get_num_parents(gck->hw.clk))
> +		gck->parent_id = 0;

Hm, I'm not sure this is correct. Here, you're just faking the
fact that your current parent is the first one in the parent list while
it actually points to the 6th entry. Not only your rate will be false
(the one calculated in ->round_rate()), but you're also changing the
behavior of the clk_set_rate() and clk_set_parent() operation (AFAIR,
if you try to change to the first parent, the core code will think it's
already properly configured and will never call ->set_parent()).

This leaves 2 solutions here:
- implement the missing clk driver and add an entry in the parent
  list
- select the 1st parent clk (I mean, change the register value) if the
  hardware points to the 6th one.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
