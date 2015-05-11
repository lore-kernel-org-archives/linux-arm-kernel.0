From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Mon, 11 May 2015 14:22:15 +0530
Subject: [PATCH 1/6] ARM: sunxi: Add Machine support for A33
In-Reply-To: <20150510103300.GD11057@lukather>
References: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
 <1431240383-12763-2-git-send-email-vishnupatekar0510@gmail.com>
 <20150510103300.GD11057@lukather>
Message-ID: <CAEzqOZvHbtK+CxfDFGz1b5isQz1wXWVJ3hQpqQNj1mDwz5Burg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, May 10, 2015 at 4:03 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sun, May 10, 2015 at 12:16:18PM +0530, Vishnu Patekar wrote:
>> Allwinnner A33 quad core cortex-a7 based SOC.
>
> There's one n to many in Allwinner, and having a verb in that sentence
> would help
Yes, Correct.
>
>> It is similar to A23.
>>
>> Renamed cpu method to "allwinner,sun8i" for common sun8i smp.
>> smp code is generic for A23, A33 and hopefully H3.
>
> Please do only one thing in a patch.
OKie.
>
>> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>>  arch/arm/mach-sunxi/Kconfig                     | 2 +-
>>  arch/arm/mach-sunxi/platsmp.c                   | 2 +-
>>  arch/arm/mach-sunxi/sunxi.c                     | 4 ++--
>>  4 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
>> index 42941fd..e32f082 100644
>> --- a/Documentation/devicetree/bindings/arm/sunxi.txt
>> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
>> @@ -9,4 +9,5 @@ using one of the following compatible strings:
>>    allwinner,sun6i-a31
>>    allwinner,sun7i-a20
>>    allwinner,sun8i-a23
>> +  allwinner,sun8i-a33
>
> Here you're introducing a new compatible for a machine that is
> sun8i-a33.... [1]
>
>>    allwinner,sun9i-a80
>> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
>> index 81502b9..38bedd8 100644
>> --- a/arch/arm/mach-sunxi/Kconfig
>> +++ b/arch/arm/mach-sunxi/Kconfig
>> @@ -35,7 +35,7 @@ config MACH_SUN7I
>>       select SUN5I_HSTIMER
>>
>>  config MACH_SUN8I
>> -     bool "Allwinner A23 (sun8i) SoCs support"
>> +     bool "Allwinner (sun8i) SoCs support"
>>       default ARCH_SUNXI
>>       select ARM_GIC
>>       select MFD_SUN6I_PRCM
>> diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
>> index e8483ec..c56b501 100644
>> --- a/arch/arm/mach-sunxi/platsmp.c
>> +++ b/arch/arm/mach-sunxi/platsmp.c
>> @@ -189,4 +189,4 @@ struct smp_operations sun8i_smp_ops __initdata = {
>>       .smp_prepare_cpus       = sun8i_smp_prepare_cpus,
>>       .smp_boot_secondary     = sun8i_smp_boot_secondary,
>>  };
>> -CPU_METHOD_OF_DECLARE(sun8i_a23_smp, "allwinner,sun8i-a23", &sun8i_smp_ops);
>> +CPU_METHOD_OF_DECLARE(sun8i_smp, "allwinner,sun8i", &sun8i_smp_ops);
>
> Like I was saying, this is an unrelated thing, it should be in a
> separate patch.
>
> And this is wrong.
>
> A compatible should be made for the first IP that uses it. The first
> user of that particular method has been the A23, it should be what's
> in the compatible.
>
> If the A33 is by chance using the exact same code, then we have two
> choices, either reuse that compatible, or introduce a new one if it
> slightly differs. And since the A33 has more cores than the A23, it
> does differ.
>
> So please add a new compatible.
>
> That also breaks the SMP code in the A23 which is a no-go, since the
> compatible would have changed but not the DT.
I think adding something like below is good way to enable smp on a33
as we are going to use separate dtsi for a33,
and a23 for now.
CPU_METHOD_OF_DECLARE(sun8i_smp_a33, "allwinner,sun8i-a33", &sun8i_smp_ops);
>
>> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
>> index 1bc811a..8937d0d 100644
>> --- a/arch/arm/mach-sunxi/sunxi.c
>> +++ b/arch/arm/mach-sunxi/sunxi.c
>> @@ -66,11 +66,11 @@ DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
>>  MACHINE_END
>>
>>  static const char * const sun8i_board_dt_compat[] = {
>> -     "allwinner,sun8i-a23",
>> +     "allwinner,sun8i",
>
> [1] ... And here, you don't introduce that new machine compatible, but
> remove one a use another one instead....
>
> Apart from the documentation mismatch, you really shouldn't do that.
>
> The machine compatible should be a identifier for the board and the
> SoC, so that we can identify both easily, and possibly enable
> quirks. The only question you should ask yourself whenever you add a
> new compatible is "is this exactly the same IP" ?
>
> In such a case, is the A23 *exactly* the same as the H3 and the A33?
>
> The answer is obviously no, otherwise we would not have this patchset
> in the first place.
>
> So you just need to introduce a new compatible for the A33, just like
> you did in the Documentation, and add that new compatible in the machine.
I'll add new compatible, "allwinner,sun8i-a33"
>
>>       NULL,
>>  };
>>
>> -DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i (A23) Family")
>> +DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i Family")
>>       .dt_compat      = sun8i_board_dt_compat,
>>       .init_late      = sunxi_dt_cpufreq_init,
>>  MACHINE_END
>> --
>> 1.9.1
>>
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
