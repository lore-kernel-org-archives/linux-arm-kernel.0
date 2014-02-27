From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Feb 2014 14:48:44 +0100
Subject: [PATCH v2 4/4] pci: Add support for creating a generic
 host_bridge from device tree
In-Reply-To: <18746655.qWHLpMg2Yy@wuerfel>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com>
 <1393506402-11474-5-git-send-email-Liviu.Dudau@arm.com>
 <18746655.qWHLpMg2Yy@wuerfel>
Message-ID: <7910042.azG0y0Ppv9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 14:38:32 Arnd Bergmann wrote:
> > +     pr_debug("Parsing ranges property...\n");
> > +     for_each_of_pci_range(&parser, &range) {
> > +             /* Read next ranges element */
> > +             pr_debug("pci_space: 0x%08x pci_addr:0x%016llx ",
> > +                             range.pci_space, range.pci_addr);
> > +             pr_debug("cpu_addr:0x%016llx size:0x%016llx\n",
> > +                                     range.cpu_addr, range.size);
> > +
> > +             /*
> > +              * If we failed translation or got a zero-sized region
> > +              * then skip this range
> > +              */
> > +             if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
> > +                     continue;
> > +
> > +             res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> > +             if (!res) {
> > +                     err = -ENOMEM;
> > +                     goto bridge_ranges_nomem;
> > +             }
> > +
> > +             of_pci_range_to_resource(&range, dev, res);
> > +
> > +             if (resource_type(res) == IORESOURCE_IO)
> > +                     *io_base = range.cpu_addr;
> > +
> > +             pci_add_resource_offset(resources, res,
> > +                             res->start - range.pci_addr);
> > +     }
> 
> This is not the correct resource for I/O space at all. Please talk
> to Will, I've been over this with him in detail and he probably
> understands it now. I assume you are both working in the same
> building.
> 

Sorry, I initially missed part of your changes in patch 1.
I think it's actually correct now.

	Arnd
