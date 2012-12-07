From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 7 Dec 2012 16:33:17 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121207233317.GB4304@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 07, 2012 at 11:04:23PM +0100, Thomas Petazzoni wrote:

>  * The most annoying problem is that when the hw_pci->setup()
>    operation is called, we don't know the size of the memory and I/O
>    regions that each PCI device will need. And on Marvell SoCs, for
>    each PCI device, we have to set up an address decoding window that
>    associates a portion of the physical address space with a given

I think a sane way to address this is to model the SOC as the root of
the PCI-E and then model each of the ports as a non-compliant PCI-E
bridge. The internal memory windows functionally map exactly to a
PCI-E bridge memory window - just with annoyingly different register
settings.

In this way you'd assign physical regions to the SOC and the linux
discovery code would allocate and assign resources as appropriate,
including the simulated bridges.

How exactly to cleanly hook the PCI code to simulate a bridge, I'm not
sure, but something like this re-uses the bulk of the existing code to
solve this problem.

Frankly, Marvell should have designed their cores to present this way
via PCI-E config transactions :|

Not sure how big a deal this is though, my kirkwood systems that use
PCI-E have a DT that exactly matches the resource assignment I expect
from the kernel, so there is no wasted physical space. This is fine
for embedded with no pluggable PCI-E..

>  * If the driver gets moved to some common place like drivers/pci/,
>    use it for mach-kirkwood, mach-mv78xx0 and mach-dove, and maybe
>    mach-orion5x.

I would be able to test a combined driver on Kirkwood, drop me a note
if you do this please :)

Regards,
Jason
