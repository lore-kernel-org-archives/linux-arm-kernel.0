From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 31 Jul 2015 10:57:33 +0800
Subject: [PATCH v2 1/2] ARM: rockchip: set correct stabilization thresholds
 in suspend
In-Reply-To: <1460722.2xOTZfOB49@diego>
References: <4610448.RXXf22Qoxl@diego> <1460722.2xOTZfOB49@diego>
Message-ID: <55BAE41D.2080707@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko

On 07/25/2015 07:09 AM, Heiko St?bner wrote:
> Hi Chris,
>
> Am Donnerstag, 23. Juli 2015, 10:29:34 schrieb Heiko St?bner:
>> diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
>> index 892bace..04d3028 100644
>> --- a/arch/arm/mach-rockchip/pm.c
>> +++ b/arch/arm/mach-rockchip/pm.c
>> @@ -145,6 +145,10 @@ static void rk3288_slp_mode_set(int level)
>>
>>   		mode_set1 |= BIT(PMU_CLR_ALIVE) | BIT(PMU_CLR_BUS) |
>>   			     BIT(PMU_CLR_PERI) | BIT(PMU_CLR_DMA);
>> +
>> +		/* 30ms on a 32kHz clock for osc and pmic stabilization */
>> +		regmap_write(pmu_regmap, RK3288_PMU_OSC_CNT, 32 * 30);
>> +		regmap_write(pmu_regmap, RK3288_PMU_STABL_CNT, 32 * 30);
> The deep suspend mode has two bits handling the 32kHz clock switch (PMU_USE_LF
> and ALIVE_USE_LF). Just for my understanding, are these always supposed to be
> set to the same value or can there be a case when only one of them is set?
If we want to close the 24Mhz osc, these 2 bit must to be set 1;
if 24Mhz still working, we can disable any one of these 2 bit, or 
disable both of them .

> Also when deciding the correct stabilization delays on which of the two are
> these dependant?
>
> I.e. something like
>
>    stabl_cnt = PMU_PMU_USE_LF ? 32 : 24000
>    osc_cnt = PMU_ALIVE_USE_LF ? 32 : 24000
>
> or are these always to be set similarly?

stabl_cnt is the time of waiting PMIC(RK808) to be stable, so if we hold the GLOBAL_PWROFF pin low,
we do not need wait this time, stabl_cnt = 0 is good in this case.
  
osc_cnt is the time of waiting 24Mhz osc to be stable, so if the 24Mhz osc is still working during suspend,
this time could be set to 0.

And these 2 time count is base on PMU_PMU_USE_LF:
stabl_cnt = PMU_PMU_USE_LF ? 32 : 24000
osc_cnt = PMU_PMU_USE_LF ? 32 : 24000

>
>
> Thanks
> Heiko
>
>
>
