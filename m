From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 3 Nov 2017 14:13:21 -0600
Subject: [PATCH 07/17] coresight: tmc etr: Add transparent buffer
 management
In-Reply-To: <cc094fc0-3d48-c17f-9afc-25b0a1186dd0@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-8-suzuki.poulose@arm.com> <20171102174812.GA23320@xps15>
 <cc094fc0-3d48-c17f-9afc-25b0a1186dd0@arm.com>
Message-ID: <CANLsYky-vi4b29nr+rwbcSP3dUMADDV1o8irAX=XDSq6MkuLSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 November 2017 at 04:02, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 02/11/17 17:48, Mathieu Poirier wrote:
>>
>> On Thu, Oct 19, 2017 at 06:15:43PM +0100, Suzuki K Poulose wrote:
>>>
>>> At the moment we always use contiguous memory for TMC ETR tracing
>>> when used from sysfs. The size of the buffer is fixed at boot time
>>> and can only be changed by modifiying the DT. With the introduction
>>> of SG support we could support really large buffers in that mode.
>>> This patch abstracts the buffer used for ETR to switch between a
>>> contiguous buffer or a SG table depending on the availability of
>>> the memory.
>>>
>>> This also enables the sysfs mode to use the ETR in SG mode depending
>>> on configured the trace buffer size. Also, since ETR will use the
>>> new infrastructure to manage the buffer, we can get rid of some
>>> of the members in the tmc_drvdata and clean up the fields a bit.
>>>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 433
>>> +++++++++++++++++++-----
>>>   drivers/hwtracing/coresight/coresight-tmc.h     |  60 +++-
>>>   2 files changed, 403 insertions(+), 90 deletions(-)
>>>
>>
>> [..]
>>
>>>
>>> +
>>> +static void tmc_etr_sync_sg_buf(struct etr_buf *etr_buf, u64 rrp, u64
>>> rwp)
>
>
>>> +       w_offset = tmc_sg_get_data_page_offset(table, rwp);
>>> +       if (w_offset < 0) {
>>> +               dev_warn(table->dev, "Unable to map RWP %llx to
>>> offset\n",
>>> +                               rwp);
>>
>>
>>                  dev_warn(table->dev,
>>                           "Unable to map RWP %llx to offset\n", rwq);
>>
>> It looks a little better and we respect indentation rules.  Same for
>> r_offset.
>>
>
>>> +static inline int tmc_etr_mode_alloc_buf(int mode,
>>> +                                 struct tmc_drvdata *drvdata,
>>> +                                 struct etr_buf *etr_buf, int node,
>>> +                                 void **pages)
>>
>>
>> static inline int
>> tmc_etr_mode_alloc_buf(int mode,
>>                         struct tmc_drvdata *drvdata,
>>                         struct etr_buf *etr_buf, int node,
>>                         void **pages)
>
>
>>> + * tmc_alloc_etr_buf: Allocate a buffer use by ETR.
>>> + * @drvdata    : ETR device details.
>>> + * @size       : size of the requested buffer.
>>> + * @flags      : Required properties of the type of buffer.
>>> + * @node       : Node for memory allocations.
>>> + * @pages      : An optional list of pages.
>>> + */
>>> +static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
>>> +                                         ssize_t size, int flags,
>>> +                                         int node, void **pages)
>>
>>
>> Please fix indentation.  Also @flags isn't used.
>>

Ok, I haven't made it that far yet.  If it's used later one just leave
it as it is.

>
> Yep, flags is only used later and can move it to the patch where we use it.
>
>>> +{
>>> +       int rc = -ENOMEM;
>>> +       bool has_etr_sg, has_iommu;
>>> +       struct etr_buf *etr_buf;
>>> +
>>> +       has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
>>> +       has_iommu = iommu_get_domain_for_dev(drvdata->dev);
>>> +
>>> +       etr_buf = kzalloc(sizeof(*etr_buf), GFP_KERNEL);
>>> +       if (!etr_buf)
>>> +               return ERR_PTR(-ENOMEM);
>>> +
>>> +       etr_buf->size = size;
>>> +
>>> +       /*
>>> +        * If we have to use an existing list of pages, we cannot
>>> reliably
>>> +        * use a contiguous DMA memory (even if we have an IOMMU).
>>> Otherwise,
>>> +        * we use the contiguous DMA memory if :
>>> +        *  a) The ETR cannot use Scatter-Gather.
>>> +        *  b) if not a, we have an IOMMU backup
>>
>>
>> Please rework the above sentence.
>
>
> How about :
>            b) if (a) is not true and we have an IOMMU connected to the ETR.

I'm good with that.

>
> I will address the other comments on indentation.
>
> Thanks for the detailed look
>
> Cheers
> Suzuki
