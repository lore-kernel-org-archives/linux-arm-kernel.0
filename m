From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 7 Sep 2016 14:33:13 +0800
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <5844875.KucAoPMrXi@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <4865343.bOXkeC8XtQ@wuerfel>
 <20160906063529.GA22312@b29397-desktop>
 <5844875.KucAoPMrXi@wuerfel>
Message-ID: <20160907063313.GA13903@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 12:38:29PM +0200, Arnd Bergmann wrote:
> On Tuesday, September 6, 2016 2:35:29 PM CEST Peter Chen wrote:
> > On Mon, Sep 05, 2016 at 05:39:27PM +0200, Arnd Bergmann wrote:
> > > On Friday, September 2, 2016 5:16:31 PM CEST Leo Li wrote:
> 
> > > 
> > > Most of these are probably never used with any nonstandard
> > > DMA settings (IOMMU, cache coherency, offset, ...).
> > > 
> > > One thing we could possibly do is to go through these and
> > > replace the hardcoded dma mask setup with of_dma_configure()
> > > in all cases in which we actually use DT for probing, which
> > > should cover the interesting cases.
> > > 
> > 
> > One case I am going to work is to let USB chipidea driver support iommu,
> > the chipidea core device is no of_node, and created by
> > platform_add_device on the runtime. Using of_dma_configure with parent
> > of_node is a solution from my point, like [1].
> > 
> > https://lkml.org/lkml/2016/2/22/7
> 
> Right, that should make it work with iommu as well. However, it does
> not solve the other issue I mentioned above, with boards that have
> USB devices hardwired to a chipidea host controller that need
> configuration from DT. For that, we still need to come up with another
> way to associate the DT hierarchy in the host bridge node with
> the Linux platform_device.
> 

Why? The DMA configuration is for host controller, not for USB device.
No matter there is hardwired or hotplug devices, the DMA configuration
for host controller are both inherited from glue layer platform devices,
current implementation is at function ci_hdrc_add_device,
drivers/usb/chipidea/core.c.

-- 

Best Regards,
Peter Chen
