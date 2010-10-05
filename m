From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 5 Oct 2010 18:06:19 +0900
Subject: [PATCH v2 3/3] ARM: S5PC210: Set the common L2 cache
	configurations
In-Reply-To: <001f01cb6469$f65aa370$e30fea50$%kim@samsung.com>
References: <20100930074959.GA11798@july>
	<001f01cb6469$f65aa370$e30fea50$%kim@samsung.com>
Message-ID: <AANLkTinb3u6fmrQvxY=JOtyY9Q+oaM8vzhwJNdao4Y+D@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 5, 2010 at 5:47 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
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
>
> It would be helpful that could use more detailed function name like
> s5pv310_l2x0_cache_init().
>
>> +{
>> +#ifdef CONFIG_CACHE_L2X0
>> + ? ? void __iomem *p = S5P_VA_L2CC;
>> +
>> + ? ? /* TAG, ?Data latency control */
>> + ? ? writel(0x110, p + L2X0_TAG_LATENCY_CTRL);
>> + ? ? writel(0x110, p + L2X0_DATA_LATENCY_CTRL);
>
> I still thinking, __raw_writel is more suitable here...
> Because no need to add barriers between each write here.

I think It's micro optimization.
>
>> +
>> + ? ? /* L2 cache prefetch control */
>> + ? ? writel(0x30000007, p + L2X0_PREFETCH_CTRL);
>> +
>> + ? ? l2x0_init(p, 0x3C070001, 0xC200FFFF);
>
> 0x7C070001 is better...or should be?...because it is for early write
> response.
> I think need it for optimization...so please change it.
Send the official documents, At the latest Info. LSI said it's no
performance gain at there.
>
> And it'd better if you could add PL310(L2 cache controller) power control
> here.
> It can help to reduce power consumption.
>
>> +#endif
>> + ? ? return 0;
>> +}
>> +early_initcall(s5pv310_init_cache);
>> +
>
> And in my opinion, following format is better even if do not consider the
> coding-style.
> Because if not defined CACHE_L2X0, no need to add empty function into
> early_initcall().
>
> #ifdef CONFIG_CACHE_L2X0
> static int __init s5pv310_l2x0_cache_init(void)
> {
>
> /* */
>
> ? ? ? ?return 0;
> }
> early_initcall(s5p_l2x0_cache_init);
> #endif
>
>
>> ?int __init s5pv310_init(void)
>> ?{
>> ? ? ? printk(KERN_INFO "S5PV310: Initializing architecture\n");
>> --
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
