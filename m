From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 7 Mar 2012 09:46:08 -0500
Subject: [PATCH v2] ARM: pxa: fix regulator related build fail in
 magician_defconfig
In-Reply-To: <1331084814.11802.YahooMailClassic@web29012.mail.ird.yahoo.com>
References: <1331084814.11802.YahooMailClassic@web29012.mail.ird.yahoo.com>
Message-ID: <4F5774B0.1030209@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-03-06 08:46 PM, Paul Parsons wrote:
> --- On Tue, 6/3/12, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
>> commit
>> 737f360d5bef5e01c6cfa755dca0b449a154c1e0 (linux-next)
>>
>>   "regulator: Remove support for supplies specified by
>> struct device"
>>
>> deletes the field from the struct, but this platform was
>> still trying
>> to set those fields.  Convert them to use the
>> REGULATOR_SUPPLY macro
>> so as to fix this failure:
>>
>> arch/arm/mach-pxa/magician.c:581: error: unknown field 'dev'
>> specified in initializer
>> arch/arm/mach-pxa/magician.c:581: warning: initialization
>> from incompatible pointer type
>> arch/arm/mach-pxa/magician.c:585: error: unknown field 'dev'
>> specified in initializer
>> arch/arm/mach-pxa/magician.c:585: warning: initialization
>> from incompatible pointer type
>>
>> arch/arm/mach-pxa/hx4700.c:683: error: unknown field 'dev'
>> specified in initializer
>> arch/arm/mach-pxa/hx4700.c:683: warning: initialization from
>> incompatible pointer type
>> arch/arm/mach-pxa/hx4700.c:687: error: unknown field 'dev'
>> specified in initializer
>> arch/arm/mach-pxa/hx4700.c:687: warning: initialization from
>> incompatible pointer type
>>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>
>> [v2: convert to using REGULATOR_SUPPLY instead of just
>> deleting the
>>  instances of setting the .dev field ]
>>
>> diff --git a/arch/arm/mach-pxa/hx4700.c
>> b/arch/arm/mach-pxa/hx4700.c
>> index f2c23ea..53c3366 100644
>> --- a/arch/arm/mach-pxa/hx4700.c
>> +++ b/arch/arm/mach-pxa/hx4700.c
>> @@ -679,14 +679,8 @@ static struct platform_device
>> power_supply = {
>>   */
>>  
>>  static struct regulator_consumer_supply bq24022_consumers[]
>> = {
>> -    {
>> -        .dev =
>> &gpio_vbus.dev,
>> -        .supply =
>> "vbus_draw",
>> -    },
>> -    {
>> -        .dev =
>> &power_supply.dev,
>> -        .supply = "ac_draw",
>> -    },
>> +    REGULATOR_SUPPLY("vbus_draw",
>> "gpio_vbus"),
>> +    REGULATOR_SUPPLY("ac_draw",
>> "power_supply"),
>>  };
> 
> The above hx4700 patch yields the following warnings:
> 
> _regulator_get: gpio-vbus supply vbus_draw not found, using dummy regulator
> _regulator_get: pda-power supply ac_draw not found, using dummy regulator
> 
> I suggest the following lines instead:
> 
> 	REGULATOR_SUPPLY("vbus_draw", "gpio-vbus"),
> 	REGULATOR_SUPPLY("ac_draw", "pda-power"),

Thanks for the report.  The regulator code is rather foreign
to me, but I think I figured out the expectations on the names
last night when looking at a similar patch here:

http://www.spinics.net/lists/arm-kernel/msg163418.html

I'll fix these two patches up, but next time I'll just report
the regulator regressions and let the sub-system maintainer
or the platform maintainer sort them out.

Paul.

> 
