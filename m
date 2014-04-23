From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 24 Apr 2014 01:02:40 +0400
Subject: [PATCH v2 1/9] ARM: S3C24XX: cpufreq-utils: don't write raw values
 to MPLLCON when using ccf
In-Reply-To: <535825AB.8060802@cogentembedded.com>
References: <2104342.rkElQpXtvM@phil> <5855371.5GIoOu8EnE@phil>
 <535825AB.8060802@cogentembedded.com>
Message-ID: <53582A70.8000206@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2014 12:42 AM, Sergei Shtylyov wrote:

>> The s3c24xx cpufreq driver needs to change the mpll speed and was doing
>> this by writing raw values from a translation table into the MPLLCON
>> register.

>> Change this to use a regular clk_set_rate call when using the common
>> clock framework and only write the raw value in the samsung_clock case.

>> To not needing to create additional infrastructure for this, the mpll clock
>> is requested at the first call to s3c2410_set_fvco().

>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>   arch/arm/mach-s3c24xx/cpufreq-utils.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)

>> diff --git a/arch/arm/mach-s3c24xx/cpufreq-utils.c
>> b/arch/arm/mach-s3c24xx/cpufreq-utils.c
>> index 2a0aa56..d5e797b 100644
>> --- a/arch/arm/mach-s3c24xx/cpufreq-utils.c
>> +++ b/arch/arm/mach-s3c24xx/cpufreq-utils.c
> [...]
>> @@ -60,5 +61,18 @@ void s3c2410_cpufreq_setrefresh(struct s3c_cpufreq_config
>> *cfg)
>>    */
>>   void s3c2410_set_fvco(struct s3c_cpufreq_config *cfg)
>>   {
>> +#ifdef CONFIG_SAMSUNG_CLOCK
>>       __raw_writel(cfg->pll.driver_data, S3C2410_MPLLCON);
>> +#endif
>> +
>> +#ifdef CONFIG_COMMON_CLK
>> +    static struct clk *mpll;
>> +
>> +    if (!mpll)

>     You are testing uninitialized variable. This check wouldn't make much
> sense even if the variable was initialized.

    Oops, I didn't notice *static*... :-> The code makes more sense now.

>> +        mpll = clk_get(NULL, "mpll")
>> +    if (IS_ERR(mpll))
>> +        return;
>> +
>> +    clk_set_rate(mpll, cfg->pll.frequency);
>> +#endif
>>   }

WBR, Sergei
