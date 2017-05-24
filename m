From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 24 May 2017 10:54:44 +0900
Subject: [PATCH v1] PM / devfreq: exynos-ppmu : Handle return value of
 clk_prepare_enable
In-Reply-To: <20170524013036epcms1p3f5ced11e6ebe5664ce70718dedcf8de1@epcms1p3>
References: <592403E7.8060906@samsung.com>
 <1495191364-16015-1-git-send-email-arvind.yadav.cs@gmail.com>
 <CGME20170519105745epcas5p29a5cbb259cd15138d7220f34e130e00a@epcms1p3>
 <20170524013036epcms1p3f5ced11e6ebe5664ce70718dedcf8de1@epcms1p3>
Message-ID: <5924E7E4.5020900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017? 05? 24? 10:30, MyungJoo Ham wrote:
>> On 2017? 05? 19? 19:56, Arvind Yadav wrote:
>>> clk_prepare_enable() can fail here and we must check its return value.
>>>
>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>> ---
>>>  drivers/devfreq/event/exynos-ppmu.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>>> index 9b73509..8f6537a 100644
>>> --- a/drivers/devfreq/event/exynos-ppmu.c
>>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>>> @@ -648,7 +648,11 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>>>  			dev_name(&pdev->dev), desc[i].name);
>>>  	}
>>>  
>>> -	clk_prepare_enable(info->ppmu.clk);
>>> +	ret = clk_prepare_enable(info->ppmu.clk);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "failed to prepare ppmu clock\n");
>>> +		return ret;
>>> +	}
>>
>> You're right. But, actually, some ppmu device-tree node doesn't include
>> the clock information because exynos clk driver don't support the
>> clock for some ppmu devices. Until now, the clock of ppmu devices
>> are default on state.
> 
> If it does not include the clock information, info->ppmu.clk is NULL,
> which makes ret == NULL, so this should be ok.
> (Line 593 of this file does that.)

Ah.. You're right. I'm missing this point.

Looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
