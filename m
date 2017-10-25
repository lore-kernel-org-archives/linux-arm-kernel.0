From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 25 Oct 2017 09:36:37 +0000
Subject: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
In-Reply-To: <CANCKTBu6H6thuK9F_6HBGhStaXSto7fwWv4V5oH8EdWQD0-1kQ@mail.gmail.com>
References: <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de>
 <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de>
 <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
 <20171020073730.GA12937@lst.de>
 <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
 <20171020145752.GA4694@lst.de>
 <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD009F05A@AcuExch.aculab.com>
 <CANCKTBu6H6thuK9F_6HBGhStaXSto7fwWv4V5oH8EdWQD0-1kQ@mail.gmail.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00A24FC@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jim Quinla
> Sent: 24 October 2017 19:08
...
> Hi David,  Christoph was also concerned about this:
> 
> "For the block world take a look at __blk_segment_map_sg which does the merging
> of contiguous pages into a single SG segment.  You'd have to override
> BIOVEC_PHYS_MERGEABLE to prevent this from happening in your supported
> architectures for the block layer."
> 
> Do you consider this a non-issue as well or can this happen and span
> memory regions?

Probably easiest to have an architecture limit on the addresses that
can be merged.

My guess is that this code only really ever merges pages that were
allocated contiguously, but have got converted to a list of VA.
So stopping merging over even 1MB boundaries would have minimal effect
(even if done unconditionally).

I even wonder if the merging is actually worthwhile at all?
Maybe if any code has limits on the SG list length.
(or reducing the number of cache lines the get dirtied...)

	David
