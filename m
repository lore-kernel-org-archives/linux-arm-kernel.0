From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 24 Aug 2011 19:55:14 +0530
Subject: [PATCH 1/3] DMA: PL330: Infer transfer direction from transfer
	request instead of platform data
In-Reply-To: <4E54E42D.9060905@gmail.com>
References: <1314050385-9617-1-git-send-email-thomas.abraham@linaro.org>
	<1314050385-9617-2-git-send-email-thomas.abraham@linaro.org>
	<4E54E42D.9060905@gmail.com>
Message-ID: <CAJuYYwQ6yHb_ixJ87cmt6BiwJ-487iVUG1xWFsdXL2b57Mr2bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 24 August 2011 17:14, Rob Herring <robherring2@gmail.com> wrote:
> Thomas,
>
> On 08/22/2011 04:59 PM, Thomas Abraham wrote:
>> The transfer direction for a channel can be inferred from the transfer
>> request and the need for specifying transfer direction in platfrom data
>> can be eliminated. So the structure definition 'struct dma_pl330_peri'
>> is no longer required.
>>
>> With the 'struct dma_pl330_peri' removed, the dma controller transfer
>> capabilities cannot be inferred any longer. Hence, the dma controller
>> capabilities is specified using platforme data.
>>
>> Cc: Jassi Brar <jassisinghbrar@gmail.com>
>> Cc: Boojin Kim <boojin.kim@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?drivers/dma/pl330.c ? ? ? ?| ? 56 ++++++++------------------------------------
>> ?include/linux/amba/pl330.h | ? 14 +++--------
>> ?2 files changed, 14 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
>> index 3a0baac..6592b9a 100644
>> --- a/drivers/dma/pl330.c
>> +++ b/drivers/dma/pl330.c

[...]

>> @@ -872,27 +855,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>>
>> ? ? ? for (i = 0; i < num_chan; i++) {
>> ? ? ? ? ? ? ? pch = &pdmac->peripherals[i];
>> - ? ? ? ? ? ? if (pdat) {
>> - ? ? ? ? ? ? ? ? ? ? struct dma_pl330_peri *peri = &pdat->peri[i];
>> -
>> - ? ? ? ? ? ? ? ? ? ? switch (peri->rqtype) {
>> - ? ? ? ? ? ? ? ? ? ? case MEMTOMEM:
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma_cap_set(DMA_MEMCPY, pd->cap_mask);
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
>> - ? ? ? ? ? ? ? ? ? ? case MEMTODEV:
>> - ? ? ? ? ? ? ? ? ? ? case DEVTOMEM:
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma_cap_set(DMA_SLAVE, pd->cap_mask);
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma_cap_set(DMA_CYCLIC, pd->cap_mask);
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
>> - ? ? ? ? ? ? ? ? ? ? default:
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_err(&adev->dev, "DEVTODEV Not Supported\n");
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? continue;
>> - ? ? ? ? ? ? ? ? ? ? }
>> - ? ? ? ? ? ? ? ? ? ? pch->chan.private = peri;
>> - ? ? ? ? ? ? } else {
>> - ? ? ? ? ? ? ? ? ? ? dma_cap_set(DMA_MEMCPY, pd->cap_mask);
>> - ? ? ? ? ? ? ? ? ? ? pch->chan.private = NULL;
>> - ? ? ? ? ? ? }
>> + ? ? ? ? ? ? pch->chan.private = (pdat) ? &pdat->peri_id[i] : NULL;
>
> Don't need parentheses here.

Ok. I will fix this in the next version of this patchset.

>
>>
>> ? ? ? ? ? ? ? INIT_LIST_HEAD(&pch->work_list);
>> ? ? ? ? ? ? ? spin_lock_init(&pch->lock);
>> @@ -907,6 +870,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>> ? ? ? }
>>
>> ? ? ? pd->dev = &adev->dev;
>> + ? ? pd->cap_mask = pdat->cap_mask;
>
> You are re-introducing the requirement to have platform data which I
> just made optional. For mem to mem transfers, there is no reason to have
> platform data. In my case, we only support mem to mem transfers.
>
> How about:
> pd->cap_mask = pdat ? pdat->cap_mask : DMA_MEMCPY;

All of your changes to make platform data optional is still retained
in this patch. But, as you said, the above change that I did to get
the capabilities from pdata would not work when no pdata is supplied
(as in the case mem-to-mem transfers). Thanks for pointing this out.

This can be fixed as below

if (pdat)
        pd->cap_mask = pdat->cap_mask;
else
        dma_cap_set(DMA_MEMCPY, pd->cap_mask);

>
> Also, should you be using dma_cap_set here?

Yes. That would be required. I will do these changes and resubmit the
patch. Thanks for your review.

Regards,
Thomas.

>
> Rob
>

[...]
