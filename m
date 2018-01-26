From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Fri, 26 Jan 2018 17:45:31 +0800
Subject: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
In-Reply-To: <f06d2d9f-3869-ed02-43f4-f4ea4a104a57@arm.com>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
 <20180124103516.2571-9-jeffy.chen@rock-chips.com>
 <f06d2d9f-3869-ed02-43f4-f4ea4a104a57@arm.com>
Message-ID: <5A6AF8BB.4040601@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Thanks for your reply.

On 01/24/2018 09:49 PM, Robin Murphy wrote:
>>
>> +Optional properties:
>> +- clocks : A list of master clocks requires for the IOMMU to be
>> accessible
>
> s/requires/required/
ok
>
>> +           by the host CPU. The number of clocks depends on the master
>> +           block and might as well be zero. See [1] for generic clock
>
> Oops, some subtleties of English here :)
>
> To say "the number of clocks ... might as well be zero" effectively
> implies "there's no point ever specifying any clocks". I guess what you
> really mean here is "...might well be...", i.e. it is both valid and
> reasonably likely to require zero clocks.
ok
>
>> +           bindings description.
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>>   Optional properties:
>>   - rockchip,disable-mmu-reset : Don't use the mmu reset operation.
>> @@ -27,5 +34,6 @@ Example:
>>           reg = <0xff940300 0x100>;
>>           interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>>           interrupt-names = "vopl_mmu";
>> +        clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
>>           #iommu-cells = <0>;
>>       };
>> diff --git a/drivers/iommu/rockchip-iommu.c
>> b/drivers/iommu/rockchip-iommu.c
>> index c4131ca792e0..8a5e2a659b67 100644
>> --- a/drivers/iommu/rockchip-iommu.c
>> +++ b/drivers/iommu/rockchip-iommu.c
>> @@ -4,6 +4,7 @@
>>    * published by the Free Software Foundation.
>>    */
>> +#include <linux/clk.h>
>>   #include <linux/compiler.h>
>>   #include <linux/delay.h>
>>   #include <linux/device.h>
>> @@ -91,6 +92,8 @@ struct rk_iommu {
>>       struct device *dev;
>>       void __iomem **bases;
>>       int num_mmu;
>> +    struct clk_bulk_data *clocks;
>> +    int num_clocks;
>>       bool reset_disabled;
>>       struct iommu_device iommu;
>>       struct list_head node; /* entry in rk_iommu_domain.iommus */
>> @@ -450,6 +453,38 @@ static int rk_iommu_force_reset(struct rk_iommu
>> *iommu)
>>       return 0;
>>   }
>> +static int rk_iommu_of_get_clocks(struct rk_iommu *iommu)
>> +{
>> +    struct device_node *np = iommu->dev->of_node;
>> +    int ret;
>> +    int i;
>> +
>> +    ret = of_count_phandle_with_args(np, "clocks", "#clock-cells");
>> +    if (ret == -ENOENT)
>> +        return 0;
>> +    else if (ret < 0)
>> +        return ret;
>> +
>> +    iommu->num_clocks = ret;
>> +    iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
>> +                     sizeof(*iommu->clocks), GFP_KERNEL);
>> +    if (!iommu->clocks)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < iommu->num_clocks; ++i) {
>> +        iommu->clocks[i].clk = of_clk_get(np, i);
>> +        if (IS_ERR(iommu->clocks[i].clk)) {
>> +            ret = PTR_ERR(iommu->clocks[i].clk);
>> +            goto err_clk_put;
>> +        }
>> +    }
>
> Just to confirm my understanding from a quick scan through the code, the
> reason we can't use clk_bulk_get() here is that currently, clocks[i].id
> being NULL means we'd end up just getting the first clock multiple
> times, right?
right, without a valid name, it would return the first clock.

     /* Walk up the tree of devices looking for a clock that matches */
     while (np) {
         int index = 0;

         /*
          * For named clocks, first look up the name in the
          * "clock-names" property.  If it cannot be found, then
          * index will be an error code, and of_clk_get() will fail.
          */
         if (name)
             index = of_property_match_string(np, "clock-names", name);
         clk = __of_clk_get(np, index, dev_id, name);


>
> I guess there could be other users who also want "just get whatever
> clocks I have" functionality, so it might be worth proposing that for
> the core API as a separate/follow-up patch, but it definitely doesn't
> need to be part of this series.
right, i can try to do it later :)
>
> I really don't know enough about correct clk API usage, but modulo the
> binding comments it certainly looks nice and tidy now;
>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
thanks.
>
> Thanks,
> Robin.
