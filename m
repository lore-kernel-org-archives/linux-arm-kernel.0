From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Mar 2014 01:17:46 +0100
Subject: [PATCH v5 3/3] arm64: Add architecture support for PCI
In-Reply-To: <20140306161713.GH6457@e106497-lin.cambridge.arm.com>
References: <1393948216-11599-1-git-send-email-Liviu.Dudau@arm.com>
 <201403042328.51361.arnd@arndb.de>
 <20140306161713.GH6457@e106497-lin.cambridge.arm.com>
Message-ID: <201403070117.47125.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 March 2014, Liviu Dudau wrote:
> On Tue, Mar 04, 2014 at 10:28:51PM +0000, Arnd Bergmann wrote:
> > On Tuesday 04 March 2014, Liviu Dudau wrote:
> > 
> > > +extern int isa_dma_bridge_buggy;
> > 
> > As commented before, I still think we can hardcode this to off
> 
> Unfortunately that doesn't work when you have CONFIG_PCI=y. drivers/pci/pci.c has:
> 
> drivers/pci/pci.c:int isa_dma_bridge_buggy;
> drivers/pci/pci.c:EXPORT_SYMBOL(isa_dma_bridge_buggy);
> 
> and drivers/pci/quirks.c does:
> 
> drivers/pci/quirks.c:   if (!isa_dma_bridge_buggy) {
> drivers/pci/quirks.c:           isa_dma_bridge_buggy=1;
> drivers/pci/quirks.c-           dev_info(&dev->dev, "Activating ISA DMA hang workarounds\n");
> drivers/pci/quirks.c-   }
> 

Ah, I see. Should we maybe move the declaration to a more generic header
file then? If the architectures cannot override it anyway, it shouldn't
be up to the architecture to declare it.

	Arnd
