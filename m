From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 1 May 2014 22:32:27 -0700
Subject: [PATCH RESEND 1/5] ARM: BCM63XX: add basic support for the
 Broadcom BCM63138 DSL SoC
In-Reply-To: <7337945.Kibhmj51LR@wuerfel>
References: <1398130758-19456-1-git-send-email-f.fainelli@gmail.com>
 <1398130758-19456-2-git-send-email-f.fainelli@gmail.com>
 <7337945.Kibhmj51LR@wuerfel>
Message-ID: <CAGVrzcayySWxBhXVK0Tq8-foH5tTX0_9EbFL3YtPreHeruNDmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-22 3:45 GMT-07:00 Arnd Bergmann <arnd@arndb.de>:
> On Monday 21 April 2014 18:39:14 Florian Fainelli wrote:
>> This patch adds basic support for the Broadcom BCM63138 DSL SoC which is
>> using a dual-core Cortex A9 system. Add the very minimum required code
>> boot Linux on this SoC.
>>
>> Due to the two specific register address spaces located at 0x8000_0000
>> and 0xfffe_0000, we need to setup a specific iotable descriptor for
>> those to be remapped at the expected virtual addresses.
>
> What is the significance of the "expected virtual address"? All drivers
> nowadays should call ioremap() and use whatever virtual address comes
> out of that.
>
>> Finally, the PL310 cache controller requires a bit of tweaking before
>> handing its initialization over l2x0_of_init(), this is also taken care
>> of to make sure that its size is properly configured.
>
> Russell has just spent a lot of work on cleaning up the l2x0 setup
> of various platforms. I really don't want to see new platform specific
> code for this.

Ok, I will try with his cleanup patchset applied and see if I need any
platform specific implementation.

>
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> index 49c914cd9c7a..26b51bcf878c 100644
>> --- a/arch/arm/mach-bcm/Kconfig
>> +++ b/arch/arm/mach-bcm/Kconfig
>> @@ -69,6 +69,26 @@ config ARCH_BCM_5301X
>>         different SoC or with the older BCM47XX and BCM53XX based
>>         network SoC using a MIPS CPU, they are supported by arch/mips/bcm47xx
>>
>> +config ARCH_BCM_63XX
>> +     bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
>> +     depends on MMU
>> +     select ARM_ERRATA_754322
>> +     select ARM_ERRATA_764369 if SMP
>> +     select ARM_GIC
>> +     select ARM_GLOBAL_TIMER
>> +     select CACHE_L2X0
>> +     select COMMON_CLK
>> +     select CPU_V7
>> +     select GENERIC_CLOCKEVENTS
>> +     select HAVE_ARM_ARCH_TIMER
>> +     select HAVE_ARM_TWD if SMP
>> +     select HAVE_ARM_SCU if SMP
>> +     select HAVE_SMP
>
> A lot of these are already selected by ARCH_MULTI_V7 and can be
> omitted here.
>
>> +#ifndef __ARM_BCM63XX_H
>> +#define __ARM_BCM63XX_H
>> +
>> +#define IO_ADDRESS(x)                (((x) & 0x00ffffff) + 0xfc000000)
>> +
>> +/* AHB register space */
>> +#define BCM63XX_AHB_PHYS     0x80001000
>> +#define BCM63XX_AHB_VIRT     IO_ADDRESS(BCM63XX_AHB_PHYS)
>> +#define BCM63XX_AHB_SIZE     0x800000
>> +
>> +/* PERIPH (legacy) register space */
>> +#define BCM63XX_PERIPH_PHYS  0xfffe8000
>> +#define BCM63XX_PERIPH_VIRT  IO_ADDRESS(BCM63XX_PERIPH_PHYS)
>> +#define BCM63XX_PERIPH_SIZE  0x10000
>
> You shouldn't need these any more. If you do, just move all of this
> into the main file, to ensure no other file accidentally relies
> on hardcoded values.
>
> Note that BCM63XX_AHB_PHYS is nor aligned, so AFAICT you don't
> actually get a huge page entry for it, and there is no point
> doing this at all, as it has neither functional nor performance
> relevance.
>
> You may have out-of-tree drivers that you haven't cleaned up
> or posted yet relying on specific static mappings, but that is
> no reason to have these mappings in the mainline kernel.

I tried without the iotable entries, and any register access to these
regions did hang the system, I will check harder what was going on
there.

>
>> diff --git a/arch/arm/mach-bcm/board_bcm63xx.c b/arch/arm/mach-bcm/board_bcm63xx.c
>> new file mode 100644
>> index 000000000000..a779aca673c4
>> --- /dev/null
>> +++ b/arch/arm/mach-bcm/board_bcm63xx.c
>
> Maybe just "bcm63xx.c"? We don't really do "board" files any more.

Makes sense, there is nothing board specific here (and there should
not be anyway).

>
>> +static void __init bcm63xx_l2cc_init(void)
>> +{
>> +     u32 auxctl_val = 0, auxctl_msk = ~0UL;
>> +
>> +     /* 16-way cache */
>> +     auxctl_val |= (1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT);
>> +     auxctl_msk &= ~(1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT);
>> +     /* 32 KB */
>> +     auxctl_val |= (2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
>> +     auxctl_msk &= ~(L2X0_AUX_CTRL_WAY_SIZE_MASK);
>> +
>> +     /*
>> +      * Set bit 22 in the auxiliary control register. If this bit
>> +      * is cleared, PL310 treats Normal Shared Non-cacheable
>> +      * accesses as Cacheable no-allocate.
>> +      */
>> +     auxctl_val |= (1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT);
>> +
>> +     /* Allow non-secure access */
>> +     auxctl_val |= (1 << L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT);
>> +     /* Instruction prefetch */
>> +     auxctl_val |= (1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT);
>> +     /* Early BRESP */
>> +     auxctl_val |= (1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT);
>> +
>> +     l2x0_of_init(auxctl_val, auxctl_msk);
>> +}
>
> What are the power-on values of bits you override here? Are you sure
> you have to force all of them?
>
> Don't we already have ways to specify the same things in DT properties?
>
>         Arnd



-- 
Florian
