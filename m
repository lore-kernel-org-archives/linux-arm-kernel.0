From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 02 Feb 2012 15:18:09 +0200
Subject: [RFC 7/7] MFD: TWL6040: Add regulator support for VIO,
 V2V1 supplies
In-Reply-To: <20120202125250.GJ7428@opensource.wolfsonmicro.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
 <1328185019-29575-8-git-send-email-peter.ujfalusi@ti.com>
 <20120202125250.GJ7428@opensource.wolfsonmicro.com>
Message-ID: <4F2A8D11.9010705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2012 02:52 PM, Mark Brown wrote:
> On Thu, Feb 02, 2012 at 02:16:59PM +0200, Peter Ujfalusi wrote:
> 
>> +	twl6040->vio = regulator_get(&client->dev, "vio");
>> +	if (IS_ERR(twl6040->vio)) {
>> +		ret = PTR_ERR(twl6040->vio);
>> +		dev_err(&client->dev, "Failed to request VIO supply: %d\n",
>> +			ret);
>> +		goto regulator_get_err;
>> +	}
>> +	twl6040->v2v1 = regulator_get(&client->dev, "v2v1");
>> +	if (IS_ERR(twl6040->v2v1)) {
>> +		ret = PTR_ERR(twl6040->v2v1);
>> +		dev_err(&client->dev, "Failed to request V2V1 supply: %d\n",
>> +			ret);
>> +		regulator_put(twl6040->vio);
>> +		goto regulator_get_err;
>> +	}
> 
> Looks like you want regulator_bulk_get() here.  Or (better yet though
> it'd be a potential issue for merge via MFD and the benefits aren't that
> exciting since you still need to disable) devm_regulator_bulk_get().

I need separate control for the two power source since we can hit
different power levels depending on which is powered/not powered:
power down: vio, v2v1 is OFF
deep sleep: vio is ON, v2v1 is OFF
sleep/power on: vio, v2v1 is ON

And we have certain sequence to move between power states.

> 
>> +	ret = regulator_enable(twl6040->vio);
>> +	if (ret != 0) {
>> +		dev_err(&client->dev, "Failed to enable VIO: %d\n", ret);
>> +		goto power_err;
>> +	}
>> +	ret = regulator_enable(twl6040->v2v1);
>> +	if (ret != 0) {
>> +		dev_err(&client->dev, "Failed to enable V2V1: %d\n", ret);
>> +		regulator_disable(twl6040->vio);

I disable the vio here, if the v2v1 enable fails.

>> +		goto power_err;
>> +	}
> 
> Similarly regulator_bulk_enable() here, and it'll fix...
> 
>>  gpio1_err:
>> +	regulator_disable(twl6040->v2v1);
>> +	regulator_disable(twl6040->vio);
> 
> ...the fact that if you fail to enable the v2.1 regulator you don't
> disable vio.

It is handled within the if(){}
With the devm_regulator this will be much nicer for sure.

-- 
P?ter
