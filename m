From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 15 Mar 2013 12:02:41 +0100 (CET)
Subject: [PATCH] genirq: allow an alternative setup for the mask cache
In-Reply-To: <5142FB46.30609@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
 <20130314174559.GO21620@kw.sim.vm.gnt> <5142FB46.30609@keymile.com>
Message-ID: <alpine.LFD.2.02.1303151201050.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Mar 2013, Holger Brunck wrote:
> On 03/14/2013 06:45 PM, Simon Guinot wrote:
> >> @@ -243,9 +243,12 @@ void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
> >>  	list_add_tail(&gc->list, &gc_list);
> >>  	raw_spin_unlock(&gc_lock);
> >>  
> >> +	/* Setup pointer to mask_cache */
> >> +	gc->pmask_cache = &gc->mask_cache;
> > 
> > You need a flag here to choose between gc->mask_cache and
> > ct->mask_cache.
> > 
> 
> hm, even here? Isn't it enough to do this if irq_setup_alt_chip is called?

Yes, you need to do it at both places. We install ct[0] by default, so
if nothing calls setup_alt_chip() you lost.
 
Thanks,

	tglx
