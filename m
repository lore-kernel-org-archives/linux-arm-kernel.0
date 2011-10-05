From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 05 Oct 2011 10:54:35 +0900
Subject: [PATCH 4/4] ARM: EXYNOS4: Add power domain to use generic Power
	domain Framework
In-Reply-To: <001901cc80d2$0da66d40$28f347c0$%kim@samsung.com>
References: <4E4360BA.3020208@samsung.com>
	<001901cc80d2$0da66d40$28f347c0$%kim@samsung.com>
Message-ID: <4E8BB8DB.6020402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> Chanwoo Choi wrote:
>> This patch initializes the power domain of EXYNOS4210. The devices
>> which suppot runtime-PM have to be added in specific power domain.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/mach-exynos4/mach-nuri.c           |   18 ++++++++++++++++++
>>  arch/arm/mach-exynos4/mach-smdkc210.c       |   18
>> ++++++++++++++++++
>>  arch/arm/mach-exynos4/mach-smdkv310.c       |   15 +++++++++++++++
>>  arch/arm/mach-exynos4/mach-universal_c210.c |   18 ++++++++++++++++++
>>  4 files changed, 69 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-
>> nuri.c
>> index 4c358cb..5844c55 100644
>> --- a/arch/arm/mach-exynos4/mach-nuri.c
>> +++ b/arch/arm/mach-exynos4/mach-nuri.c
>> @@ -44,6 +44,7 @@
>>  #include <plat/mfc.h>
>>
>>  #include <mach/map.h>
>> +#include <mach/pm-exynos4210.h>
>>
>>  /* Following are default values for UCON, ULCON and UFCON UART registers */
>>  #define NURI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
>> @@ -1125,6 +1126,21 @@ static void __init nuri_reserve(void)
>>  	s5p_mfc_reserve_mem(0x43000000, 8 << 20, 0x51000000, 8 << 20);
>>  }
>>
>> +static void __init nuri_power_domain_init(void)
>> +{
>> +	/* Initialize Power domain */
>> +	exynos4210_init_pm_domain(&exynos4210_pd_mfc);
>> +	exynos4210_init_pm_domain(&exynos4210_pd_g3d);
>> +	exynos4210_init_pm_domain(&exynos4210_pd_lcd0);
>> +	exynos4210_init_pm_domain(&exynos4210_pd_lcd1);
>> +	exynos4210_init_pm_domain(&exynos4210_pd_tv);
>> +	exynos4210_init_pm_domain(&exynos4210_pd_cam);
>> +	exynos4210_init_pm_domain(&exynos4210_pd_gps);
> 
> As you know, the EXYNOS421 boards have same power domains so how about to make array of struct exynos4210_pm_domain and just one calling exynos4210_init_pm_domain()?
> 
OK, I will reimplement it to remove duplicate function call for initializing the generic power-domain of exynos4210.

>> +
>> +	/* Add device to MFC power domain */
>> +	exynos4210_add_device_to_domain(&exynos4210_pd_mfc,
>> &s5p_device_mfc);
>> +}
>> +
>>  static void __init nuri_machine_init(void)
>>  {
>>  	nuri_sdhci_init();
>> @@ -1145,6 +1161,8 @@ static void __init nuri_machine_init(void)
>>
>>  	/* Last */
>>  	platform_add_devices(nuri_devices, ARRAY_SIZE(nuri_devices));
>> +
>> +	nuri_power_domain_init();
>>  }
>>
>>  MACHINE_START(NURI, "NURI")
>> diff --git a/arch/arm/mach-exynos4/mach-smdkc210.c b/arch/arm/mach-
>> exynos4/mach-smdkc210.c
>> index 4d1976c..0a3b2a9 100644
>> --- a/arch/arm/mach-exynos4/mach-smdkc210.c
>> +++ b/arch/arm/mach-exynos4/mach-smdkc210.c
> 
> The mach-smdkc210.c and mach-smdkv310.c are merged one mach-smdkv310.c file.
> 
OK, I will modify it according to merged state of mach-smdkv310.c.

Thanks & Regards,
Chanwoo Choi
