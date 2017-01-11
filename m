From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jan 2017 17:21:49 +0100
Subject: [PATCH v2] arm64: do not set dma masks that device connection
 can't handle
In-Reply-To: <7c6a1523-e41b-ad83-501a-27c260b9f9ee@cogentembedded.com>
References: <1483947002-16410-1-git-send-email-nikita.yoush@cogentembedded.com>
 <5c5cd4fd-4854-a2dd-10b6-9cc98e63a85c@arm.com>
 <7c6a1523-e41b-ad83-501a-27c260b9f9ee@cogentembedded.com>
Message-ID: <3179509.2spa1K0WKy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 11, 2017 3:37:22 PM CET Nikita Yushchenko wrote:
> > I actually have a third variation of this problem involving a PCI root
> > complex which *could* drive full-width (40-bit) addresses, but won't,
> > due to the way its PCI<->AXI interface is programmed. That would require
> > even more complicated dma-ranges handling to describe the windows of
> > valid physical addresses which it *will* pass, so I'm not pressing the
> > issue - let's just get the basic DMA mask case fixed first.
> 
> R-Car + NVMe is actually not "basic case".
> 
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

You can in theory handle this by defining your own platform specific
dma_map_ops, as we used to do in the old days. Unfortunately, the modern
way of using the generic IOVA allocation can't handle really it, so it's
unclear if the work that would be necessary to support it (and the long
term maintenance cost) outweigh the benefits.

The more likely option here is to try harder to get the IOMMU working
(or show that it's impossible but make sure the next chip gets it right).

	Arnd
