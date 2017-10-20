From: jim2101024@gmail.com (Jim Quinlan)
Date: Fri, 20 Oct 2017 10:41:56 -0400
Subject: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
In-Reply-To: <20171020073730.GA12937@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de>
 <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de>
 <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
 <20171020073730.GA12937@lst.de>
Message-ID: <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 3:37 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Oct 19, 2017 at 06:47:45PM -0400, Jim Quinlan wrote:
>> The only way to prevent this is to reserve a single page at the end of
>> the first memory region of any pair that are adjacent in physical
>> memory.  A hack, yes, but I don't see an easier way out of this.  Many
>> if not most of our boards do not have adjacent regions and would not
>> need this.
>
> dma mappings can be much larger than a single page.  For the block
> world take a look at __blk_segment_map_sg which does the merging
> of contiguous pages into a single SG segment.  You'd have to override
> BIOVEC_PHYS_MERGEABLE to prevent this from happening in your supported
> architectures for the block layer.

I am not sure I understand your comment -- the size of the request
shouldn't be a factor.  Let's look at your example of the DMA request
of 3fffff00 to 4000000f (physical memory).  Lets say it is for 15
pages.  If we block out  the last page [0x3ffff000..0x3fffffff] from
what is available, there is no 15 page span that can happen across the
0x40000000 boundary.  For SG, there can be no merge that connects a
page from one region to another region.  Can you give an example of
the scenario you are thinking of?
