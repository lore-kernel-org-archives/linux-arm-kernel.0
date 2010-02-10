From: rdunlap@xenotime.net (Randy Dunlap)
Date: Wed, 10 Feb 2010 13:27:47 -0800
Subject: [RFC 0/2] fix dma_map_sg not to do barriers for each buffer
In-Reply-To: <1265834250-29170-1-git-send-email-adharmap@codeaurora.org>
References: <1265834250-29170-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <4B7324D3.1000509@xenotime.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/10 12:37, adharmap at codeaurora.org wrote:
> From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> 
> Please refer to the post here
> http://lkml.org/lkml/2010/1/4/347
> 
> These changes are to introduce barrierless dma_map_area and dma_unmap_area and
> use them to map the buffers in the scatterlist. For the last buffer, call
> the normal dma_map_area(aka with barriers) effectively executing the barrier
> at the end of the operation.
> 
> Note that the barrierless operations are implemented for few arm
> architectures only and I would implement for others once these are okayed by the
> community.

So when you add these interfaces for other architectures, you will also
update Documentation/DMA-API.txt,  right??


> Abhijeet Dharmapurikar (2):
>   dma: define barrierless versions of map and unmap area
>   dma: fix scatter-gather api to use barrierless map/unmap functions
> 
>  arch/arm/include/asm/cacheflush.h  |    9 +++
>  arch/arm/include/asm/dma-mapping.h |   82 +++++++++++++++++++++
>  arch/arm/mm/cache-v3.S             |    6 ++
>  arch/arm/mm/cache-v4.S             |    6 ++
>  arch/arm/mm/cache-v4wb.S           |   94 +++++++++++++++++-------
>  arch/arm/mm/cache-v4wt.S           |    6 ++
>  arch/arm/mm/cache-v6.S             |  139 +++++++++++++++++++++++++----------
>  arch/arm/mm/cache-v7.S             |  120 +++++++++++++++++++++++--------
>  arch/arm/mm/dma-mapping.c          |   55 +++++++++++++--
>  9 files changed, 414 insertions(+), 103 deletions(-)


-- 
~Randy
