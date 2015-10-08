From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 08 Oct 2015 10:01:13 +0900
Subject: [PATCH 5/6] ARM: s3c64xx: hmt: Use PWM lookup table
In-Reply-To: <20151007153724.GC1975@ulmo>
References: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
 <1444049237-29878-6-git-send-email-thierry.reding@gmail.com>
 <56147766.6010703@samsung.com> <20151007153724.GC1975@ulmo>
Message-ID: <5615C059.5050507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.10.2015 00:37, Thierry Reding wrote:
> On Wed, Oct 07, 2015 at 10:37:42AM +0900, Krzysztof Kozlowski wrote:
>> On 05.10.2015 21:47, Thierry Reding wrote:
>>> Use a PWM lookup table to provide the PWM to the pwm-backlight device.
>>> The driver has a legacy code path that is required only because boards
>>> still use the legacy method of requesting PWMs by global ID. Replacing
>>> these usages allows that legacy fallback to be removed.
>>>
>>> Cc: Kukjin Kim <kgene@kernel.org>
>>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
>>> ---
>>>  arch/arm/mach-s3c64xx/mach-hmt.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
>>> index e4b087c58ee6..816b39d1e6d1 100644
>>> --- a/arch/arm/mach-s3c64xx/mach-hmt.c
>>> +++ b/arch/arm/mach-s3c64xx/mach-hmt.c
>>> @@ -19,6 +19,7 @@
>>>  #include <linux/gpio.h>
>>>  #include <linux/delay.h>
>>>  #include <linux/leds.h>
>>> +#include <linux/pwm.h>
>>>  #include <linux/pwm_backlight.h>
>>>  #include <linux/mtd/mtd.h>
>>>  #include <linux/mtd/partitions.h>
>>> @@ -73,6 +74,11 @@ static struct s3c2410_uartcfg hmt_uartcfgs[] __initdata = {
>>>  	},
>>>  };
>>>  
>>> +static struct pwm_lookup hmt_pwm_lookup[] = {
>>> +	PWM_LOOKUP("samsung-pwm", 1, "pwm-backlight.0", NULL,
>>
>> Same questions as in patch 2 - why suffix ".0" for "pwm-backlight"?
> 
> For the same reason that I explained in patch 2. Not sure if the .id = 0
> was really supposed to be. For most devices it would probably make sense
> to initialize it to -1 because they typically only have a single
> backlight. But given that userspace might be using the name to control
> the backlight via sysfs it's probably not a good idea to go and change
> that.

Thanks for explanation.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
