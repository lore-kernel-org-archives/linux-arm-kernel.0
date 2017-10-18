From: hch@lst.de (Christoph Hellwig)
Date: Wed, 18 Oct 2017 08:53:16 +0200
Subject: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
In-Reply-To: <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
Message-ID: <20171018065316.GA11183@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 12:11:55PM -0400, Jim Quinlan wrote:
> My understanding is that dma_pfn_offset is that it is a single
> constant offset from RAM, in our case, to map to PCIe space.

Yes.

> But in
> my commit message I detail how our PCIe controller presents memory
> with multiple regions with multiple different offsets. If an EP device
> maps to a region on the host memory, yes we can set the dma_pfn_offset
> for that device for that location within that range,.  But if the
> device then unmaps and allocates from another region with a different
> offset, it won't work.  If  I set dma_pfn_offset I have to assume that
> the device is using only one region of memory only, not more than one,
> and that it is not unmapping that region and mapping another (with a
> different offset).  Can I make those assumptions?

No, we can't make that assumption unfortunately.  But how is your
code going to work if the mapping spans multiple of your translation
regions?

Also I really don't think the stacking of dma_ops as in this patch
is a good idea.  For MIPS you should do the variant suggested in
the patch description and hook into dma_to_phys/phys_to_dma helpers,
and for ARM/ARM64 you should talk to the maintainers on how they
want the translation integrated.
