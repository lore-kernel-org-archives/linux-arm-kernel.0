From: sdliyong@gmail.com (LIYONG)
Date: Sun, 21 Feb 2016 20:19:57 +0800
Subject: [PATCH] ARM: OMAP2+: allow DEBUG_UNCOMPRESS for OMAP2+
In-Reply-To: <20160219180237.GI21202@atomide.com>
References: <1451362159-27910-1-git-send-email-sdliyong@gmail.com>
 <20160219180237.GI21202@atomide.com>
Message-ID: <BLU402-EAS3654C3D896BB35B714D68BD6A20@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

no problem, let me submit another patch

> ? 2016?2?20??02:02?Tony Lindgren <tony@atomide.com> ???
> 
> Hi,
> 
> * Yong Li <sdliyong@gmail.com> [151228 20:12]:
>> Based on the below
>> commit ae3c99a26c60 ("ARM: 7806/1: allow DEBUG_UNCOMPRESS for Tegra"),
>> change the .data section to .text section,
>> to enable DEBUG_UNCOMPRESS for OMAP2+ platforms
>> Tested okay using BeagleBone Black
> 
> Sorry for the delay, I just noticed this one while looking
> through my inbox for pending patches.
> 
> I think we should first simplify things by moving things over
> to use the generic DEBUG_UART_8250 code where the addresses
> need to be specified in the .config. It's been on my list of
> things to do for quite a while but I keep getting interrupted.
> 
> My guess is that if we do that, this patch is no longer
> needed :) Yong, care to take a look at that?
> 
> Regards,
> 
> Tony
> 
>> Signed-off-by: Yong Li <sdliyong@gmail.com>
>> ---
>> arch/arm/Kconfig.debug             |  2 +-
>> arch/arm/include/debug/omap2plus.S | 13 ++++++++++---
>> 2 files changed, 11 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index 259c0ca..e5ae36a 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -1596,7 +1596,7 @@ config DEBUG_UART_8250_FLOW_CONTROL
>> config DEBUG_UNCOMPRESS
>>    bool
>>    depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
>> -    default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
>> +    default y if DEBUG_LL && (!DEBUG_OMAP2PLUS_UART || !ZBOOT_ROM) && \
>>             (!DEBUG_TEGRA_UART || !ZBOOT_ROM)
>>    help
>>      This option influences the normal decompressor output for
>> diff --git a/arch/arm/include/debug/omap2plus.S b/arch/arm/include/debug/omap2plus.S
>> index 6d867ae..12421f9 100644
>> --- a/arch/arm/include/debug/omap2plus.S
>> +++ b/arch/arm/include/debug/omap2plus.S
>> @@ -58,11 +58,18 @@
>> 
>> #define UART_OFFSET(addr)    ((addr) & 0x00ffffff)
>> 
>> +#if defined(ZIMAGE)
>> +    omap_uart_phys:    .word    0
>> +    omap_uart_virt:    .word    0
>> +    omap_uart_lsr:    .word    0
>> +#else
>> +
>>        .pushsection .data
>> -omap_uart_phys:    .word    0
>> -omap_uart_virt:    .word    0
>> -omap_uart_lsr:    .word    0
>> +    omap_uart_phys:    .word    0
>> +    omap_uart_virt:    .word    0
>> +    omap_uart_lsr:    .word    0
>>        .popsection
>> +#endif
>> 
>>        .macro    addruart, rp, rv, tmp
>> 
>> -- 
>> 2.1.4
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
