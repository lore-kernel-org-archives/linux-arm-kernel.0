From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Mon, 21 Sep 2015 09:58:59 +0530
Subject: [PATCH v2 4/9] clk: qcom: create virtual child device for TSENS
In-Reply-To: <20150916223925.GP23081@codeaurora.org>
References: <1442384603-26053-1-git-send-email-rnayak@codeaurora.org>
 <1442384603-26053-5-git-send-email-rnayak@codeaurora.org>
 <20150916223925.GP23081@codeaurora.org>
Message-ID: <55FF878B.5010009@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/17/2015 04:09 AM, Stephen Boyd wrote:
> On 09/16, Rajendra Nayak wrote:
>> @@ -3520,7 +3522,26 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
>>   	if (IS_ERR(clk))
>>   		return PTR_ERR(clk);
>>
>> -	return qcom_cc_probe(pdev, match->data);
>> +	ret = qcom_cc_probe(pdev, match->data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	tsens = platform_device_alloc("qcom-tsens", -1);
>> +	if (!tsens) {
>> +		ret = -ENOMEM;
>> +		goto err_alloc;
>> +	}
>> +
>> +	tsens->dev.parent = &pdev->dev;
>> +	ret = platform_device_add(tsens);
>> +	if (ret)
>> +		goto err_add;
>
> platform_device_register_data() instead of all these lines? We
> should probably remove the device when this driver is removed
> too.

Thanks Stephen, I'll fix it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
