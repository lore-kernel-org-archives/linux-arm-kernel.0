From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 08 Nov 2016 10:13:48 -0800
Subject: [PATCH] ARM: davinci: enable PM for DT boot
In-Reply-To: <c3a69359-bcec-40fe-e25c-048b97bab726@ti.com> (Sekhar Nori's
 message of "Fri, 28 Oct 2016 17:40:10 +0530")
References: <20161025214738.27744-1-khilman@baylibre.com>
 <c3a69359-bcec-40fe-e25c-048b97bab726@ti.com>
Message-ID: <m2shr16dr7.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

Sekhar Nori <nsekhar@ti.com> writes:

> On Wednesday 26 October 2016 03:17 AM, Kevin Hilman wrote:
>> Currently system PM is only enabled for legacy (non-DT) boot.  Enable
>> for DT boot also.
>> 
>> Tested on da850-lcdk using "rtcwake -m mem -s5 -d rtc0".
>> 
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>>  arch/arm/mach-davinci/da8xx-dt.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>> 
>> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
>> index c9f7e9274aa8..a8089fa40d86 100644
>> --- a/arch/arm/mach-davinci/da8xx-dt.c
>> +++ b/arch/arm/mach-davinci/da8xx-dt.c
>> @@ -43,8 +43,26 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>>  
>>  #ifdef CONFIG_ARCH_DAVINCI_DA850
>>  
>> +static struct davinci_pm_config da850_pm_pdata = {
>> +	.sleepcount = 128,
>> +};
>> +
>> +static struct platform_device da850_pm_device = {
>> +	.name           = "pm-davinci",
>> +	.dev = {
>> +		.platform_data	= &da850_pm_pdata,
>> +	},
>> +	.id             = -1,
>> +};
>> +
>>  static void __init da850_init_machine(void)
>>  {
>> +	int ret;
>> +
>> +	ret = da850_register_pm(&da850_pm_device);
>
> I am not sure if it makes sense to keep the "pm device" around anymore.
> I think for both DT and non-DT boot, we can get rid of the fake PM
> device and combine da850_register_pm() and davinci_pm_probe() into a
> single davinci_init_suspend() function which can then be called both for
> DT and non-DT boot.

Looking closer at this, where do you propose the pdata comes from for
the non-DT boot?

It seems to me that we can't currently remove the pdata dependency
without breaking the non-DT platforms, so the approach proposed here is
the least invasive.

Once other platforms are DT converted, we could clean this up a bit
more.

Kevin
