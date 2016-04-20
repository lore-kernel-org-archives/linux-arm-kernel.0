From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 20 Apr 2016 09:36:16 -0400
Subject: [PATCH 1/2] i2c: s3c2410: Print errno code in error logs
In-Reply-To: <5717455A.1000007@samsung.com>
References: <1461096641-19788-1-git-send-email-javier@osg.samsung.com>
 <5717455A.1000007@samsung.com>
Message-ID: <571785D0.8090808@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

Thanks a lot for your feedback.

On 04/20/2016 05:01 AM, Krzysztof Kozlowski wrote:
> On 04/19/2016 10:10 PM, Javier Martinez Canillas wrote:
>> The driver not always prints the error code in case of a failure but this
>> information can be very useful for debugging. So let's print if available.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> ---
>>
>> Hello,
>>
>> This patch and 2/2 were only build tested because I don't have access to
>> a board using this IP block. I just noticed these issues when comparing
>> the i2c-s3c2410 driver with i2c-exynos5 where I did some fixes recently.
>>
>> I think the patches are simple enough that is safe to pick them but of
>> course testing will be highly appreciated.
>>
>> Best regards,
>> Javier
>>
>>  drivers/i2c/busses/i2c-s3c2410.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
>> index 362a6de54833..4b873fe9a75b 100644
>> --- a/drivers/i2c/busses/i2c-s3c2410.c
>> +++ b/drivers/i2c/busses/i2c-s3c2410.c
>> @@ -944,7 +944,7 @@ static int s3c24xx_i2c_cpufreq_transition(struct notifier_block *nb,
>>  		i2c_unlock_adapter(&i2c->adap);
>>  
>>  		if (ret < 0)
>> -			dev_err(i2c->dev, "cannot find frequency\n");
>> +			dev_err(i2c->dev, "cannot find frequency (%d)\n", ret);
>>  		else
>>  			dev_info(i2c->dev, "setting freq %d\n", got);
>>  	}
>> @@ -995,7 +995,8 @@ static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
>>  
>>  		ret = gpio_request(gpio, "i2c-bus");
>>  		if (ret) {
>> -			dev_err(i2c->dev, "gpio [%d] request failed\n", gpio);
>> +			dev_err(i2c->dev, "gpio [%d] request failed (%d)\n",
>> +				gpio, ret);
>>  			goto free_gpio;
>>  		}
>>  	}
> 
> The changes above are okay. Below - do not make sense. Just think...
> What do you want to improve? The probe failure already prints errno!
>
> 
> Just look at crafted example (error triggered manually):
> [    0.135443] s3c-i2c 13860000.i2c: I2C clock enable failed (-100)
> [    0.135484] s3c-i2c: probe of 13860000.i2c failed with error -100
>

Sorry, I missed that. I should had looked more carefully to the call path...

I'll post a v2 with only the changes that makes sense.

> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
