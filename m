From: r.sricharan@ti.com (R, Sricharan)
Date: Sun, 6 May 2012 13:06:25 +0530
Subject: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
In-Reply-To: <20120504223933.GX5613@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
 <20120504223933.GX5613@atomide.com>
Message-ID: <CAJ7qFSfkHGF7ehanZP=hyZ27HqSp1ONsT0tUV-wpLne9B4DEaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,
[snip]
> OK this seems to be based on Santosh' Makefile cleanup.
>
 yes..

>>
>> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4) || \
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? defined(CONFIG_ARCH_OMAP5)
>>
>
> How about we add CONFIG_SOC_OMAP3PLUS in the clean-up series?
> Then this becomes just:
>
> #ifdef CONFIG_SOC_OMAP3PLUS
>
 Ok, thanks for the example later. I will do a cleanup patch and
rebase this one.


>> -# ifdef CONFIG_ARCH_OMAP4
>> +#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_OMAP5)
>> ?extern int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?u16 clkctrl_offs);
>
> And this would be:
>
> #ifdef CONFIG_SOC_OMAP4PLUS
>
 ok..

>
> Also, please change the whole series to use CONFIG_SOC_OMAP5 instead
> of CONFIG_ARCH_OMAP5. CONFIG_ARCH_OMAPXXXX stuff will go away except
> for CONFIG_ARCH_OMAP2PLUS. Sorry forgot to mention that earlier.
>
 ok. sure. will change this.


>> -#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) || ? ?\
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? defined(CONFIG_ARCH_OMAP3))
>> +#if (defined(CONFIG_ARCH_OMAP5) || defined(CONFIG_ARCH_OMAP4)) && \
>> + ? ? ? ? ? ? !(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
>> +
>> ?static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
>> ?{
>> ? ? ? WARN(1, "prm: omap2xxx/omap3xxx specific function and "
>
> Maybe these functions could be just set up as __weak to avoid the
> ifdeffery?
>
 sorry to understand,
 you mean make this weak and have a strong override for OMAP2 ?

>> ?#define CK_443X ? ? ? ? ? ? ?(1 << 11)
>> ?#define CK_TI816X ? ?(1 << 12)
>> ?#define CK_446X ? ? ? ? ? ? ?(1 << 13)
>> +#define CK_54XX ? ? ? ? ? ? ?(1 << 14)
>> ?#define CK_1710 ? ? ? ? ? ? ?(1 << 15) ? ? ? /* 1710 extra for rate selection */
>>
>>
>
> Are we going to have to patch tons of existing clocks just to add
> CK_54XX? If so, we should init clocks using SoC specific lists instead.
>

>> diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
>> index d0ef57c..41858f4 100644
>> --- a/arch/arm/plat-omap/include/plat/clock.h
>> +++ b/arch/arm/plat-omap/include/plat/clock.h
>> @@ -61,6 +61,7 @@ struct clkops {
>> ?#define RATE_IN_4460 ? ? ? ? (1 << 7)
>> ?#define RATE_IN_AM33XX ? ? ? ? ? ? ? (1 << 8)
>> ?#define RATE_IN_TI814X ? ? ? ? ? ? ? (1 << 9)
>> +#define RATE_IN_54XX ? ? ? ? (1 << 10)
>
> This too may have similar issues, but I guess that's really a different
> patch series to sort out..
>
 ok. agree

>> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4) \
>> + ? ? ? ? ? ? || defined(CONFIG_ARCH_OMAP5)
>> ? ? ? void __iomem ? ? ? ? ? ?*autoidle_reg;
>> ? ? ? void __iomem ? ? ? ? ? ?*idlest_reg;
>> ? ? ? u32 ? ? ? ? ? ? ? ? ? ? autoidle_mask;
>
>
> #ifdef CONFIG_SOC_OMAP3PLUS could be used here too
>
 ok..

Thanks,
 Sricharan
