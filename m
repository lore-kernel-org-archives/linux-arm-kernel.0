From: grundler@chromium.org (Grant Grundler)
Date: Mon, 12 May 2014 13:02:13 -0700
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <537112FC.1040204@wwwdotorg.org>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <20140509105638.GB3921@e103592.cambridge.arm.com>
 <5370F484.9030209@wwwdotorg.org> <25333129.urqEa0mCI8@wuerfel>
 <537112FC.1040204@wwwdotorg.org>
Message-ID: <CANEJEGuCbE0THLvK-6pXuN+QUA=LZON97KTpPK-0QUJPToXkdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 11:29 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
....
>> But the important point here is that you wouldn't use the dma-mapping
>> API to manage this. First of all, the CPU is special anyway, but also
>> if you do a device-to-device DMA into the GPU address space and that
>> ends up being redirected to memory through the IOMMU, you still wouldn't
>> manage the I/O page tables through the interfaces of the device doing the
>> DMA, but through some private interface of the GPU.
>
> Why not? If something wants to DMA to a memory region, irrespective of
> whether the GPU MMU (or any MMU) is in between those master transactions
> and the RAM or not, surely the driver should always use the DMA mapping
> API to set that up?

No.  As one of the contributors to DMA API, I'm pretty confident it's
not. It _could_ be used that way but it's certainly not the original
design. P2P transactions are different since they are "less likely"
(depends on arch and implementation) to participate in the CPU cache
coherency or even be visible to the CPU. In particular, think of case
where all transactions are locally routed behind a PCI bridge (or
other fabric) and CPU/IOMMU/RAM controller never sees those.

A long standing real example is in drivers/scsi/sym53c8xx_2 driver.
The "scripts" engine needs to access local (on chip) RAM through PCI
bus transactions. So it uses it's own PCI BAR registers to sort that
out.
In essence, "local PCI physical" addresses.  I believe the code is in
sym_iomap_device(). No CPU or IOMMU is involved with this.  This
driver otherwise uses the DMA API for all other host RAM accesses.

> Anything else just means using custom APIs, and
> isn't the whole point of the DMA mapping API to provide a standard API
> for that purpose?

yes and no. Yes, the generic DMA API is to provide DMA mapping
services to hide the (or lack of) IOMMU AND provide Cache Coherency
for DMA transactions to RAM that is visible to the CPU cache.

In general, I'd argue transactions that route through an IOMMU need to
work with the existing DMA API. Historically those transactions are
routed "upstream" - away from other IO devices and thus not the case
referred to here.

If the IOMMU is part of a "graph topology" (vs a tree topology), the
drivers will have to know if they use DMA API or not to access the
intended target.

cheers,
grant
