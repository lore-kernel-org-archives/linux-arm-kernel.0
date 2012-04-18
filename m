From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Apr 2012 12:55:17 -0700
Subject: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
In-Reply-To: <20120418191051.GR25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk>
 <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com>
 <20120418152956.GP25053@n2100.arm.linux.org.uk>
 <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com>
 <20120418181918.GL21106@atomide.com>
 <20120418191051.GR25053@n2100.arm.linux.org.uk>
Message-ID: <20120418195517.GO21106@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120418 12:14]:
> On Wed, Apr 18, 2012 at 11:19:18AM -0700, Tony Lindgren wrote:
> > * T Krishnamoorthy, Balaji <balajitk@ti.com> [120418 08:39]:
> > > On Wed, Apr 18, 2012 at 8:59 PM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > > On Wed, Apr 18, 2012 at 08:53:32PM +0530, T Krishnamoorthy, Balaji wrote:
> > > >> Hi,
> > > >>
> > > >> drivers/mmc/host/omap.c is also using dma_mask should that also be removed
> > > >
> > > > Does this driver make use of this platform data?
> > > >
> > > > If so, it needs converting to DMA engine _before_ this patch (which is
> > > > one reason why its a good idea to do these changes as separate patches...
> > > > as I've done.) ?It means stuff like this can be slotted in as necessary
> > > > in the patch order.
> > 
> > Can't we can just do this in drivers/mmc/host/omap.c:
> > 
> > - host->dev->dma_mask = &pdata->dma_mask;
> > + host->dev->dma_mask = 0xffffffff;
> > 
> > And that way drop it from the platform data. Looks like some omap1
> > omap_mmc_platform_data don't have it set though, but we do have host->use_dma = 1
> > set anyways in drivers/mmc/host/omap.c.
> 
> No.  dma_mask is a pointer to u64.  You need it stored in some variable.

Oops yeah.
 
> But, really, we shouldn't be initializing dma masks in drivers at all.
> That's supposed to come from the point where devices are created - and
> in the case of DMA engine stuff, its not the peripheral device structures
> which are doing DMA (they're DMA-incapable) - they rely on the services
> of a separate IP to perform DMA on their behalf.

OK

Tony
