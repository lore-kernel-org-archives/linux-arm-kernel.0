From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 30 Oct 2014 13:35:38 -0600
Subject: [RFC PATCH 0/2] arm: pcibios: remove pci_sys_data domain
In-Reply-To: <3532414.9PZuBnKWYz@wuerfel>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20141030173914.GS1069@e106497-lin.cambridge.arm.com>
 <20141030174541.GH26820@obsidianresearch.com>
 <3532414.9PZuBnKWYz@wuerfel>
Message-ID: <20141030193538.GK26820@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 08:21:40PM +0100, Arnd Bergmann wrote:

> > So how does mvebu now allocate a unique domain number per mvebu_pcie?
> 
> I believe the answer to that is that the mvebu PCIe driver currently only
> supports one domain, and it will have the unique number '0', which is the
> default.

It is like most of the the other new drivers, each mvebu_pcie_probe
expects to create a new domain with a unique bus number set for that
platform_device. AFAIK everything is uniq'd to the struct mcebu_pcie,
so there is nothing precluding the driver from being instantiated
twice.

Indeed, the way mvebu hardware works you could actually create a DT
that assigned some ports to one domain and some other ports to a
different domain, using two platform_devices. All that was missing
from the driver was to increment the domain number.

I think Lorenzo's patches improve this, at least it appears that
unique domain numbers are now being assigned, I'm not sure - I'm a
little confused how we can safely blindly apply the new domain logic
without the driver opt'ing in....

I thought older PCI platforms tended to call pci_common_init for each
physical PCI bus, and we don't want them to suddenly have non-zero
domain numbers??

Jason
