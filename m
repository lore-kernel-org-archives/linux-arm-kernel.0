From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 25 Jul 2017 23:18:08 +0800
Subject: [PATCH 1/4] ARM: sun9i: Support SMP on A80 with Multi-Cluster
 Power Management (MCPM)
In-Reply-To: <20170725144006.3bz45ozpv6dwu6k4@flea>
References: <20170725050919.16036-1-wens@csie.org>
 <20170725050919.16036-2-wens@csie.org>
 <20170725074759.5mqrwcp7djeju33g@flea>
 <CAGb2v67tGuivydj1r+uD=5aw+yYZyBabbNsKwik9ZONNQmc=jQ@mail.gmail.com>
 <20170725144006.3bz45ozpv6dwu6k4@flea>
Message-ID: <CAGb2v65wdwJNrNvrG4pDy7=7n0mw4k7q_PNJ6Hth=PH6pkGK3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 10:40 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Jul 25, 2017 at 04:29:52PM +0800, Chen-Yu Tsai wrote:
>>          default ARCH_SUNXI
>> On Tue, Jul 25, 2017 at 3:47 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Hi Chen-Yu,
>> >
>> > On Tue, Jul 25, 2017 at 01:09:16PM +0800, Chen-Yu Tsai wrote:
>> >> The A80 is a big.LITTLE SoC with 1 cluster of 4 Cortex-A7s and
>> >> 1 cluster of 4 Cortex-A15s.
>> >>
>> >> This patch adds support to bring up the second cluster and thus all
>> >> cores using the common MCPM code. Core/cluster power down has not
>> >> been implemented, thus CPU hotplugging and big.LITTLE switcher is
>> >> not supported.
>> >>
>> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> >> ---
>> >>  arch/arm/mach-sunxi/Kconfig  |  10 ++
>> >>  arch/arm/mach-sunxi/Makefile |   1 +
>> >>  arch/arm/mach-sunxi/mcpm.c   | 391 +++++++++++++++++++++++++++++++++++++++++++
>> >>  3 files changed, 402 insertions(+)
>> >>  create mode 100644 arch/arm/mach-sunxi/mcpm.c
>> >>
>> >> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
>> >> index 58153cdf025b..177380548d99 100644
>> >> --- a/arch/arm/mach-sunxi/Kconfig
>> >> +++ b/arch/arm/mach-sunxi/Kconfig
>> >> @@ -47,5 +47,15 @@ config MACH_SUN9I
>> >>       bool "Allwinner (sun9i) SoCs support"
>> >>       default ARCH_SUNXI
>> >>       select ARM_GIC
>> >> +     imply MCPM
>> >> +
>> >> +config SUN9I_A80_MCPM
>> >> +     bool "Allwinner A80 Multi-Cluster PM support"
>> >> +     depends on MCPM && MACH_SUN9I
>> >> +     default MACH_SUN9I
>> >> +     select ARM_CCI400_PORT_CTRL
>> >> +     help
>> >> +       This is needed to provide CPU and cluster power management
>> >> +       on Allwinner A80 implementing big.LITTLE.
>> >
>> > Do we really need an option for that? we don't provide the option to
>> > disable the CPU SMP operations for the rest of the SoCs.
>>
>> It was an option as it also required MCPM and CCI400 support to be built.
>> We could hide it. Or, using mach-hisi as a reference, we could do:
>>
>> config MACH_SUN9I
>>         default ARCH_SUNXI
>>         select ARM_GIC
>>         select MCPM if SMP
>>         select ARM_CCI400_PORT_CTRL if SMP
>>
>> and in the Makefile:
>>
>> obj-$(CONFIG_MCPM) += sun9i-mcpm.o
>
> I guess a hidden option would work for me.

I kind of prefer mach-hisi's solution though.

>
>> >> +#define SUNXI_CPUS_PER_CLUSTER               4
>> >> +#define SUNXI_NR_CLUSTERS            2
>> >> +
>> >> +#define SUN9I_A80_A15_CLUSTER                1
>> >
>> > Don't we have a way to derive that from the DT ?
>>
>> Indeed we can.
>>
>> It would be slighty more complicated though:
>>
>> node = of_cpu_device_node_get(cluster * SUNXI_CPUS_PER_CLUSTER + cpu);
>> if (of_device_is_compatible(node, "arm,cortex-a15")) {
>>         ...
>> }
>
> There's no helper to create that map?

Are you referring to the topology map? That one only stores topology,
not what type of cores they are. The CPU capacity part doesn't either.
It only stores the results.

> We'll use it for A83T too, so the complexity will be reduced anyway.

I'll just put it in a helper function.

[...]

>> >
>> > It looks mostly good, and I would replace the sunxi by sun9i, and call
>> > that file sun9i-mcpm.c
>>
>> I was hoping to reuse the file for the A83T, so it was sunxi-mcpm.c
>> or just mcpm. Most of the stuff is similiar, except the A83T has two
>> revisions and one of them has two gate/power bits swapped. :(
>
> Hmmm, that's true.
>
> What about just mcpm then?

Works for me. I don't need to change anything. :)

ChenYu
