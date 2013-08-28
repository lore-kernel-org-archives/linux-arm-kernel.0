From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 28 Aug 2013 15:04:05 +0900
Subject: [PATCH] ARM: shmobile: Shared APMU SMP support code
In-Reply-To: <52091660.5030201@arm.com>
References: <20130807224510.9832.38560.sendpatchset@w520>
 <52091660.5030201@arm.com>
Message-ID: <CANqRtoSFKvXbuEb7G=DcmZCmZogjpU16RjSna3Lz-1YZLdin7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Tue, Aug 13, 2013 at 2:07 AM, Sudeep KarkadaNagesha
<Sudeep.KarkadaNagesha@arm.com> wrote:
> On 07/08/13 23:45, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Introduce shared APMU SMP code for mach-shmobile. Both SMP boot up
>> and CPU Hotplug is supported. DT is used for configuration of the
>> APMU hardware block, as the following r8a73a4 example shows:
>>
>>        apmu at e6152000 {
>>                compatible = "renesas,r8a73a4-apmu", "renesas,apmu";
>>                reg = <0 0xe6152000 0 0x88>;
>>                cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
>>        };
>>
> This is introducing a new DT binding which needs to be documented. Also
> you need to cc devicetree mailing list in case you need to add new
> bindings. But I think you should not require this new binding.

Good idea, I have no objections against DT binding documentation. So
if future versions end up using DT then those bindings surely need to
be documented.

The reason behind using DT here is that it was recommended to me
during the review of an earlier SMP prototype version. The base
addresses for the Renesas-specific APMU hardware needs to be
configured somehow and using DT may not be such a bad idea.

>> The code is designed around CONFIG_NR_CPUS and should in theory support
>> any number of APMUs. At this point only the APMU that includes the
>> boot CPU is enabled - this to prevent non-deterministic scheduling on
>> upstream in case of multi-cluster hardware with varying performance.
>>
> I couldn't understand this patch completely but I believe you are
> trying to solve multi-cluster power management and in your own custom
> way.
>
> But there are 2 ways to handle this in a generic way:
> 1. If Linux runs in non-secure mode, you need to use PSCI.
>    You can refer Calxeda platform for reference[1]
> 2. If Linux runs in secure mode, you need to use MPCM
>    You can refer Vexpress CA15_CA7/TC2 platform for reference[2]

Thanks for this information. I'm not really trying to do any custom
multi-cluster power management here, only provide software support for
our APMU hardware block. The APMU hardware block is used in several
SoCs from Renesas - for instance in single-cluster CA15-only
configurations or multi-cluster CA15 and CA7 configurations.

So regardless of PSCI or MPCM it seems to me that the APMU hardware
needs to be supported somewhere. I would like to have the APMU
software support in Linux to follow the same style as our other SoCs.
Having dependencies on binary blobs is something that I would like to
avoid unless it is absolutely necessary. Regarding secure vs
non-secure mode, as you may have guessed by now - the hardware on my
desk runs in non-secure mode.

As for PSCI, I wonder how that is supposed to work when power domains
are shared between I/O devices and CPUs? I can understand the benefits
of using PSCI to share independent CPU core PM support code outside of
Linux if multiple OS would be supported perhaps together with TOS. But
if there is no TOS and only a single OS and/or the hardware power
domains include CPU cores and I/O devices driven by the OS then the
merits of PSCI become less clear to me.

>> +#ifdef CONFIG_HOTPLUG_CPU
>> +/* nicked from arch/arm/mach-exynos/hotplug.c */
>> +static inline void cpu_enter_lowpower_a15(void)
>> +{
>> +     unsigned int v;
>> +
>> +     asm volatile(
>> +     "       mrc     p15, 0, %0, c1, c0, 0\n"
>> +     "       bic     %0, %0, %1\n"
>> +     "       mcr     p15, 0, %0, c1, c0, 0\n"
>> +     : "=&r" (v)
>> +     : "Ir" (CR_C)
>> +     : "cc");
>> +
>> +     flush_cache_louis();
>> +
>> +     asm volatile(
>> +     /*
>> +      * Turn off coherency
>> +      */
>> +     "       mrc     p15, 0, %0, c1, c0, 1\n"
>> +     "       bic     %0, %0, %1\n"
>> +     "       mcr     p15, 0, %0, c1, c0, 1\n"
>> +     : "=&r" (v)
>> +     : "Ir" (0x40)
>> +     : "cc");
>> +
>> +     isb();
>> +     dsb();
>> +}
>
> This sequences exactly matches the power-down sequence for CA15/A7.
> (implemented in [2]). Unless your platform needs a different sequence,
> you can re-use the code. Nico was trying to consolidate the power-down
> sequence for all ARM Cortex-A15/A7 implementations[3].

Yes, thanks, reusing that code sounds like a good plan.

> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/187130.html
> [2]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/184372.html
> [3] http://www.spinics.net/lists/arm-kernel/msg260472.html

Thanks for your help!

Cheers,

/ magnus
