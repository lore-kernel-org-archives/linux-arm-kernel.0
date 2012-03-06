From: bhutchings@solarflare.com (Ben Hutchings)
Date: Tue, 6 Mar 2012 14:03:28 +0000
Subject: [PATCH v4] lpc32xx: Added ethernet driver: smp_wmb()
In-Reply-To: <4F55EA6D.3070602@antcom.de>
References: <1330983641-32622-1-git-send-email-stigge@antcom.de>
 <1330987524.2538.61.camel@bwh-desktop> <4F55EA6D.3070602@antcom.de>
Message-ID: <1331042608.2347.1.camel@bwh-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-03-06 at 11:43 +0100, Roland Stigge wrote:
> On 03/05/2012 11:45 PM, Ben Hutchings wrote:
> >> +	/* Clear and enable interrupts */
> >> +	writel(0xFFFF, LPC_ENET_INTCLEAR(pldat->net_base));
> >> +	lpc_eth_enable_int(pldat->net_base);
> >> +
> >> +	/* Get the next TX buffer output index */
> >> +	pldat->num_used_tx_buffs = 0;
> >> +	pldat->last_tx_idx =
> >> +		readl(LPC_ENET_TXCONSUMEINDEX(pldat->net_base));
> > 
> > Doesn't this need to be done *before* enabling interrupts?  Also, I
> > think you need an smp_wmb() so that the interrupt handler is guaranteed
> > to see all these writes.
> 
> Do you mean _one_ smp_wmb() directly after lpc_eth_enable_int() (which
> I'm moving behind the above code?

The sequence should be

	pldat->state = values...;
	smp_wmb();
	enable_interrupts();

> Note that there is no SMP in LPCs and NXP is not planning to build one
> AFAIK.

Never say never!

> However, I'm fine with including smp_wmb() anyway for completeness.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
