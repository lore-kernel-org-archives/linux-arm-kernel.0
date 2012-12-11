From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 11 Dec 2012 08:52:10 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <50C62161.9080708@wwwdotorg.org>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
 <50C62161.9080708@wwwdotorg.org>
Message-ID: <20121211075207.GA29977@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 10:52:33AM -0700, Stephen Warren wrote:
> On 12/07/2012 04:33 PM, Jason Gunthorpe wrote:
> > On Fri, Dec 07, 2012 at 11:04:23PM +0100, Thomas Petazzoni wrote:
> > 
> >>  * The most annoying problem is that when the hw_pci->setup()
> >>    operation is called, we don't know the size of the memory and I/O
> >>    regions that each PCI device will need. And on Marvell SoCs, for
> >>    each PCI device, we have to set up an address decoding window that
> >>    associates a portion of the physical address space with a given
> > 
> > I think a sane way to address this is to model the SOC as the root of
> > the PCI-E and then model each of the ports as a non-compliant PCI-E
> > bridge. The internal memory windows functionally map exactly to a
> > PCI-E bridge memory window - just with annoyingly different register
> > settings.
> 
> Mainly as background:
> 
> I /think/ Tegra has a similar HW setup (but perhaps not identical)
> (based on a very brief reading of your emails and brief knowledge of
> this aspect of the Tegra HW).
> 
> On Tegra, there is a 1GB physical address window that the PCIe
> controller serves. The controller has 2 or 3 ports, each a separate PCIe
> domain I believe. There are registers in the PCIe controller which route
> accessed made to the 1GB physical window to the various child ports and
> transaction types.

No, the ports on Tegra are not separate PCIe domains. The configuration
space mapping is shared between all ports and is programmed in the
register space of the PCIe controller. This is what PCIe refers to as
ECAM, only with a slightly incompatible mapping.

The registers that I think you're referring to allow the type of access
for a given region (I/O, prefetchable and non-prefetchable MMIO) to be
specified. They cannot be programmed to route accesses to a specific
port. The most recent bit of information was that this is derived from
the standard PCI registers that are available for each port.

> IIRC, the bindings Thierry came up with for the Tegra PCIe controller
> statically describe the setup of those mappings (e.g. it could assign a
> 256MB physical address region to port 1, and a 768MB physical address
> region to port 2 perhaps?).

Yes, that's correct. I also have experimental patches that add a
bus-range property to be assigned to each port, but that doesn't quite
work yet. The PCI core keeps complaining about the assigned bus range
conflicting with [0x00-0xff], which AFAICT is the one assigned by
default if no bus-range was specified by the driver.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121211/6a8de55c/attachment-0001.sig>
