From: sumit.semwal@linaro.org (Sumit Semwal)
Date: Thu, 22 Jan 2015 09:16:01 +0530
Subject: [RFCv2 1/2] device: add dma_params->max_segment_count
In-Reply-To: <54BFF679.6010705@arm.com>
References: <1421813807-9178-1-git-send-email-sumit.semwal@linaro.org>
 <1421813807-9178-2-git-send-email-sumit.semwal@linaro.org>
 <54BFF679.6010705@arm.com>
Message-ID: <CAO_48GHLJKLxDxuPWbcTKP6T1Vdt0RLbYYncRihepL5H7KET=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin!

On 22 January 2015 at 00:26, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Sumit,
>
>
> On 21/01/15 04:16, Sumit Semwal wrote:
>>
>> From: Rob Clark <robdclark@gmail.com>
>>
>> For devices which have constraints about maximum number of segments in
>> an sglist.  For example, a device which could only deal with contiguous
>> buffers would set max_segment_count to 1.
>>
>> The initial motivation is for devices sharing buffers via dma-buf,
>> to allow the buffer exporter to know the constraints of other
>> devices which have attached to the buffer.  The dma_mask and fields
>> in 'struct device_dma_parameters' tell the exporter everything else
>> that is needed, except whether the importer has constraints about
>> maximum number of segments.
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>>   [sumits: Minor updates wrt comments on the first version]
>> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
>> ---
>>   include/linux/device.h      |  1 +
>>   include/linux/dma-mapping.h | 19 +++++++++++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index fb50673..a32f9b6 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -647,6 +647,7 @@ struct device_dma_parameters {
>>          * sg limitations.
>>          */
>>         unsigned int max_segment_size;
>> +       unsigned int max_segment_count;    /* INT_MAX for unlimited */
>>         unsigned long segment_boundary_mask;
>>   };
>>
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index c3007cb..38e2835 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -154,6 +154,25 @@ static inline unsigned int
>> dma_set_max_seg_size(struct device *dev,
>>                 return -EIO;
>>   }
>>
>> +#define DMA_SEGMENTS_MAX_SEG_COUNT ((unsigned int) INT_MAX)
>> +
>> +static inline unsigned int dma_get_max_seg_count(struct device *dev)
>> +{
>> +       return dev->dma_parms ?
>> +                       dev->dma_parms->max_segment_count :
>> +                       DMA_SEGMENTS_MAX_SEG_COUNT;
>> +}
>
>
> I know this copies the style of the existing code, but unfortunately it also
> copies the subtle brokenness. Plenty of drivers seem to set up a dma_parms
> struct just for max_segment_size, thus chances are you'll come across a
> max_segment_count of 0 sooner or later. How badly is that going to break
> things? I posted a fix recently[1] having hit this problem with
> segment_boundary_mask in IOMMU code.
>
Thanks very much for reviewing this code; and apologies for missing
your patch that you mentioned here; sure, I will update my patch
accordingly as well.
>> +
>> +static inline int dma_set_max_seg_count(struct device *dev,
>> +                                               unsigned int count)
>> +{
>> +       if (dev->dma_parms) {
>> +               dev->dma_parms->max_segment_count = count;
>> +               return 0;
>> +       } else
>
>
> This "else" is just as unnecessary as the other two I've taken out ;)
>
>
> Robin.
>
> [1]:http://article.gmane.org/gmane.linux.kernel.iommu/8175/
>
>
>> +               return -EIO;
>> +}
>> +
>>   static inline unsigned long dma_get_seg_boundary(struct device *dev)
>>   {
>>         return dev->dma_parms ?
>>
>
>

BR,
Sumit.
