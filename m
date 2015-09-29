From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 29 Sep 2015 11:48:32 +0100
Subject: [PATCH 1/1] arm: mm: Fix comments in sg_sync functions
In-Reply-To: <1443471655-28302-1-git-send-email-sakari.ailus@linux.intel.com>
References: <1443471655-28302-1-git-send-email-sakari.ailus@linux.intel.com>
Message-ID: <560A6C80.1050808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sakari,

On 28/09/15 21:20, Sakari Ailus wrote:
> The comment on the usage of arm_dma_sync_sg_for_cpu(),
> arm_dma_sync_sg_for_device(), arm_iommu_sync_sg_for_cpu() and
> arm_iommu_sync_sg_for_device() functions wrongly noted that the "nelems"
> parameter is the number of sglist entries returned by dma_map_sg(), while
> this must be the number of entiries passed to dma_map_sg() instead.

Oops, I somehow missed you off cc when I posted [0] last week, 
apologies. I was planning to stick that in Russell's patch system today, 
but since you've done a slightly more thorough job with s/map/sync/ than 
I managed, I'm happy for this version to take precedence over mine:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I'd hope that the lack of objections to my patch so far (and Dan's 
approval) also apply transitively to this one  ;)

Robin.

[0]:http://thread.gmane.org/gmane.linux.ports.arm.kernel/441862

> Suggested-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Hi folks,
>
> This related patch was applied to Jonathan Corbet's tree:
>
> <URL:http://www.spinics.net/lists/linux-doc/msg31801.html>
>
> The comments were indeed wrong. This may have contributed to a related
> videobuf2 bug:
>
> <URL:http://www.spinics.net/lists/linux-media/msg93765.html>
>
>   arch/arm/mm/dma-mapping.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index e626043..1c0154a 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -958,7 +958,7 @@ void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>    * arm_dma_sync_sg_for_cpu
>    * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
>    * @sg: list of buffers
> - * @nents: number of buffers to map (returned from dma_map_sg)
> + * @nents: number of buffers to sync (same as was passed to dma_map_sg)
>    * @dir: DMA transfer direction (same as was passed to dma_map_sg)
>    */
>   void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
> @@ -977,7 +977,7 @@ void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
>    * arm_dma_sync_sg_for_device
>    * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
>    * @sg: list of buffers
> - * @nents: number of buffers to map (returned from dma_map_sg)
> + * @nents: number of buffers to sync (same as was passed to dma_map_sg)
>    * @dir: DMA transfer direction (same as was passed to dma_map_sg)
>    */
>   void arm_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
> @@ -1672,7 +1672,7 @@ void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>    * arm_iommu_sync_sg_for_cpu
>    * @dev: valid struct device pointer
>    * @sg: list of buffers
> - * @nents: number of buffers to map (returned from dma_map_sg)
> + * @nents: number of buffers to sync (same as was passed to dma_map_sg)
>    * @dir: DMA transfer direction (same as was passed to dma_map_sg)
>    */
>   void arm_iommu_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
> @@ -1690,7 +1690,7 @@ void arm_iommu_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
>    * arm_iommu_sync_sg_for_device
>    * @dev: valid struct device pointer
>    * @sg: list of buffers
> - * @nents: number of buffers to map (returned from dma_map_sg)
> + * @nents: number of buffers to sync (same as was passed to dma_map_sg)
>    * @dir: DMA transfer direction (same as was passed to dma_map_sg)
>    */
>   void arm_iommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>
