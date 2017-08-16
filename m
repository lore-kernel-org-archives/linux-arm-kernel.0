From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 16 Aug 2017 11:22:33 +0100
Subject: Questions about PMU counters
In-Reply-To: <20170716100537.GA15094@golem.pkh.me>
References: <20170716100537.GA15094@golem.pkh.me>
Message-ID: <3bf77de4-e064-1117-8073-f785b060544a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/17 11:05, Cl?ment B?sch wrote:
> Hi,
> 
> I have a few questions about the PMU counters I couldn't get anywhere
> else. Hopefully this is the right place.
> 
> 
> 1. Device-Tree: pmu vs arm-pmu
> ==============================
> 
> Documentation/devicetree/bindings/arm/pmu.txt is documenting "pmu" as
> identifier, but both "arm-pmu" and "pmu" seems to be used interchangeably
> in the codebase in both arch/{arm,arm64}.

The node *name* is essentially just some unique namespace identifier; in
most cases it doesn't really matter at all, although DT guidelines are
that it should represent the general type of device (see "Node Names" in
http://www.devicetree.org/specifications-pdf). The "compatible" string
is what actually identifies the hardware, and what drivers care about.

> While most of the codebase seems to use "pmu", drivers/perf/arm_pmu.c is
> also checking for the exact "arm-pmu" string.

I don't see that - AFAICS that string only appears as the name it
registers interrupts with.

> Q: what is the difference between the two?

One is prefixed with "arm-" ;)

Note that "pmu" is also used for Power Management Units in some cases,
so sometimes it's an explicit disambiguation.

> 2. Userspace access
> ===================
> 
> An RFC patch was sent a few years ago to allows userspace access to the
> PMU counters: https://patchwork.kernel.org/patch/5217341/
> 
> AFAICT, this was not mainlined as a module or the suggested sysfs control.
> I tried to contact the author of this patch but got no answer.
> 
> The perf API may be considered good enough for end users, but some
> projects have their own benchmarking framework which they want
> cross-platform, with as little overhead as possible (FFmpeg is one of
> them).
> 
> Currently, the only workaround seems to use this lost module, which
> "recently" got arm64 support: https://github.com/zhiyisun/enable_arm_pmu/
> I confirm it's working on various boards I tested, but it's still not
> ideal (typically, it's breaking badly if perf is used at the same time).
> 
> Q: did anything come out of this, is there any plan, or is there a
> decision to not doing this?

Say you do give userspace direct access to the PMU; now run two or more
programs at once that believe they can use the counters for their own
"minimal-overhead" profiling. Have fun interpreting those results...

And that's not even getting into the implications of scheduling across
different CPUs, CPUidle, etc. where the PMU state is completely beyond
userspace's control. In general, the plan to provide userspace with
something which might happen to just about work in a few corner cases,
but is meaningless, misleading or downright broken in all others, is to
never do so.
> 3. ACPU controller for the Hikey
> ================================
> 
> This question is specific to the Hikey (hisilicon/hi6220-hikey.dts).
> 
> While I was able to get PMU counters access through enable_arm_pmu with
> most of my boards, it made no difference for the Hikey. So I was under the
> impression that the board needs a special treatment to enable these PMU
> counters.
> 
> Anyway, according the specifications, there is an ACPU interrupt
> ACPU_PMUIRQ_intr=131 (so SPI 99) "combined interrupt of the eight core
> CoreSight interrupts of the two clusters of the ACPU)."
> 
> Just in case, I naively attempted:
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 470461ddd427..98fb2c775540 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -171,6 +171,11 @@
>                 CLUSTER1_L2: l2-cache1 {
>                         compatible = "cache";
>                 };
> +
> +               pmu {
> +                       compatible = "arm,armv8-pmuv3";
> +                       interrupts = <GCI_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
> +               };
>         };
>  
>         cpu_opp_table: cpu_opp_table {
> 
> But it didn't make any difference.
> 
> Q: any idea where I can find more information on this? I couldn't get any help
>    from 96boards.
> 
> 
> 4. Quick questions
> ==================
> 
> Q: Where can I find the "interrupt" parser of the device-tree? (I'm trying
>    to verify I understand correctly how exactly is handled 1, 2 and 3
>    parameters forms).

The interrupt cells are interpreted by relevant interrupt controller
driver, not generically - their meanings are defined by whichever DT
binding applies to the appropriate interrupt parent.

> Q: rpi3 seems to have perf counters in 32-bit but not in 64-bit. I don't
>    understand why: they seem to both share the same device-tree. Oh, and
>    that bcm2837 doesn't seem to even have pmu declared, so I'm confused.
> 
> Q: Why "v3" in "armv8-pmuv3"?

Because it's version 3 of the PMU architecture (which is the baseline
for version 8 of the CPU architecture).

Robin.

> 
> Q: I watched an old talk about device trees, and one of the main issue seemed
>    to be the impossibility to keep API/ABI compatibility forever. What came out
>    of this wrt the process of defining how to write device trees?
> 
> 
> Note: as you probably guessed, I'm completely new to all this stuff, so if you
> can answer at least one of these questions, this will probably help me a lot
> finding my way in the forest.
> 
> 
> Thanks,
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
