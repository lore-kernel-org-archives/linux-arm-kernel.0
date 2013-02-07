From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 7 Feb 2013 08:28:24 +0100
Subject: [PATCH v2 22/27] arm: mvebu: add PCIe Device Tree informations
 for Armada XP
In-Reply-To: <20130207010502.GA7435@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-23-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302062241.14444.arnd@arndb.de>
 <20130207010502.GA7435@obsidianresearch.com>
Message-ID: <20130207072824.GA24827@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 06:05:02PM -0700, Jason Gunthorpe wrote:
[...]
> Also, what should 'reg' be so that the PCI core binds the OF nodes
> properly?  The standard says reg should have the configuration space
> address of the bridge, and I noticed Thierry was using something that
> almost looked like a config space address in his driver..
> 
> But that seems overly tricky.. When using the link stanzas, shouldn't
> this scheme be more like this:
> 
> // The PCI-E host bridge
> pex at 0 {
>    device_type = "pciex"; // <<-- Important!!

That might actually work but is somewhat dangerous. I originally tried
to trick the OF code into parsing the ranges properly by setting this to
"pci". However that breaks horribly because of_bus_pci_match() in
drivers/of/address.c will cause the parent bus of the pex@0 controller
to be PCI, which will cause #address-cells == 3 and #size-cells == 2,
and thus messing up the address translation because you actually have
#address-cells == 1 and #size-cells == 1.

The code doesn't seem to match on "pciex", so you might get away with
it, but I don't see why exactly it would be necessary. For one it is
actually wrong as the device isn't a PCI device but a platform device.
What I did to solve the ranges parsing problem is to use of_find_bus()
instead of of_match_bus() in of_pci_process_ranges(), so that the cell
count is correct.

>    ranges = <
>       // Driver internal control registers in MMIO space
>       0x82000000 0x10000000 0xd0040000  0xd0040000  0x0 0x8000000

I'm not sure I understand what you're doing here. Where does the
0x10000000 in cell 2 come from?

I also just noticed that I used 0x00000800 in the first cell, maybe that
should be 0x02000800, though I think that didn't quite work for some
reason. I'll need to check that. The odd part about this is that the
address is in fact not within PCI MMIO space at all, so I'm not sure
this is even a correct way to represent it. However I find it quite
intuitive to do so and it is really the only way to make the translation
from the PCI-PCI bridge's reg property work while at the same time
having a proper PCI address for the port.

Note that 0x82000800 would probably not be correct as it'd indicate that
the address is relocatable, which it really isn't.

>       // CPU 0xe0000000 -> e8000000 bridged to PCI MMIO
>       0x82000000 0x00000000 0xe0000000  0xe0000000  0x0 0x8000000
>       // CPU IO bus 0x0000000 -> 0xa0000 bridged to PCI IO
>       0x81000000 0x00000000 0x00000000  0x00000000  0x0 0xa0000
>       // CPU 0xe8000000 -> f0000000 bridged to PCI MMIO, prefetchable
>       0xC2000000 0x00000000 0xe8000000  0xe8000000  0x0 0x8000000
>       >;

These look good.

>    // PCI-PCI bridge to Physical link 0
>    pcie at 0,0 {
>      device_type = "pciex";
>      // The configuration space address of the PCI-PCI bridge required by OF
>      reg = <0x80 0 0  0 0>; // Bus 0, Dev 0x10, Fn 0

I think the first cell should be 0x800.

> 
>      /* The 'bar' on the PCI-PCI bridge, maps to internal control
>         registers, required by the driver. */
>      assigned-addresses = <0x82000000 0x10000000 0xd0040000  0 0x2000>;
>      // ..
>   }

The PCI DT binding says that each entry in the assigned-addresses
property is to correspond to one of the PCI device's base address
registers. So unless this is actually the value that ends up being
written to one of the BARs I don't think this is correct.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130207/5e9430fb/attachment.sig>
