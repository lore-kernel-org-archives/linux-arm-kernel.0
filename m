From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 08 Jan 2014 12:20:00 +0000
Subject: [PATCH 3/4] thermal: rcar: Add missing clock handling
In-Reply-To: <20140107205719.GL20094@book.gsilab.sittig.org>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
 <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
 <20140107205719.GL20094@book.gsilab.sittig.org>
Message-ID: <52CD4270.3010907@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/14 20:57, Gerhard Sittig wrote:
> On Tue, Jan 07, 2014 at 19:57 +0100, Geert Uytterhoeven wrote:
>>
>> @@ -378,23 +380,38 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>>   	spin_lock_init(&common->lock);
>>   	common->dev = dev;
>>
>> +	common->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(common->clk)) {
>> +		dev_err(&pdev->dev, "cannot get clock\n");
>> +		return PTR_ERR(common->clk);
>> +	}
>> +
>> +	ret = clk_prepare(common->clk);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "unable to prepare clock\n");
>> +		return ret;
>> +	}
>> +
>> +	clk_enable(common->clk);
>> +
>>   	pm_runtime_enable(dev);
>>   	pm_runtime_get_sync(dev);
>
> clk_enable() can fail, too, so you should check its return value

Also, if you enable the pm-runtime then the device clock is actually
handled by the common pm-clock framework.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
