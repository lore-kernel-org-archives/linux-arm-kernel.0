From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 11 Mar 2013 22:08:16 +0100 (CET)
Subject: [PATCH] genirq: move mask_cache into struct irq_chip_type
In-Reply-To: <20130311154016.GM21620@kw.sim.vm.gnt>
References: <20110720234537.GD16297@kw.sim.vm.gnt>
 <1311295758-27493-1-git-send-email-simon@sequanux.org>
 <CAMAG_edBy1kjmEGDD76-C5T0xtha9YxMFJ6B3D8A5kHBwQ1PMQ@mail.gmail.com>
 <20110726153930.GG16297@kw.sim.vm.gnt>
 <CAMAG_ee8YBvDsdQ2zNfn-7qdyTmVYBVb8xykMMv4pg8tEswJgg@mail.gmail.com>
 <5134AF7E.5010605@keymile.com> <20130304154454.GG21620@kw.sim.vm.gnt>
 <alpine.LFD.2.02.1303051114370.22263@ionos>
 <20130306132944.GJ21620@kw.sim.vm.gnt>
 <alpine.LFD.2.02.1303061518160.22263@ionos>
 <20130311154016.GM21620@kw.sim.vm.gnt>
Message-ID: <alpine.LFD.2.02.1303112159330.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Mar 2013, Simon Guinot wrote:
> On Wed, Mar 06, 2013 at 04:19:30PM +0100, Thomas Gleixner wrote:
> > Not so hypothetic. There _are_ irq controllers out there which use the
> > same mask register for both level and edge type irqs.
> 
> Sure, but if the same mask register is used, then a single irq_chip_type
> should be able to handle both level and edge interrupts ? I mean, if one
> needs to register different irq_chip_type for edge and level interrupts,
> it is most likely because the registers are not the same...

No, it's because first of all the types have different flow handlers
and because they can have a different irq_chip due to different
callbacks while still having the necessarity to share a single
mask_cache.

Care to look at struct irq_chip_type as a whole and not just from the
POV of your particular chip incarnation?

Again. Here is the solution to the problem:

> > I'd rather refactor the core code so it uses a pointer to the
> > mask_cache. The default would be to let it point to gc->mask_cache and
> > optionally let it point to ct->mask_cache. We'd need to store the flag
> > in the gc struct so we can redirect the pointer to the ct->mask_cache
> > in irq_setup_alt_chip().

Stop arguing in circles and implement the 20 lines of patch already.

Thanks,

	tglx
