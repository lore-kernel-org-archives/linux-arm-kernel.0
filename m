From: david@lechnology.com (David Lechner)
Date: Fri, 8 Dec 2017 13:14:04 -0600
Subject: [PATCH v1 1/6] ARM: davinci: clean up map_io functions
In-Reply-To: <0dad9d38-3645-c295-212b-6b66733f633b@ti.com>
References: <1512182054-17410-1-git-send-email-david@lechnology.com>
 <1512182054-17410-2-git-send-email-david@lechnology.com>
 <2e0a60bb-08be-5d0c-3c4c-c9e075c9170a@ti.com>
 <2e3b9ef7-b9ee-a6b7-bc67-e3dbd6119f48@lechnology.com>
 <0dad9d38-3645-c295-212b-6b66733f633b@ti.com>
Message-ID: <f7511e62-b933-f1d6-2196-ce4e738c3465@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2017 09:34 AM, Sekhar Nori wrote:
> On Thursday 07 December 2017 10:44 PM, David Lechner wrote:
>> On 12/07/2017 08:52 AM, Sekhar Nori wrote:
>>> On Saturday 02 December 2017 08:04 AM, David Lechner wrote:
>>>> This cleans up the map_io functions in the board init files for
>>>> mach-davinci.
>>>>
>>>> Most of the boards had a wrapper function around <board>_init(). This
>>>> wrapper is removed and the function is used directly. Additionally, the
>>>> <board>_init() functions are renamed to <board>_map_io() to match the
>>>> field name.
>>>>
>>>> Signed-off-by: David Lechner <david@lechnology.com>
>>>
>>>> diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c
>>>> b/arch/arm/mach-davinci/board-dm646x-evm.c
>>>> index cb0a41e..f0e2762 100644
>>>> --- a/arch/arm/mach-davinci/board-dm646x-evm.c
>>>> +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
>>>> @@ -716,16 +716,6 @@ static void __init evm_init_i2c(void)
>>>>  ? }
>>>>  ? #endif
>>>>  ? -#define DM6467T_EVM_REF_FREQ??????? 33000000
>>>> -
>>>> -static void __init davinci_map_io(void)
>>>> -{
>>>> -??? dm646x_init();
>>>
>>> The call to dm646x_init() is dropped here, but I don't see it added
>>> back, at least in this patch.
>>
>> dm646x_init() is renamed to dm646x_map_io(), which is used directly in
>> MACHINE_START().
> 
> Ah, I missed that. But I think its a symptom of too many things going on
> in the patch. How about splitting the patch to:
> 
> a) Remove trivial <board>_map_io() wrappers and use <soc>_init()
> directly to initialize .map_io
> 
> b) Rename <soc>_init() to <soc>_map_io
> 
>>
>>>
>>>> diff --git a/arch/arm/mach-davinci/dm646x.c
>>>> b/arch/arm/mach-davinci/dm646x.c
>>>> index da21353..b3be5c8 100644
>>>> --- a/arch/arm/mach-davinci/dm646x.c
>>>> +++ b/arch/arm/mach-davinci/dm646x.c
>>>> @@ -17,6 +17,7 @@
>>>>  ? #include <linux/platform_data/edma.h>
>>>>  ? #include <linux/platform_data/gpio-davinci.h>
>>>>  ? +#include <asm/mach-types.h>
>>>>  ? #include <asm/mach/map.h>
>>>>  ? ? #include <mach/cputype.h>
>>>> @@ -952,11 +953,16 @@ int __init dm646x_init_edma(struct
>>>> edma_rsv_info *rsv)
>>>>  ????? return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
>>>>  ? }
>>>>  ? -void __init dm646x_init(void)
>>>> +#define DM6467T_EVM_REF_FREQ??????? 33000000
>>>> +
>>>> +void __init dm646x_map_io(void)
>>>>  ? {
>>>>  ????? davinci_common_init(&davinci_soc_info_dm646x);
>>>>  ????? davinci_map_sysmod();
>>>>  ????? davinci_clk_init(davinci_soc_info_dm646x.cpu_clks);
>>>> +
>>>> +??? if (machine_is_davinci_dm6467tevm())
>>>> +??????? davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);
>>>>  ? }
>>>
>>> I think we should leave the DM646x case out of this since there are
>>> additional issues like introducing these EVM specific defines in a file
>>> meant for SoC.
>>
>> I agree with the sentiment. This quirk gets moved around several times
>> in this series just to keep things working for a git bisect even if it
>> is not the ideal place for it to be.
>>
>> Currently, all boards use a common reference frequency from the common
>> SoC files instead of the board file. I have not done so in this version
>> of the series, but I could rework it so that this happens, which would
>> remove the need for this quirk altogether. But even then, it would
>> probably get shuffled around a bit before being eliminated.
> 
> We should avoid shuffling and modifying the same code repeatedly if we
> can. I think, it will be easier to read if patch 2 and 1 are interchanged.
> 
> There is a lot going on and I wasn't sure how that will look so I tried
> it briefly and pushed a branch.
> 
> Do have a look, but this seems better to me.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git/log/?h=for-davidl
> 

Thank you for the suggestion. I think it will be better as well. I'll 
respin the series and we'll see how it works.
