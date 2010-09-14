From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 14 Sep 2010 18:56:09 +0900
Subject: [PATCH 3/3] ARM: S5PC210: Set the common L2 cache configurations
In-Reply-To: <017301cb53f1$f57f3750$e07da5f0$%kim@samsung.com>
References: <20100911053115.GA23209@july>
	<017301cb53f1$f57f3750$e07da5f0$%kim@samsung.com>
Message-ID: <AANLkTikwSX706ZdeW0RFNq5DaQXRaN7GcYacNiTSvcXi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 14, 2010 at 6:48 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> From: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> S5PC210 has PL310 1MiB L2 cache.
>> It uses the optimized data & tag latency and also enable the prefetch.
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv310/cpu.c | ? 19 +++++++++++++++++++
>> ?1 files changed, 19 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
>> index e5b261a..b50312e 100644
>> --- a/arch/arm/mach-s5pv310/cpu.c
>> +++ b/arch/arm/mach-s5pv310/cpu.c
>> @@ -15,6 +15,7 @@
>> ?#include <asm/mach/irq.h>
>>
>> ?#include <asm/proc-fns.h>
>> +#include <asm/hardware/cache-l2x0.h>
>>
>> ?#include <plat/cpu.h>
>> ?#include <plat/clock.h>
>> @@ -121,6 +122,24 @@ static int __init s5pv310_core_init(void)
>>
>> ?core_initcall(s5pv310_core_init);
>>
>> +static int __init s5pv310_init_cache(void)
>> +{
>> +#ifdef CONFIG_CACHE_L2X0
>> + ? ? void __iomem *p = S5P_VA_L2CC;
>> +
>> + ? ? /* TAG, ?Data latency control */
>> + ? ? writel(0x110, p + L2X0_TAG_LATENCY_CTRL);
>
> Please use '__raw_writel' instead of 'writel' here...
why?
>
>> + ? ? writel(0x110, p + L2X0_DATA_LATENCY_CTRL);
>> +
>> + ? ? /* L2 cache prefetch control */
>> + ? ? writel(0x6, p + L2X0_PREFETCH_CTRL);
>
> As I know, there is more suitable value which has been tested.
> It means should be changed...but now it is under testing.
I know but almost same effect. 0x3000'000x is set by at AUX_CTRL. and
0x7 is not fully tested.
I mean 0x3000'0006 and 0x6 is same.
>
>> +
>> + ? ? l2x0_init(p, 0x3C070001, 0xC200FFFF);
>> +#endif
>> + ? ? return 0;
>> +}
>> +early_initcall(s5pv310_init_cache);
>> +
>> ?int __init s5pv310_init(void)
>> ?{
>> ? ? ? printk(KERN_INFO "S5PV310: Initializing architecture\n");
>> --
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
