From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 02 Feb 2012 15:59:20 +0200
Subject: [RFC 7/7] MFD: TWL6040: Add regulator support for VIO,
 V2V1 supplies
In-Reply-To: <20120202133207.GN7428@opensource.wolfsonmicro.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
 <1328185019-29575-8-git-send-email-peter.ujfalusi@ti.com>
 <20120202125250.GJ7428@opensource.wolfsonmicro.com> <4F2A8D11.9010705@ti.com>
 <20120202133207.GN7428@opensource.wolfsonmicro.com>
Message-ID: <4F2A96B8.2030004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2012 03:32 PM, Mark Brown wrote:
> That's not a problem for using the bulk get - the array is part of the
> API so you can use regulator_bulk_get() and still look at individual
> supplies within the array later on when enabling and disabling them.

For some reason I have associated the use of regulator_bulk_get with the
use of regulator_bulk_enable/disable. It did not even crossed my mind
that I can still use regulator_enable on the individual regulators.
Will convert the regulator_get/put to bulk operations. It will make the
code a bit cleaner.
Thanks

>>>> +	ret = regulator_enable(twl6040->vio);
>>>> +	if (ret != 0) {
>>>> +		dev_err(&client->dev, "Failed to enable VIO: %d\n", ret);
>>>> +		goto power_err;
>>>> +	}
>>>> +	ret = regulator_enable(twl6040->v2v1);
>>>> +	if (ret != 0) {
>>>> +		dev_err(&client->dev, "Failed to enable V2V1: %d\n", ret);
>>>> +		regulator_disable(twl6040->vio);
> 
>> I disable the vio here, if the v2v1 enable fails.
> 
> Oh, that's quite confusing when mixed in with the goto/unwind - it'd be
> clearer to have the extra lable to jump to.

I guess this is a matter of taste.
However I have found some inconsistent naming with the exit labels,
which I'm going to fix for the next series.

-- 
P?ter
