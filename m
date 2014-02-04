From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 4 Feb 2014 12:10:55 -0700
Subject: [PATCH] arm64: Add architecture support for PCI
In-Reply-To: <8676627.b6SYsazoah@wuerfel>
References: <1391453028-23191-1-git-send-email-Liviu.Dudau@arm.com>
 <13031998.NR888KZWhk@wuerfel>
 <20140204181514.GA25695@obsidianresearch.com>
 <8676627.b6SYsazoah@wuerfel>
Message-ID: <20140204191055.GC25695@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 07:34:50PM +0100, Arnd Bergmann wrote:

> Well, the way I see it, we already have support for arbitrary
> PCI domains in the kernel, and that works fine, so we can just
> as well use it. That way we don't have to partition the available
> 256 buses among the host bridges, and anything that needs a separate
> PCI config space can live in its own world. Quite often when you
> have multiple PCI hosts, they actually have different ways to
> get at the config space and don't even share the same driver.

> On x86, any kind of HT/PCI/PCIe/PCI-x bridge is stuffed into a
> single domain so they can support OSs that only know the
> traditional config space access methods, but I don't see
> any real advantage to that for other architectures.

Supporting a standard configration interface is a solid reason, but
there is alot more going on.

For instance to support peer-to-peer IO you need to have a consisent,
non-overlapping set of bus/device/function/tag to uniquely route TLPs
within the chip. Cross domain TLP routing in HW is non-trivial.

IOMMUs (and SR-IOv) rely on the BDF to identify the originating device
for each TLP. Multiple domains means a much more complex IOMMU
environment.

Failure to integrate on-chip devices into the PCI world also means
thing like SR-IOv won't work sanely with on-chip devices.

The only reason we should see multi-domain on a SOC is because the HW
design was lazy. Being lazy misses the Big Picture where PCI is the
cornerstone of many important Server/Enterprise technologies.

> > SOC internal peripherals should all show up in the bus 0 config space
> > of the only domain and SOC PCI-E physical ports should show up on bus
> > 0 as PCI-PCI bridges. This is all covered in the PCI-E specs regarding
> > the root complex.
> > 
> > Generally I would expect the internal peripherals to still be
> > internally connected with AXI, but also connected through the ECAM
> > space for configuration, control, power management and address
> > assignment.
> 
> That would of course be very nice from a software perspective,
> but I think that is much less likely for any practical
> implementation.

Well, all x86 implementations do this already.. It actually isn't that
big a deal from a HW perspective, you just have to think about it
fully, understand PCI, and position your registers accordingly.

Jason
