From: andrew.murray@arm.com (Andrew Murray)
Date: Fri, 12 Apr 2013 14:48:11 +0100
Subject: [PATCH] ARM: pci: pass a parent to pci_common_init()
In-Reply-To: <201304121501.48866.arnd@arndb.de>
References: <1365719096-11639-1-git-send-email-linus.walleij@linaro.org>
 <201304121326.56030.arnd@arndb.de> <20130412120538.GA32488@arm.com>
 <201304121501.48866.arnd@arndb.de>
Message-ID: <20130412134811.GA26188@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 02:01:48PM +0100, Arnd Bergmann wrote:
> On Friday 12 April 2013, Andrew Murray wrote:
> > I would also be happy with this. Though alternatively could you
> > not just add a struct device to hw_pci? Then change pcibios_init_hw
> > to use hw->device instead of NULL?
> > 
> 
> I think struct hw_pci is meant to be statically defined, so that would
> not work if you need the same hw_pci for two host bridge devices.
> 
> 	Arnd
> 

Yes, though the new PCIe host/bridge drivers with DT support all seem to call
pci_common_init at probe with a non-statically defined hw_pci with the
nr_controllers always set to 1 (meaning that pci_common_init can be called
multiple times). Also hw_pci now has a field for private_data anyway which
breaks this assumption...

Is there an argument for removing hw_pci or at least .nr_controllers and call
pci_common_init multiple times (as is potential current use case for DT PCI
drivers)?

Andrew Murray
