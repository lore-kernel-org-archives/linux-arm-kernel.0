From: thomas.ab@samsung.com (Thomas Abraham)
Date: Sat, 28 May 2011 09:09:44 +0530
Subject: [PATCH v2 7/7] ARM: Exynos4: Add clkdev support
In-Reply-To: <BANLkTikVj7crwc53PWvzJ5DMKevMbeiPJg@mail.gmail.com>
References: <1306509996-30280-1-git-send-email-thomas.ab@samsung.com>
	<1306509996-30280-8-git-send-email-thomas.ab@samsung.com>
	<BANLkTi=LQ2neqPe3Eobmx4Qx2rBQacCx8g@mail.gmail.com>
	<4DE05A85.4050201@samsung.com>
	<BANLkTinOXSV3ZfrXs9BvFqJmhaOc6TjR9A@mail.gmail.com>
	<BANLkTikVj7crwc53PWvzJ5DMKevMbeiPJg@mail.gmail.com>
Message-ID: <BANLkTi=w+5Yv7dqyBQzZW24i6MfqP2-h+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 28, 2011 at 8:06 AM, Kyungmin Park <kmpark@infradead.org> wrote:
> On Sat, May 28, 2011 at 11:33 AM, Kyungmin Park <kmpark@infradead.org> wrote:
>> On Sat, May 28, 2011 at 11:14 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>>>
>>>
>>> On 05/27/11 18:53, Kyungmin Park wrote:
>>>>
>>>> On Sat, May 28, 2011 at 12:26 AM, Thomas Abraham<thomas.ab@samsung.com>
>>>> ?wrote:
>>>>>
>>>>> Add clkdev support for Samsung's Exynos4 platform and fixes the
>>>>> incorrect clock name for the dw_mmc controller.
>>>>>
>>>>> Signed-off-by: Thomas Abraham<thomas.ab@samsung.com>
>>>>> ---
>>>>> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
>>>>> ?arch/arm/mach-exynos4/clock.c ? ? ? ? ? ? ? | ?178
>>>>> +++++++++------------------
>>>>> ?arch/arm/mach-exynos4/include/mach/clkdev.h | ? ?7 +
>>>>> ?arch/arm/mach-exynos4/time.c ? ? ? ? ? ? ? ?| ? ?2 +
>>>>> ?4 files changed, 67 insertions(+), 121 deletions(-)
>>>>> ?create mode 100644 arch/arm/mach-exynos4/include/mach/clkdev.h
>>>
>>> (snip)
>>>
>>>>> diff --git a/arch/arm/mach-exynos4/include/mach/clkdev.h
>>>>> b/arch/arm/mach-exynos4/include/mach/clkdev.h
>>>>> new file mode 100644
>>>>> index 0000000..1247f5e
>>>>> --- /dev/null
>>>>> +++ b/arch/arm/mach-exynos4/include/mach/clkdev.h
>>>>> @@ -0,0 +1,7 @@
>>>>> +#ifndef __MACH_EXYNOS4_CLKDEV_H__
>>>>> +#define __MACH_EXYNOS4_CLKDEV_H__
>>>>> +
>>>>> +#define __clk_get(clk) ({ 1; })
>>>>> +#define __clk_put(clk) do { } while (0)
>>>>> +
>>>>> +#endif
>>>>
>>>> Looks good to me.
>>>>
>>>> One nitpick
>>>> How about to just create the one clkdev.h at plat-samsung with proper
>>>> ifdef endif config.
>>>> I think don't need to create clkdev.h for each SoCs.
>>>
>>> No, basically the "mach/clkdev.h" should be added, please see
>>> arch/arm/include/asm/clkdev.h.
>>
>> Okay it's required,
>> but also see the others.
>> http://git.infradead.org/linux-2.6.git/blob/HEAD:/arch/arm/mach-omap2/include/mach/clkdev.h
>>
>> ? 1 /*
>> ? 2 ?* arch/arm/mach-omap2/include/mach/clkdev.h
>> ? 3 ?*/
>> ? 4
>> ? 5 #include <plat/clkdev.h>
>
> and
> http://git.infradead.org/linux-2.6.git/blob/HEAD:/arch/arm/plat-omap/include/plat/clkdev.h
>
> ? 1 #ifndef __MACH_CLKDEV_H
> ? 2 #define __MACH_CLKDEV_H
> ? 3
> ? 4 static inline int __clk_get(struct clk *clk)
> ? 5 {
> ? 6 ? ? ? ? return 1;
> ? 7 }
> ? 8
> ? 9 static inline void __clk_put(struct clk *clk)
> ?10 {
> ?11 }
> ?12
> ?13 #endif
>
> To Arnd,
>
> in case of ARM, it has almost same form. then how about to move the
> arm generic one?
>>

We also need to consider the case in which a platform requires a
custom implementation of __clk_get and __clk_put. In that case, will a
single clkdev.h suffice?

Thanks,
Thomas.

>> Thank you,
>> Kyungmin Park
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
