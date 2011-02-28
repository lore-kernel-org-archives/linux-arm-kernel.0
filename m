From: tsoni@codeaurora.org (Trilok Soni)
Date: Mon, 28 Feb 2011 17:43:37 +0530
Subject: [PATCH 2/4] msm: iommu: Rework clock logic and add IOMMU bus
	clock control
In-Reply-To: <4D6828B5.6050608@codeaurora.org>
References: <1298599242-21971-1-git-send-email-stepanm@codeaurora.org>
	<1298599242-21971-2-git-send-email-stepanm@codeaurora.org>
	<4D675A42.9090803@codeaurora.org> <4D6828B5.6050608@codeaurora.org>
Message-ID: <4D6B9171.60600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On 2/26/2011 3:39 AM, Stepan Moskovchenko wrote:
> On 2/24/2011 11:29 PM, Trilok Soni wrote:
>> Hi Steve,
> 
> Hello
> 
>>> @@ -130,117 +131,134 @@ static int msm_iommu_probe(struct platform_device *pdev)
>>>   {
>>>       struct resource *r, *r2;
>>>       struct clk *iommu_clk;
>>> +    struct clk *iommu_pclk;
>>>       struct msm_iommu_drvdata *drvdata;
>>>       struct msm_iommu_dev *iommu_dev = pdev->dev.platform_data;
>> const please.
>>
> 
> I am not clear on what you mean. Please be more specific here.

I mean

const struct msm_iommu_dev *iommu_dev = pdev->dev.platform_data; 

Now I see that this change is not part of this patch so you can ignore my comment.

> 
>>> +    iommu_pclk = clk_get(NULL, "smmu_pclk");
>>> +    if (IS_ERR(iommu_pclk)) {
>>> +        ret = -ENODEV;
>>> +        goto fail;
>>> +    }
>> I am not a big fan of this when you have the "device" around. You should just do
>>
>> iommu_pclk = clk_get(&pdev->dev, NULL);
>>
>> ...error logic...
>>
>> iommu_clk = clk_get(&pdev->dev, "iommu_clk");
>>
>> ...error logic...
>>
> 
> The pclk is a "special" bus clock and does not have a specific device instance associated with it, so passing a device would not be appropriate in this case. I pass the device for other clocks that are indeed associated with devices, but this is not one of them. I suppose we could create 11 or 12 aliases for the pclk and associate it with all the IOMMU devices, but I would prefer to avoid doing that as I believe the current approach is cleaner.

ok.

> 
>>> -            ret = -EBUSY;
>>> -            goto fail;
>>> -        }
>>> +    len = r->end - r->start + 1;
>>
>> resource_size please.
>>
> 
> Ok

Thanks.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
