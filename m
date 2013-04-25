From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 16:11:39 +0200
Subject: [PATCH 6/9] crypto: ux500/cryp - Set DMA configuration though
 dma_slave_config()
In-Reply-To: <20130425134402.GN4623@gmail.com>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdbFgW6bGYt59WtN4r2izuN09AJw4J1cqir82uzFsuMmWQ@mail.gmail.com>
 <20130425134402.GN4623@gmail.com>
Message-ID: <201304251611.39667.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 April 2013, Lee Jones wrote:

> > > @@ -232,6 +236,7 @@ struct cryp_dma {
> > >   */
> > >  struct cryp_device_data {
> > >         struct cryp_register __iomem *base;
> > > +       phys_addr_t phybase;
> > 
> > Use dma_addr_t. Maybe "phybase" is misleading,
> > "dmabase" is probably better. (Also applies to the
> > cryp patch).
> 
> Accept it's not the dmabase.
> 
> It's the phybase (U8500_CRYP1_BASE) i.e. the physical base address of
> the device's regs.

Right, this recently came up in a different context and I agree:

The dma engine driver must know the address in its dma space, while the
slave driver has it available in physical space. These two are often the
same, but there is no generic way to convert between the two, especially
if the dma engine resides behind an IOMMU.

The best assumption we can make is that the dma engine driver knows
how to convert between the two. Interestingly the documentation for
dma_slave_config talks about "physical address", while the structure
itself uses a dma_addr_t. Linus Walleij introduced the structure in
c156d0a5b0 "DMAENGINE: generic slave channel control v3", so I assume
he can shed some light on what he was thinking. I assume the documentation
is right but the structure is not and should be converted to use
phys_add_t or resource_size_t.

	Arnd
