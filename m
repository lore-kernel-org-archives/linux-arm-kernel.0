From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Apr 2014 22:46:36 +0200
Subject: [PATCH v7 4/6] pci: Introduce a domain number for pci_host_bridge.
In-Reply-To: <20140410145304.GS985@e106497-lin.cambridge.arm.com>
References: <1394811272-1547-5-git-send-email-Liviu.Dudau@arm.com>
 <6144916.rD76jOL8sv@wuerfel>
 <20140410145304.GS985@e106497-lin.cambridge.arm.com>
Message-ID: <6459805.ygy4tBNDNz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 April 2014 15:53:04 Liviu Dudau wrote:
> On Thu, Apr 10, 2014 at 03:07:44PM +0100, Arnd Bergmann wrote:

> > This mirrors how we treat devices: a pci_device has an embedded device,
> > and so on, in other subsystems we can have multiple layers.
> > 
> > In this example, the tegra pcie driver then allocates its own tegra_pcie
> > structure, fills out the fields it needs, and registers it with the
> > ARM architecture code, passing just the pci_sys_data pointer. That function
> > in turn passes a pointer to the embedded pci_host_bridge down to the
> > generic code. Ideally we should try to eliminate the architecture specific
> > portion here, but that is a later step.
> 
> So Arnd seems to agree with me: we should try to get out of architecture specific
> pci_sys_data and link the host bridge driver straight into the PCI core. The
> core then can call into arch code via pcibios_*() functions.
> 
> Arnd, am I reading correctly into what you are saying?

Half of it ;-)

I think it would be better to not have an architecture specific data
structure, just like it would be better not to have architecture specific
pcibios_* functions that get called by the PCI core. Note that the
architecture specific functions are the ones that rely on the architecture
specific data structures as well. If they only use the common fields,
it should also be possible to share the code.

I also don't realistically think we can get there on a lot of architectures
any time soon. Note that most architectures only have one PCI host
implementation, so the architecture structure is the same as the host
driver structure anyway.

For architectures like powerpc and arm that have people actively working
on them, we have a chance to clean up that code in the way we want it
(if we can agree on the direction), but it's still not trivial to do.

Speaking of arm32 in particular, I think we will end up with a split
approach: modern platforms (multiplatform, possibly all DT based) using
PCI core infrastructure directly and no architecture specific PCI
code on the one side, and a variation of today's code for the legacy
platforms on the other.

	Arnd
