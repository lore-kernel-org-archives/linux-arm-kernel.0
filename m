From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 15 Mar 2013 20:55:56 +0100 (CET)
Subject: [PATCH] genirq: allow an alternative setup for the mask cache
In-Reply-To: <51434BC2.70105@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
 <20130314174559.GO21620@kw.sim.vm.gnt> <51434BC2.70105@keymile.com>
Message-ID: <alpine.LFD.2.02.1303152046180.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Mar 2013, Gerlando Falauto wrote:

> Hi Simon,
> 
> On 03/14/2013 06:45 PM, Simon Guinot wrote:
> > On Thu, Mar 14, 2013 at 05:10:30PM +0100, Holger Brunck wrote:
> > > @@ -243,9 +243,12 @@ void irq_setup_generic_chip(struct irq_chip_generic
> > > *gc, u32 msk,
> > >   	list_add_tail(&gc->list, &gc_list);
> > >   	raw_spin_unlock(&gc_lock);
> > > 
> > > +	/* Setup pointer to mask_cache */
> > > +	gc->pmask_cache = &gc->mask_cache;
> > 
> > You need a flag here to choose between gc->mask_cache and
> > ct->mask_cache.
> 
> I'm sorry, I don't understand...
> Shouldn't pmask_cache be a pointer within ct, so that the pointers for all
> instances could either be the same (in case of a single register) or all
> different (in case of multiple registers)?

You are right. gc->pmask_cache wont solve the issue.

We need a ct->pmask_cache, so the various instances of gc->ct[] can
have their own selector, which default to gc-mask_cache if not
requested to be separate by a flag. In that case we need to initialize
the ct->mask_cache at setup time for each ct. No modifications to
setup_alt_chip() required then.

> I already have a patch which seems to work, but I'm afraid I've come to YAM
> (Yet Another Misunderstanding (R) ) in regards to Thomas' suggestion.

No, that was my brain going backwards :)

Care to send your patch ?

Thanks,

	tglx
