From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 27 Apr 2018 10:23:35 +0100
Subject: [linux-sunxi] [PATCH 1/3] mmc: sunxi: add support for the MMC
 controller on H6
In-Reply-To: <EECAFDD1-FEAC-42DF-BB17-F11C1C8612DE@aosc.io>
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-2-icenowy@aosc.io>
 <f722ce51-2391-620c-df65-48f047b5f3d5@arm.com>
 <EECAFDD1-FEAC-42DF-BB17-F11C1C8612DE@aosc.io>
Message-ID: <fbc00944-71f3-fb38-e4c9-582bc2ff3dc9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27/04/18 09:38, Icenowy Zheng wrote:
> 
> 
> ? 2018?4?27? GMT+08:00 ??12:45:24, Andre Przywara <andre.przywara@arm.com> ??:
>> Hi,
>>
>> On 26/04/18 15:07, Icenowy Zheng wrote:
>>> The new Allwinner H6 SoC have 3 MMC controllers. The first and second
>>> ones are similar to the ones on A64, but the third one adds EMCE
>>> (Embedded Crypto Engine) support which does hardware transparent
>> crypto
>>> on the eMMC.
>>>
>>> As we still do not have support for EMCE, and the support of it is
>>> disabled by defualt, we just duplicate the A64 mmc configurations and
>>> change the compatible string.
>>
>> So if the A64 MMC part is compatible, we should express it like this:
>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  2 ++
>>>  drivers/mmc/host/sunxi-mmc.c                        | 16
>> ++++++++++++++++
>>>  2 files changed, 18 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>> b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>>> index 132e0007d7d6..e6aa5c7a5e12 100644
>>> --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>>> @@ -16,6 +16,8 @@ Required properties:
>>>     * "allwinner,sun9i-a80-mmc"
>>>     * "allwinner,sun50i-a64-emmc"
>>>     * "allwinner,sun50i-a64-mmc"
>>> +   * "allwinner,sun50i-h6-emmc"
>>> +   * "allwinner,sun50i-h6-mmc"
>>
>> This should be changed to:
>>
>>      * "allwinner,sun50i-h6-emmc", "allwinner,sun50i-a64-emmc"
>>      * "allwinner,sun50i-h6-mmc", "allwinner,sun50i-a64-mmc"
> 
> This list shouldn't list pairs,

It should, as this is what Rob suggested the other day:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/564752.html

Cheers,
Andre.

> and as I said in the reply,
> these pairs are not valid.
> 
>>
>>>   - reg : mmc controller base registers
>>>   - clocks : a list with 4 phandle + clock specifier pairs
>>>   - clock-names : must contain "ahb", "mmc", "output" and "sample"
>>> diff --git a/drivers/mmc/host/sunxi-mmc.c
>> b/drivers/mmc/host/sunxi-mmc.c
>>> index 97c6b79b7d6f..05e2b5fd7aa4 100644
>>> --- a/drivers/mmc/host/sunxi-mmc.c
>>> +++ b/drivers/mmc/host/sunxi-mmc.c
>>> @@ -1168,6 +1168,20 @@ static const struct sunxi_mmc_cfg
>> sun50i_a64_emmc_cfg = {
>>>  	.can_calibrate = true,
>>>  };
>>>  
>>> +static const struct sunxi_mmc_cfg sun50i_h6_cfg = {
>>> +	.idma_des_size_bits = 16,
>>> +	.clk_delays = NULL,
>>> +	.can_calibrate = true,
>>> +	.mask_data0 = true,
>>> +	.needs_new_timings = true,
>>> +};
>>> +
>>> +static const struct sunxi_mmc_cfg sun50i_h6_emmc_cfg = {
>>> +	.idma_des_size_bits = 13,
>>> +	.clk_delays = NULL,
>>> +	.can_calibrate = true,
>>> +};
>>> +
>>
>> ... and then we don't need those changes ...
>>
>>>  static const struct of_device_id sunxi_mmc_of_match[] = {
>>>  	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg
>> },
>>>  	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg
>> },
>>> @@ -1176,6 +1190,8 @@ static const struct of_device_id
>> sunxi_mmc_of_match[] = {
>>>  	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg
>> },
>>>  	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg
>> },
>>>  	{ .compatible = "allwinner,sun50i-a64-emmc", .data =
>> &sun50i_a64_emmc_cfg },
>>> +	{ .compatible = "allwinner,sun50i-h6-mmc", .data = &sun50i_h6_cfg
>> },
>>> +	{ .compatible = "allwinner,sun50i-h6-emmc", .data =
>> &sun50i_h6_emmc_cfg },
>>
>> ... and those, at least yet.
>> Should we ever extend the driver to support the EMCE, we can add them
>> at
>> this occasion.
>>
>> So this patch would just add the compatible pairs to the binding doc.
>>
>> Cheers,
>> Andre.
>>
>>>  	{ /* sentinel */ }
>>>  };
>>>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
>>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
