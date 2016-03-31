From: david@lechnology.com (David Lechner)
Date: Thu, 31 Mar 2016 17:28:48 -0500
Subject: [PATCH v3 15/16] usb: musb: da8xx: Use devm in probe
In-Reply-To: <20160331222112.GA28044@uda0271908>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-16-git-send-email-david@lechnology.com>
 <20160331222112.GA28044@uda0271908>
Message-ID: <56FDA4A0.6080106@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2016 05:21 PM, Bin Liu wrote:

>> -	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
>> +	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
>>   	if (!glue) {
>>   		dev_err(&pdev->dev, "failed to allocate glue context\n");
>> -		goto err0;
>> +		return -ENOMEM;
>>   	}
>>
>> -	clk = clk_get(&pdev->dev, "usb20");
>> +	clk = devm_clk_get(&pdev->dev, "usb20");
>>   	if (IS_ERR(clk)) {
>>   		dev_err(&pdev->dev, "failed to get clock\n");
>> -		ret = PTR_ERR(clk);
>> -		goto err3;
>> +		return PTR_ERR(clk);
>
> memory leak due to not kfree(glue).

It is my understanding that since glue is allocated with devm_kzalloc(), 
that if the probe function returns and error, glue and everything else 
allocated with devm_* will be automatically freed.

If this is not the case, wouldn't devm_kfree() be the appropriate 
function instead?


>> @@ -576,8 +569,6 @@ static int da8xx_remove(struct platform_device *pdev)
>>   	platform_device_unregister(glue->musb);
>>   	usb_phy_generic_unregister(glue->phy);
>>   	clk_disable(glue->clk);
>> -	clk_put(glue->clk);
>> -	kfree(glue);
>
> Doesn't match with $subject, I'd put them into a seperate patch.


I disagree. Since these are now automatically freed because of changes 
in the probe function, these changes belong in the same patch.
