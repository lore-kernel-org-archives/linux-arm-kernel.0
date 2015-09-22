From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 23 Sep 2015 07:52:18 +0800
Subject: [RESEND PATCH] media: vb2: Fix vb2_dc_prepare do not correct sync
 data to device
In-Reply-To: <20150922203751.GS3175@valkosipuli.retiisi.org.uk>
References: <1442838371-21484-1-git-send-email-tiffany.lin@mediatek.com>
 <56000293.9000802@xs4all.nl> <560175AD.2010401@arm.com>
 <20150922203751.GS3175@valkosipuli.retiisi.org.uk>
Message-ID: <CAGS+omAm5j7N-TPbium6CNO3RkcuBViuULbnMe_Yh4NUwm-xKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sakari,

On Wed, Sep 23, 2015 at 4:37 AM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> Hi Robin,
>
> On Tue, Sep 22, 2015 at 04:37:17PM +0100, Robin Murphy wrote:
>> Hi Hans,
>>
>> On 21/09/15 14:13, Hans Verkuil wrote:
>> >Hi Tiffany!
>> >
>> >On 21-09-15 14:26, Tiffany Lin wrote:
>> >>vb2_dc_prepare use the number of SG entries dma_map_sg_attrs return.
>> >>But in dma_sync_sg_for_device, it use lengths of each SG entries
>> >>before dma_map_sg_attrs. dma_map_sg_attrs will concatenate
>> >>SGs until dma length > dma seg bundary. sgt->nents will less than
>> >>sgt->orig_nents. Using SG entries after dma_map_sg_attrs
>> >>in vb2_dc_prepare will make some SGs are not sync to device.
>> >>After add DMA_ATTR_SKIP_CPU_SYNC in vb2_dc_get_userptr to remove
>> >>sync data to device twice. Device randomly get incorrect data because
>> >>some SGs are not sync to device. Change to use number of SG entries
>> >>before dma_map_sg_attrs in vb2_dc_prepare to prevent this issue.
>> >>
>> >>Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
>> >>---
>> >>  drivers/media/v4l2-core/videobuf2-dma-contig.c | 4 ++--
>> >>  1 file changed, 2 insertions(+), 2 deletions(-)
>> >>
>> >>diff --git a/drivers/media/v4l2-core/videobuf2-dma-contig.c b/drivers/media/v4l2-core/videobuf2-dma-contig.c
>> >>index 2397ceb..c5d00bd 100644
>> >>--- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
>> >>+++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
>> >>@@ -100,7 +100,7 @@ static void vb2_dc_prepare(void *buf_priv)
>> >>    if (!sgt || buf->db_attach)
>> >>            return;
>> >>
>> >>-   dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
>> >>+   dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
>> >>  }
>> >>
>> >>  static void vb2_dc_finish(void *buf_priv)
>> >>@@ -112,7 +112,7 @@ static void vb2_dc_finish(void *buf_priv)
>> >>    if (!sgt || buf->db_attach)
>> >>            return;
>> >>
>> >>-   dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
>> >>+   dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
>> >>  }
>> >
>> >I don't really understand it. I am assuming that this happens on an arm and that
>> >the dma_map_sg_attrs and dma_sync_sg_* functions used are arm_iommu_map_sg() and
>> >arm_iommu_sync_sg_* as implemented in arch/arm/mm/dma-mapping.c.
>> >
>> >Now, as I understand it (and my understanding may very well be flawed!) the map_sg
>> >function concatenates SG entries if possible, so it may return fewer entries. But
>> >the dma_sync_sg functions use those updated SG entries, so the full buffer should
>> >be covered by this. Using orig_nents will actually sync parts of the buffer twice!
>> >The first nents entries already cover the full buffer so any remaining entries up
>> >to orig_nents will just duplicate parts of the buffer.
>>
>> As Documentation/DMA-API.txt says, the parameters to dma_sync_sg_* must be
>> the same as those originally passed into dma_map_sg. The segments are only
>> merged *from the point of view of the device*: if I have a scatterlist of
>> two discontiguous 4K segments, I can remap them with an IOMMU so the device
>> sees them as a single 8K buffer, and tell it as such. If on the other hand I
>> want to do maintenance from the CPU side (i.e. any DMA API call), then those
>> DMA addresses mean nothing and I can only operate on the CPU addresses of
>> the underlying pages, which are still very much discontiguous in the linear
>> map; ergo I still need to iterate over the original entries.
>>
>> Whilst I can't claim much familiarity with v4l itself, from a brief look
>> over the existing code this patch does look to be doing the right thing.
>
> Thanks for the explanation. I wonder if this is the only place where we have
> this issue. :-I
>
> I think this might have been partly caused by the unfortunately named field
> (nents) in struct sg_table. I wrote a small patch for this (plus a fix for a
> few other things as well):
>
>
> From 8928d76db4d45c2b4a16ff90de6695bc88e19779 Mon Sep 17 00:00:00 2001
> From: Sakari Ailus <sakari.ailus@iki.fi>
> Date: Tue, 22 Sep 2015 23:30:30 +0300
> Subject: [PATCH 1/1] Documentation: DMA API: Be more explicit that nelems is
>  always the same
>
> The nelems argument to the DMA API functions operating on scatterlists is
> always the same. The documentation used different argument names and the
> matter was not mentioned in Documentation/DMA-API-HOWTO.txt at all. Fix
> these.


Thanks for this patch!  I was very confused by this as well.
Can you also fix the following incorrect comments in arch/arm/mm/dma-mapping.c :

1694 /**
1695  * arm_iommu_sync_sg_for_cpu
1696  * @dev: valid struct device pointer
1697  * @sg: list of buffers
1698  * @nents: number of buffers to map (returned from dma_map_sg)
1699  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
1700  */
1701 void arm_iommu_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,

1712 /**
1713  * arm_iommu_sync_sg_for_device
1714  * @dev: valid struct device pointer
1715  * @sg: list of buffers
1716  * @nents: number of buffers to map (returned from dma_map_sg)
1717  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
1718  */
1719 void arm_iommu_sync_sg_for_device(struct device *dev, struct
scatterlist *sg,

In both cases @nents should be

  * @nents: number of buffers to sync (same as was passed to dma_map_sg)


Thanks!
-Dan

>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  Documentation/DMA-API-HOWTO.txt | 5 +++++
>  Documentation/DMA-API.txt       | 9 +++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
> index 55b70b9..d69b3fc 100644
> --- a/Documentation/DMA-API-HOWTO.txt
> +++ b/Documentation/DMA-API-HOWTO.txt
> @@ -681,6 +681,11 @@ or:
>
>  as appropriate.
>
> +PLEASE NOTE:  The 'nents' argument to dma_sync_sg_for_cpu() and
> +             dma_sync_sg_for_device() must be the same passed to
> +             dma_map_sg(). It is _NOT_ the count returned by
> +             dma_map_sg().
> +
>  After the last DMA transfer call one of the DMA unmap routines
>  dma_unmap_{single,sg}(). If you don't touch the data from the first
>  dma_map_*() call till dma_unmap_*(), then you don't have to call the
> diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
> index edccacd..8c832f0 100644
> --- a/Documentation/DMA-API.txt
> +++ b/Documentation/DMA-API.txt
> @@ -340,14 +340,15 @@ accessed sg->address and sg->length as shown above.
>
>         void
>         dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> -               int nhwentries, enum dma_data_direction direction)
> +               int nents, enum dma_data_direction direction)
>
>  Unmap the previously mapped scatter/gather list.  All the parameters
>  must be the same as those and passed in to the scatter/gather mapping
>  API.
>
>  Note: <nents> must be the number you passed in, *not* the number of
> -DMA address entries returned.
> +DMA address entries returned. In struct sg_table this is the field
> +called orig_nents.
>
>  void
>  dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
> @@ -356,10 +357,10 @@ void
>  dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
>                            enum dma_data_direction direction)
>  void
> -dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
> +dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nents,
>                     enum dma_data_direction direction)
>  void
> -dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
> +dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nents,
>                        enum dma_data_direction direction)
>
>  Synchronise a single contiguous or scatter/gather mapping for the CPU
>
> --
> Kind regards,
>
> Sakari Ailus
> e-mail: sakari.ailus at iki.fi     XMPP: sailus at retiisi.org.uk
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
