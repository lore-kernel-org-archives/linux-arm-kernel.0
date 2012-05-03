From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 04 May 2012 01:02:20 +0200
Subject: [PATCH 18/18][V3] ARM: OMAP3: cpuidle - set global variables
 static
In-Reply-To: <878vh9ko3j.fsf@ti.com>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
 <1335276339-11135-19-git-send-email-daniel.lezcano@linaro.org>
 <878vh9ko3j.fsf@ti.com>
Message-ID: <4FA30E7C.8090900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2012 10:26 PM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> and check the powerdomain lookup is successful.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> Reviewed-by: Jean Pihet<j-pihet@ti.com>
>> ---
>>   arch/arm/mach-omap2/cpuidle34xx.c |    5 ++++-
>>   1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
>> index 0d28596..116a0d8 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -73,7 +73,7 @@ static struct omap3_idle_statedata omap3_idle_data[] = {
>>   	},
>>   };
>>
>> -struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
>> +static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
>>
>>   static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
>>   				struct clockdomain *clkdm)
>> @@ -252,6 +252,9 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>>   	 *        its own code.
>>   	 */
>>
>> +	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
>> +		return -ENODEV;
>> +
>
> Why check here?  cam_pd is actually used just above this code.
>
> Also, this is in the fast path.  This should just be checked once at
> init time instead of every idle path.
>
> For those reasons, I've dropped this part of the patch (updated patch
> below.)

Hmm, weird this part should have been in the init function, I likely 
missed a big fuzz I think when porting the patchset to the latest kernel 
version. Thanks for fixing it.

> If desired, you can send an additional patch that adds this error
> checking at init time and then refuses to register the driver if any of
> the pwrdms don't exist.

Yes, I will do it.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
