From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 13 Mar 2013 20:26:28 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130313170205.GB24042@obsidianresearch.com>
References: <20130311232516.GA13873@obsidianresearch.com>
 <513E6AFE.3090304@firmworks.com>
 <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
Message-ID: <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 11:02:05AM -0600, Jason Gunthorpe wrote:
> On Wed, Mar 13, 2013 at 09:18:15AM +0100, Thierry Reding wrote:
> 
> > Mitch already answered this. The specification is now almost 15 years
> > old and it couldn't possibly have foreseen all of the future use-cases.
> > If the specification is too restrictive and Mitch gives his blessing to
> > remove some of the restrictions, I don't see any reason why we shouldn't
> > do so if it lets us represent the reality of hardware more accurately in
> > DT.
> 
> I understand the spec is old, and I have no problem with making a
> Linux specific revision, but do *that* - don't bury some random
> deviation inside the bindings for a driver. I even suggested some
> language, but I feel more thought is needed to consider how to model
> the standardized ECAM mechanism..

As Mitch already said there's very little chance that the specification
update will be ratified through IEEE, so I think that we might just as
well put a corresponding text somewhere below Documentation/devicetree.

Also note that this has absolutely nothing to do with ECAM. All I'm
proposing is to allow the reg property of a root port to be translated
into a CPU addressable memory region through the ranges property. This
turns out to actually work properly with the current OF core in Linux.

> > Furthermore we're not discussing radical changes. None of the changes
> > will be backwards-incompatible, but they will allow recent hardware to
> > be represented more correctly or conveniently.
> 
> Sure, but it is still inconsistent, one MMIO config mechansim is in
> ranges, one is in regs. Plus I don't think tegra's case is a great
> starting point to design a spec update, it's config access mechanism
> is especially strange...

Again, it is still the most accurate way to describe the hardware. I
know it's not terribly beautiful and doesn't match with what you'd
expect from PC hardware. However it is still a reality and something the
kernel will have to deal with. Marvell hardware isn't very pretty either
but that shouldn't exclude it from being supported by Linux.

> Anyhow, I think this has been hashed to death, as long as your final
> binding has the 'device_type = pci' on the pcie-controller node I
> think it will be fine.

No. The pcie-controller is *not* a PCI device. It is a PCI host bridge.
It is the instance that translates from the platform to the PCI bus. Why
should it be device_type = "pci"? And we've also been over this before,
making that change stops the proposed binding from working properly
because the entry in the reg property can't be translated into a CPU
addressable memory region.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130313/89f7970f/attachment.sig>
