From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 17 Sep 2013 13:13:42 -0600
Subject: [PATCH] bus: mvebu-mbus: Fix optional pcie-mem/io-aperture
 properties
In-Reply-To: <20130917210503.1ea8cdd9@skate>
References: <20130917183853.GC21230@obsidianresearch.com>
 <20130917210503.1ea8cdd9@skate>
Message-ID: <20130917191342.GA4354@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 09:05:03PM +0200, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Tue, 17 Sep 2013 12:38:53 -0600, Jason Gunthorpe wrote:
> > If the property was not specified then then the returned resource
> > had a resource_size(..) == 1, rather than 0. The PCI-E driver checks
> > for 0 so it blindly continues on with a corrupted resource.
> > 
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> >  drivers/bus/mvebu-mbus.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> > index 19ab6ff..7a66203 100644
> > +++ b/drivers/bus/mvebu-mbus.c
> > @@ -866,6 +866,8 @@ static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
> >  	 */
> >  	memset(mem, 0, sizeof(struct resource));
> >  	memset(io, 0, sizeof(struct resource));
> > +	mem->end--;
> > +	io->end--;
> >  
> >  	ret = of_property_read_u32_array(np, "pcie-mem-aperture", reg, ARRAY_SIZE(reg));
> >  	if (!ret) {
> 
> This seems a little bit nasty, isn't it? 

Well, I'm not 100% sure, but AFAICT that is how struct resources
should be used. The start/end address are inclusive, so the resource
(start=0,end=0) describes 1 byte at address 0.

The only way to get a 0 sized resource is (start=0,end=-1)

Before I did this I checked other user of resource_size and found
tests to zero, so the above seems to be correct..

Eg a quick grep shows:
 arch/powerpc/kernel/pci-common.c: pcibios_fixup_bridge

                if (pci_has_flag(PCI_REASSIGN_ALL_RSRC)) {
                        res->flags |= IORESOURCE_UNSET;
                        res->start = 0;
                        res->end = -1;
                        continue;
                }

Do you see something different?

Jason
