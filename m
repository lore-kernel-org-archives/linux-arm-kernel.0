From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 27 May 2014 14:13:32 +0100
Subject: [RESEND PATCH v5 3/5] ARM: Conceal DEBUG_LL_UART_NONE from
 unsupported platforms
In-Reply-To: <6624276.NBS809VbNB@wuerfel>
References: <1398355246-29571-1-git-send-email-daniel.thompson@linaro.org>
 <1400857819-7975-4-git-send-email-daniel.thompson@linaro.org>
 <5013253.K6sZTxep7b@wuerfel> <6624276.NBS809VbNB@wuerfel>
Message-ID: <53848F7C.6020508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/05/14 14:39, Arnd Bergmann wrote:
>>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>>> index eab8ecb..4c8d7db 100644
>>> --- a/arch/arm/Kconfig.debug
>>> +++ b/arch/arm/Kconfig.debug
>>> @@ -842,7 +842,18 @@ choice
>>>  
>>>       config DEBUG_LL_UART_NONE
>>>               bool "No low-level debugging UART"
>>> -             depends on !ARCH_MULTIPLATFORM
>>> +             depends on ARCH_AT91 || \
>>> +                     ARCH_CLPS711X || \
>>> +                     ARCH_FOOTBRIDGE || \
>>> +                     ARCH_KS8695 || \
>>> +                     ARCH_NETX || \
>>> +                     ARCH_OMAP1 || \
>>> +                     ARCH_SA1100 || \
>>> +                     ARCH_S3C24XX || \
>>> +                     ARCH_S3C64XX || \
>>> +                     ARCH_S5P64X0 || \
>>> +                     ARCH_S5PC100 || \
>>> +                     ARCH_S5PV210
>>>               help
>>>                 Say Y here if your platform doesn't provide a UART option
>>>                 above. This relies on your platform choosing the right UART
>>
>> ARCH_S3C24XX has been moved over in linux-next to use debug/s3c24xx.S.
>> A few others will likely move soon (AT91, CLPS711x, S5PV210), as the
>> platforms get moved to ARCH_MULTIPLATFORM.

The list in my patch came from:

sundance$ find arch/arm -name "debug-macro.S"
arch/arm/mach-at91/include/mach/debug-macro.S
arch/arm/mach-clps711x/include/mach/debug-macro.S
arch/arm/mach-footbridge/include/mach/debug-macro.S
arch/arm/mach-ks8695/include/mach/debug-macro.S
arch/arm/mach-netx/include/mach/debug-macro.S
arch/arm/mach-omap1/include/mach/debug-macro.S
arch/arm/mach-s3c64xx/include/mach/debug-macro.S
arch/arm/mach-s5p64x0/include/mach/debug-macro.S
arch/arm/mach-s5pc100/include/mach/debug-macro.S
arch/arm/mach-s5pv210/include/mach/debug-macro.S
arch/arm/mach-sa1100/include/mach/debug-macro.S

In other words this patch lists of all platforms where
DEBUG_LL_UART_NONE should not result in failure to compile the kernel.

This list doesn't seem to have changed in linux-next.

>> As an alternative to your patch, we could decide to move the remaining
>> files as well.
> 
> Follow-up: I also noticed that AT91, CLPS711X, FOOTBRIDGE and all the SAMSUNG
> platforms already have an entry in the list, so DEBUG_LL_UART_NONE is redundant
> for them. The below change should be enough.
> 
> For AT91 this is actually better because the old AT91X40 support doesn't
> have working DEBUG_LL support. This gets handled correctly by 
> AT91_DEBUG_LL_DBGU0/AT91_DEBUG_LL_DBGU1, but not DEBUG_LL_UART_NONE.

I'm very happy to update my patch to follow this one. However since it
will render the corresponding debug-macro.S unreachable by KBuild I like
to nuke the file as well. Good idea?


Daniel.
