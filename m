From: nm@ti.com (Nishanth Menon)
Date: Fri, 24 Jun 2016 11:46:58 -0500
Subject: [PATCH] hwrng: OMAP: Fix assumption that runtime_get_sync will
 always succeed
In-Reply-To: <576D6156.2050508@ti.com>
References: <1466783867-25743-1-git-send-email-nm@ti.com>
 <576D6156.2050508@ti.com>
Message-ID: <576D6402.1090201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2016 11:35 AM, Suman Anna wrote:
[...]
>> diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
>> index 8a1432e8bb80..f30a1870cb64 100644
>> --- a/drivers/char/hw_random/omap-rng.c
>> +++ b/drivers/char/hw_random/omap-rng.c
>> @@ -384,7 +384,11 @@ static int omap_rng_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	pm_runtime_enable(&pdev->dev);
>> -	pm_runtime_get_sync(&pdev->dev);
>> +	ret = pm_runtime_get_sync(&pdev->dev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to runtime_get device: %d\n", ret);
>> +		goto err_ioremap;
> 
> You need to also add a pm_runtime_put_noidle() on get_sync failures to
> balance the device's power usage_count.
> 

Crap, yep, I should have known better. thanks for catching it.. v2
incoming..


-- 
Regards,
Nishanth Menon
