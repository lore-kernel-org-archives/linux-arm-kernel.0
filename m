From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 5 Mar 2018 14:13:16 +0000
Subject: [RESEND PATCH v6 13/14] iommu/rockchip: Add runtime PM support
In-Reply-To: <CAAFQd5D2SY2RV9HLTeTQigfnVCkF9wDq74_+t3OV2YEb9wJtqg@mail.gmail.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
 <20180301101837.27969-14-jeffy.chen@rock-chips.com>
 <CAAFQd5D2SY2RV9HLTeTQigfnVCkF9wDq74_+t3OV2YEb9wJtqg@mail.gmail.com>
Message-ID: <0cd81b39-ffe9-eda3-1358-13afeb2ec25b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/18 13:49, Tomasz Figa wrote:
[...]
>> @@ -518,7 +520,12 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>>          u32 int_status;
>>          dma_addr_t iova;
>>          irqreturn_t ret = IRQ_NONE;
>> -       int i;
>> +       int i, err, need_runtime_put;
> 
> nit: need_runtime_put could be a bool.
> 
>> +
>> +       err = pm_runtime_get_if_in_use(iommu->dev);
>> +       if (err <= 0 && err != -EINVAL)
>> +               return ret;
>> +       need_runtime_put = err > 0;
> 
> Generally something must be really wrong if we end up with err == 0
> here, because the IOMMU must be powered on to signal an interrupt. The
> only case this could happen would be if the IRQ signal was shared with
> some device from another power domain. Is it possible on Rockchip
> SoCs? If not, perhaps we should have a WARN_ON() here for such case.

In general, there's almost certainly some time window between the 
interrupt level being latched at the GIC and the IRQ actually being 
taken by its target CPU, in which potentially the power could be removed 
and/or the clocks gated - especially if there are higher-priority IRQs 
pending at the same time and the racing PM call is on some other CPU. 
Sure, it's probably unlikely, but I wouldn't necessarily consider it 
completely erroneous.

Robin.
