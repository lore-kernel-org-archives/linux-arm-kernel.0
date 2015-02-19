From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 19 Feb 2015 11:11:58 +0000
Subject: [PATCH 2/2] regmap: Add range check in _regmap_raw_write()
In-Reply-To: <20150219103156.GD3198@finisterre.sirena.org.uk>
References: <1424335193-7431-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424335255-7517-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150219103156.GD3198@finisterre.sirena.org.uk>
Message-ID: <54E5C4FE.5080604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/02/15 10:31, Mark Brown wrote:
> On Thu, Feb 19, 2015 at 08:40:55AM +0000, Srinivas Kandagatla wrote:
>> regmap_bulk_write() ends up using the path that invokes _regmap_raw_write(),
>> however _regmap_raw_write() never checks if the registers that are accessed
>> are actually within the accessible range. This results in kernel crashes when
>> trying to access registers beyond max_registers.
>>
>> This patch just adds check before accessing the register range.
>
>>   	/* Check for unwritable registers before we start */
>> -	if (map->writeable_reg)
>> -		for (i = 0; i < val_len / map->format.val_bytes; i++)
>> -			if (!map->writeable_reg(map->dev,
>> -						reg + (i * map->reg_stride)))
>> -				return -EINVAL;
>> +	for (i = 0; i < count; i++)
>> +		if (!regmap_writeable(map, reg + (i * map->reg_stride)))
>> +			return -EINVAL;
>
> Your changelog doesn't correspond to what the code is actually doing
> here...  what you're actually doing here is replacing an open coding of
> regmap_writeable() with calls to the function.
>
> The same papering over the cracks concerns do apply here as well, it's
> not immediately obvious that this is a good fix for the issue you
> describe.
Only reason for me to send this patch was that fact that 
_regmap_raw_write() also suffers from same issue as _regmap_raw_read(), 
which is "access beyond max_register".

Should I drop this patch?
Or
Adding similar check of max_register before the writing makes sense?


--srini
