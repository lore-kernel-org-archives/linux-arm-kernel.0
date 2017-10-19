From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Oct 2017 11:16:44 +0200
Subject: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
In-Reply-To: <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de>
 <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
Message-ID: <20171019091644.GA14983@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 10:41:17AM -0400, Jim Quinlan wrote:
> That's what brcm_to_{pci,cpu} are for -- they keep a list of the
> dma-ranges given in the PCIe DT node, and translate from system memory
> addresses to pci-space addresses, and vice versa.  As long as people
> are using the DMA API it should work.  It works for all of the ARM,
> ARM64, and MIPS Broadcom systems I've tested, using eight different EP
> devices.  Note that I am not thrilled to be advocating this mechanism
> but it seemed the best alternative.

Say we are using your original example ranges:

 memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
 memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
 memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
 memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
 memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
 memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]

and now you get a dma mapping request for physical addresses
3fffff00 to 4000000f, which would span two of your ranges.  How
is this going to work?

> I would prefer that the same code work for all three architectures.
> What I would like from ARM/ARM64 is the ability to override
> phys_to_dma() and dma_to_phys(); I thought the chances of that being
> accepted would be slim.  But you are right, I should ask the
> maintainers.

It is still better than trying to stack dma ops, which is a receipe
for problems down the road.
