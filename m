From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Apr 2013 22:27:53 +0200
Subject: [PATCH 11/11] RFC: ARM: get PCI device IRQs from device tree
In-Reply-To: <1365087696-9548-12-git-send-email-linus.walleij@linaro.org>
References: <1365087696-9548-1-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-2-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-3-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-4-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-5-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-6-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-7-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-8-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-9-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-10-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-11-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-12-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZhPYqxgUuffTabN+RZkTBY2w0t-OmJ8Wsew8qOWTRQ7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 4, 2013 at 5:01 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This currently bugs out - when trying to get the IRQs for
> devices of_irq_map_pci() reads the IRQ pin from the PCI config
> space successfully, then comes to trying to look up the parent
> PCI device by checking pdev->bus->self, which is NULL, then
> tries to treat it as a bridge doing pci_bus_to_OF_node(pdev->bus)
> which also results in NULL and it bails out.
>
> No clue why this is so - some problem with the parent of this
> bus not being a PCI device in itself? Help.

Tracked this down to a point where in drivers/pci/of.c
pci_set_bus_of_node() is called on the root bus, at which
point it calls pcibios_get_phb_of_node() which has no clue
on how to obtain the DT node for the root hub. (Only bridges.)

Inserting this na?ve fragment into the PCI driver makes things
tick:

+struct device_node *static_root;
+
+struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
+{
+       return static_root;
+}
+

In probe():
+       static_root = np;

It'll override the weak symbol and make things work.

I guess this is something for kernel/bios32.c to implement
if we want to support DT on these PCI adapters, so looking
into that next...

But how do others get their things to work? Not using bios32?
I wonder...

Yours,
Linus Walleij
