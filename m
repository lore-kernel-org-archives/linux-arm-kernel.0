From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 12 Sep 2017 13:55:52 +0530
Subject: [PATCH v3 1/2] i2c: davinci: Add PM Runtime Support
In-Reply-To: <94b7a185-4cde-03e6-cc17-f64d5d28c9f2@ti.com>
References: <20170908175448.3367-1-fcooper@ti.com>
 <20170908175448.3367-2-fcooper@ti.com>
 <57153767-6dee-a5b5-548c-f7b0dc104b46@ti.com>
 <f185afb9-e877-1916-fcbc-c2a28f23b0cc@ti.com>
 <94b7a185-4cde-03e6-cc17-f64d5d28c9f2@ti.com>
Message-ID: <5d8778d8-281c-8926-fec3-f9acf82e342c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 September 2017 01:41 AM, Grygorii Strashko wrote:
> 
> 
> On 09/11/2017 03:07 PM, Franklin S Cooper Jr wrote:
>>
>>
>> On 09/11/2017 06:29 AM, Sekhar Nori wrote:
>>> On Friday 08 September 2017 11:24 PM, Franklin S Cooper Jr wrote:
>>>> 66AK2G has I2C instances that are not apart of the ALWAYS_ON power domain
>>>> like other Keystone 2 SoCs and OMAPL138. Therefore, pm_runtime
>>>
>>> unlike ?
>>>
>>>> is required to insure the power domain used by the specific I2C instance is
>>>> properly turned on along with its functional clock.
>>>>
>>>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>>>> ---
>>>> Version 3 changes:
>>>> Remove several statements that set clk to NULL
>>>> Fix error path
>>>>
>>>>   drivers/i2c/busses/i2c-davinci.c | 64 +++++++++++++++++++++++++++++++++-------
>>>>   1 file changed, 53 insertions(+), 11 deletions(-)
>>>
>>>> @@ -802,12 +821,22 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>>>>   	dev->clk = devm_clk_get(&pdev->dev, NULL);
>>>>   	if (IS_ERR(dev->clk))
>>>>   		return PTR_ERR(dev->clk);
>>>> -	clk_prepare_enable(dev->clk);
>>>>   
>>>>   	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>   	dev->base = devm_ioremap_resource(&pdev->dev, mem);
>>>>   	if (IS_ERR(dev->base)) {
>>>> -		r = PTR_ERR(dev->base);
>>>> +		return PTR_ERR(dev->base);
>>>> +	}
>>>> +
>>>> +	pm_runtime_set_autosuspend_delay(dev->dev,
>>>> +					 DAVINCI_I2C_PM_TIMEOUT);
>>>> +	pm_runtime_use_autosuspend(dev->dev);
>>>> +
>>>> +	pm_runtime_enable(dev->dev);
>>>> +
>>>> +	r = pm_runtime_get_sync(dev->dev);
>>>> +	if (r < 0) {
>>>> +		dev_err(dev->dev, "failed to runtime_get device: %d\n", r);
>>>>   		goto err_unuse_clocks;
>>>
>>> You end up doing a pm_runtime_put_sync() on failure here, instead of
>>> pm_runtime_put_noidle() like rest of the patch.
>>>
>>> May be handle this failure here instead of relying on the goto path.
>>
>> Ok
> 
> I think, it's not necessary - pm_runtime_put_sync() can be used in this case
>  (and used the same way in many other drivers).
> In case, of failure in this place - pm_runtime_put_sync() will just decrement usage counter.

Can you please explain why this is the case? At least on DA850, I see
the runtime_idle callback invoked from rpm_idle() if
pm_runtime_put_sync() is used in the failure path.

Thanks
Sekhar
