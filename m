From: andrew.murray@arm.com (Andrew Murray)
Date: Fri, 12 Apr 2013 09:22:29 +0100
Subject: [PATCH 11/11] RFC: ARM: get PCI device IRQs from device tree
In-Reply-To: <CACRpkdZhPYqxgUuffTabN+RZkTBY2w0t-OmJ8Wsew8qOWTRQ7A@mail.gmail.com>
References: <1365087696-9548-4-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-5-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-6-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-7-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-8-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-9-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-10-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-11-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZhPYqxgUuffTabN+RZkTBY2w0t-OmJ8Wsew8qOWTRQ7A@mail.gmail.com>
Message-ID: <20130412082229.GA30593@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 09:27:53PM +0100, Linus Walleij wrote:
> On Thu, Apr 4, 2013 at 5:01 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > This currently bugs out - when trying to get the IRQs for
> > devices of_irq_map_pci() reads the IRQ pin from the PCI config
> > space successfully, then comes to trying to look up the parent
> > PCI device by checking pdev->bus->self, which is NULL, then
> > tries to treat it as a bridge doing pci_bus_to_OF_node(pdev->bus)
> > which also results in NULL and it bails out.
> >
> > No clue why this is so - some problem with the parent of this
> > bus not being a PCI device in itself? Help.
> 
> Tracked this down to a point where in drivers/pci/of.c
> pci_set_bus_of_node() is called on the root bus, at which
> point it calls pcibios_get_phb_of_node() which has no clue
> on how to obtain the DT node for the root hub. (Only bridges.)
> 
> Inserting this na?ve fragment into the PCI driver makes things
> tick:
> 
> +struct device_node *static_root;
> +
> +struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
> +{
> +       return static_root;
> +}
> +
> 
> In probe():
> +       static_root = np;
> 
> It'll override the weak symbol and make things work.
> 
> I guess this is something for kernel/bios32.c to implement
> if we want to support DT on these PCI adapters, so looking
> into that next...
> 
> But how do others get their things to work? Not using bios32?
> I wonder...

I think there are a mix of solutions out here, let me try and remember...

* I originally [1] implemented a pcibios_get_phb_of_node function
  in arch/arm/bios32.c this used a new .of_node field from sysdata.
  The idea being that pcibios_init_hw populates .of_node from a field
  of the same name provided by the driver in hw_pci.

* I believe Thierry's approach was to reuse the existing pcibios_get_phb_of_node
  function [2], to do this some changes were needed elsewhere I'm not sure the
  full details of this, I never got around to testing it. But I understand it's
  an approach that Thomas also used. It believe it requries a custom
  implementation of hw->scan such that instead of using pcibios_init_hw's default
  implementation of pci_scan_root_bus (which passes a NULL) your custom
  implementation calls pci_create_root_bus instead and passes a suitable struct
  device.

* I recall having some issues with weak symbols when playing around with
  pcibios_get_phb_of_node - there seems to be some changes in this area [3].

I don't think any of these solutions are ideal - perhaps pcibios_init_hw needs
to be changed... there are patches around which involve passing additional
private data in sys_data/hw_pci see [1] and [4] if this additional data
contains struct device or struct device_node then perhaps they can be plumbed
into the default call to pci_scan_root_bus in bios32? If every ARM DT host
bridge driver needs to implement their own scan function then something isn't
quite right.

I hope that helps.

Andrew Murray

[1] http://patchwork.ozlabs.org/patch/213570
[2] http://www.spinics.net/lists/linux-pci/msg19917.html
[3] http://patchwork1.kernel.org/patch/2394451
[4] http://patchwork.kernel.org/patch/2129431
