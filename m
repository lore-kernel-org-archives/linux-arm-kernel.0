From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Wed, 28 Jan 2015 19:49:33 +0200
Subject: [PATCH 4/4] ARM: dts: Add initial support for Alpine platform
In-Reply-To: <20150126114239.GB23313@leverpostej>
References: <54c53663.0OSd3sO9f1oYd3El%tsahee@annapurnalabs.com>
 <20150126114239.GB23313@leverpostej>
Message-ID: <CABM=7km0SpBYyjM0EUJ_OS5oLSF3sCNBoB9xbMiRW0W4A1HohA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 January 2015 at 13:42, Mark Rutland <mark.rutland@arm.com> wrote:
>> diff --git a/Documentation/devicetree/bindings/arm/cpu-enable-method/annapurna-labs,alpine-smp b/Documentation/devicetree/bindings/arm/cpu-enable-method/annapurna-labs,alpine-smp
>> new file mode 100644
>> index 0000000..6245aa9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/cpu-enable-method/annapurna-labs,alpine-smp
>> @@ -0,0 +1,64 @@
>> +========================================================
>> +Secondary CPU enable-method "annapurna-labs,alpine-smp" binding
>> +========================================================
>> +
>> +This document describes the "annapurna-labs,alpine-smp" method for
>> +enabling secondary CPUs. To apply to all CPUs, a single
>> +"annapurna-labs,alpine-smp" enable method should be defined in the
>> +"cpus" node.
>> +
>> +Enable method name:    "annapurna-labs,alpine-smp"
>> +Compatible machines:   "annapurna-labs,alpine"
>> +Compatible CPUs:       "arm,cortex-a15"
>> +Related properties:    (none)
>
>Please describe what the contract of the method is? What's expected of
>the system, FW, and kernel?
>
>Otherwise the documentation is practically useless.
I'm not sure I understand exactly what you ask.
This is simply documenting the device-tree binding, not much more or
less informational than the existing documentation for "berlin-smp".
The method is implemented in the previous patch. I will add a little
more detail to the implementation itself on the next patchset.
The node
Basically: the FW contract is pretty straight forward and tries to
keep up with arm/linux requirements. All CPUs boot to the same state,
firmware handles necessary initializations in the cases the CPU can't
make them because of it's mode.

>> +       soc {
>> +               #address-cells = <2>;
>> +               #size-cells = <2>;
>> +               compatible = "simple-bus";
>> +               interrupt-parent = <&gic_main>;
>> +               ranges;
>> +
>> +               arch-timer {
>> +                       compatible = "arm,cortex-a15-timer",
>> +                                    "arm,armv7-timer";
>> +                       interrupts =
>> +                               <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +                               <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +                               <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +                               <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +                       clock-frequency = <0>; /* Filled by loader */
>> +               };
>
> Please fix your bootloader/FW to configure CNTFRQ on all CPUs whenever
> they are brought up.
>
For completeness, I agree. However, arch_timer_detect_rate in
drivers/clocksource/arm_arch_timer.c seems to first try reading the
frequency from devicetree, and fall-back to CNTFRQ only if that fails.

Either way, filling the arch-timer in bootloader seems right.

> Are CPUs booted at Hyp? If not, is CNTVOFF configured uniformly across
> CPUs by the bootloader/FW?
>
> If the answer to both those questions is no, timekeeping will not work
> on this platform.
>
Generally yes, all CPUs boot to HYP. We do plan for other options - so
thanks for the heads up!

All other comments (unnecessary nodes/properties, bad brackets, etc..)
- will be fixed.

Thank you!
tsahee.
