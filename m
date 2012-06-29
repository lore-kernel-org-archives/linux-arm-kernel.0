From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Fri, 29 Jun 2012 18:25:30 +0530
Subject: [PATCH] I2C: OMAP: fix runtime PM get/put balance on error
In-Reply-To: <874npunx6a.fsf@ti.com>
References: <1340960868-7371-1-git-send-email-shubhrajyoti@ti.com>
 <874npunx6a.fsf@ti.com>
Message-ID: <4FEDA5C2.3000905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 June 2012 05:32 PM, Kevin Hilman wrote:
> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
>
>>     ensure pm_runtime_put() is called, on pm_runtime_get_sync()
>>     failure.
>>
>>     Without this, after a failed call, the runtime PM usecount will have
>>     been incremented, but not decremented causing the usecount to never
>>     reach zero after a failure. Thanks to Kevin for educating about it. 
>>     While at it also fix a missing pm_runtime_disable in the probe error
>>     path.
> This is the same subject and changelog as the patch I sent, but is a
> different patch.  
>
> Please write a new subject and a changelog specific to your patch.
OK.
Actually I did that on purpose your patch fixed the xfer call only.
I thought that since get_sync increments the count always we could extend
the patch to all the callers.
>
> As this changes the error/failure path, please be specific about how
> the failure modes were tested, and on which platforms.
I found and fixed by review only.
Didnt really hit the failure case.
>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>>  drivers/i2c/busses/i2c-omap.c |    7 +++----
>>  1 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 2500f19..c8e5c76 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -1113,10 +1113,10 @@ err_free_irq:
>>  	free_irq(dev->irq, dev);
>>  err_unuse_clocks:
>>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>> +err_free_mem:
>>  	pm_runtime_put(dev->dev);
>>  	iounmap(dev->base);
> This doesn't look right.  At least one of the gotos for this label, the
> ioremap has failed.
Yes , missed that thanks will fix it.
>
>>  	pm_runtime_disable(&pdev->dev);
>> -err_free_mem:
>>  	platform_set_drvdata(pdev, NULL);
>>  	kfree(dev);
>>  err_release_region:
>> @@ -1136,10 +1136,9 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
>>  	free_irq(dev->irq, dev);
>>  	i2c_del_adapter(&dev->adapter);
>>  	ret = pm_runtime_get_sync(&pdev->dev);
>> -	if (IS_ERR_VALUE(ret))
>> -		return ret;
>> +	if (!IS_ERR_VALUE(ret))
>> +		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> this change isn't described in changelog
Will do so.
>
>> -	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>>  	pm_runtime_put(&pdev->dev);
>>  	pm_runtime_disable(&pdev->dev);
>>  	iounmap(dev->base);
> Kevin
