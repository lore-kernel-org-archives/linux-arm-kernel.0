From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 4 Sep 2014 17:02:17 +0100
Subject: [PATCH] drivers: pci: convert generic host controller to DT host
 bridge creation API
In-Reply-To: <6930538.Get2YiuMvJ@wuerfel>
References: <1407861695-25549-1-git-send-email-Liviu.Dudau@arm.com>
 <20140819120553.GA23128@arm.com>
 <20140904133956.GA12351@e102568-lin.cambridge.arm.com>
 <6930538.Get2YiuMvJ@wuerfel>
Message-ID: <20140904160217.GC12351@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

thanks for having a look.

On Thu, Sep 04, 2014 at 03:05:53PM +0100, Arnd Bergmann wrote:
> On Thursday 04 September 2014 14:39:56 Lorenzo Pieralisi wrote:
> > > > +   if (!res_valid) {
> > > > +           dev_err(dev, "non-prefetchable memory resource required\n");
> > > > +           return -EINVAL;
> > > > +   }
> > > > +
> > > > +   if (iores) {
> > > > +           if (!PAGE_ALIGNED(io_cpuaddr))
> > > > +                   return -EINVAL;
> > > 
> > > Why is this alignment check not in the core code? Probably a question for
> > > somebody like Arnd, but do we need to deal with multiple IO resources?
> > > Currently we'll just silently take the last one that we found, which doesn't
> > > sound ideal.
> > 
> > (1) Yes, the alignment check should be made in core code
> 
> Makes sense. In theory we could support unaligned addresses (as long as
> the offset in the page is the same for virtual and physical), but I don't
> see why we should implement that unless some implementation absolutely
> requires it.
> 
> > (2) I could take the first IO resource and warn on multiple IO resources if
> >     they are detected. Thoughts ?
> 
> I think we should either warn, or be reasonably sure that it will work.
> Again, in theory this should work, but no sane hardware implementation
> would do it like that.

Ok, I will refactor the IO resources mapping code on top of Livius's v10.

> > > > +           if (err)
> > > > +                   return err;
> > > > +   }
> > > > +
> > > > +   /* Parse and map our Configuration Space windows */
> > > > +   err = gen_pci_parse_map_cfg_windows(host);
> > > > +   if (err)
> > > > +           return err;
> > > > +
> > > > +   pci_add_flags(PCI_ENABLE_PROC_DOMAINS);
> > > > +   pci_add_flags(PCI_REASSIGN_ALL_BUS | PCI_REASSIGN_ALL_RSRC);
> > > 
> > > Why does this belong in the host controller driver and how does it interact
> > > with the probe-only property?
> > 
> > That's a very good question and it is one that confuses me too.
> > 
> > Current code in pci_common_init_dev() sets PCI_REASSIGN_ALL_RSRC behind
> > our backs silently. That flag has a side effect only if the probing code
> > detects PCI bridges in the list of devices, since PCI core probing code
> > will try to reassign the bus numbers upon PCI bridge detection IIUC. I do
> > not think that PCI_REASSIGN_ALL_BUS has any side effect on ARM (by grepping
> > around I noticed that PCI_REASSIGN_ALL_RSRC is used in
> > 
> > pcibios_assign_all_busses()
> > 
> > which in turn is triggered only if PCI bridges are detected, still grokking
> > the code though).
> 
> Interesting point: the generic implementation should probably not default
> to reassigning all buses at all. We could have a (host controller specific,
> but with standardized name) DT property for it, but it would be best if
> firmware already probes it to not have to do it again.

I think that makes sense, let me point out though that this is
*not* how the code works today, since the pcibios code sets:

PCI_REASSIGN_ALL_RSRC (pci_common_init_dev() in arch/arm/kernel/bios32.c)

by default. I won't set the PCI_REASSIGN_ALL_RSRC and PCI_REASSIGN_ALL_BUS
flags.

> > Apart from the PCI_ENABLE_PROC_DOMAINS flag which I think it is safe to
> > set by default (but let me check that too),
> 
> I think it should be enabled here, as no legacy machine will use this
> driver.

+1

I will wait for Liviu's v10 and repost accordingly.

Lorenzo
