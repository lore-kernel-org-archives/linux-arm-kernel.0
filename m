From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 1 Feb 2016 10:51:23 -0500
Subject: [PATCH V13 10/10] vfio, platform: add QTI HIDMA reset driver
In-Reply-To: <56AF7C9D.4070600@linaro.org>
References: <1454106914-15857-1-git-send-email-okaya@codeaurora.org>
 <1454106914-15857-11-git-send-email-okaya@codeaurora.org>
 <56AF7C9D.4070600@linaro.org>
Message-ID: <56AF7EFB.9040108@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/2016 10:41 AM, Eric Auger wrote:
> Hi Sinan,

>> +
>> +	trreg = vdev->regions[0];
>> +	if (!trreg.ioaddr) {
>> +		trreg.ioaddr =
>> +			ioremap_nocache(trreg.addr, trreg.size);
> this is going to leak. See "vfio: platform: reset: calxedaxgmac: fix
> ioaddr leak".

Thanks, I was following what other drivers were doing and got hit by the same problem :)

>> +		if (!trreg.ioaddr)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	evreg = vdev->regions[1];
>> +	if (!evreg.ioaddr) {
>> +		evreg.ioaddr =
>> +			ioremap_nocache(evreg.addr, evreg.size);
> same here
I'll take care of it.

>> +		if (!evreg.ioaddr)
>> +			return -ENOMEM;
>> +	}
>> +
> I understood the device is a kind of SR-IOV platform device. When the VF
> gets reset are there any interactions with the management driver? Is it
> handled by HW?

There is no communication between the management interface and the DMA channels. 
Management interface is just a runtime platform resource allocator. 

"if you pay more, you get more DMA bandwidth. Otherwise, you get to share the channel 
with other users"

The DMA channels can be reset independent of other DMA channels or the management HW. 
This is a HW feature.

> 
> Best Regards
> 
> Eric
>> +	/* disable IRQ */
>> +	writel(0, evreg.ioaddr + EVCA_IRQ_EN_OFFSET);
>> +
>> +	/* reset both transfer and event channels */
>> +	val = readl(trreg.ioaddr + TRCA_CTRLSTS_OFFSET);
>> +	val &= ~(CH_CONTROL_MASK << 16);
>> +	val |= CH_RESET << 16;
>> +	writel(val, trreg.ioaddr + TRCA_CTRLSTS_OFFSET);
>> +
>> +	ret = readl_poll_timeout(trreg.ioaddr + TRCA_CTRLSTS_OFFSET, val,
>> +				 HIDMA_CH_STATE(val) == CH_DISABLED, 1000,
>> +				 10000);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = readl(evreg.ioaddr + EVCA_CTRLSTS_OFFSET);
>> +	val &= ~(CH_CONTROL_MASK << 16);
>> +	val |= CH_RESET << 16;
>> +	writel(val, evreg.ioaddr + EVCA_CTRLSTS_OFFSET);
>> +
>> +	ret = readl_poll_timeout(evreg.ioaddr + EVCA_CTRLSTS_OFFSET, val,
>> +				 HIDMA_CH_STATE(val) == CH_DISABLED, 1000,
>> +				 10000);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pr_info("HIDMA channel reset\n");
>> +	return 0;
>> +}
>> +module_vfio_reset_handler("qcom,hidma", NULL,
>> +			  vfio_platform_qcomhidma_reset);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Reset support for Qualcomm Technologies HIDMA device");
>>
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
