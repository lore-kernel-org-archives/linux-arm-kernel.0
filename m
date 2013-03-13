From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 13 Mar 2013 21:54:07 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130313195901.GA26550@obsidianresearch.com>
References: <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <20130313195901.GA26550@obsidianresearch.com>
Message-ID: <20130313205407.GA29025@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 01:59:01PM -0600, Jason Gunthorpe wrote:
> On Wed, Mar 13, 2013 at 08:26:28PM +0100, Thierry Reding wrote:
> 
> > As Mitch already said there's very little chance that the specification
> > update will be ratified through IEEE, so I think that we might just as
> > well put a corresponding text somewhere below Documentation/devicetree.
> 
> Sure, I'm fine with that.
>  
> > Also note that this has absolutely nothing to do with ECAM. All I'm
> > proposing is to allow the reg property of a root port to be translated
> > into a CPU addressable memory region through the ranges property. This
> > turns out to actually work properly with the current OF core in Linux.
> 
> ECAM is the only standard based mechanism that could possibly use this
> new config space ranges concept. Whatever you do for tegra shouldn't
> stomp on the possibility of making that work in the future. So at
> least think about how ECAM could be modeled for a few mins before
> going ahead.
> 
> Tegra is the non-standard unusual case here, an update to the PCI OF
> binding should be of general use.

But I'm not trying to encode ECAM in the DT. ECAM isn't the problem at
all. The only problem is that each root port has a separate window in
the CPU address space that is used to access that port's configuration
space.

ECAM only comes into play when accessing the configuration space of
subordinate devices (via type 1 transactions). But at that point the
device tree doesn't need to know about it. The only thing that needs to
be in DT is the memory region that the controller should write to in
order to generate type 1 transactions. And that's a problem that has
long been solved.

> > > Anyhow, I think this has been hashed to death, as long as your final
> > > binding has the 'device_type = pci' on the pcie-controller node I
> > > think it will be fine.
> > 
> > No. The pcie-controller is *not* a PCI device. It is a PCI host bridge.
> > It is the instance that translates from the platform to the PCI bus. Why
> > should it be device_type = "pci"? 
> 
> Spec says so, Mitch said so, other PCI host bridge bindings in the
> tree work like this. Do a grep in the powerpc tree, for instance.
> 
> arch/x86/platform/ce4100/falconfalls.dts is a pretty comprehensive
> example.

Yes, yes. We all know by now what the spec says. The whole point is
that maybe the spec needs to be updated and this requirement lifted.
What I keep trying to say is that in case of Tegra the PCIe controller
does not provide the PCI bus. It doesn't appear as a device on the PCI
bus and it doesn't have configuration space itself.

Only the PCI root ports provide access to the subordinate busses. And
only they appear on the PCI bus.

> > And we've also been over this before, making that change stops the
> > proposed binding from working properly because the entry in the reg
> > property can't be translated into a CPU addressable memory region.
> 
> Sigh, that's because the change makes things follow the OF PCI
> spec. The Linux OF core follows the spec. Config space ranges binding
> is specifically *defined to not work* in the spec. Why should it work
> today?

Okay. I keep understanding what you're saying. But the whole point of
this discussion is that maybe the spec should be amended to allow this
to work. In fact it does work with the current implementation in the
Linux kernel. And what I've been trying to explain is that I think this
to be the most accurate description of the Tegra hardware.

> You have to deal with this problem somehow, and omitting the top level
> device_type is not a solution.

So we've already agreed that the specification might be too restrictive,
and I'm trying to solve this problem by finding an accurate description
in DT to represent the hardware without following the spec to the letter
because it wasn't written with this kind of hardware in mind.

Tegra's PCIe controller doesn't actually implement the bus. In fact we
have to jump through hoops to make both root ports appear on the root
bus specifically because there's no common access to the configuration
space that includes the host bridge or the root ports.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130313/0239c411/attachment-0001.sig>
