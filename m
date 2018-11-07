From: john.stultz@linaro.org (John Stultz)
Date: Tue, 6 Nov 2018 17:27:14 -0800
Subject: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
In-Reply-To: <20181008080246.20543-7-hch@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-7-hch@lst.de>
Message-ID: <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2018 at 1:04 AM Christoph Hellwig <hch@lst.de> wrote:
>
> No need to duplicate the code - map_sg is equivalent to map_page
> for each page in the scatterlist.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/swiotlb.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)

Hey all,

So, I've found this patch seems to break userspace booting on the
HiKey960 board. Initially I thought this was an issue with the mali
drivers, and have worked w/ the mali team to try to find a solution,
but I've since found that booting just the upstream kernel (with no
graphics support) will see userland hang/block unless this patch is
reverted.

When I see the hangs, it seems like the filesystems are stuck or
something, as kernel messages still show up and sometimes I can get to
a shell, but commands that I run in that shell (like ls) just hang. I
don't see any other error messages.

Reverting this patch then gets it work. In order to cleanly revert the
patch, I have to revert the following set:
  "arm64: use the generic swiotlb_dma_ops"
  "swiotlb: add support for non-coherent DMA"
  "swiotlb: don't dip into swiotlb pool for coherent allocations"
  "swiotlb: refactor swiotlb_map_page"
  "swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs"

But at that point if I just re-apply "swiotlb: use swiotlb_map_page in
swiotlb_map_sg_attrs", I reproduce the hangs.

Any suggestions for how to further debug what might be going wrong
would be appreciated!

thanks
-john
