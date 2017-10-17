From: jim2101024@gmail.com (Jim Quinlan)
Date: Tue, 17 Oct 2017 12:11:55 -0400
Subject: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
In-Reply-To: <20171017081422.GA19475@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de>
Message-ID: <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 4:14 AM, Christoph Hellwig <hch@lst.de> wrote:
> Just took a quick look over this and I basically agree with the comments
> from Robin.
>
> What I don't understand is why you're even trying to do all these
> hacky things.
>
> It seems like the controller should simply set dma_pfn_offset for
> each device hanging off it, and all the supported architectures
> should be updated to obey that if they don't do so yet, and
> you're done without needing this giant mess.

My understanding is that dma_pfn_offset is that it is a single
constant offset from RAM, in our case, to map to PCIe space.  But in
my commit message I detail how our PCIe controller presents memory
with multiple regions with multiple different offsets. If an EP device
maps to a region on the host memory, yes we can set the dma_pfn_offset
for that device for that location within that range,.  But if the
device then unmaps and allocates from another region with a different
offset, it won't work.  If  I set dma_pfn_offset I have to assume that
the device is using only one region of memory only, not more than one,
and that it is not unmapping that region and mapping another (with a
different offset).  Can I make those assumptions?
