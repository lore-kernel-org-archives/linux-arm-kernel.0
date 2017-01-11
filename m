From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 11 Jan 2017 18:28:15 +0000
Subject: [PATCH v2] arm64: do not set dma masks that device connection
 can't handle
In-Reply-To: <7c6a1523-e41b-ad83-501a-27c260b9f9ee@cogentembedded.com>
References: <1483947002-16410-1-git-send-email-nikita.yoush@cogentembedded.com>
 <07253eaa-5729-0f15-42b6-e8403f1f0412@cogentembedded.com>
 <11daacde-5399-039f-80a3-01d7bd13e9e8@arm.com> <6116278.nQQUSuo3l4@wuerfel>
 <5c5cd4fd-4854-a2dd-10b6-9cc98e63a85c@arm.com>
 <7c6a1523-e41b-ad83-501a-27c260b9f9ee@cogentembedded.com>
Message-ID: <b6648c47-89ef-d9d6-72bb-91b49bab8f96@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/17 12:37, Nikita Yushchenko wrote:
>> I actually have a third variation of this problem involving a PCI root
>> complex which *could* drive full-width (40-bit) addresses, but won't,
>> due to the way its PCI<->AXI interface is programmed. That would require
>> even more complicated dma-ranges handling to describe the windows of
>> valid physical addresses which it *will* pass, so I'm not pressing the
>> issue - let's just get the basic DMA mask case fixed first.
> 
> R-Car + NVMe is actually not "basic case".

I meant "basic" in terms of what needs to be done in Linux - simply
preventing device drivers from overwriting the DT-configured DMA mask
will make everything work as well as well as it possibly can on R-Car,
both with or without the IOMMU, since apparently all you need is to
ensure a PCI device never gets given a DMA address above 4GB. The
situation where PCI devices *can* DMA to all of physical memory, but
can't use arbitrary addresses *outside* it - which only becomes a
problem with an IOMMU - is considerably trickier.

> It has PCI<->AXI interface involved.
> PCI addresses are 64-bit and controller does handle 64-bit addresses
> there. Mapping between PCI addresses and AXI addresses is defined. But
> AXI is 32-bit.
> 
> SoC has iommu that probably could be used between PCIe module and RAM.
> Although AFAIK nobody made that working yet.
> 
> Board I work with has 4G of RAM, in 4 banks, located at different parts
> of wide address space, and only one of them is below 4G. But if iommu is
> capable of translating addresses such that 4 gigabyte banks map to first
> 4 gigabytes of address space, then all memory will become available for
> DMA from PCIe device.

The aforementioned situation on Juno is similar yet different - the PLDA
XR3 root complex uses an address-based lookup table to translate
outgoing PCI memory space transactions to AXI bus addresses with the
appropriate attributes, in power-of-two-sized regions. The firmware
configures 3 LUT entries - 2GB at 0x8000_0000 and 8GB at 0x8_8000_0000
with cache-coherent attributes to cover the DRAM areas, plus a small one
with device attributes covering the GICv2m MSI frame. The issue is that
there is no "no match" translation, so any transaction not within one of
those regions never makes it out of the root complex at all.

That's fine in normal operation, as there's nothing outside those
regions in the physical memory map a PCI device should be accessing
anyway, but turning on the SMMU is another matter - since the IOVA
allocator runs top-down, a PCI device with a 64-bit DMA mask will do a
dma_map or dma_alloc, get the physical page mapped to an IOVA up around
FF_FFFF_F000 (the SMMU will constrain things to the system bus width of
40 bits), then try to access that address and get a termination straight
back from the RC. Similarly, A KVM guest which wants to place its memory
at arbitrary locations and expect device passthrough to work is going to
have a bad time.

I don't know if it's feasible to have the firmware set the LUT up
differently, as that might lead to other problems when not using the
SMMU, and/or just require far more than the 8 available LUT entries
(assuming they have to be non-overlapping - I'm not 100% sure and
documentation is sparse). Thus it seems appropriate to describe the
currently valid PCI-AXI translations with dma-ranges, but then we'd have
multiple entries - last time I looked Linux simply ignores all but the
last one in that case - which can't be combined into a simple bitmask,
so I'm not entirely sure where to go from there. Especially as so far it
seems to be a problem exclusive to one not-widely-available ageing
early-access development platform...

It happens that limiting all PCI DMA masks to 32 bits would bodge around
this problem thanks to the current IOVA allocator behaviour, but that's
pretty yuck, and would force unnecessary bouncing for the non-SMMU case.
My other hack to carve up IOVA domains to reserve all addresses not
matching memblocks is hardly any more realistic, hence why the SMMU is
in the Juno DT in a change-it-at-your-own-peril "disabled" state ;)

Robin.
