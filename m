From: hch@lst.de (Christoph Hellwig)
Date: Fri, 20 Oct 2017 09:37:30 +0200
Subject: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
In-Reply-To: <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de>
 <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de>
 <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
Message-ID: <20171020073730.GA12937@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 06:47:45PM -0400, Jim Quinlan wrote:
> The only way to prevent this is to reserve a single page at the end of
> the first memory region of any pair that are adjacent in physical
> memory.  A hack, yes, but I don't see an easier way out of this.  Many
> if not most of our boards do not have adjacent regions and would not
> need this.

dma mappings can be much larger than a single page.  For the block
world take a look at __blk_segment_map_sg which does the merging
of contiguous pages into a single SG segment.  You'd have to override
BIOVEC_PHYS_MERGEABLE to prevent this from happening in your supported
architectures for the block layer.
