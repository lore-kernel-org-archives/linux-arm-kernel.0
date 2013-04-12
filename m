From: andrew.murray@arm.com (Andrew Murray)
Date: Fri, 12 Apr 2013 13:05:38 +0100
Subject: [PATCH] ARM: pci: pass a parent to pci_common_init()
In-Reply-To: <201304121326.56030.arnd@arndb.de>
References: <1365719096-11639-1-git-send-email-linus.walleij@linaro.org>
 <201304121326.56030.arnd@arndb.de>
Message-ID: <20130412120538.GA32488@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 12:26:55PM +0100, Arnd Bergmann wrote:
> On Friday 12 April 2013, Linus Walleij wrote:
> > When working with device tree support for PCI on ARM you run
> > into a problem when mapping IRQs from the device tree irqmaps:
> > doing this the code in drivers/of/of_pci_irq.c will try to
> > find the OF node on the root bridge and this fails, because
> > bus->dev.of_node is NULL, and that in turn boils down to
> > the fact that pci_set_bus_of_node() has called
> > pcibios_get_phb_of_node() from drivers/pci/of.c to obtain
> > the OF node of the bridge or its parent and none is set
> > and thus NULL is returned.
> > 
> > Fix this by adding an additional parent argument when
> > registering PCI bridges on the ARM architecture using the
> > pci_common_init() call, and pass along this parent to
> > pci_scan_root_bus() called from pcibios_init_hw() in
> > bios32.c and voila: the IRQ mappings start working:
> > the OF node can be retrieved from the parent.
> > 
> > Currently all users are set to use NULL as argument to this
> > call, but subsequent patches to the Integrator/AP make use
> > of this facility to pass a parent.
> 
> Could you try making it a less invasive patch by renaming
> pci_common_init to something else and providing a wrapper
> like this?
> 
> static inline void pci_common_init(struct hw_pci *hw)
> {
> 	pci_common_init_dev(NULL, hw);
> }
> 
> That would avoid most of the churn and get the same result.
> 
> 	Arnd
>

I would also be happy with this. Though alternatively could you
not just add a struct device to hw_pci? Then change pcibios_init_hw
to use hw->device instead of NULL?

Andrew Murray
