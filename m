From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Wed, 11 Jan 2017 15:37:22 +0300
Subject: [PATCH v2] arm64: do not set dma masks that device connection
 can't handle
In-Reply-To: <5c5cd4fd-4854-a2dd-10b6-9cc98e63a85c@arm.com>
References: <1483947002-16410-1-git-send-email-nikita.yoush@cogentembedded.com>
 <07253eaa-5729-0f15-42b6-e8403f1f0412@cogentembedded.com>
 <11daacde-5399-039f-80a3-01d7bd13e9e8@arm.com> <6116278.nQQUSuo3l4@wuerfel>
 <5c5cd4fd-4854-a2dd-10b6-9cc98e63a85c@arm.com>
Message-ID: <7c6a1523-e41b-ad83-501a-27c260b9f9ee@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I actually have a third variation of this problem involving a PCI root
> complex which *could* drive full-width (40-bit) addresses, but won't,
> due to the way its PCI<->AXI interface is programmed. That would require
> even more complicated dma-ranges handling to describe the windows of
> valid physical addresses which it *will* pass, so I'm not pressing the
> issue - let's just get the basic DMA mask case fixed first.

R-Car + NVMe is actually not "basic case".

It has PCI<->AXI interface involved.
PCI addresses are 64-bit and controller does handle 64-bit addresses
there. Mapping between PCI addresses and AXI addresses is defined. But
AXI is 32-bit.

SoC has iommu that probably could be used between PCIe module and RAM.
Although AFAIK nobody made that working yet.

Board I work with has 4G of RAM, in 4 banks, located at different parts
of wide address space, and only one of them is below 4G. But if iommu is
capable of translating addresses such that 4 gigabyte banks map to first
4 gigabytes of address space, then all memory will become available for
DMA from PCIe device.
