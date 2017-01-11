From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 10 Jan 2017 17:30:21 -0700
Subject: [PATCH] usb: dwc3-exynos fix axius clock error path to do cleanup
In-Reply-To: <e4f0b77a-d827-08fa-c4f6-950197c54358@osg.samsung.com>
References: <20170110230528.7612-1-shuahkh@osg.samsung.com>
 <e4f0b77a-d827-08fa-c4f6-950197c54358@osg.samsung.com>
Message-ID: <c1938cd9-9bcf-d28b-48fd-be6a22a1f3f7@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2017 05:27 PM, Javier Martinez Canillas wrote:
> Hello Shuah,
> 
> Patch looks good to me, I've just one comment.
> 
> On 01/10/2017 08:05 PM, Shuah Khan wrote:
>> Axius clock error path returns without disabling clock and suspend clock.
>> Fix it to disable them before returning error.
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>  drivers/usb/dwc3/dwc3-exynos.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
>> index 3e8407a..f7421c2 100644
>> --- a/drivers/usb/dwc3/dwc3-exynos.c
>> +++ b/drivers/usb/dwc3/dwc3-exynos.c
>> @@ -136,7 +136,8 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>  		exynos->axius_clk = devm_clk_get(dev, "usbdrd30_axius_clk");
>>  		if (IS_ERR(exynos->axius_clk)) {
>>  			dev_err(dev, "no AXI UpScaler clk specified\n");
>> -			return -ENODEV;
>> +			ret = -ENODEV;
>> +			goto axius_clk_err;
>>  		}
>>  		clk_prepare_enable(exynos->axius_clk);
>>  	} else {
>> @@ -194,6 +195,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>  	regulator_disable(exynos->vdd33);
>>  err2:
>>  	clk_disable_unprepare(exynos->axius_clk);
>> +axius_clk_err:
> 
> This label isn't consistent with the others, I know the errN aren't great
> so what about changing those to meaningful names in a preparatory patch?
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Best regards,
> 

Javier,

Right they aren't consistent. Changing them all to a better naming scheme
will have be done in another cleanup patch in my opinion. I don't want to
include cleanup in this fix.

thanks,
-- Shuah
