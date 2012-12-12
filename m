From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 12 Dec 2012 21:34:33 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <50C7A3C5.7050100@wwwdotorg.org>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
 <50C62161.9080708@wwwdotorg.org>
 <20121211075207.GA29977@avionic-0098.adnet.avionic-design.de>
 <50C7A3C5.7050100@wwwdotorg.org>
Message-ID: <20121212203433.GA7898@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 02:21:09PM -0700, Stephen Warren wrote:
> On 12/11/2012 12:52 AM, Thierry Reding wrote:
> > On Mon, Dec 10, 2012 at 10:52:33AM -0700, Stephen Warren wrote:
> >> On 12/07/2012 04:33 PM, Jason Gunthorpe wrote:
> >>> On Fri, Dec 07, 2012 at 11:04:23PM +0100, Thomas Petazzoni
> >>> wrote:
> >>> 
> >>>> * The most annoying problem is that when the hw_pci->setup() 
> >>>> operation is called, we don't know the size of the memory and
> >>>> I/O regions that each PCI device will need. And on Marvell
> >>>> SoCs, for each PCI device, we have to set up an address
> >>>> decoding window that associates a portion of the physical
> >>>> address space with a given
> >>> 
> >>> I think a sane way to address this is to model the SOC as the
> >>> root of the PCI-E and then model each of the ports as a
> >>> non-compliant PCI-E bridge. The internal memory windows
> >>> functionally map exactly to a PCI-E bridge memory window - just
> >>> with annoyingly different register settings.
> >> 
> >> Mainly as background:
> >> 
> >> I /think/ Tegra has a similar HW setup (but perhaps not
> >> identical) (based on a very brief reading of your emails and
> >> brief knowledge of this aspect of the Tegra HW).
> >> 
> >> On Tegra, there is a 1GB physical address window that the PCIe 
> >> controller serves. The controller has 2 or 3 ports, each a
> >> separate PCIe domain I believe. There are registers in the PCIe
> >> controller which route accessed made to the 1GB physical window
> >> to the various child ports and transaction types.
> > 
> > No, the ports on Tegra are not separate PCIe domains. The
> > configuration space mapping is shared between all ports and is
> > programmed in the register space of the PCIe controller. This is
> > what PCIe refers to as ECAM, only with a slightly incompatible
> > mapping.
> 
> OK, so can you please remind me why the top-level PCIe controller node
> has a child node for each port, with hard-coded non-intersecting
> ranges for configuration space access? If they all go through the same
> address range, and use standard PCI bridge registers to route
> transactions to the separate ports, I would have expected no need for
> explicit per-port sub-nodes or static address allocations.

The ranges for configuration space access are phony. I think that's
something that Mitch suggested at the time because you need to pass
ranges such as this to the children somehow. Within the driver only the
configuration space as specified in the pcie-controller node's reg
property is used.

As for the separate child nodes, those are still required to model each
port as a separate bus. I don't see how this could be done any other
way, but maybe that's not what you were asking.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121212/73e7d23e/attachment.sig>
