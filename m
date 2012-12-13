From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 13 Dec 2012 08:03:32 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <50C9056D.2050309@wwwdotorg.org>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
 <50C62161.9080708@wwwdotorg.org>
 <20121211075207.GA29977@avionic-0098.adnet.avionic-design.de>
 <50C7A3C5.7050100@wwwdotorg.org>
 <20121212203433.GA7898@avionic-0098.adnet.avionic-design.de>
 <50C9056D.2050309@wwwdotorg.org>
Message-ID: <20121213070332.GA9946@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 03:30:05PM -0700, Stephen Warren wrote:
> On 12/12/2012 01:34 PM, Thierry Reding wrote:
> > On Tue, Dec 11, 2012 at 02:21:09PM -0700, Stephen Warren wrote:
> >> On 12/11/2012 12:52 AM, Thierry Reding wrote:
> ...
> >>> No, the ports on Tegra are not separate PCIe domains. The 
> >>> configuration space mapping is shared between all ports and is 
> >>> programmed in the register space of the PCIe controller. This
> >>> is what PCIe refers to as ECAM, only with a slightly
> >>> incompatible mapping.
> >> 
> >> OK, so can you please remind me why the top-level PCIe controller
> >> node has a child node for each port, with hard-coded
> >> non-intersecting ranges for configuration space access? If they
> >> all go through the same address range, and use standard PCI
> >> bridge registers to route transactions to the separate ports, I
> >> would have expected no need for explicit per-port sub-nodes or
> >> static address allocations.
> > 
> > The ranges for configuration space access are phony. I think
> > that's something that Mitch suggested at the time because you need
> > to pass ranges such as this to the children somehow. Within the
> > driver only the configuration space as specified in the
> > pcie-controller node's reg property is used.
> > 
> > As for the separate child nodes, those are still required to model
> > each port as a separate bus. I don't see how this could be done any
> > other way, but maybe that's not what you were asking.
> 
> If the PCIe controller acts like a PCIe bridge, then won't the
> separate ports show up on the PCIe bus and hence be auto-probed and
> hence not require and representation in the DT at all? Or, does the HW
> simply use standardized registers to program the routing of
> transactions to the ports, yet not actually appear on the PCIe bus as
> a bridge device?

I don't think that's the way it works. The PCIe controller is what the
PCIe specification refers to as root complex. The root complex can have
one or more root ports. In case of Tegra20 that would be 2 root ports,
Tegra30 has 3. Each of these root ports is a virtual PCI-PCI bridge
within the root complex. However, they don't "appear" on the bus since
they are the origins of two busses.

At least that's how I read the downstream code and how the upstream code
works as well. For each port a new pci_bus is created and enumerated. I
think the problem that prevents it from working the way you proposed is
that each root port has a special way of accessing the configuration
space, which is a region that is mapped to the register space of each
root port. If you look at the tegra_pcie_{read,write}_conf() functions
you'll see how they are special-cased for the root ports.

Perhaps it will even work the way you suggested if instead we removed
the special-case for root ports and enumerate only one root bus. I'll
need to check that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121213/b00e27cf/attachment.sig>
