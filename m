From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jan 2017 11:51:33 +0000
Subject: [PATCH v2] arm64: do not set dma masks that device connection
 can't handle
In-Reply-To: <1483947002-16410-1-git-send-email-nikita.yoush@cogentembedded.com>
References: <1483947002-16410-1-git-send-email-nikita.yoush@cogentembedded.com>
Message-ID: <20170110115132.GD21598@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 10:30:02AM +0300, Nikita Yushchenko wrote:
> It is possible that device is capable of 64-bit DMA addresses, and
> device driver tries to set wide DMA mask, but bridge or bus used to
> connect device to the system can't handle wide addresses.
> 
> With swiotlb, memory above 4G still can be used by drivers for streaming
> DMA, but *dev->mask and dev->dma_coherent_mask must still keep values
> that hardware handles physically.
> 
> This patch enforces that. Based on original version by
> Arnd Bergmann <arnd@arndb.de>, extended with coherent mask hadnling.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes since v1:
> - fixed issues noted by Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>   - save mask, not size
>   - remove doube empty line
> 
>  arch/arm64/Kconfig              |  3 +++
>  arch/arm64/include/asm/device.h |  1 +
>  arch/arm64/mm/dma-mapping.c     | 51 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+)

I still don't think this patch is general enough. The problem you're seeing
with swiotlb seems to be exactly the same problem reported by Feng Kan over
at:

  http://lkml.kernel.org/r/CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g at mail.gmail.com

[read on; it was initially thought to be a hardware erratum, but it's
 actually the inability to restrict the DMA mask of the endpoint that's
 the problem]

The point here is that an IOMMU doesn't solve your issue, and the
IOMMU-backed DMA ops need the same treatment. In light of that, it really
feels to me like the DMA masks should be restricted in of_dma_configure
so that the parent mask is taken into account there, rather than hook
into each set of DMA ops to intercept set_dma_mask. We'd still need to
do something to stop dma_set_mask widening the mask if it was restricted
by of_dma_configure, but I think Robin (cc'd) was playing with that.

Will
