From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 22 Sep 2015 16:37:17 +0100
Subject: [RESEND PATCH] media: vb2: Fix vb2_dc_prepare do not correct sync
 data to device
In-Reply-To: <56000293.9000802@xs4all.nl>
References: <1442838371-21484-1-git-send-email-tiffany.lin@mediatek.com>
 <56000293.9000802@xs4all.nl>
Message-ID: <560175AD.2010401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On 21/09/15 14:13, Hans Verkuil wrote:
> Hi Tiffany!
>
> On 21-09-15 14:26, Tiffany Lin wrote:
>> vb2_dc_prepare use the number of SG entries dma_map_sg_attrs return.
>> But in dma_sync_sg_for_device, it use lengths of each SG entries
>> before dma_map_sg_attrs. dma_map_sg_attrs will concatenate
>> SGs until dma length > dma seg bundary. sgt->nents will less than
>> sgt->orig_nents. Using SG entries after dma_map_sg_attrs
>> in vb2_dc_prepare will make some SGs are not sync to device.
>> After add DMA_ATTR_SKIP_CPU_SYNC in vb2_dc_get_userptr to remove
>> sync data to device twice. Device randomly get incorrect data because
>> some SGs are not sync to device. Change to use number of SG entries
>> before dma_map_sg_attrs in vb2_dc_prepare to prevent this issue.
>>
>> Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
>> ---
>>   drivers/media/v4l2-core/videobuf2-dma-contig.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/v4l2-core/videobuf2-dma-contig.c b/drivers/media/v4l2-core/videobuf2-dma-contig.c
>> index 2397ceb..c5d00bd 100644
>> --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
>> +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
>> @@ -100,7 +100,7 @@ static void vb2_dc_prepare(void *buf_priv)
>>   	if (!sgt || buf->db_attach)
>>   		return;
>>
>> -	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
>> +	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
>>   }
>>
>>   static void vb2_dc_finish(void *buf_priv)
>> @@ -112,7 +112,7 @@ static void vb2_dc_finish(void *buf_priv)
>>   	if (!sgt || buf->db_attach)
>>   		return;
>>
>> -	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
>> +	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
>>   }
>
> I don't really understand it. I am assuming that this happens on an arm and that
> the dma_map_sg_attrs and dma_sync_sg_* functions used are arm_iommu_map_sg() and
> arm_iommu_sync_sg_* as implemented in arch/arm/mm/dma-mapping.c.
>
> Now, as I understand it (and my understanding may very well be flawed!) the map_sg
> function concatenates SG entries if possible, so it may return fewer entries. But
> the dma_sync_sg functions use those updated SG entries, so the full buffer should
> be covered by this. Using orig_nents will actually sync parts of the buffer twice!
> The first nents entries already cover the full buffer so any remaining entries up
> to orig_nents will just duplicate parts of the buffer.

As Documentation/DMA-API.txt says, the parameters to dma_sync_sg_* must 
be the same as those originally passed into dma_map_sg. The segments are 
only merged *from the point of view of the device*: if I have a 
scatterlist of two discontiguous 4K segments, I can remap them with an 
IOMMU so the device sees them as a single 8K buffer, and tell it as 
such. If on the other hand I want to do maintenance from the CPU side 
(i.e. any DMA API call), then those DMA addresses mean nothing and I can 
only operate on the CPU addresses of the underlying pages, which are 
still very much discontiguous in the linear map; ergo I still need to 
iterate over the original entries.

Whilst I can't claim much familiarity with v4l itself, from a brief look 
over the existing code this patch does look to be doing the right thing.

Robin.
