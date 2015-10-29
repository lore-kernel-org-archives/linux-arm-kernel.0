From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 29 Oct 2015 14:15:19 +0900
Subject: [PATCH v12 1/7] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC
 support
In-Reply-To: <20151028184504.GG8899@e104818-lin.cambridge.arm.com>
References: <1445839312-8874-1-git-send-email-horms+renesas@verge.net.au>
 <1445839312-8874-2-git-send-email-horms+renesas@verge.net.au>
 <20151028184504.GG8899@e104818-lin.cambridge.arm.com>
Message-ID: <CANqRtoT-7hhAN907KQFYwrP7+B7tVZdDEpp0SPrnXG3YrDbKoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 3:45 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Mon, Oct 26, 2015 at 03:01:46PM +0900, Simon Horman wrote:
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -66,6 +66,23 @@ config ARCH_SEATTLE
>>       help
>>         This enables support for AMD Seattle SOC Family
>>
>> +config ARCH_SHMOBILE
>> +     bool
>> +
>> +config ARCH_RENESAS
>> +     bool "Renesas SoC Platforms"
>> +     select ARCH_SHMOBILE
>> +     select PINCTRL
>> +     select PM_GENERIC_DOMAINS if PM
>> +     help
>> +       This enables support for the ARMv8 based Renesas SoCs.
>> +
>> +config ARCH_R8A7795
>> +     bool "Renesas R-Car H3 SoC Platform"
>> +     depends on ARCH_RENESAS
>> +     help
>> +       This enables support for the Renesas R-Car H3 SoC.
>
> Do you need such fine-grained configuration? I'd really like to avoid
> individual SoC Kconfig entries and only include SoC families (like
> ARCH_RENESAS). There are some which I didn't spot at the time
> (ARCH_FSL_LS2085A and ARCH_TEGRA_132_SOC) but we shouldn't continue this
> trend any further.

I agree with you about coarse grained configuration in general. I am
also wondering how to handle cases where IP varies with SoC version.
=)

The two most common cases with SoC-specific IP for Renesas SoCs tend
to be Pinctrl which is using rather large tables to support the PFC
hardware and also the clocks (CCF) that drives the SoC specific CPG
hardware. For the PFC and CPG I think it makes sense to enable build
based on SoC model like we do already, but for the Kconfig bits in
arch/arm64 perhaps ARCH_RENESAS can simply select ARCH_R8A7795?

Thanks,

/ magnus
