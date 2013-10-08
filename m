From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 8 Oct 2013 18:45:05 +0530
Subject: [PATCH V2] clk: palmas: add clock driver for palmas
In-Reply-To: <20131008010237.7445.32387@quantum>
References: <1381154751-4565-1-git-send-email-ldewangan@nvidia.com>
 <20131008010237.7445.32387@quantum>
Message-ID: <52540559.6030406@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 October 2013 06:32 AM, Mike Turquette wrote:
> Quoting Laxman Dewangan (2013-10-07 07:05:51)
>> +               if (!ret) {
>> +                       switch (prop) {
>> +                       case 1:
>> +                               prop = PALMAS_EXT_CONTROL_ENABLE1;
>> +                               break;
>> +                       case 2:
>> +                               prop = PALMAS_EXT_CONTROL_ENABLE2;
>> +                               break;
>> +                       case 3:
>> +                               prop = PALMAS_EXT_CONTROL_NSLEEP;
>> +                               break;
> Can magic numbers be replaced with defines?
Fine, will do in V3.

>
>
> +
> +       ret = palmas_update_bits(palmas_clks->palmas, PALMAS_RESOURCE_BASE,
> +                       cinfo->clk_desc->control_reg,
> +                       cinfo->clk_desc->sleep_mask, 0);
> What does this call to palmas_update_bits do?

This APIs update the selected bits based on mask. This is wrapper over 
the regmap_update_bits() to provide the interface at the Palmas register 
access.
The palmas registers are paged on different i2c address and offset. The 
i2c address and offset is decided based on base_address and offset.
This APIs does all calculation to get the correct i2c slave address and 
offset address based on argument.

>> +static int palmas_clks_remove(struct platform_device *pdev)
>> +{
>> +       of_clk_del_provider(pdev->dev.of_node);
> I'll be taking Sylwester's clock deregistration series after he
> publishes the next version, so if you want to call clk_unregister here
> (based on the new call) you could.
>
> If you want to add that in a later patch it is OK.

Thanks for pointing me this changes. I like to add this on my follow on 
(later) patch, not on this. -- 1.7.1.1
