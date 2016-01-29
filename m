From: wdc@rock-chips.com (David.Wu)
Date: Fri, 29 Jan 2016 19:35:23 +0800
Subject: [PATCH v2] pinctrl: rockchip: add support for the rk3399
In-Reply-To: <7536813.E6m4KCLL9V@diego>
References: <1451997055-47655-1-git-send-email-wdc@rock-chips.com>
 <1452152498-21780-1-git-send-email-wdc@rock-chips.com>
 <7536813.E6m4KCLL9V@diego>
Message-ID: <56AB4E7B.2060807@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

? 2016/1/29 0:56, Heiko St?bner ??:
> Hi David,
>
> Am Donnerstag, 7. Januar 2016, 15:41:38 schrieb David Wu:
>> From: David Wu <david.wu@rock-chips.com>
>>
>> The pinctrl of rk3399 is much different from other's,
>> especially the 3bits of drive strength.
>>
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> ---
>> change from v1:
>> - need spin_unlock_irqrestore for set drive default case
>>
>>   .../bindings/pinctrl/rockchip,pinctrl.txt          |   1 +
>>   drivers/pinctrl/pinctrl-rockchip.c                 | 339
>> ++++++++++++++++++++- 2 files changed, 326 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
>> b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt index
>> 391ef4b..3bb9456 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
>> @@ -22,6 +22,7 @@ Required properties for iomux controller:
>>     - compatible: one of "rockchip,rk2928-pinctrl",
>> "rockchip,rk3066a-pinctrl" "rockchip,rk3066b-pinctrl",
>> "rockchip,rk3188-pinctrl"
>>   		       "rockchip,rk3288-pinctrl", "rockchip,rk3368-pinctrl"
>> +		       "rockchip,rk3399-pinctrl"
>>     - rockchip,grf: phandle referencing a syscon providing the
>>   	 "general register files"
>>
>> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
>> b/drivers/pinctrl/pinctrl-rockchip.c index a065112..9d61c6e 100644
>> --- a/drivers/pinctrl/pinctrl-rockchip.c
>> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> [...]
>
>> @@ -685,19 +821,60 @@ static int rockchip_get_drive_perpin(struct
>> rockchip_pin_bank *bank, struct rockchip_pin_ctrl *ctrl = info->ctrl;
>>   	struct regmap *regmap;
>>   	int reg, ret;
>> -	u32 data;
>> +	u32 data, temp, rmask_bits;
>>   	u8 bit;
>> +	int drv_type = bank->drv[pin_num / 8].drv_type;
>>
>>   	ctrl->drv_calc_reg(bank, pin_num, &regmap, &reg, &bit);
>>
>> +	switch (drv_type) {
>> +	case DRV_TYPE_IO_1V8_3V0_AUTO:
>> +	case DRV_TYPE_IO_3V3_ONLY:
>> +		if (RK3399_DRV_3BITS_PER_PIN + bit >= 16) {
> According to the doc excerpts, wouldn't the big special handling only be
> necessary for for gpio3b5 alone (+ other banks) ... i.e. the one setting being
> split over both registers?

yes, only the pin5 setting of 3bits width bank is split over two registers.

> If so I think doing something like the following might be easier to
> understand? Same of course for the set-counterpart. [Beware if I missed up the
> indices somewhere :-)

yeap.
Seemed it is clearer to view by using following code.
I will have a try, thanks.

>
> rmask_bits = RK3399_DRV_3BITS_PER_PIN;
> switch(bit) {
> case 0 ... 12:
> 	/* regular case, nothing to do */
> 	break;
> case 15:
> 	/* drive-strength offset is special, as it is spread over 2 registers */
> 	ret = regmap_read(regmap, reg, &data);
> 	if (ret)
> 		return ret;
>
> 	ret = regmap_read(regmap, reg + 0x4, &temp);
> 	if (ret)
> 		return ret;
>
> 	/*
> 	 * the bit data[15] contains bit 0 of the value
> 	 * while temp[1:0] containts bits 2 and 1
> 	 */
> 	data >>= 15;
> 	temp &= 0x3;
> 	temp <<= 1;
> 	data |= temp;
>
> 	return rockchip_perpin_drv_list[drv_type][data];
> case 18 ... 21:
> 	/* setting fully enclosed in the second register */
> 	rmask_bits = RK3399_DRV_3BITS_PER_PIN;
> 	reg += 4;
> 	bit -= 18;
> }
>
>> +			/* need to read regs twice */
>> +			ret = regmap_read(regmap, reg, &temp);
>> +			if (ret)
>> +				return ret;
>> +
>> +			temp >>= bit;
>> +			rmask_bits = 16 - bit;
>> +			temp &= (1 << rmask_bits) - 1;
>> +
>> +			reg = reg + 0x4;
>> +			ret = regmap_read(regmap, reg, &data);
>> +			if (ret)
>> +				return ret;
>> +
>> +			rmask_bits = RK3399_DRV_3BITS_PER_PIN
>> +				+ bit - 16;
>> +			data &= (1 << rmask_bits) - 1;
>> +			data <<= 16 - bit;
>> +			data |= temp;
>> +
>> +			return rockchip_perpin_drv_list[drv_type][data];
>> +		}
>> +
>> +		rmask_bits = RK3399_DRV_3BITS_PER_PIN;
>> +		break;
>> +	case DRV_TYPE_IO_DEFAULT:
>> +	case DRV_TYPE_IO_1V8_OR_3V0:
>> +	case DRV_TYPE_IO_1V8_ONLY:
>> +		rmask_bits = RK3288_DRV_BITS_PER_PIN;
>> +		break;
>> +	default:
>> +		dev_err(info->dev, "unsupported pinctrl drive type: %d\n",
>> +			drv_type);
>> +		return -EINVAL;
>> +	}
>> +
>>   	ret = regmap_read(regmap, reg, &data);
>>   	if (ret)
>>   		return ret;
>>
>>   	data >>= bit;
>> -	data &= (1 << RK3288_DRV_BITS_PER_PIN) - 1;
>> +	data &= (1 << rmask_bits) - 1;
>>
>> -	return rockchip_perpin_drv_list[data];
>> +	return rockchip_perpin_drv_list[drv_type][data];
>>   }
>>
>>   static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
> [...]
>
>> @@ -729,8 +913,45 @@ static int rockchip_set_drive_perpin(struct
>> rockchip_pin_bank *bank,
>>
>>   	spin_lock_irqsave(&bank->slock, flags);
>>
>> +	switch (drv_type) {
>> +	case DRV_TYPE_IO_1V8_3V0_AUTO:
>> +	case DRV_TYPE_IO_3V3_ONLY:
>> +		if (RK3399_DRV_3BITS_PER_PIN + bit >= 16) {
>> +			/* need to write regs twice */
>> +			rmask_bits = 16 - bit;
>> +			/* enable the write to the equivalent lower bits */
>> +			data = ((1 << rmask_bits) - 1) << (bit + 16);
>> +			rmask = data | (data >> 16);
>> +			ret &= (1 << rmask_bits) - 1;
>> +			data |= (ret << bit);
>> +
>> +			ret = regmap_update_bits(regmap, reg, rmask, data);
>> +			if (ret)
>> +				return ret;
>> +
>> +			ret = i >> rmask_bits;
>> +			rmask_bits = RK3399_DRV_3BITS_PER_PIN + bit - 16;
>> +			reg = reg + 0x4;
>> +			bit = 0;
> Apart from a change similar to the above, should the setting maybe also
> directly return and not depend on the final write?

okay, i will do the simialr change to the above.

>> +		} else {
>> +			rmask_bits = RK3399_DRV_3BITS_PER_PIN;
>> +		}
>> +		break;
>> +	case DRV_TYPE_IO_DEFAULT:
>> +	case DRV_TYPE_IO_1V8_OR_3V0:
>> +	case DRV_TYPE_IO_1V8_ONLY:
>> +		rmask_bits = RK3288_DRV_BITS_PER_PIN;
>> +		break;
>> +	default:
>> +		spin_unlock_irqrestore(&bank->slock, flags);
>> +		dev_err(info->dev, "unsupported pinctrl drive type: %d\n",
>> +			drv_type);
>> +		return -EINVAL;
>> +
>> +	}
>> +
>>   	/* enable the write to the equivalent lower bits */
>> -	data = ((1 << RK3288_DRV_BITS_PER_PIN) - 1) << (bit + 16);
>> +	data = ((1 << rmask_bits) - 1) << (bit + 16);
>>   	rmask = data | (data >> 16);
>>   	data |= (ret << bit);
>>
> [...]
>
>> @@ -2208,6 +2461,62 @@ static struct rockchip_pin_ctrl rk3368_pin_ctrl = {
>>   		.drv_calc_reg		= rk3368_calc_drv_reg_and_bit,
>>   };
>>
>> +static struct rockchip_pin_bank rk3399_pin_banks[] = {
>> +	PIN_BANK_IOMUX_DRV_FLAGS_OFFSET(0, 32, "gpio0", IOMUX_SOURCE_PMU,
>> +					IOMUX_SOURCE_PMU,
>> +					IOMUX_SOURCE_PMU,
>> +					IOMUX_SOURCE_PMU,
>> +					DRV_TYPE_IO_1V8_ONLY,
>> +					DRV_TYPE_IO_1V8_ONLY,
>> +					0,
>> +					0,
> DRV_TYPE_IO_DEFAULT instead of 0 please.
>
>
>
>
