From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Apr 2014 17:53:23 +0200
Subject: [PATCH 01/27] ARM: EXYNOS: Add Exynos3250 SoC ID
In-Reply-To: <534B6E8E.20506@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
 <1397122658-16013-2-git-send-email-cw00.choi@samsung.com>
 <20140411014650.GB14934@quad.lixom.net> <53478C75.60302@samsung.com>
 <5347AA35.4010504@samsung.com> <534B6E8E.20506@samsung.com>
Message-ID: <534EA773.30006@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 14.04.2014 07:13, Chanwoo Choi wrote:
> On 04/11/2014 05:39 PM, Tomasz Figa wrote:
>> On 11.04.2014 08:32, Chanwoo Choi wrote:
>>> On 04/11/2014 10:46 AM, Olof Johansson wrote:
>>>> On Thu, Apr 10, 2014 at 06:37:12PM +0900, Chanwoo Choi wrote:
>>>>> diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
>>>>> index 5992b8d..3d808f6b 100644
>>>>> --- a/arch/arm/plat-samsung/include/plat/cpu.h
>>>>> +++ b/arch/arm/plat-samsung/include/plat/cpu.h
>>>>> @@ -43,6 +43,9 @@ extern unsigned long samsung_cpu_id;
>>>>>    #define S5PV210_CPU_ID        0x43110000
>>>>>    #define S5PV210_CPU_MASK    0xFFFFF000
>>>>>
>>>>> +#define EXYNOS3250_SOC_ID       0xE3472000
>>>>> +#define EXYNOS3_SOC_MASK        0xFFFFF000
>>>>> +
>>>>>    #define EXYNOS4210_CPU_ID    0x43210000
>>>>>    #define EXYNOS4212_CPU_ID    0x43220000
>>>>>    #define EXYNOS4412_CPU_ID    0xE4412200
>>>>> @@ -68,6 +71,7 @@ IS_SAMSUNG_CPU(s5p6440, S5P6440_CPU_ID, S5P64XX_CPU_MASK)
>>>>>    IS_SAMSUNG_CPU(s5p6450, S5P6450_CPU_ID, S5P64XX_CPU_MASK)
>>>>>    IS_SAMSUNG_CPU(s5pc100, S5PC100_CPU_ID, S5PC100_CPU_MASK)
>>>>>    IS_SAMSUNG_CPU(s5pv210, S5PV210_CPU_ID, S5PV210_CPU_MASK)
>>>>> +IS_SAMSUNG_CPU(exynos3250, EXYNOS3250_SOC_ID, EXYNOS3_SOC_MASK)
>>>>>    IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
>>>>>    IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
>>>>>    IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
>>>>> @@ -126,6 +130,12 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
>>>>>    # define soc_is_s5pv210()    0
>>>>>    #endif
>>>>>
>>>>> +#if defined(CONFIG_SOC_EXYNOS3250)
>>>>> +# define soc_is_exynos3250()    is_samsung_exynos3250()
>>>>> +#else
>>>>> +# define soc_is_exynos3250()    0
>>>>> +#endif
>>>>
>>>> In general, I think we have too much code littered with soc_is_<foo>() going
>>>> on, so please try to avoid adding more for this SoC. Especially in cases where
>>>> you just want to bail out of certain features where we might already have
>>>> function pointers to control if a function is called or not, such as the
>>>> firmware interfaces.
>>>>
>>>
>>> Do you prefer dt helper function such as following function instead of new soc_is_xx() ?
>>> - of_machine_is_compatible("samsung,exynos3250")
>>>
>>> If you are OK, I'll use of_machine_is_compatible() instead of soc_is_xx().
>>
>> First of all, there is still a lot of code in mach-exynos/ using the soc_is_xx() macros, so having some SoCs use them and other SoCs use of_machine_is_compatible() wouldn't make the code cleaner.
>>
>> For now, I wouldn't mind adding soc_is_exynos3250(), but in general such code surrounded with if (soc_is_xx()) blocks should be reworked to use something better, for example function pointers, as Olof suggested.
>
> I thought 'function pointers' method instead of soc_is_xxx() macro as following two case:
> I need more detailed explanation/example of "for example function pointers, as Olof suggested." sentence.
>
> [case 1]
> Each Exynos SoC has other function pointers according to compatible name of DT.
>
> For example, arch/arm/mach-exynos/firmware.c
>
> static const struct firmware_ops exynos_firmware_ops = {
> 	.do_idle		= exynos_do_idle,
> 	.set_cpu_boot_addr	= exynos_set_cpu_boot_addr,
> 	.cpu_boot		= exynos_cpu_boot,
> };
> static const struct firmware_ops exynos3250_firmware_ops = {
> 	.do_idle		= exynos_do_idle,
> 	.set_cpu_boot_addr	= exynos4212_set_cpu_boot_addr,
> 	.cpu_boot		= exynos3250_cpu_boot,
> };
>
> static const struct firmware_ops exynos4212_firmware_ops = {
> 	.do_idle		= exynos_do_idle,
> 	.set_cpu_boot_addr	= exynos4212_set_cpu_boot_addr,
> 	.cpu_boot		= exynos4212_cpu_boot,
> };
>
> struct secure_firmware {
> 	char *name;
> 	const struct firmware_ops *ops;
> } exynos_secure_firmware[] __initconst = {
> 	{ "samsung,secure-firmware",		&exynos_firmware_ops },
> 	{ "samsung,exynos3250-secure-firmware", &exynos3250_firmware_ops },
> 	{ "samsung,exynos4212-secure-firmware", &exynos4212_firmware_ops },
> };
>

This is probably the right solution. Another would be to detect which 
firmware ops to use by matching root node with particular SoC compatible 
strings.

Best regards,
Tomasz
