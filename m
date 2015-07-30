From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 30 Jul 2015 12:41:07 +0200
Subject: [PATCH v4] clk: at91: add generated clock driver
In-Reply-To: <20150729091531.2f167170@bbrezillon>
References: <1438099685-5592-1-git-send-email-nicolas.ferre@atmel.com>
 <20150729091531.2f167170@bbrezillon>
Message-ID: <55B9FF43.2070101@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 29/07/2015 09:15, Boris Brezillon a ?crit :
> Hi Nicolas,
> 
> On Tue, 28 Jul 2015 18:08:05 +0200
> Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> 
> 
>> +static void clk_generated_startup(struct clk_generated *gck)
>> +{
>> +	struct at91_pmc *pmc = gck->pmc;
>> +	u32 tmp;
>> +
>> +	pmc_lock(pmc);
>> +	pmc_write(pmc, AT91_PMC_PCR, (gck->id & AT91_PMC_PCR_PID_MASK));
>> +	tmp = pmc_read(pmc, AT91_PMC_PCR);
>> +	pmc_unlock(pmc);
>> +
>> +	gck->parent_id = (tmp & AT91_PMC_PCR_GCKCSS_MASK)
>> +					>> AT91_PMC_PCR_GCKCSS_OFFSET;
>> +	/*
>> +	 * make sure that what we read in hardware is coherent with
>> +	 * what we've just probed
>> +	 */
>> +	if (gck->parent_id >= __clk_get_num_parents(gck->hw.clk))
>> +		gck->parent_id = 0;
> 
> Hm, I'm not sure this is correct. Here, you're just faking the
> fact that your current parent is the first one in the parent list while
> it actually points to the 6th entry. Not only your rate will be false
> (the one calculated in ->round_rate()), but you're also changing the
> behavior of the clk_set_rate() and clk_set_parent() operation (AFAIR,
> if you try to change to the first parent, the core code will think it's
> already properly configured and will never call ->set_parent()).

Well, as the values are actually used from the cached local structure
all the way to the "enable" function, I suspect it won't break the core
behavior. And making sure that this clock is not enabled before Linux is
run makes this change work.

But I admit it is somehow weird, as a workaround :-\


> This leaves 2 solutions here:
> - implement the missing clk driver and add an entry in the parent
>   list

Yes, I'll do this.

> - select the 1st parent clk (I mean, change the register value) if the
>   hardware points to the 6th one.

This is not safer than what I proposed hereunder.

So, I remove this change in the v4 and send you a v5 that reverts this
modification and adds a WARN_ON the condition, to ease debugging...

Bye,
-- 
Nicolas Ferre
