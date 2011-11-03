From: liu.h.jason@gmail.com (Jason Liu)
Date: Thu, 3 Nov 2011 15:36:05 +0800
Subject: [PATCH v3 3/3] ARM:i.MX: fix the compile warnings in
	clock-mx51-mx53.c
In-Reply-To: <20111103064426.GN23421@pengutronix.de>
References: <1320231836-9555-1-git-send-email-jason.hui@linaro.org>
	<1320231836-9555-6-git-send-email-jason.hui@linaro.org>
	<20111103064426.GN23421@pengutronix.de>
Message-ID: <CAB4PhKcU8AQg3Y9MbP8cp6Ji_jZafRtNv-vz83HuECcmg9O7jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/3 Sascha Hauer <s.hauer@pengutronix.de>:
> On Wed, Nov 02, 2011 at 07:03:56PM +0800, Jason Liu wrote:
>> arch/arm/mach-mx5/clock-mx51-mx53.c: In function 'clk_get_freq_dt':
>> arch/arm/mach-mx5/clock-mx51-mx53.c: In function 'mx53_clocks_init_dt':
>> arch/arm/mach-mx5/clock-mx51-mx53.c:1673: warning: 'ckil' is used uninitialized in this function
>> arch/arm/mach-mx5/clock-mx51-mx53.c:1673: warning: 'osc' is used uninitialized in this function
>> arch/arm/mach-mx5/clock-mx51-mx53.c:1673: warning: 'ckih1' is used uninitialized in this function
>> arch/arm/mach-mx5/clock-mx51-mx53.c:1673: warning: 'ckih2' is used uninitialized in this function
>> arch/arm/mach-mx5/clock-mx51-mx53.c: In function 'mx51_clocks_init_dt':
>> arch/arm/mach-mx5/clock-mx51-mx53.c:1665: warning: 'ckil' is used uninitialized in this function
>> arch/arm/mach-mx5/clock-mx51-mx53.c:1665: warning: 'osc' is used uninitialized in this function
>> arch/arm/mach-mx5/clock-mx51-mx53.c:1665: warning: 'ckih1' is used uninitialized in this function
>> arch/arm/mach-mx5/clock-mx51-mx53.c:1665: warning: 'ckih2' is used uninitialized in this function
>
> You only get this warning because you have put the code in
> clk_get_freq_dt into #ifdef CONFIG_OF in the last patch. Instead please
> put the whole block including clk_get_freq_dt, mx51_clocks_init_dt and
> mx53_clocks_init_dt into #ifdef CONFIG_OF.

Yes, I can put #ifdef CONFIG_OF to cover the whole block including
clk_get_freq_dt/
mx51_clocks_init_dt/mx53_clocks_init_dt, but after enable CONFIG_OF,
you still will
meet these compiling warnings.

But refer to grant before, we don't need place #ifdef CONFIG_OF #endif into
the .c file, no-matter enable device_tree support or not. I'm not sure
why we still
meet compile error, shawn, any comments?

Jason Liu

> Sascha
>
>>
>> Signed-off-by: Jason Liu <jason.hui@linaro.org>
>> ---
>> ?arch/arm/mach-mx5/clock-mx51-mx53.c | ? ?2 ++
>> ?1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
>> index 7c373b83..e352a5a 100644
>> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
>> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
>> @@ -1662,6 +1662,7 @@ int __init mx51_clocks_init_dt(void)
>> ?{
>> ? ? ? unsigned long ckil, osc, ckih1, ckih2;
>>
>> + ? ? ckil = osc = ckih1 = ckih2 = 0;
>> ? ? ? clk_get_freq_dt(&ckil, &osc, &ckih1, &ckih2);
>> ? ? ? return mx51_clocks_init(ckil, osc, ckih1, ckih2);
>> ?}
>> @@ -1670,6 +1671,7 @@ int __init mx53_clocks_init_dt(void)
>> ?{
>> ? ? ? unsigned long ckil, osc, ckih1, ckih2;
>>
>> + ? ? ckil = osc = ckih1 = ckih2 = 0;
>> ? ? ? clk_get_freq_dt(&ckil, &osc, &ckih1, &ckih2);
>> ? ? ? return mx53_clocks_init(ckil, osc, ckih1, ckih2);
>> ?}
>> --
>> 1.7.4.1
>>
>>
>>
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
