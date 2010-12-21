From: yong.shen@linaro.org (Yong Shen)
Date: Tue, 21 Dec 2010 17:17:06 +0800
Subject: [PATCH 1/2] ARM i.MX53: Some bug fix about MX53 MSL code
In-Reply-To: <20101221083048.GF14221@pengutronix.de>
References: <1292902651-26636-1-git-send-email-yong.shen@freescale.com>
	<20101221083048.GF14221@pengutronix.de>
Message-ID: <AANLkTikW=qsC=XSSbxsB8Bg4jaeK8JVV0ZWZjgGGQ8Vv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,


>> --- a/arch/arm/mach-mx5/crm_regs.h
>> +++ b/arch/arm/mach-mx5/crm_regs.h
>> @@ -19,6 +19,10 @@
>> ?#define MX51_GPC_BASE ? ? ? ? ? ? ? ?MX51_IO_ADDRESS(MX51_GPC_BASE_ADDR)
>>
>> ?/*MX53*/
>> +#define MX53_CCM_BASE ? ? ? ? ? ? ? ?MX53_IO_ADDRESS(MX53_CCM_BASE_ADDR)
>> +#define MX53_DPLL1_BASE ? ? ? ? ? ? ?MX53_IO_ADDRESS(MX53_PLL1_BASE_ADDR)
>> +#define MX53_DPLL2_BASE ? ? ? ? ? ? ?MX53_IO_ADDRESS(MX53_PLL2_BASE_ADDR)
>> +#define MX53_DPLL3_BASE ? ? ? ? ? ? ?MX53_IO_ADDRESS(MX53_PLL3_BASE_ADDR)
>> ?#define MX53_DPLL4_BASE ? ? ? ? ? ? ?MX53_IO_ADDRESS(MX53_PLL3_BASE_ADDR)
> hmm, I'd like to have MX53_CCM_VBASE_ADDR (or similar) here.
> MX53_CCM_BASE doesn't show the difference to MX53_CCM_BASE_ADDR. ?(And
> yes, I saw that MX53_DPLL4_BASE is already there.)
Yes, the name you suggested is better. However, I named them to align
with previous mx51 definition, if you agree, let's just keep them like
this, otherwise I need to create another patch for name changing or
leave them not aligned.

>>
>> ?/* PLL Register Offsets */
>> diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
>> index 4abbdd1..eca8f83 100644
>> --- a/arch/arm/plat-mxc/include/mach/mxc.h
>> +++ b/arch/arm/plat-mxc/include/mach/mxc.h
>> @@ -126,7 +126,7 @@ extern unsigned int __mxc_cpu_type;
>> ?# define cpu_is_mx35() ? ? ? ? ? ? ? (0)
>> ?#endif
>>
>> -#ifdef CONFIG_ARCH_MX5
>> +#ifdef CONFIG_ARCH_MX51
>> ?# ifdef mxc_cpu_type
>> ?# ?undef mxc_cpu_type
>> ?# ?define mxc_cpu_type __mxc_cpu_type
>> @@ -134,11 +134,22 @@ extern unsigned int __mxc_cpu_type;
>> ?# ?define mxc_cpu_type MXC_CPU_MX51
>> ?# endif
>> ?# define cpu_is_mx51() ? ? ? ? ? ? ? (mxc_cpu_type == MXC_CPU_MX51)
>> -# define cpu_is_mx53() ? ? ? ? ? ? ? (mxc_cpu_type == MXC_CPU_MX53)
>> ?#else
>> ?# define cpu_is_mx51() ? ? ? ? ? ? ? (0)
>> ?#endif
>>
>> +#ifdef CONFIG_ARCH_MX53
>> +# ifdef mxc_cpu_type
>> +# ?undef mxc_cpu_type
>> +# ?define mxc_cpu_type __mxc_cpu_type
>> +# else
>> +# ?define mxc_cpu_type MXC_CPU_MX53
>> +# endif
>> +# define cpu_is_mx53() ? ? ? ? ? ? ? (mxc_cpu_type == MXC_CPU_MX53)
>> +#else
>> +# define cpu_is_mx53() ? ? ? ? ? ? ? (0)
>> +#endif
>> +
> This is OK, though it could use CONFIG_SOC_MX53.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
