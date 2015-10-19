From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Oct 2015 11:39:12 -0500
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <5624CF62.6020001@sigmadesigns.com>
References: <560EAA7C.3070302@free.fr> <5124277.UR9sg1IOHT@wuerfel>
 <560EFDB3.9010305@free.fr> <11113740.WL812ZaRcZ@wuerfel>
 <5612A473.8030405@sigmadesigns.com>
 <5613EF4C.30603@sigmadesigns.com>
 <CAL_JsqJ+WTBYF=sJWbkgNzL48H5AiXL4aoVV3DNiL6T_UQKQfg@mail.gmail.com>
 <561D2952.4060908@sigmadesigns.com>
 <CAL_JsqKa4trfpLY_DPsjBrfH-7SSUQMACYVW7DNN1=Pv3B4FrA@mail.gmail.com>
 <5624CF62.6020001@sigmadesigns.com>
Message-ID: <CAL_Jsq+jthx9ffnUm-G-TV9LdxBRp3SKyhyfcVu=7kN3CuumJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 6:09 AM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:
> On 13/10/2015 19:55, Rob Herring wrote:
>> Marc Gonzalez wrote:
>>> On 09/10/2015 16:08, Rob Herring wrote:
>>>
>>>> No cpus node?
>>>
>>> Is this used to document the CPU?
>>> I didn't see any code making use of that information.
>>
>> The SMP code uses it: arch/arm/kernel/devtree.c
>
> Now I see arm_dt_init_cpu_maps()
>
> <confused> I thought DT was used to specify things that cannot be
> dynamically discovered? Isn't it possible for the OS to discover at
> run-time how many cores and/or CPUs are present?

Yes, at first we didn't have them either. It is all the other things
associated with the cpu's that we need such as enable-method prop,
clocks, power domains, etc. that cause you to need them.

> On a related topic, I have a DTS for my board, which includes the
> DTS for the architecture. However, there are single-core SoCs and
> dual-core SoCs. Where is the cpus node supposed to appear?

You could do 3 levels of dts includes (common, SOC, board), or you
could put both cores in marking the second core disabled, and then
enable it in the bootloader checking some fuse or id. Kind of depends
on how different the chips are and how you want to manage dtb files.

> Or should I specify in the architecture DTS the maximum number
> of cores, as in
>
>     cpus {
>         #address-cells = <1>;
>         #size-cells = <0>;
>         cpu at 0 {
>             compatible = "arm,cortex-a9";
>             reg = <0>;
>         };
>         cpu at 1 {
>             compatible = "arm,cortex-a9";
>             reg = <1>;
>         };
>     };
>
>
>>>> No pl310? A9 performance mon?
>
> Found "arm,cortex-a9-pmu" in arch/arm/kernel/perf_event_v7.c
> Are the PMU registers available from non-secure mode, or is TrustZone
> going to get in the way?

I don't recall off-hand.

> About the cache controller, I was confused by this comment:
>         /*
>          * Always enable non-secure access to the lockdown registers -
>          * we write to them as part of the L2C enable sequence so they
>          * need to be accessible.
>          */
>         l2x0_saved_regs.aux_ctrl = aux | L310_AUX_CTRL_NS_LOCKDOWN;
>
> I see no lock() function, only unlock().
>
> But the unlock function merely writes 0 to the relevant registers,
> and 0 is the value at reset for those registers. Since nothing ever
> sets the registers to non-zero, why is the unlock needed at all?

It was because some bootloaders set those registers. Linux just wants
them to be all unlocked.

Rob
