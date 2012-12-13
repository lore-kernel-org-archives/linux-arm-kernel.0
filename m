From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 13 Dec 2012 01:04:15 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121213070332.GA9946@avionic-0098.adnet.avionic-design.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
 <50C62161.9080708@wwwdotorg.org>
 <20121211075207.GA29977@avionic-0098.adnet.avionic-design.de>
 <50C7A3C5.7050100@wwwdotorg.org>
 <20121212203433.GA7898@avionic-0098.adnet.avionic-design.de>
 <50C9056D.2050309@wwwdotorg.org>
 <20121213070332.GA9946@avionic-0098.adnet.avionic-design.de>
Message-ID: <20121213080415.GA21178@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 08:03:32AM +0100, Thierry Reding wrote:

> I don't think that's the way it works. The PCIe controller is what the
> PCIe specification refers to as root complex. The root complex can have
> one or more root ports. 

PCIe is very specific about what a root complex is:

Root Complex =
 An entity that includes a Host Bridge, zero or more Root Complex Integrated
 Endpoints, zero or more Root Complex Event Collectors, and one or more
 Root Ports.

It also has other specific text requiring that each of the root
complex items conform to the software configuration interface -
they must be discoverable, they must have device numbers, they must
have configuration space.

Stephen is correct in how things should work - the physical PCI-E link
off the SOC should be reporting to linux as the secondary port on a
PCIe-PCIe bridge, and discovery should naturally follow along it from
the host bridge with no additional configuration or DT modeling
required.

When linux starts enumeration the bus 0, device 0, function 0
configuration space should be a host bridge. Bus 0 devices XX should be
the virtual PCI-PCI bridges.

> Tegra30 has 3. Each of these root ports is a virtual PCI-PCI bridge
> within the root complex. However, they don't "appear" on the bus since
> they are the origins of two busses.

This is not compliant.

When the spec talks about a 'virtual PCI-PCI bridge' it means virtual
in the sense that it is not seperate physical hardware. It absolutely
must appear in PCI device enumeration.

The spec is very clear on this point:

bridge =
   A device that virtually or actually connects a PCI/PCI-X segment or
   PCI Express Port with an internal component interconnect or with another
   PCI/PCI-X segment or PCI Express Port. A virtual Bridge in a Root
   Complex or Switch must use the software configuration interface
   described in this specification.

> Perhaps it will even work the way you suggested if instead we removed
> the special-case for root ports and enumerate only one root bus. I'll
> need to check that.

You might be missing the host bridge. If the SOC is providing
compliant PCIe bridges with configuration space for the root ports but
does not provide the host bridge configuration space then you may need
to provide the host bridge in software to tie it all together into a
compliant root complex.

Regards,
Jason
