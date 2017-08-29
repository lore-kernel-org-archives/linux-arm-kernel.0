From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 29 Aug 2017 11:04:43 +0200
Subject: [Bug] ARM: cpuidle: possible memleak
In-Reply-To: <299133306.50715.1503747980116@email.1und1.de>
References: <1980049531.494543.1502543973258@email.1und1.de>
 <20170813035040.GA13637@leoy-linaro>
 <37728512.316309.1502619006183@email.1und1.de>
 <299133306.50715.1503747980116@email.1und1.de>
Message-ID: <7a5e668d-61dc-90f2-deae-36ef3398af07@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/2017 13:46, Stefan Wahren wrote:

[ ... ]

>> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
>> index 7080c38..827ab25 100644
>> --- a/drivers/cpuidle/cpuidle-arm.c
>> +++ b/drivers/cpuidle/cpuidle-arm.c
>> @@ -104,12 +104,14 @@ static int __init arm_idle_init(void)
>>  		ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
>>  		if (ret <= 0) {
>>  			ret = ret ? : -ENODEV;
>> +			kfree(drv);
>>  			goto out_fail;
>>  		}
>>  
>>  		ret = cpuidle_register_driver(drv);
>>  		if (ret) {
>>  			pr_err("Failed to register cpuidle driver\n");
>> +			kfree(drv);
>>  			goto out_fail;
>>  		}

I would prefer if you create another label on top of out_fail to free
'drv' and 'dev'. So you can remove the kfree in this loop (also take the
opportunity to remove the pr_err("Failed to allocate cpuidle device")
message.

> should i split this patch (fix for "my" memleak and cleanup fix)?

Yes, please.

Thanks.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
